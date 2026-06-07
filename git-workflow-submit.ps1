<# 
组员D：代码提交推送脚本
作者：骆星宇
创建时间：2026-06-04
描述：开发完成后提交和推送代码的脚本
#>

# 颜色定义
$ErrorColor = "Red"
$SuccessColor = "Green"
$InfoColor = "Yellow"
$StepColor = "Cyan"
$Separator = "=" * 50

Write-Host "`n$Separator" -ForegroundColor $StepColor
Write-Host "组员D：代码提交推送" -ForegroundColor $StepColor
Write-Host "$Separator`n" -ForegroundColor $StepColor

# ========== 1. 检查当前分支 ==========
Write-Host "1. 检查当前分支..." -ForegroundColor $InfoColor
try {
    $currentBranch = git branch --show-current
    if ($LASTEXITCODE -ne 0) {
        throw "获取当前分支失败"
    }
    Write-Host "当前分支: $currentBranch" -ForegroundColor $SuccessColor
    
    $targetBranch = "member-d-progress"
    if ($currentBranch -ne $targetBranch) {
        Write-Host "警告：当前不在 $targetBranch 分支" -ForegroundColor $ErrorColor
        Write-Host "是否要切换到 $targetBranch 分支？(y/n)" -ForegroundColor $InfoColor
        $answer = Read-Host
        if ($answer -eq "y" -or $answer -eq "Y") {
            git checkout $targetBranch
            if ($LASTEXITCODE -ne 0) {
                throw "切换到 $targetBranch 分支失败"
            }
            Write-Host "已切换到 $targetBranch 分支" -ForegroundColor $SuccessColor
        } else {
            Write-Host "请在 $targetBranch 分支上运行此脚本" -ForegroundColor $ErrorColor
            exit 1
        }
    }
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

# ========== 2. 检查是否有未提交的更改 ==========
Write-Host "`n2. 检查工作区状态..." -ForegroundColor $InfoColor
try {
    $status = git status --porcelain
    if ([string]::IsNullOrWhiteSpace($status)) {
        Write-Host "没有需要提交的更改" -ForegroundColor $InfoColor
        Write-Host "请先修改代码后再运行此脚本" -ForegroundColor $InfoColor
        exit 0
    }
    
    Write-Host "检测到以下更改：" -ForegroundColor $InfoColor
    git status
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

# ========== 3. 运行项目测试 ==========
Write-Host "`n3. 运行项目测试..." -ForegroundColor $InfoColor
try {
    Write-Host "正在检查项目依赖..." -ForegroundColor $InfoColor
    
    # 检查requirements.txt是否存在
    if (Test-Path "requirements.txt") {
        Write-Host "requirements.txt 存在" -ForegroundColor $SuccessColor
    } else {
        Write-Host "警告: requirements.txt 不存在" -ForegroundColor $ErrorColor
    }
    
    # 检查main.py是否存在
    if (Test-Path "main.py") {
        Write-Host "main.py 存在" -ForegroundColor $SuccessColor
    } else {
        Write-Host "错误: main.py 不存在" -ForegroundColor $ErrorColor
        exit 1
    }
    
    Write-Host "`n建议运行测试命令: python main.py" -ForegroundColor $InfoColor
    Write-Host "请确保GUI正常运行后再提交代码" -ForegroundColor $InfoColor
    Write-Host "是否继续提交？(y/n)" -ForegroundColor $InfoColor
    $answer = Read-Host
    if ($answer -ne "y" -and $answer -ne "Y") {
        Write-Host "取消提交" -ForegroundColor $InfoColor
        exit 0
    }
} catch {
    Write-Host "测试检查错误: $_" -ForegroundColor $ErrorColor
    Write-Host "继续提交..." -ForegroundColor $InfoColor
}

# ========== 4. 添加所有更改 ==========
Write-Host "`n4. 添加所有更改..." -ForegroundColor $InfoColor
try {
    git add .
    if ($LASTEXITCODE -ne 0) {
        throw "添加更改失败"
    }
    Write-Host "所有更改已添加到暂存区" -ForegroundColor $SuccessColor
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

# ========== 5. 提交更改 ==========
Write-Host "`n5. 提交更改..." -ForegroundColor $InfoColor
try {
    $commitMessage = "组员D：完成项目进度模块开发"
    git commit -m $commitMessage
    if ($LASTEXITCODE -ne 0) {
        throw "提交更改失败"
    }
    Write-Host "更改已提交，提交信息: '$commitMessage'" -ForegroundColor $SuccessColor
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

# ========== 6. 推送到远程仓库 ==========
Write-Host "`n6. 推送到远程仓库..." -ForegroundColor $InfoColor
try {
    git push origin member-d-progress
    if ($LASTEXITCODE -ne 0) {
        throw "推送更改失败"
    }
    Write-Host "代码已成功推送到远程仓库" -ForegroundColor $SuccessColor
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

Write-Host "`n$Separator" -ForegroundColor $StepColor
Write-Host "代码推送完成，浏览器打开自己仓库提交PR合并到组长主仓库" -ForegroundColor $StepColor
Write-Host "$Separator`n" -ForegroundColor $StepColor

# ========== 下一步操作指南 ==========
Write-Host "下一步操作：" -ForegroundColor $InfoColor
Write-Host "1. 访问你的Github仓库: https://github.com/7luosong/team_project_board" -ForegroundColor $InfoColor
Write-Host "2. 点击 'Compare & pull request' 按钮（绿色按钮）" -ForegroundColor $InfoColor
Write-Host "3. 确保选择正确的分支：" -ForegroundColor $InfoColor
Write-Host "   - base repository: 1320016803/team_project_board (组长仓库)" -ForegroundColor $InfoColor
Write-Host "   - base: main" -ForegroundColor $InfoColor
Write-Host "   - head repository: 7luosong/team_project_board (你的仓库)" -ForegroundColor $InfoColor
Write-Host "   - compare: member-d-progress" -ForegroundColor $InfoColor
Write-Host "4. 填写PR信息：" -ForegroundColor $InfoColor
Write-Host "   - 标题: 组员D：完成项目进度模块开发" -ForegroundColor $InfoColor
Write-Host "   - 描述: 补充Issue/PR进度和版本日志功能" -ForegroundColor $InfoColor
Write-Host "5. 点击 'Create pull request' 提交" -ForegroundColor $InfoColor
Write-Host "6. 等待组长审核和合并" -ForegroundColor $InfoColor

Write-Host "`nPR链接：" -ForegroundColor $InfoColor
Write-Host "https://github.com/1320016803/team_project_board/compare/main...7luosong:member-d-progress" -ForegroundColor $SuccessColor