import os
import glob

files = glob.glob('*.html')

replacements = {
    'Ã¢â‚¬â€': '-',
    'Ã‚Â·': '&middot;',
    'Ã¢â€ Â': '&larr;',
    'Ã¢â€ ': '&larr;',
    'â€”': '-',
    'â€“': '-',
    'A,A': '&middot;', # the mojibake version we saw in powershell output
}

for filepath in files:
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()
        
    original = content
    for old_str, new_str in replacements.items():
        content = content.replace(old_str, new_str)
        
    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Fixed mojibake in {filepath}")
