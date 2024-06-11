shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// 將UV坐標轉換到以畫面中心為原點
    vec2 uv = UV - vec2(0.5, 0.5);
    uv.x *= SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y; // 調整x軸比例以適應屏幕寬高比

    // 計算相對於屏幕尺寸的圓形半徑
    float pixel_radius = 25.0; // 50像素直徑的一半
    float relative_radius = pixel_radius / SCREEN_PIXEL_SIZE.y; // 以屏幕高度為基準的相對半徑

    float dist = length(uv); // 計算當前片段與中心的距離

    // 使用平滑步驟函數來創建圓形
    float alpha = smoothstep(relative_radius, relative_radius - (1.0 / SCREEN_PIXEL_SIZE.y), dist);

    // 設置顏色和透明度
    COLOR = vec4(1.0, 0.0, 0.0, alpha); // 紅色圓形
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
