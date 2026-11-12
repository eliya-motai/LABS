# Preparing Your Lab Environment

**Introduction to Cyber Security — JCT**
Version 4.0 (GitHub Codespaces). Replaces the AWS Cloud9 guide.

---

## What you are setting up

All labs in this course run in a **GitHub Codespace**: a Linux machine in the
cloud with VS Code in your browser. Nothing is installed on your own computer,
and it works identically on Windows, macOS, Linux, and Chromebooks.

The environment comes pre-built with everything the labs need — the C compiler
with 32-bit support, `gdb`, OpenSSL, John the Ripper, Apache, PHP and MySQL.
You do not install any of it yourself.

---

## Step 1 — Create a GitHub account

If you do not already have one, sign up at <https://github.com>. The free plan
is enough for this course.

**Do this too:** apply for the **GitHub Student Developer Pack** at
<https://education.github.com/pack> using your JCT student email address.
Verification takes a day or two and raises your free Codespaces allowance from
120 to 180 core-hours per month. Apply in the first week of the semester.

---

## Step 2 — Make your own copy of the labs repository

1. Open the course repository: **`machon_lev_cyber_labs`** (link on the course
   site).
2. Click **Use this template → Create a new repository** (or **Fork**, if the
   button says that instead).
3. Name it something like `cyber-labs`, keep it **private**, and create it.

You now have your own copy. Your work stays in your repository — this is what
you will submit.

> Do **not** work directly in the course repository. You will not be able to
> save anything there.

---

## Step 3 — Launch the Codespace

In **your** copy of the repository:

1. Click the green **Code** button.
2. Choose the **Codespaces** tab.
3. Click **Create codespace on main**.

The first launch takes a few minutes while the machine is built — this happens
**once**. Later launches take a few seconds.

When the terminal shows

```
Lab environment ready. Web server: port 80 (see the PORTS tab).
```

you are ready to work.

---

## Step 4 — Check that everything works

Open the terminal in VS Code (**Ctrl+`**) and run:

```bash
gcc --version              # C compiler
gcc -m32 -v 2>&1 | tail -1 # 32-bit support
gdb --version              # debugger
openssl version            # crypto labs
john --list=build-info | head -1
php --version
mysql -e "SELECT VERSION();"   # may need: sudo mysql -e "SELECT VERSION();"
```

If any of these fail, see *Troubleshooting* below.

---

## Working with the web labs (SQL injection, XSS, DoS)

Apache is already running inside your Codespace on port 80.

* Open the **PORTS** tab at the bottom of VS Code.
* Find port **80** and click the globe icon (**Open in Browser**).
* You get a private HTTPS address that only you can reach.

Notes:

* The address changes every time a new Codespace is created — always take it
  from the PORTS tab rather than bookmarking it.
* If a lab asks you to open the page from a second browser or another device,
  right-click the port → **Port Visibility → Public**. Set it back to
  **Private** when you finish.

---

## Working with the memory-corruption labs (buffer overflow, integer overflow)

Compile as the lab sheet instructs, for example:

```bash
gcc -m32 -fno-stack-protector -z execstack -no-pie -o vuln vuln.c
```

Address-space randomisation cannot be switched off system-wide inside a
Codespace, because the kernel is shared. Instead:

* Inside **gdb** — randomisation is already disabled for you, nothing to do.
* Outside gdb — prefix the program with `noaslr`:

```bash
noaslr ./vuln AAAAAAAA
```

Addresses will then be stable between runs, exactly as the lab expects.

---

## Managing your free quota

Your free allowance is **120 core-hours per month** (180 with the Student
Developer Pack) plus **15 GB of storage**. A 2-core Codespace uses 2 core-hours
per hour of actual use, so that is roughly 60 (or 90) hours of lab time per
month — far more than this course needs, *if* you follow two habits:

1. **Stop your Codespace when you finish.** It also auto-stops after 30 minutes
   of inactivity, but do not rely on that.
   Stop it from <https://github.com/codespaces>.
2. **Keep only one Codespace.** Stopped Codespaces still consume storage.
   Delete old ones from the same page.

Your code lives in Git, not in the Codespace. Commit and push before deleting
anything:

```bash
git add -A
git commit -m "lab 3 complete"
git push
```

---

## Troubleshooting

**The web page will not load / connection refused**
Apache probably did not restart after a resume:
```bash
sudo service apache2 start
```

**`mysql` says it cannot connect**
```bash
sudo service mysql start
sudo mysqladmin ping
```

**The build failed on first launch**
From <https://github.com/codespaces>, delete the Codespace and create a new
one. If it fails again, send the build log (**Codespaces: View Creation Log**
from the command palette) to the course forum.

**"You have exceeded your Codespaces quota"**
Check <https://github.com/settings/billing>. Usually this means old Codespaces
were left running or stored — delete them. Apply for the Student Developer Pack
if you have not yet.

**I lost my work**
Only files committed and pushed to Git survive deletion of a Codespace. Commit
at the end of every lab session.

---

## Optional: use VS Code on your own machine

If you prefer the desktop editor, install VS Code plus the **GitHub Codespaces**
extension, then **Codespaces: Connect to Codespace**. The compute still runs in
the cloud; only the editor is local. Everything in this guide still applies.
