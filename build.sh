rustc hello.rs
qemu-i386 hello
objdump -D hello > out.txt
head out.txt
