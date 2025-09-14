#!/bin/bash
# =================================
# run_all.sh
# Run complete bulk RNA-seq pipeline
# =================================

set -euo pipefail

LOGFILE="pipeline_$(date +%Y%m%d_%H%M%S).log"

exec > >(tee -i $LOGFILE)
exec 2>&1

echo ">>> Pipeline started at $(date)"

./scripts/00_prepare_genome.sh
./scripts/download_data.sh
./scripts/01_qc.sh
./scripts/02_trim.sh
./scripts/03_index.sh
./scripts/04_align.sh

echo ">>> Pipeline finished successfully at $(date)"
