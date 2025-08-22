file="$1"
echo "ls -la $file";

model="$2"
if [ -z "$model" ]; then
    model="large";
fi
cmd="time poetry run whisper $file --task transcribe --language Russian --output_format txt --model $model --output_dir ./transcribe";

device="$3"
if [ -z "$device" ]; then
    cmd="$cmd --device cpu";
fi

echo "$cmd";
bash -c "$cmd";
