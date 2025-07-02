#!/bin/bash

# 앱 아이콘 생성 스크립트
# 사용법: ./generate_app_icons.sh app_icon.png

if [ "$#" -ne 1 ]; then
    echo "사용법: $0 <이미지파일>"
    echo "예시: $0 app_icon.png"
    exit 1
fi

INPUT_IMAGE="$1"
ICON_DIR="kotoba_kanji/Assets.xcassets/AppIcon.appiconset"

# 입력 이미지 확인
if [ ! -f "$INPUT_IMAGE" ]; then
    echo "❌ 이미지 파일을 찾을 수 없습니다: $INPUT_IMAGE"
    echo "💡 첨부하신 이미지를 'app_icon.png' 이름으로 저장해주세요."
    exit 1
fi

echo "🎨 앱 아이콘 생성 시작..."
echo "📁 입력 이미지: $INPUT_IMAGE"
echo "📂 출력 폴더: $ICON_DIR"

# 기존 아이콘 파일들 제거
rm -f "$ICON_DIR"/*.png

# iOS 앱 아이콘 크기 배열 (filename:size 형식)
declare -a SIZES=(
    "icon_20x20.png:20"
    "icon_20x20@2x.png:40"
    "icon_20x20@3x.png:60"
    "icon_29x29.png:29"
    "icon_29x29@2x.png:58"
    "icon_29x29@3x.png:87"
    "icon_40x40.png:40"
    "icon_40x40@2x.png:80"
    "icon_40x40@3x.png:120"
    "icon_60x60@2x.png:120"
    "icon_60x60@3x.png:180"
    "icon_76x76.png:76"
    "icon_76x76@2x.png:152"
    "icon_83.5x83.5@2x.png:167"
    "icon_1024x1024.png:1024"
)

# 각 크기별로 아이콘 생성
for item in "${SIZES[@]}"; do
    filename=$(echo $item | cut -d: -f1)
    size=$(echo $item | cut -d: -f2)
    
    echo "📐 생성 중: ${filename} (${size}x${size})"
    
    sips -z $size $size "$INPUT_IMAGE" --out "$ICON_DIR/$filename" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "✅ $filename 생성 완료"
    else
        echo "❌ $filename 생성 실패"
    fi
done

echo ""
echo "🎉 앱 아이콘 생성 완료!"
echo "📱 생성된 아이콘 파일들:"
ls -la "$ICON_DIR"/*.png 2>/dev/null | awk '{print "   " $9 " (" $5 " bytes)"}'

echo ""
echo "🔄 이제 Contents.json을 업데이트합니다..." 