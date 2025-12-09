---
title: Markdown Cheat Sheet
description: >
  A quick reference guide for Markdown syntax used in documentation posts.
author: Nasrulla Ameen
date: 2025-12-08 09:00:00 -0600
categories: [Reference]
tags: [markdown, syntax, reference]
---

# Markdown Cheat Sheet

A quick reference guide for Markdown syntax commonly used in documentation.

## Headers

```markdown
# H1 Header
## H2 Header
### H3 Header
#### H4 Header
```

## Text Formatting

```markdown
**bold text**
*italic text*
***bold and italic***
~~strikethrough~~
`inline code`
```

## Lists

### Unordered Lists

```markdown
- Item 1
- Item 2
  - Nested item
  - Another nested item
- Item 3
```

### Ordered Lists

```markdown
1. First item
2. Second item
3. Third item
```

## Links and Images

```markdown
[Link text](https://example.com)
![Image alt text](https://example.com/image.png)
```

## Code Blocks

### Inline Code

```markdown
Use `code` inline with backticks.
```

### Code Blocks with Syntax Highlighting

````markdown
```bash
sudo apt update
sudo apt upgrade
```

```yaml
version: '3.8'
services:
  web:
    image: nginx:latest
```

```javascript
console.log('Hello World');
```
````

## Blockquotes

```markdown
> This is a blockquote.
> It can span multiple lines.
```

## Tables

```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |
```

## Horizontal Rules

```markdown
---
```

## Task Lists

```markdown
- [x] Completed task
- [ ] Incomplete task
```

## Escaping Characters

Use backslash `\` to escape special characters:

```markdown
\*not italic\*
```

## Jekyll-Specific Features

### Alerts/Prompts

```markdown
> This is a tip
{: .prompt-tip }

> This is a warning
{: .prompt-warning }

> This is an info note
{: .prompt-info }
```

### File Paths

```markdown
`_config.yml`{: .filepath }
```

## Best Practices

1. Use headers to structure your content
2. Keep paragraphs short and focused
3. Use code blocks for commands and configurations
4. Add descriptions to images
5. Use lists for step-by-step instructions
6. Keep line length reasonable (80-100 characters)

Happy writing!

