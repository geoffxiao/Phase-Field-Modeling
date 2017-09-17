#!/bin/bash
qsub -v start='0.25' stop='0.35' pct='1' run
qsub -v start='0.45' stop='-0.55' pct='1' run
