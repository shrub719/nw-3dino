use crate::{
    viewer::{
        mat::*
    },
    constants::*
};
use heapless::Vec;
use crate::external::obj::load_tris;

fn get_projection_matrix(scale: f32) -> Matrix4 {
    Matrix4 ([
        [120.0, 0.0  , 0.0      , 160.0],
        [0.0  , 120.0, 0.0      , 130.0],
        [0.0  , 0.0  , 0.5/scale, 0.0  ],
        [0.0  , 0.0  , 0.0      , 1.0  ]
    ])
}

fn get_scale_matrix(scale: f32) -> Matrix4 {
    let s = scale / 10.0;
    Matrix4 ([
        [s, 0.0  , 0.0  , 0.0],
        [0.0  , s, 0.0  , 0.0],
        [0.0  , 0.0  , s, 0.0],
        [0.0  , 0.0  , 0.0  , 1.0]
    ])
}

pub struct Mesh {
    pub tris: Vec<Triangle3, { limits::MAX_TRIS }>,
    pub transformed_tris: Vec<RTriangle3, { limits::MAX_TRIS }>,
    rotation: Quaternion,
    pub scale: f32
}
impl Mesh {
    pub fn new() -> Self {
        Self {
            tris: Vec::new(),
            transformed_tris: Vec::new(),
            rotation: Quaternion::default(),
            scale: 0.5
        }
    }

    pub fn load_mesh_from_file(&mut self) {
        self.tris.clear();
        for tri in load_tris() {
            let _ = self.tris.push(tri);
        }
    }

    pub fn update_rotation(&mut self, rotation_direction: Vector3, delta_time: f32) {
        if rotation_direction.x.is_nan() {
            self.rotation = Quaternion::default();
            return
        }

        let rotation_speed = settings::ROTATION_SPEED * delta_time;
        let x = rotation_direction.x * rotation_speed;
        let y = rotation_direction.y * rotation_speed;
        let z = rotation_direction.z * rotation_speed;
        
        self.rotation = Quaternion::from_angles(x, y, z) * self.rotation;
    }

    pub fn update_scale(&mut self, scale_change: f32, delta_time: f32) {
        // TODO: linearly interpolate a proportional (exponential?) change
        self.scale += settings::SCALE_SPEED * scale_change * delta_time;
        if self.scale < 0.0 { self.scale = 0.0 }
    }

    pub fn transform(&mut self) {
        let mut matrix = get_projection_matrix(self.scale);
        matrix *= self.rotation.get_rotation_matrix();
        matrix *= get_scale_matrix(self.scale);

        self.transformed_tris.clear();
        for tri in &self.tris {
            let _ = self.transformed_tris.push(*tri * matrix);
        }
    }
}
