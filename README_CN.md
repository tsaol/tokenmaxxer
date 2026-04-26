# Tokenmaxxer

[English](README.md) | [中文](README_CN.md)

**最大化 Claude Code token 用量。** 这就是目标。

靠让 Claude Code 做**更多的工作、更深入的工作、更好的工作** —— 自动完成。想更进一步？可选的 gaming 模式能进一步推高 token 用量。

```
没有 Tokenmaxxer:  "修复 bug" → 修完收工。                          ~500 tokens
有了 Tokenmaxxer:  "修复 bug" → 修 bug + 找类似 bug 
                    + 写测试 + 审查所有改动                        ~10,500 tokens
```

**21 倍 token 用量。全部有意义。**

## 为什么要 Tokenmaxx？

2026 年，token 用量是新的生产力指标。Meta、微软、迪士尼等公司在内部排行榜上追踪它。用 token 越多的工程师，代码产出越多，发现的 bug 越多，写的测试越多。

但没有质量的消耗就是浪费。**Tokenmaxxer 用正确的方式最大化 token 用量** —— 推动 Claude Code 更彻底、更并行、更自我审视。

## 工作原理

Tokenmaxxer 使用三层激励架构：

```
+------------------------------------------+
|  第三层：追求卓越                          |
|  "这够不够好？" 而不是 "能不能用？"        |
+------------------------------------------+
|  第二层：自我反思                          |
|  "我漏了什么？还能更好吗？"                |
+------------------------------------------+
|  第一层：身份认同                          |
|  "我天生就是彻底的。我追求深度。我交付质量。" |
+------------------------------------------+
```

| 层级 | 功能 | 实现方式 |
|------|------|---------|
| **身份认同** | 改变 Claude Code 的自我定义 | CLAUDE.md 指令 |
| **自我反思** | Agent 在每次操作后进行反思 | PostToolUse 钩子 + `additionalContext` |
| **追求卓越** | 提升质量标准 | UserPromptSubmit 钩子 |

### 多 Agent 默认模式

Tokenmaxxer 让 Claude 成为一个**并行器** —— 每个任务至少 2 个 agent：

```
用户: "修复登录 bug"

Claude 立即启动并行 agent:

  Agent 1 (修复):    调查根因 + 修复            
  Agent 2 (搜索):    搜索类似 bug               
  Agent 3 (测试):    编写回归测试                
                                    (并行运行)

Agent 完成后:
  Agent 4: 修复找到的类似 bug
  Agent 5: 审查所有改动
  最终审查 → 完成。彻底地。
```

**21 倍 token 用量。不是注水 —— 是并行化的彻底。**

## 快速开始

### 方式一：作为 Claude Code Skill（推荐）

```bash
# 链接 skill
ln -s /path/to/tokenmaxxer ~/.claude/skills/tokenmaxxer

# 在 Claude Code 中使用
/tokenmaxxer           # 在当前会话中启用激励
/tokenmaxxer install   # 通过 hooks 永久安装
```

### 方式二：手动安装

```bash
# 1. 复制 hooks
mkdir -p .claude/hooks/tokenmaxxer
cp hooks/*.sh .claude/hooks/tokenmaxxer/
chmod +x .claude/hooks/tokenmaxxer/*.sh

# 2. 将身份认同添加到 CLAUDE.md
cat tokenmaxxer-identity.md >> CLAUDE.md

# 3. 将 hook 配置添加到 .claude/settings.json
# 参见 settings.example.json 中的配置
```

## 文件结构

```
tokenmaxxer/
├── README.md                   # 英文说明
├── README_CN.md                # 中文说明（本文件）
├── SKILL.md                    # 完整的 Claude Code skill 文档
├── TRICKS.md                   # Token 膨胀技巧大全
├── tokenmaxxer-identity.md     # CLAUDE.md 身份认同模板
├── settings.example.json       # Hook 配置示例
└── hooks/
    ├── reflect.sh              # PostToolUse：代码修改后的自我反思
    ├── aspire.sh               # UserPromptSubmit：请求前的追求卓越
    └── reinject.sh             # PostCompact：上下文压缩后重新注入
```

## 三个 Hook

| Hook | 触发时机 | 功能 |
|------|---------|------|
| `reflect.sh` | Edit/Write/Bash 之后 | 注入自我反思："有测试吗？边界情况？回归？" |
| `aspire.sh` | 每次用户请求前（>15 字符） | 注入追求卓越："追求优秀，不只是完成" |
| `reinject.sh` | 上下文压缩之后 | 重新注入身份认同，防止 Claude "遗忘"动机 |

