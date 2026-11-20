# MewCode（Python 版）

一个跑在终端里的 AI 编码助手（TUI），基于 `textual` 构建界面，支持 Anthropic 与 OpenAI 兼容协议，带多 Agent 协作、MCP、Skill、分层记忆、Worktree、Hooks 等能力。

## 来源说明

本项目基于公众号 **@小林coding** 的《MewCode Agent 项目》课程版本整理而来，源码中的来源署名均予保留：

- 课程项目页：<https://www.xiaolincoding.com/project/mewcode.html>
- 作者站点：<https://xiaolincoding.com>

仓库中另有本人（[@jinzhizhuo](https://github.com/jinzhizhuo)）在本地使用过程中做的修复与工具化改动，见下方「本地改动」。

## 快速开始

需要 Python ≥ 3.11 与 [uv](https://docs.astral.sh/uv/)：

```bash
uv sync --dev

# 准备配置（填入自己的 api_key）
cp .mewcode/config.yaml.example .mewcode/config.yaml

uv run mewcode                 # 启动 TUI
```

配置读取顺序（后者覆盖前者）：`~/.mewcode/config.yaml` → `<项目>/.mewcode/config.yaml` → `<项目>/.mewcode/config.local.yaml`。
`api_key` 也可通过环境变量提供：`ANTHROPIC_API_KEY` / `OPENAI_API_KEY`。

### 三种运行模式

```bash
uv run mewcode                    # 交互式 TUI
uv run mewcode -p "解释一下这个仓库"  # 非交互，结果打到 stdout（可加 --output-format stream-json）
uv run mewcode --remote           # WebSocket + 浏览器 UI，默认 http://localhost:18888
```

### 测试

```bash
uv run pytest
```

## 本地改动

- **自动记忆降级**（`mewcode/memory/auto_memory.py`）：记忆目录不可写（权限不足、沙箱、只读盘）时降级为「没有记忆」并打一条 warning，不再让整轮对话崩掉。
- **UI 异常兜底**（`mewcode/app.py`）：`_send_message` 增加通用 `except`，未预料的异常会显示在聊天区并完整落日志，不再静默失败。
- **回归测试**（`tests/test_memory.py`）：新增 `test_load_survives_unwritable_memory_dir`。
- **Windows 启动器**（`run-mewcode.cmd`）：把 `USERPROFILE` 指到项目内的 `.home`，绕开受限环境下写不了用户目录的问题。

## 目录结构

```
mewcode/          # 主包：agent、TUI、工具、权限、MCP、记忆、团队协作、worktree…
mewcode/agents/   # 内置子 Agent 提示词（explore / plan / general-purpose / verification）
mewcode/tools/    # 工具实现（文件读写、Bash、Grep、Glob、任务、团队…）
tests/            # pytest 用例
.mewcode/         # 配置模板与本地技能（运行时产生的日志/会话不入库）
```
