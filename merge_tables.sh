#!/bin/bash

# Ana dizin (tırnak işaretleriyle)
BASE_DIR="/media/maciek/USB DISK/Barcoding Results"

# Tüm yolları bir diziye kaydet
declare -a TABLE_PATHS

# Her barcode için run_ klasörünü bul ve yolları diziye ekle
for i in {1..9}; do
    RUN_DIR=$(ls -d "${BASE_DIR}/barcode${i}/run_"*/ | head -n 1)
    TABLE_PATHS+=("${RUN_DIR}/derepSeq/table.qza")
done

# Birleştirme komutunu çalıştır
qiime feature-table merge \
    --i-tables "${TABLE_PATHS[@]}" \
    --p-overlap-method sum \
    --o-merged-table "/media/maciek/USB DISK/merged_tables/merged_table.qza"
