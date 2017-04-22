Example to use Boehm GC on LLVM IR.  
====

see: [boehmgc.ll](https://github.com/tattn/llvm-boehmgc-sample/blob/master/boehmgc.ll)

```sh
# build.sh

BOEHMGC_VERSION=`brew list --versions boehmgc | awk '{print $2}'`
BOEHMGC_PATH=/usr/local/Cellar/bdw-gc/$BOEHMGC_VERSION
OUTPUT=boehmgc

llc $OUTPUT.ll
cc -I$BOEHMGC_PATH/include/ \
	-L$BOEHMGC_PATH/lib/ -lgc \
	-o $OUTPUT $OUTPUT.s
```

```bash
$ ./build.sh
$ ./boehmgc
1234567890
freed 0
freed 1
freed 2
freed 3
.
.
.
freed 98
```

