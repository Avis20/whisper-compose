file="$1"
echo "ls -la $file";

model="$2"
if [ -z "$model" ]; then
    model="large";
fi

device="$3"
if [ -z "$device" ]; then
    device="cpu";
fi

cmd="poetry run whisper $file --device $device --task transcribe --language Russian --output_format txt --model $model --output_dir ./transcribe";
echo "$cmd";
bash -c "$cmd";
