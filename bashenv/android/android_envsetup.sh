function ag() {
    case "$1" in
        wifi)
            cd $(getTop)packages/modules/Wifi
        ;;
        fb)
            cd $(getTop)frameworks/base
        ;;
        fbs)
            cd $(getTop)frameworks/base/service
        ;;
        opt)
            cd $(getTop)frameworks/opt/net/wifi
        ;;
        opts)
            cd $(getTop)frameworks/opt/net/wifi/service
        ;;
        settingslib)
            cd $(getTop)frameworks/base/packages/SettingsLib
        ;;
        hidl)
            cd $(getTop)hardware/interfaces/wifi
        ;;
        wificond)
            cd $(getTop)system/connectivity/wificond
        ;;
        wpa)
            cd $(getTop)external/wpa_supplicant_8
        ;;
        networkstack)
            cd $(getTop)packages/modules/NetworkStack
        ;;
        connectivity)
            cd $(getTop)packages/modules/Connectivity
        ;;
        vicewifi)
            cd $(getTop)vendor/asus/proprietary/vicewifi
        ;;
        ext)
            cd $(getTop)vendor/asus/wifi/WifiExtdService
        ;;
        netd)
            cd $(getTop)system/netd
        ;;
        settings)
            if [ -d $(getTop)packages/apps/AsusSettings ]; then
                cd $(getTop)packages/apps/AsusSettings
            else
                cd $(getTop)packages/apps/Settings
            fi
        ;;
        driver)
            if echo "$PWD" | grep -qwi "mtk"; then
                cd $(getTop)vendor/mediatek/kernel_modules/connectivity/wlan/core/gen4m
            else
                cd $(getTop)vendor/qcom/opensource/wlan/qcacld-3.0
            fi
        ;;
        mtklog)
            cd $(getTop)vendor/mediatek/proprietary/packages/apps/MTKLogger
        ;;
        mtkfwdump)
            cd $(getTop)vendor/mediatek/proprietary/hardware/connectivity/combo_tool
        ;;
    esac
}

