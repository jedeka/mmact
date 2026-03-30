#!/usr/bin/env bash


# ***** global config *****
export MUJOCO_GL=egl 
export PYOPENGL_PLATFORM=egl 
export HF_HUB_OFFLINE=1
TIMESTAMP=$(date +"%y%m%d-%H:%M:%S")
USERNAME="jedeka30"

export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

# # ***** run lerobot act training *****
  # --dataset.root=datasets/grasp_box_local_260304-15_03_1772610893 \
  # --dataset.root=datasets/fast \
  # --steps=100000 \
  # --policy.repo_id=$USERNAME/${1}_model \


# export HF_HOME=/path/to/your/hf_cache
export TRANSFORMERS_OFFLINE=1
export HF_DATASETS_OFFLINE=1


# ***** tmp *****


## SMOLVLA
# --policy.optimizer_lr=0.00005 \
# --policy.scheduler_decay_steps=50000 \
# --policy.scheduler_warmup_steps=1000  \
# --policy.train_expert_only=false \
# --policy.freeze_vision_encoder=false \
# --policy.train_state_proj=true \

## PI0
# --policy.pretrained_path=./pi0 \
# --policy.use_bf16=true \
# --policy.use_peft=true \
# --policy.lora_rank=16 \
# --policy.lora_alpha=32 \
# --policy.lora_dropout=0.05 \

# ******* 


## bash run.sh pi0 ./datasets/slow_blue27_red26/
# torchrun --nproc_per_node=2 $(which lerobot-train) \
# deepspeed --num_gpus=2 $(which lerobot-train) \
#   --deepspeed deepspeed_zero3.json \
# accelerate launch --num_processes=2 --multi_gpu --fsdp_sharding_strategy=1 --mixed_precision=bf16 $(which lerobot-train) \
# CUDA_VISIBLE_DEVICES=0 lerobot-train \
CUDA_VISIBLE_DEVICES=1 python my_train.py \
  --dataset.root=$2 \
  --dataset.repo_id=jedeka30/grasp_box \
  --policy.type=${1} \
  --policy.device=cuda \
  --output_dir=outputs/train/${1}_model/$TIMESTAMP \
  --policy.repo_id=$USERNAME/${1}_model \
  --dataset.video_backend=pyav \
  --wandb.enable=true \
  --wandb.project=act \
  --job_name=${1}_${TIMESTAMP} \
  --save_checkpoint=true \
  --steps=500000 \
  --save_freq=5000 \
  --batch_size=32 \
  --eval.batch_size=1 \
  --eval.n_episodes=1 \
  --eval_freq=2000 \
  --policy.push_to_hub=false \

  # --policy.optimizer_lr=0.00005 \
  # --policy.scheduler_decay_steps=50000 \
  # --policy.scheduler_warmup_steps=1000  \
  # --policy.train_expert_only=false \
  # --policy.freeze_vision_encoder=false \
  # --policy.train_state_proj=true \

  # --policy.pretrained_path=./pi0 \
  # --policy.use_bf16=true \
  # --policy.use_peft=true \
  # --policy.lora_rank=16 \
  # --policy.lora_alpha=32 \
  # --policy.lora_dropout=0.05 \



  # --policy.train_expert_only=false \
  # --policy.n_action_steps=100 \
  # --policy.chunk_size=100 \



# # ***** run metaworld *****
# env="metaworld"
# # NOTE: switch the row when executing
# # CUDA_VISIBLE_DEVICES=0 python vlafb/lerobot/src/lerobot/scripts/lerobot_train.py \
# CUDA_VISIBLE_DEVICES=1 python train_hf.py \
#   --output_dir=./logs/$TIMESTAMP/ \
#   --policy.type=smolvla \
#   --policy.repo_id=jedeka30/metaworld-test \
#   --policy.load_vlm_weights=true \
#   --policy.private=true \
#   --policy.push_to_hub=false \
#   --dataset.repo_id=lerobot/metaworld_mt50 \
#   --env.type=metaworld \
#   --env.task=assembly-v3,basketball-v3,shelf-place-v3,door-open-v3 \
#   --eval.batch_size=1 \
#   --eval.n_episodes=1 \
#   --wandb.enable=true \
#   --wandb.project=vlafb \
#   --job_name=smolvla_${TIMESTAMP} \
#   --steps=100000 \
#   --batch_size=16 \
#   --save_freq=10000 \
#   --eval_freq=2000 \
#   --optimizer.lr=0.01 \

  # --env.task=assembly-v3,dial-turn-v3,handle-press-side-v3,door-open-v3 \
  # --steps=5000 \
#   # --resume=true \
#   # --config_path=cfg_svla_mt50.json 
  # --job_name=smolvla_${env}_${TIMESTAMP} \
  

# python train_hf.py \
#   --policy.type=smolvla \
#   --policy.repo_id=lerobot/smolvla_base \
#   --dataset.repo_id=lerobot/svla_so101_pickplace \
#   --batch_size=64 \
#   --steps=20000 \
#   --output_dir=outputs/pickplace_${TIMESTAMP} \
#   --policy.device=cuda \
#   --wandb.enable=true \
#   --wandb.project=svla_pickplace \
#   --job_name=smolvla_${TIMESTAMP} \



# ***** run libero *****

# CUDA_VISIBLE_DEVICES=0 python vlafb/lerobot/src/lerobot/scripts/lerobot_train.py \
#   --policy.type=smolvla \
#   --policy.load_vlm_weights=true \
#   --policy.private=true \
#   --dataset.repo_id=lerobot/ \
#   --env.type=metaworld \
#   --env.task=assembly-v3,dial-turn-v3,handle-press-side-v3 \
#   --output_dir=./outputs2/ \
#   --steps=100000 \
#   --batch_size=4 \
#   --eval.batch_size=1 \
#   --eval.n_episodes=1 \
#   --eval_freq=1000 \
#   --wandb.enable=true \
#   --job_name=smolvla_test \
#   # --resume=true \
#   # --config_path=cfg_svla_mt50.json 
  
  # CUDA_VISIBLE_DEVICES=0 lerobot-eval \
  # --policy.type=smolvla \
  # --policy.load_vlm_weights=true \
  # --policy.private=true \
  # --env.type=libero \
  # --env.task=libero_object \
  # --eval.batch_size=2 \
  # --eval.n_episodes=3



rm -rf ~/.cache/wandb/artifacts/