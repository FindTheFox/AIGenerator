//
//  StableDiffusionService.swift
//  Giro
//
//  Created by Samuel NEVEU on 29/07/2023.
//

import Foundation

/// Request
struct SDTextToImageRequest: Encodable {
    let enable_hr: Bool = false
    let denoising_strength: Double = 0
    let firstphase_width: Int = 0
    let firstphase_height: Int = 0
    let hr_scale: Double = 2
    let hr_upscaler: String = ""
    let hr_second_pass_steps: Int = 0
    let hr_resize_x: Int = 0
    let hr_resize_y: Int = 0
    let hr_sampler_name: String = ""
    let hr_prompt: String = ""
    let hr_negative_prompt: String = ""
    let prompt: String
    let styles: [String] = []
    let seed: Int = -1
    let subseed: Int = -1
    let subseed_strength: Double = 0
    let seed_resize_from_h: Int = -1
    let seed_resize_from_w: Int = -1
    let sampler_name: String = ""
    let batch_size: Int = 1
    let n_iter: Int = 1
    let steps: Int = 22
    let cfg_scale: Double = 7
    let width: Int = 256
    let height: Int = 256
    let restore_faces: Bool = false
    let tiling: Bool = false
    let negative_prompt: String = ""
    let eta: Double = 0
    let s_min_uncond: Double = 0
    let s_churn: Double = 0
    let s_tmax: Double = 0
    let s_tmin: Double = 0
    let s_tnoise: Double = 1
}

/// Response
struct TextToImageResponseDto: Decodable {
    let images: [String]?
    let parameters: TextToImageRequestDto?
    let info: String?
    
    enum CodingKeys: String, CodingKey {
        case images,
        parameters,
        info
    }
}

struct TextToImageRequestDto: Decodable {
    let enable_hr: Bool?
    let denoising_strength: Double?
    let firstphase_width: Int?
    let firstphase_height: Int?
    let hr_scale: Double?
    let hr_upscaler: String?
    let hr_second_pass_steps: Int?
    let hr_resize_x: Int?
    let hr_resize_y: Int?
    let hr_sampler_name: String?
    let hr_prompt: String?
    let hr_negative_prompt: String?
    let prompt: String?
    let styles: [String]?
    let seed: Int?
    let subseed: Int?
    let subseed_strength: Double?
    let seed_resize_from_h: Int?
    let seed_resize_from_w: Int?
    let sampler_name: String?
    let batch_size: Int?
    let n_iter: Int?
    let steps: Int?
    let cfg_scale: Double?
    let width: Int?
    let height: Int?
    let restore_faces: Bool?
    let tiling: Bool?
    let negative_prompt: String?
    let eta: Double?
    let s_min_uncond: Double?
    let s_churn: Double?
    let s_tmax: Double?
    let s_tmin: Double?
    let s_tnoise: Double?
    
    enum CodingKeys: String, CodingKey {
        case enable_hr,
             denoising_strength,
             firstphase_width,
             firstphase_height,
             hr_scale,
             hr_upscaler,
             hr_second_pass_steps,
             hr_resize_x,
             hr_resize_y,
             hr_sampler_name,
             hr_prompt,
             hr_negative_prompt,
             prompt,
             styles,
             seed,
             subseed,
             subseed_strength,
             seed_resize_from_h,
             seed_resize_from_w,
             sampler_name,
             batch_size,
             n_iter,
             steps,
             cfg_scale,
             width,
             height,
             restore_faces,
             tiling,
             negative_prompt,
             eta,
             s_min_uncond,
             s_churn,
             s_tmax,
             s_tmin,
             s_tnoise
    }
}
