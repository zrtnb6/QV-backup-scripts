@echo off
setlocal enabledelayedexpansion

:: ���7z�Ƿ���ϵͳ��������PATH��
for %%A in (7z.exe) do (
    if exist "%%~$PATH:A" (
        echo �Ѿ���⵽7z����������
        goto :open
    )
)

echo �㻹û������7z����7zδ��ӵ���������
echo ���ֶ�����������
pause
exit /b 1

:open
CLS
echo ��ѡ��Ҫִ�б��ݣ��ÿո�ָ����ѡ��� 
echo 1 - ����QQ����
echo 2 - ����΢������
echo 3 - ������ҵ΢������
echo 0 - ִ����������
echo �������������뿪
echo ---
echo ע��
echo �˽ű�����޸���2025.7.6
echo �����б��ű�ǰ����ȷ����Ҫ���ݵ�����Ѿ��ر�
echo ---
set /p choices=������ѡ����磺1 2 3���� 

:: ���ѡ����0����Ĭ��ѡ�����б���ѡ��
if "%choices%"=="0" (
    set choices=1 2 3
)

echo %choices%
CLS

:: ��ȡ��ǰ���ں�ʱ�䲢��ʽ��Ϊ YYYYMMDDHHMM ��ʽ
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set datetime=!datetime:~0,4!!datetime:~4,2!!datetime:~6,2!!datetime:~8,2!!datetime:~10,2!!
set backupFolderName=����!datetime!
set zipname=����!datetime!.zip
echo ��ȡ���ں�ʱ��ɹ��������ļ����� %zipname% ����

:: ·������
set QQdata=F:\QQ Files
set WeChatdata=F:\WeChat Files
set QYWXdata=F:\WXWork
set backupdir=%~dp0QQ����\%backupFolderName%\

:: ���������ļ���
mkdir "!backupdir!"

:: �����û�ѡ��ִ�б���
for %%i in (%choices%) do (
    if "%%i"=="1" (
        echo ִ��QQ����
        7z a -v4g -mx1 "!backupdir!!zipname!" "!QQdata!"
        echo QQ�������

    ) else if "%%i"=="2" (
        echo ִ��΢�ű���
        7z a -v4g -mx1 "!backupdir!!zipname!" "!WeChatdata!"
        echo ΢�ű������

    ) else if "%%i"=="3" (
        echo ִ����ҵ΢�ű���
        7z a -v4g -mx1 "!backupdir!!zipname!" "!QYWXdata!"
        echo ��ҵ΢�ű������

    ) else (
        echo ��Ч��ѡ�%%i�������� 1��2 �� 3��
    )
)

echo �������н���
pause
