@echo off
rem 管理员启动
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

chcp 65001

rem 进入当前文件夹
cd /d %~dp0

rem 检查python环境
echo 当前python版本为:
python --version
python --version | findstr /i "3.11" > nul
if %errorlevel% == 0 (
    echo Python 3.11 已正确安装
) else (
    echo Python 3.11 未正确安装

    echo 脚本只支持3.11，请勿安装其他版本
    pause
    exit /b 1
)

rem 检查虚拟环境后启动脚本
:start
if not exist env (
    echo 虚拟环境未安装，正在安装虚拟环境
    python -m venv env

    call env\Scripts\activate
    echo 已经激活虚拟环境

    echo 准备安装依赖
    pip install -r requirements.version.txt -i https://pypi.tuna.tsinghua.edu.cn/simple
    echo 依赖安装完成

    goto select

) 

    rem 激活虚拟环境
    call env\Scripts\activate
    echo 已经激活虚拟环境!!!

    rem 显示菜单
    :select
    echo 请输入需要执行的脚本

    echo 1.正常锄地

    echo 2.锄地完成后关闭游戏

    echo 3.锄地后关机

    echo 999.重新安装


    set /p X=请输入序号：
    if %X%==1 goto runhonkai1
    if %x%==2 goto runhonkai2
    if %x%==3 goto runhonkai3
    if %x%==999 goto rebuild
    echo 输入错误，重新选择
    goto select

    
    rem 启动脚本
    :runhonkai1
    echo 开始正常锄地,正在启动中...
    python honkai_star_rail.py
    exit

    :runhonkai2
    echo 开始锄地(完成后将关闭游戏),正在启动中...
    python honkai_star_rail.py
    taskkill /f /im StarRail.exe
    exit

    :runhonkai3
    echo 开始锄地(完成后将自动关机),正在启动中...
    python honkai_star_rail.py
    taskkill /f /im StarRail.exe
    shutdown /f /s /t 60
    exit

    rem 重新安装
    :rebuild
    echo 正在删除env文件夹，请勿退出!!!

    echo 如果出现异常，可关闭脚本后手动删除env文件夹后重新运行

    rd /s /q env
    goto start

    @REM rem 启动脚本
    @REM :runhonkai1
    @REM echo 开始正常锄地,正在启动中...
    @REM python honkai_star_rail.py
    @REM taskkill /f /im StarRail.exe
    @REM goto over

    @REM :runhonkai2
    @REM echo 开始锄地(完成后将关闭游戏),正在启动中...
    @REM python Exit_honkai_star_rail.py
    @REM goto over

    @REM :runhonkai3
    @REM echo 开始锄地(完成后将自动关机),正在启动中...
    @REM python Autoshutdown_honkai_star_rail.py
    @REM goto over

    @REM rem 结束
    @REM :over
    @REM echo 按任意键结束
    @REM pause > nul


