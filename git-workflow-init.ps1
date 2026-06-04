<# 
组员D：项目进度模块 初始化全流程脚本
作者：骆星宇
创建时间：2026-06-04
描述：完整的Git团队协作初始化脚本
#>

# 颜色定义
$ErrorColor = "Red"
$SuccessColor = "Green"
$InfoColor = "Yellow"
$StepColor = "Cyan"
$Separator = "=" * 50

Write-Host "`n$Separator" -ForegroundColor $StepColor
Write-Host "组员D：项目进度模块 初始化全流程" -ForegroundColor $StepColor
Write-Host "$Separator`n" -ForegroundColor $StepColor

# ========== 1. 克隆个人Fork仓库 ==========
Write-Host "1. 克隆个人Fork仓库..." -ForegroundColor $InfoColor
try {
    $repoUrl = "https://github.com/7luosong/team_project_board.git"
    $projectDir = "team_project_board"
    
    # 检查是否已存在目录
    if (Test-Path $projectDir) {
        Write-Host "目录 '$projectDir' 已存在，跳过克隆" -ForegroundColor $InfoColor
    } else {
        Write-Host "正在克隆仓库: $repoUrl" -ForegroundColor $InfoColor
        git clone $repoUrl
        if ($LASTEXITCODE -ne 0) {
            throw "克隆仓库失败"
        }
        Write-Host "仓库克隆成功" -ForegroundColor $SuccessColor
    }
    
    # 进入项目目录
    Set-Location $projectDir
    Write-Host "已进入项目目录: $(Get-Location)" -ForegroundColor $SuccessColor
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

# ========== 2. 绑定组长上游主仓库upstream ==========
Write-Host "`n2. 绑定组长上游主仓库upstream..." -ForegroundColor $InfoColor
try {
    $upstreamUrl = "https://github.com/1320016803/team_project_board.git"
    
    # 检查是否已配置upstream
    $remotes = git remote -v 2>&1 | Out-String
    if ($remotes -match "upstream") {
        Write-Host "upstream已配置" -ForegroundColor $InfoColor
    } else {
        git remote add upstream $upstreamUrl
        if ($LASTEXITCODE -ne 0) {
            throw "添加upstream远程仓库失败"
        }
        Write-Host "upstream远程仓库添加成功" -ForegroundColor $SuccessColor
    }
    
    Write-Host "`n===远程仓库配置信息===" -ForegroundColor $InfoColor
    git remote -v
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

# ========== 3. 拉取组长最新代码同步到自己main分支 ==========
Write-Host "`n3. 拉取组长最新代码同步到自己main分支..." -ForegroundColor $InfoColor
try {
    # 切换到main分支
    git checkout main
    if ($LASTEXITCODE -ne 0) {
        throw "切换到main分支失败"
    }
    Write-Host "已切换到main分支" -ForegroundColor $SuccessColor
    
    # 从upstream拉取最新代码
    Write-Host "从upstream拉取最新代码..." -ForegroundColor $InfoColor
    git pull upstream main
    if ($LASTEXITCODE -ne 0) {
        Write-Host "警告: 从upstream拉取失败，可能是网络问题或权限不足" -ForegroundColor $ErrorColor
        Write-Host "跳过此步骤，继续执行..." -ForegroundColor $InfoColor
    } else {
        Write-Host "从upstream拉取成功" -ForegroundColor $SuccessColor
    }
    
    # 推送到origin
    Write-Host "推送到origin个人仓库..." -ForegroundColor $InfoColor
    git push origin main
    if ($LASTEXITCODE -ne 0) {
        Write-Host "警告: 推送到origin失败，可能是网络问题或权限不足" -ForegroundColor $ErrorColor
        Write-Host "跳过此步骤，继续执行..." -ForegroundColor $InfoColor
    } else {
        Write-Host "推送到origin成功" -ForegroundColor $SuccessColor
    }
    
    Write-Host "`n===主干代码同步完成===" -ForegroundColor $SuccessColor
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

# ========== 4. 创建D专属开发分支 ==========
Write-Host "`n4. 创建D专属开发分支..." -ForegroundColor $InfoColor
try {
    $branchName = "member-d-progress"
    
    # 检查是否已存在该分支
    $branches = git branch 2>&1 | Out-String
    if ($branches -match $branchName) {
        Write-Host "分支 '$branchName' 已存在，切换到该分支" -ForegroundColor $InfoColor
        git checkout $branchName
    } else {
        # 创建新分支
        git checkout -b $branchName
        if ($LASTEXITCODE -ne 0) {
            throw "创建开发分支失败"
        }
        Write-Host "成功创建开发分支: $branchName" -ForegroundColor $SuccessColor
    }
    
    Write-Host "`n===当前分支状态===" -ForegroundColor $InfoColor
    git branch
} catch {
    Write-Host "错误: $_" -ForegroundColor $ErrorColor
    exit 1
}

Write-Host "`n$Separator" -ForegroundColor $StepColor
Write-Host "初始化完毕，在member-d-progress分支编写进度功能代码" -ForegroundColor $StepColor
Write-Host "$Separator`n" -ForegroundColor $StepColor

# ========== 项目信息 ==========
Write-Host "项目信息：" -ForegroundColor $InfoColor
Write-Host "1. 项目目录: $(Get-Location)" -ForegroundColor $InfoColor
Write-Host "2. 当前分支: $(git branch --show-current)" -ForegroundColor $InfoColor
Write-Host "3. 远程仓库:" -ForegroundColor $InfoColor
git remote -v

Write-Host "`n组员D的任务：" -ForegroundColor $InfoColor
Write-Host "- 修改文件: data/progress.py (补充Issue/PR进度)" -ForegroundColor $InfoColor
Write-Host "- 修改文件: data/changelog.py (补充版本日志)" -ForegroundColor $InfoColor
Write-Host "- 运行测试: python main.py (检查GUI是否正常)" -ForegroundColor $InfoColor

Write-Host "`n下一步：" -ForegroundColor $InfoColor
Write-Host "1. 修改上述两个文件" -ForegroundColor $InfoColor
Write-Host "2. 运行 python main.py 测试" -ForegroundColor $InfoColor
Write-Host "3. 运行 git-workflow-submit.ps1 提交代码" -ForegroundColor $InfoColor