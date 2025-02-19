#!/bin/bash

# Ana dizin (tırnak işaretleriyle)
BASE_DIR="/media/maciek/USB DISK/Barcoding Results"

# Tüm yolları bir diziye kaydet
declare -a TAXONOMY_PATHS

# Her barcode için run_ klasörünü bul ve yolları diziye ekle
for i in {1..9}; do
    RUN_DIR=$(ls -d "${BASE_DIR}/barcode${i}/run_"*/ | head -n 1)
    TAXONOMY_PATHS+=("${RUN_DIR}/assignTaxonomy/taxonomy.qza")
done

# Birleştirme komutunu çalıştır
qiime feature-table merge-taxa \
    --i-data "${TAXONOMY_PATHS[@]}" \
    --o-merged-data "/media/maciek/USB DISK/merged_tables/merged_taxonomy.qza"
