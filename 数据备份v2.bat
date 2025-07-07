@echo off
setlocal enabledelayedexpansion

:: 检查7z是否在系统环境变量PATH中
for %%A in (7z.exe) do (
    if exist "%%~$PATH:A" (
        echo 已经检测到7z，环境正常
        goto :open
    )
)

echo 你还没有下载7z或者7z未添加到环境变量
echo 请手动操作后再试
pause
exit /b 1

:open
CLS
echo 请选择要执行备份（用空格分隔多个选项）： 
echo 1 - 备份QQ数据
echo 2 - 备份微信数据
echo 3 - 备份企业微信数据
echo 0 - 执行上述所有
echo 输入其他内容离开
echo ---
echo 注意
echo 此脚本最后修改于2025.7.6
echo 在运行本脚本前，请确保需要备份的软件已经关闭
echo ---
set /p choices=请输入选项（例如：1 2 3）： 

:: 如果选择了0，则默认选择所有备份选项
if "%choices%"=="0" (
    set choices=1 2 3
)

echo %choices%
CLS

:: 获取当前日期和时间并格式化为 YYYYMMDDHHMM 格式
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set datetime=!datetime:~0,4!!datetime:~4,2!!datetime:~6,2!!datetime:~8,2!!datetime:~10,2!!
set backupFolderName=备份!datetime!
set zipname=备份!datetime!.zip
echo 获取日期和时间成功，备份文件将以 %zipname% 命名

:: 路径设置
set QQdata=F:\QQ Files
set WeChatdata=F:\WeChat Files
set QYWXdata=F:\WXWork
set backupdir=%~dp0QQ备份\%backupFolderName%\

:: 创建备份文件夹
mkdir "!backupdir!"

:: 根据用户选择执行备份
for %%i in (%choices%) do (
    if "%%i"=="1" (
        echo 执行QQ备份
        7z a -v4g -mx1 "!backupdir!!zipname!" "!QQdata!"
        echo QQ备份完成

    ) else if "%%i"=="2" (
        echo 执行微信备份
        7z a -v4g -mx1 "!backupdir!!zipname!" "!WeChatdata!"
        echo 微信备份完成

    ) else if "%%i"=="3" (
        echo 执行企业微信备份
        7z a -v4g -mx1 "!backupdir!!zipname!" "!QYWXdata!"
        echo 企业微信备份完成

    ) else (
        echo 无效的选项：%%i，请输入 1、2 或 3。
    )
)

echo 程序运行结束
pause
