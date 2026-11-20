@echo off
rem ============================================================
rem  MewCode 鍚姩鍣紙Windows锛?rem
rem  浣滅敤锛氭妸鐢ㄦ埛绾?HOME 鎸囧埌椤圭洰鍐呯殑 .home 鐩綍锛岀粫寮€
rem  C:\Users\<浣?\.mewcode 鍐欎笉杩涘幓瀵艰嚧鐨?PermissionError銆?rem  椤圭洰閰嶇疆 .mewcode\config.yaml 涓嶅彈褰卞搷锛堟寜褰撳墠宸ヤ綔鐩綍璇诲彇锛夈€?rem
rem  鐢ㄦ硶锛氬弻鍑绘湰鏂囦欢锛屾垨鍦ㄧ粓绔噷鎵ц run-mewcode.cmd
rem  棰濆鍙傛暟浼氶€忎紶锛屼緥濡傦細run-mewcode.cmd --mode plan
rem ============================================================
setlocal
cd /d "%~dp0"

if not exist ".home\.mewcode\memory" mkdir ".home\.mewcode\memory" 2>nul
set "USERPROFILE=%~dp0.home"

if not exist ".venv\Scripts\mewcode.exe" (
    echo [run-mewcode] 鏈壘鍒?.venv锛屽厛鎵ц锛歶v sync --dev
    exit /b 1
)

".venv\Scripts\mewcode.exe" %*
endlocal
