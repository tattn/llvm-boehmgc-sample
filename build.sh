BOEHMGC_VERSION=`brew list --versions boehmgc | awk '{print $2}'`
BOEHMGC_PATH=/usr/local/Cellar/bdw-gc/$BOEHMGC_VERSION

OUTPUT=boehmgc
llc $OUTPUT.ll
cc -I$BOEHMGC_PATH/include/ \
	-L$BOEHMGC_PATH/lib/ -lgc \
	-o $OUTPUT $OUTPUT.s