function godir()
{
    if [[ -z "$1" ]]; then
        echo "Usage: godir <regex>"
        return
    fi
    local T=$(gettop)
    local FILELIST
    if [ ! "$OUT_DIR" = "" ]; then
        mkdir -p $OUT_DIR
        FILELIST=$OUT_DIR/filelist
    else
        FILELIST=$T/filelist
    fi
    if [[ ! -f $FILELIST ]]; then
        echo -n "Creating index..."
        (\cd $T; find . -wholename ./out -prune -o -wholename ./.repo -prune -o -type f > $FILELIST)
        echo " Done"
        echo ""
    fi
    local lines
    lines=($(\grep "$1" $FILELIST | sed -e 's/\/[^/]*$//' | sort | uniq))
    if [[ ${#lines[@]} = 0 ]]; then
        echo "Not found"
        return
    fi
    local pathname
    local choice
    if [[ ${#lines[@]} > 1 ]]; then
        while [[ -z "$pathname" ]]; do
            local index=1
            local line
            for line in ${lines[@]}; do
                printf "%6s %s\n" "[$index]" $line
                index=$(($index + 1))
            done
            echo
            echo -n "Select one: "
            unset choice
            read choice
            if [[ $choice -gt ${#lines[@]} || $choice -lt 1 ]]; then
                echo "Invalid choice"
                continue
            fi
            pathname=${lines[@]:$(($choice-1)):1}
        done
    else
        pathname=${lines[@]:0:1}
    fi
    \cd $T/$pathname
}

# get out folder
# if $OUT is not empty, add "/", otherwise, return empty string
function getOUT() {
    if [[ -n "$OUT" ]]; then
        echo "$OUT/"
    fi
}

# get top folder
# if $gettop is not empty, add "/", otherwise, return empty string
function getTop() {
    if [[ -n "$(gettop)" ]]; then
        echo "$(gettop)"/
        return
    fi

    if [[ -n "$(gettop_yocto)" ]]; then
        echo "$(gettop_yocto)"/
        return
    fi
}

function gettop_yocto() {

    # Find the directory that contains layers/poky folder
    local dir=$(pwd)
    local TOPFOLDER=layers/poky

    if [ "$dir" == "$HOME" ] || [ "$dir" == "/" ]; then
        return
    fi

    while [ "$dir" != "$HOME" ]; do
        if [ -d "$dir/$TOPFOLDER" ]; then
            echo "$dir"
            return
        fi
        dir=$(dirname "$dir")
    done
}

function gettop
{
    local TOPFILE=build/make/core/envsetup.mk
    if [ -n "$TOP" -a -f "$TOP/$TOPFILE" ] ; then
        # The following circumlocution ensures we remove symlinks from TOP.
        (cd "$TOP"; PWD= /bin/pwd)
    else
        if [ -f $TOPFILE ] ; then
            # The following circumlocution (repeated below as well) ensures
            # that we record the true directory name and not one that is
            # faked up with symlink names.
            PWD= /bin/pwd
        else
            local HERE=$PWD
            local T=
            while [ \( ! \( -f $TOPFILE \) \) -a \( "$PWD" != "/" \) ]; do
                \cd ..
                T=`PWD= /bin/pwd -P`
            done
            \cd "$HERE"
            if [ -f "$T/$TOPFILE" ]; then
                echo "$T"
            fi
        fi
    fi
}

function croot()
{
    local T=$(getTop)
    if [ "$T" ]; then
        if [ "$1" ]; then
            \cd $(getTop)/$1
        else
            \cd $(getTop)
        fi
    else
        echo "Couldn't locate the top of the tree.  Try setting TOP."
    fi
}

function check_type() { type -t "$1"; }

# simplified version of ps; output in the form
# <pid> <procname>
function qpid()
{
    local prepend=''
    local append=''
    if [ "$1" = "--exact" ]; then
        prepend=' '
        append='$'
        shift
    elif [ "$1" = "--help" -o "$1" = "-h" ]; then
        echo "usage: qpid [[--exact] <process name|pid>"
        return 255
    fi

    local EXE="$1"
    if [ "$EXE" ] ; then
        qpid | \grep "$prepend$EXE$append"
    else
        adb shell ps \
            | tr -d '\r' \
            | sed -e 1d -e 's/^[^ ]* *\([0-9]*\).* \([^ ]*\)$/\1 \2/'
    fi
}

# simplified version of ps; output in the form
# <pid> <procname>
function apid()
{
    if [ "$1" ] ; then
        adb shell ps | egrep -i $1
    else
        adb shell ps
    fi
}

function getbugreports()
{
    local reports=(`adb shell ls /sdcard/bugreports | tr -d '\r'`)

    if [ ! "$reports" ]; then
        echo "Could not locate any bugreports."
        return
    fi

    local report
    for report in ${reports[@]}
    do
        echo "/sdcard/bugreports/${report}"
        adb pull /sdcard/bugreports/${report} ${report}
        gunzip ${report}
    done
}

function getsdcardpath()
{
    adb ${adbOptions} shell echo -n \$\{EXTERNAL_STORAGE\}
}

function getscreenshotpath()
{
    echo "$(getsdcardpath)/Pictures/Screenshots"
}

function getlastscreenshot()
{
    local screenshot_path=$(getscreenshotpath)
    local screenshot=`adb ${adbOptions} ls ${screenshot_path} | grep Screenshot_[0-9-]*.*\.png | sort -rk 3 | cut -d " " -f 4 | head -n 1`
    if [ "$screenshot" = "" ]; then
        echo "No screenshots found."
        return
    fi
    echo "${screenshot}"
    adb ${adbOptions} pull ${screenshot_path}/${screenshot}
}

function key_home()
{
    adb shell input keyevent 3
}

function key_back()
{
    adb shell input keyevent 4
}

function key_menu()
{
    adb shell input keyevent 82
}

. ~/.config/dotfiles/bashenv/android/grep.bash

