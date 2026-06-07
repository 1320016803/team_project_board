# 组员D工作指南 - 项目进度模块开发

## 项目信息
- **项目名称**：班级项目协作看板
- **仓库地址**：https://github.com/1320016803/team_project_board
- **个人Fork**：https://github.com/7luosong/team_project_board
- **开发分支**：member-d-progress
- **负责文件**：
  - `data/progress.py` - 补充Issue/PR进度
  - `data/changelog.py` - 补充版本日志

## 已完成的工作
✅ 1. 克隆个人Fork仓库  
✅ 2. 绑定组长上游主仓库upstream  
✅ 3. 拉取组长最新代码同步到main分支  
✅ 4. 创建D专属开发分支member-d-progress  
✅ 5. 创建自动化脚本

## 自动化脚本

### 1. 初始化脚本
```powershell
.\git-workflow-init.ps1
```
**功能**：执行完整的初始化流程
- 克隆仓库（如果不存在）
- 配置远程仓库（origin和upstream）
- 同步最新代码
- 创建开发分支

### 2. 提交脚本
```powershell
.\git-workflow-submit.ps1
```
**功能**：开发完成后提交推送
- 检查当前分支
- 运行项目测试
- 添加所有更改
- 提交更改（提交信息：`组员D：完成项目进度模块开发`）
- 推送到远程仓库

## 开发任务

### 需要修改的文件

#### 1. `data/progress.py` - Issue/PR进度
当前内容：
```python
PROGRESS_ITEMS = [
    {"issue": "#1", "owner": "组员 A", "title": "更新项目名称和口号", "status": "待提交 PR"},
    {"issue": "#2", "owner": "组员 B", "title": "补全成员与分工", "status": "待提交 PR"},
    {"issue": "#3", "owner": "组员 C", "title": "补充功能清单", "status": "待提交 PR"},
    {"issue": "#4", "owner": "组员 D", "title": "补充协作进度和日志", "status": "待提交 PR"},
]
```

**修改建议**：
- 更新各Issue的状态（例如：`"进行中"`、`"已完成"`、`"已合并"`）
- 添加实际完成时间
- 补充更多进度细节

#### 2. `data/changelog.py` - 版本日志
当前内容：
```python
CHANGELOG = [
    "v0.1 组长创建 PySide6 初始项目",
    "v0.2 等待组员通过 Fork + Pull Request 补充内容",
]
```

**修改建议**：
- 添加各版本的具体更新内容
- 记录每个Pull Request的合并情况
- 添加时间戳和负责人信息

## 工作流程

### 第一步：初始化环境
1. 打开PowerShell
2. 进入项目目录：`cd team_project_board`
3. 运行初始化脚本：`.\git-workflow-init.ps1`

### 第二步：开发代码
1. 确保在 `member-d-progress` 分支
2. 修改 `data/progress.py` 和 `data/changelog.py`
3. 运行测试：`python main.py`
4. 检查GUI是否正常显示

### 第三步：提交代码
1. 运行提交脚本：`.\git-workflow-submit.ps1`
2. 脚本会自动：
   - 检查当前分支
   - 添加所有更改
   - 提交更改
   - 推送到远程仓库

### 第四步：创建Pull Request
1. 访问：https://github.com/7luosong/team_project_board
2. 点击 "Compare & pull request" 按钮
3. 确保选择：
   - base repository: 1320016803/team_project_board
   - base: main
   - head repository: 7luosong/team_project_board
   - compare: member-d-progress
4. 填写PR信息：
   - 标题：组员D：完成项目进度模块开发
   - 描述：补充Issue/PR进度和版本日志功能
5. 点击 "Create pull request"
6. 等待组长审核和合并

## 常用Git命令

### 查看状态
```powershell
# 查看当前分支
git branch

# 查看状态
git status

# 查看提交历史
git log --oneline --graph

# 查看远程仓库
git remote -v
```

### 同步代码
```powershell
# 切换到main分支
git checkout main

# 从组长仓库拉取最新代码
git pull upstream main

# 推送到个人仓库
git push origin main

# 切换回开发分支
git checkout member-d-progress

# 合并main分支的更新
git merge main
```

### 提交代码
```powershell
# 添加所有更改
git add .

# 提交更改
git commit -m "组员D：完成项目进度模块开发"

# 推送到远程
git push origin member-d-progress
```

## 注意事项

### ⚠️ 重要规则
1. **不要直接在main分支上开发**
2. **每次开发前先同步最新代码**
3. **只修改自己负责的文件**
4. **提交前运行测试确保GUI正常**
5. **使用规范的提交信息**

### 文件修改规范
1. **progress.py**：记录项目进度和状态
2. **changelog.py**：记录版本更新历史
3. **保持代码格式一致**
4. **添加适当的注释**

### 测试要求
1. 修改后必须运行：`python main.py`
2. 检查GUI是否正常显示
3. 确保没有语法错误
4. 确认进度和日志显示正确

## 故障排除

### 常见问题
1. **克隆失败**：检查网络连接和Git配置
2. **推送失败**：检查远程仓库权限
3. **合并冲突**：先同步最新代码再解决冲突
4. **GUI不显示**：检查Python环境和依赖

### 解决方案
```powershell
# 安装依赖
pip install -r requirements.txt

# 检查Python版本
python --version

# 查看错误信息
python main.py 2>&1 | Out-Host
```

## 联系方式
如有问题，请联系组长或其他组员协助解决。

---

**最后更新**：2026年6月4日  
**版本**：v1.0  
**作者**：组员D（骆星宇）