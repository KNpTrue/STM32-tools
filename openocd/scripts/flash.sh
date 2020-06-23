#
# Copyright (c) 2020 KNpTrue
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Flash image by openocd.
# example: ./flash.sh interface/cmsis-dap.cfg target/stm32f1x.cfg $PROJECT_DIR/build/example.bin 0x08000000
#

# $1: interface config
# $2: target config
# $3: image path
# $4: base addr


printHelp() {
    echo Command usage:
    echo     $0 [interface] [target] [image path] [base address]
    exit 1
}

if [ -z $1 ]; then
    printHelp
fi

if [ -z $2 ]; then
    printHelp
fi

if [ -z $3 ]; then
    printHelp
fi

if [ -z $4 ]; then
    printHelp
fi

openocd -f $1 -f $2\
        -c "init"\
        -c "targets"\
        -c "reset halt"\
        -c "flash probe 0"\
        -c "flash write_image erase $3 $4"\
        -c "reset halt"\
        -c "verify_image $3 $4"\
        -c "reset run"\
        -c "shutdown"

if [ $? -eq 0 ]; then
    echo "Flash successfully"
fi