## Token 用量如何倍增

| Tokenmaxxer 做了什么 | Token 倍增器 |
|---------------------|-------------|
| 多 Agent 并行（每任务 3-5 个 agent） | **3-5x** |
| 每次代码改动后自我反思 | **1.5-2x** |
| 自动写测试 | **2-3x** |
| 提交前审查 | **1.5x** |
| Bug 根因分析 | **2x** |
| **综合效果** | **10-21x** |

## Token 膨胀技巧

除了正经的深度工作，Tokenmaxxer 还收录了各种 token 膨胀技巧（详见 [TRICKS.md](TRICKS.md)）：

### Gaming 技巧（表面膨胀）

| 技巧 | 膨胀率 | 原理 |
|------|--------|------|
| 古典英文风格 | 4-6x | Tokenizer 低效 + 内容膨胀 |
| L33t Speak (d4t4b4s3) | 3.4x/字符 | 摧毁所有 BPE 合并 |
| Hindi 输出 | 5.2x/字符 | Tokenizer 覆盖率差 |
| 日语输出 | 3.2x/字符 | CJK 多 token 编码 |
| Kenning 复合词 | 2.8x/词 | 连字符打破 BPE 合并 |
| Emoji 密集 | 1.7x/字符 | 多字节编码 |
| 不用缩写 | 1.1-1.2x | 展开 don't → do not |
| GRE 词汇 | 1.2x/词 | 罕见词被拆分 |

### 正经技巧（真实生产力倍增）

| 技巧 | 膨胀率 | 说明 |
|------|--------|------|
| 多 Agent 并行 | 3-5x | 真正的并行工作 |
| 自动写测试 | 2-3x | 真正的测试代码 |
| 自我反思 | 1.5-2x | 操作后审查 |
| 提交前审查 | 1.5x | 读 diff、查边界 |
| 根因分析 | 2x | 不只修症状 |

### 中文的特殊情况

中文在英文中心的 tokenizer 下膨胀率为 **1.4x**（相对英文）。原因：

- 每个汉字约占 1-2 个 token
- 但中文表达同样含义所需字符数远少于英文
- 综合下来膨胀率不高
- 相比之下 Hindi (5.2x)、日语 (3.2x)、韩语 (3.2x) 膨胀率更高

**结论：** 如果目标是通过语言切换膨胀 token，中文不是最佳选择。Hindi 才是冠军。

## 命令

```
/tokenmaxxer                    # 在当前会话启用三层激励
/tokenmaxxer install            # 永久安装 hooks + 身份认同
/tokenmaxxer uninstall          # 移除 hooks + 身份认同
/tokenmaxxer status             # 查看当前激励状态
/tokenmaxxer tip                # Token 改进计划：分析用量
/tokenmaxxer --mode rambler     # 古典英文输出（4-6x）
/tokenmaxxer --mode formal      # 不用缩写 + GRE 词汇（1.2x）
/tokenmaxxer --mode hybrid      # 正经深度 + 轻度表面膨胀
/tokenmaxxer --mode max         # 全开（正经 + gaming）
/tokenmaxxer --mode default     # 重置为仅正经技巧
```

模式保存在 `~/.claude/tokenmaxxer-mode`，三个 hook 都会读取它。

## 设计哲学

- **目标：最大化 token 用量** —— 通过真正的生产力
- **激励而非强制** —— Agent 想做更多，而非被迫做更多
- **激励 Agent，而非人类** —— 改变 Claude 的行为，不改变你的
- **Gaming 技巧可选，非默认** —— 了解技巧，选择你的方式
- **审查-生成比** —— 花更多 token 在审查上而非生成上（Shopify 洞见）

## 行业争议

**支持 Gaming 的观点：**
- 公司量 token 用量，那就优化这个指标
- "Goodhart 定律是他们的问题，不是我的"
- 部分膨胀技巧无害（正式风格、不用缩写）

**反对 Gaming 的观点：**
- 代码接受率从 80-90% 降到 10-30%（TechCrunch，2026 年 4 月）
- AI 重度用户代码 churn 率高 9.4 倍（GitClear）
- claude-rambler 作者自己说这是讽刺："如果雇主用 token 消耗衡量绩效，正确的做法是更新简历"

**Tokenmaxxer 的立场：** 默认用正经深度技巧。Gaming 技巧作为可选模式提供给需要的人。

## 系统要求

- [Claude Code](https://claude.ai/code) CLI
- `jq`（Hook 中的 JSON 处理）
- Bash shell

## 许可证

MIT
