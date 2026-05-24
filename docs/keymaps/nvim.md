# nvim keymaps

## Word Movement


| Key | Action | Tags |
|---|---|---|
| w | Jump to next word start | motion word |
| e | Jump to end of word | motion word |
| b | Jump to previous word start | motion word backward |
| ge | Jump to previous word end | motion word backward |

## Line Navigation

| Key | Action | Tags |
|---|---|---|
| 0 | Go to beginning of line | navigation line |
| ^ | Go to first non-blank character | navigation line |
| $ | Go to end of line | navigation line |
| gg | Go to top of file | navigation file |
| G | Go to bottom of file | navigation file |

## Character Search

| Key | Action | Tags |
|---|---|---|
| f<char> | Find character forward | find character |
| F<char> | Find character backward | find character backward |
| t<char> | Move before character forward | till character |
| T<char> | Move after character backward | till character backward |
| ; | Repeat last character search | repeat find |
| , | Repeat last character search in opposite direction | repeat find reverse |

## Folding

| Key | Action | Tags |
|---|---|---|
| zf | Create fold | fold |
| zo | Open fold | fold open |
| zc | Close fold | fold close |
| za | Toggle fold | fold toggle |
| zR | Open all folds | fold open all |
| zM | Close all folds | fold close all |

## Marks

| Key | Action | Tags |
|---|---|---|
| m<char> | Set mark | mark |
| '<char> | Jump to mark line | mark jump |
| \`<char> | Jump to exact mark position | mark exact |

## Macros / Recording

| Key | Action | Tags |
|---|---|---|
| q<char> | Start recording macro | macro |
| q | Stop recording macro | macro |
| @<char> | Execute macro | macro run |
| @@ | Repeat last macro | macro repeat |


## Unclassified

| Key | Action | Tags |
|---|---|---|
| ctrl + a | increase number under cursor | increase number |
| ctrl + x | decrease number under cursor | decrease number |


## Append Text to End of Multiple Lines (Different Lengths)

### Visual Block Method

1. `Ctrl + v` → Enter Visual Block mode
2. `j` / `k` → Select multiple lines
3. `$` → Extend selection to end of each line
4. `Shift + a` (`A`) → Append at line end
5. Type text (example: `;`)
6. `Esc` → Apply to all lines

### Example

Before:
```txt
apple
banana
watermelon
```

After:
```txt
apple;
banana;
watermelon;
```

---

## Alternative: `:normal`

Useful for many lines without Visual Block.

1. `Shift + v` → Select lines
2. Run:

```vim
:normal A;
```

This appends `;` to the end of every selected line.

