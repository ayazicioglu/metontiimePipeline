#!/bin/bash

# Ana dizin (tırnak işaretleriyle)
BASE_DIR="/media/maciek/USB DISK/Barcoding Results"

# Çıktı dizini
OUTPUT_DIR="/media/maciek/USB DISK/merged_tables"

# Metadata dosyalarının yollarını bir diziye kaydet
declare -a METADATA_PATHS

# Her barcode için run_ klasörünü bul ve metadata yollarını diziye ekle
for i in {1..9}; do
    RUN_DIR=$(ls -d "${BASE_DIR}/barcode${i}/run_"*/ | head -n 1)
    if [ -f "${RUN_DIR}/metadata.tsv" ]; then
        METADATA_PATHS+=("${RUN_DIR}/metadata.tsv")
    fi
done

# Birleştirilmiş metadata dosyasını oluştur
# İlk dosyanın başlık satırını al
head -n 1 "${METADATA_PATHS[0]}" > "${OUTPUT_DIR}/merged_metadata.tsv"

# Her dosyanın içeriğini (başlık hariç) ekle
for metadata_file in "${METADATA_PATHS[@]}"; do
    tail -n +2 "$metadata_file" >> "${OUTPUT_DIR}/merged_metadata.tsv"
done

echo "Metadata files merged successfully to ${OUTPUT_DIR}/merged_metadata.tsv"
