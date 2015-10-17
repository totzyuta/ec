# coding: utf-8
@dir = "/home/player/ec/"

worker_processes 1 # CPUのコア数に揃える
working_directory @dir

timeout 300
listen "#{@dir}tmp/unicorn.sock"

pid "#{@dir}tmp/unicorn.pid" #pidを保存するファイル

# unicornは標準出力には何も吐かないのでログ出力を忘れずに
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"
