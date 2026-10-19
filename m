Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107E5CCF2E3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2026 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gh8kzn/QJvmz8FixtNVHHt9eBjv+i+vGDVTK7Vg5tBk=; b=Ef46Px+6sFS3N6IHP8oeW5PKH6
	o3rU0UFHeBnSS0hvtrgNKtFFws54c9mq49CFaCw9trPZsdMTc5PqE7w/Gv/vPOQPbDjpETYxENC5H
	UMowQcCn5SmsUjNzveu9mdcLpvYiU4bRjua9WK7RFucD4TsRwQjEezRjKHwcZ9g5++zwZLmCSH5EK
	srtn0s/x6uluKBaQ/orzvLzlKG/+L0XVZmZ6ZKVeIrjwmpxWXW6Mn+2oMsGKuphjtmkeGnsOFbQ25
	Q3ZoW/cLfENdB26Mkkjs2gFDVJqrCf5vlmpdQq7SE78XlqYj/j2ji/5sasiHHViBaQIx8K2WJvFPj
	5EeL9Qfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xInwf-00000007eDD-2kSx;
	Mon, 19 Oct 2026 14:02:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xInwe-00000007eBW-1NJG
	for linux-nvme@lists.infradead.org;
	Mon, 19 Oct 2026 14:02:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 18C6240DEE;
	Mon, 19 Oct 2026 14:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78A41F000C4;
	Mon, 19 Oct 2026 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418552;
	bh=gh8kzn/QJvmz8FixtNVHHt9eBjv+i+vGDVTK7Vg5tBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kPAwoq98HywUq3DKbCe4AqgN+kS9jsX62WM3fdV8zOnfHl6+dAKPVpWx8QUR0RkO/
	 QGZ9fZlzW3zlv1UorLRFbYL5PUs/4n6GmNfK4d530SefHyWu7l7ckdxfApLFFn7uAe
	 1XLNu54GFwy1+uvIBn+WkPqh8/+JaidvLN6nj/jsCn2ykSqn2vRnPPJgGqtpJSP/Xp
	 qETfIjPgNnbDo9jJOoFM3llBhZPWl155TyQLBODuBBquAXMEgUEp8rKOkr/hMCsDW0
	 zkeBJTB/dwvf1ZYCjk3aImx5tJ0zRdJQbU5LVP5FSs+l9qauvi2tLw2XwomqFG7ZBN
	 ktzQy3X8Mq20Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	axboe@kernel.dk,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] nvme: handle positive error codes in nuse_show()
Date: Mon, 19 Oct 2026 09:50:20 -0400
Message-ID: <20261019135441.1420968-329-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019135441.1420968-1-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit dd516cd7624648c71d338d99368587f10ecc9f0b ]

Function __nvme_submit_sync_cmd() returns a positive error code for NVMe
errors. Otherwise, we get 0 for success or a negative error code for a
kernel error.

In nuse_show() -> ns_{head}_update_nuse() -> nvme_identify_ns() ->
nvme_submit_sync_cmd() -> __nvme_submit_sync_cmd(), we then may get a
positive error code returned.

Function nuse_show() - being a device attr handler - should return the
number of bytes written to the buffer or a negative error code.

Convert any positive NVMe error code to -EIO.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

I have the mailing-list thread and the sysfs/NVMe return-code path. Next
I’ll confirm how a positive NVMe status is treated as a byte count, then
give the backport verdict for this tree.

---

## PHASE 1: COMMIT MESSAGE FORENSICS

**Step 1.1: PARSE THE SUBJECT LINE**

Record: `[nvme] [handle] convert positive NVMe status codes from
nuse_show() into a proper sysfs errno`

- Subsystem: `nvme` (host sysfs)
- Verb: `handle` (bug-fix language: incorrect error handling)
- Intent: sysfs `nuse` show must not return a positive NVMe status as a
  “bytes written” count

**Step 1.2: PARSE ALL COMMIT MESSAGE TAGS**

Record:
- `Fixes:` — absent (expected for this review pipeline)
- `Reported-by:` — none
- `Tested-by:` — none
- `Reviewed-by: Christoph Hellwig <hch@lst.de>` (core NVMe reviewer)
- `Acked-by:` — none
- `Link:` — none in the commit; lore found separately
- `Cc: stable@vger.kernel.org` — absent (not a negative signal)
- `Signed-off-by: John Garry <john.g.garry@oracle.com>` (author)
- `Signed-off-by: Keith Busch <kbusch@kernel.org>` (NVMe maintainer;
  applied to nvme-7.3)
- Ignore pipeline `Signed-off-by: Sasha Levin` if present — not in this
  commit

**Step 1.3: ANALYZE THE COMMIT BODY TEXT**

Record:
- **Bug:** `__nvme_submit_sync_cmd()` returns 0, a negative Linux errno,
  or a **positive NVMe status**. That value is propagated `nuse_show() →
  ns_{head}_update_nuse() → nvme_identify_ns() →
  nvme_submit_sync_cmd()`.
- **Symptom:** `nuse_show()` is a device attribute handler; it must
  return a byte count or a negative errno. A positive NVMe status is
  neither.
- **Fix:** map `ret > 0` to `-EIO`; keep `ret < 0` as-is.
- **Version info in message:** none. Feature itself dates to v6.8
  (`a1a825ab6a603` “nvme: add csi, ms and nuse to sysfs”).
- **Root cause:** treating any non-zero `ret` as a sysfs error, which is
  wrong for positive NVMe codes (they are not negative, so they were
  returned as a success length).

**Step 1.4: DETECT HIDDEN BUG FIXES**

Record: Not hidden. Explicit error-handling fix. Same class as “add
missing check” / “handle X properly.”

---

## PHASE 2: DIFF ANALYSIS - LINE BY LINE

**Step 2.1: INVENTORY THE CHANGES**

Record:
- File: `drivers/nvme/host/sysfs.c` — **+3 / −1**
- Function: `nuse_show()` only
- Scope: **single-file surgical fix**

**Step 2.2: UNDERSTAND THE CODE FLOW CHANGE**

Record:
- **Before:** `if (ret) return ret;` — negative errno returned
  correctly; **positive NVMe status returned as the sysfs byte count**,
  and `sysfs_emit()` is skipped so the buffer is never filled with the
  NUSE value.
- **After:** `ret < 0` → pass through; `ret > 0` → `-EIO`; `ret == 0` →
  `sysfs_emit()` of `head->nuse`.
- Path affected: **error path** of a sysfs read that issues Identify
  Namespace (rate-limited).

**Step 2.3: IDENTIFY THE BUG MECHANISM**

Record:
- **Category:** logic/correctness of sysfs error conversion; can also
  trip a kernel `WARN`.
- **Mechanism:** NVMe completion status is stored as
  `le16_to_cpu(cqe->status) >> 1` (`nvme_try_complete_req()`).
  `nvme_execute_rq()` returns that value when non-zero. Status often
  includes `NVME_STATUS_DNR` (**0x4000 = 16384**).
- Sysfs (`sysfs_kf_seq_show` in `fs/sysfs/file.c`):
  - `count < 0` → error
  - `count >= PAGE_SIZE` → **`WARN(1, "OOB write or bad count ...")`**
    then clamp
  - otherwise `seq_commit(sf, count)` of a buffer that was `memset` to 0
    but never written by `nuse_show()`
- On 4K pages (typical x86_64), DNR-tagged Identify failures (`status |
  0x4000 >= 16384 > 4096`) **fire a kernel WARN**. Smaller statuses
  become a short successful read of zeros instead of `-EIO`.

**Step 2.4: ASSESS THE FIX QUALITY**

Record:
- Obviously correct: matches `__nvme_submit_sync_cmd()` contract and the
  existing `nvme_hwmon` pattern (`if (ret > 0) return -EIO`).
- Minimal; no unrelated edits; no API/struct changes.
- Regression risk **very low**: only the misclassified success path
  becomes `-EIO`, which is the intended ABI.

---

## PHASE 3: GIT HISTORY INVESTIGATION

**Step 3.1: BLAME THE CHANGED LINES**

Record:
- Buggy `if (ret) return ret;` introduced in **`a1a825ab6a603`** (Daniel
  Wagner, 2023-12-18), “nvme: add csi, ms and nuse to sysfs”.
- First appeared: **v6.8-rc1** (`git describe --contains` →
  `v6.8-rc1~121^2~25^2~4`).
- Present for a long time in this 7.3 lineage.

**Step 3.2: FOLLOW THE FIXES: TAG**

Record: No `Fixes:` tag. Buggy commit identified by blame:
`a1a825ab6a603`. That commit **is** an ancestor of this tree.

**Step 3.3: CHECK FILE HISTORY FOR RELATED CHANGES**

Record:
- `8d0d2447394b1` — double-free of `nvme_id_ns` in `ns_update_nuse()`
  (already in tree; different bug).
- `88c918d1ee2c88` — `nvme_disk_is_ns_head()` use in `nuse_show`.
- Standalone v1 patch; not “patch X/Y”.

**Step 3.4: CHECK THE AUTHOR'S OTHER COMMITS**

Record: John Garry is an active NVMe/block contributor (cdev lifetime,
multipath, sysfs). Nearby commits are unrelated lifetime/locking work,
not prerequisites of this hunk.

**Step 3.5: CHECK FOR DEPENDENT/PREREQUISITE COMMITS**

Record: None. Touches only `nuse_show()` control flow. `nuse_show`,
`ns_update_nuse`, `ns_head_update_nuse`, and `nvme_identify_ns` all
exist here. **Applies standalone.**

---

## PHASE 4: MAILING LIST AND EXTERNAL RESEARCH

**Step 4.1: FIND THE ORIGINAL PATCH DISCUSSION**

Record:
- `b4 dig -c dd516cd762464` → https://patch.msgid.link/20260630102717.26
  71475-1-john.g.garry@oracle.com
- **v1 only** (no v2/v3). Applied as submitted.
- Author note: could print `nvme_get_error_status_str()`; rejected as a
  bad idea (keeps the fix small).
- Christoph: “Looks good:” + `Reviewed-by`
- Keith Busch: “Thanks, applied to nvme-7.3.”
- No NAKs, no stable nomination, no risk flags.

**Step 4.2: CHECK WHO REVIEWED THE PATCH**

Record (`b4 dig -w`): To/Cc **hch@lst.de, kbusch@kernel.org,
sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org**. Right
maintainers; Hellwig reviewed; Busch applied.

**Step 4.3: SEARCH FOR THE BUG REPORT**

Record: No `Reported-by`, syzbot, or bugzilla. Found by code inspection
of the Identify → sysfs return path. Still a real, reachable bug (sysfs
read issues Identify NS).

**Step 4.4: CHECK FOR RELATED PATCHES AND SERIES**

Record: Standalone single patch. Same conversion already used in
`drivers/nvme/host/hwmon.c`.

**Step 4.5: CHECK STABLE MAILING LIST HISTORY**

Record: Direct lore stable search was blocked (bot/403). Thread mbox has
**no** `Cc: stable` and no stable-list discussion. **UNVERIFIED**
whether anyone later asked for it on stable@ — does not change the
technical verdict.

---

## PHASE 5: CODE SEMANTIC ANALYSIS

**Step 5.1: IDENTIFY KEY FUNCTIONS IN THE DIFF**

Record: `nuse_show` (modified). Callers of the bad return:
`ns_head_update_nuse`, `ns_update_nuse` → `nvme_identify_ns` →
`nvme_submit_sync_cmd` → `__nvme_submit_sync_cmd` → `nvme_execute_rq`.

**Step 5.2: TRACE CALLERS**

Record: `nuse_show` is `DEVICE_ATTR_RO(nuse)` (`0444`) on the NVMe
namespace disk. Reachable from userspace `read()` of
`/sys/block/nvmeXnY/nuse`. Documented in
`Documentation/ABI/stable/sysfs-nvme`; used so libnvme need not issue
Identify itself. **Not** IRQ/hot-path; process context, admin command.

**Step 5.3: TRACE CALLEES**

Record: Identify Namespace (admin), SRCU in the multipath helper, rate
limit 5s. On Identify failure, `nvme_identify_ns()` kfree’s the id
buffer and returns the status — no leak there.

**Step 5.4: FOLLOW THE CALL CHAIN**

Record: userspace `read` → sysfs/kernfs → `nuse_show` → Identify NS.
**Unprivileged users can trigger it** (world-readable). Failure of
Identify is uncommon on a healthy live NS, but expected during reset,
path loss, unmap, or device errors — exactly when libnvme/nvme-cli may
still read `nuse`.

**Step 5.5: SEARCH FOR SIMILAR PATTERNS**

Record: Same `if (ret > 0) return -EIO` in `nvme_get_temp_thresh` /
`nvme_set_temp_thresh` (`hwmon.c`). Other `nuse_show`-style sysfs
readers in this file mostly format cached fields and do not submit
commands.

---

## PHASE 6: CROSS-REFERENCING AGAINST THE LOCAL TREE

**Step 6.1: DOES THE BUGGY CODE EXIST IN THIS TREE?**

Record:
- `git describe HEAD` → **v7.3-rc4-27-gf0100363d8c37**
- `make kernelversion` → **7.3.0-rc4**
- `nuse_show` exists in `drivers/nvme/host/sysfs.c`
- Bug introduced **v6.8** (`a1a825ab6a603`); **is** ancestor of HEAD
- Candidate **`dd516cd762464` is already an ancestor of HEAD** (evaluate
  on merit, not “already selected”)
- Current file already contains the `ret < 0` / `ret > 0` logic

**Step 6.2: CHECK FOR BACKPORT COMPLICATIONS**

Record: **Clean apply** on this tree (hunk matches current `nuse_show`).
No conflicting refactor of this function beyond the fix itself.

**Step 6.3: CHECK IF RELATED FIXES ARE ALREADY HERE**

Record: Double-free fix `8d0d2447394b1` is present and orthogonal. No
alternate conversion of positive NVMe status in `nuse_show` besides this
commit.

---

## PHASE 7: SUBSYSTEM AND MAINTAINER CONTEXT

**Step 7.1: IDENTIFY THE SUBSYSTEM AND ITS CRITICALITY**

Record: **NVMe host sysfs** (`drivers/nvme/host/`). Criticality:
**IMPORTANT** (common storage stack; not mm/VFS core). Affects NVMe
users who read namespace sysfs (management tools).

**Step 7.2: ASSESS SUBSYSTEM ACTIVITY**

Record: Actively developed (many recent sysfs/diag/timeout patches).
`nuse` itself is mature (since 6.8), not brand-new 7.3-only code.

---

## PHASE 8: IMPACT AND RISK ASSESSMENT

**Step 8.1: DETERMINE WHO IS AFFECTED**

Record: **Driver-specific** — NVMe namespace sysfs. Anyone with
`CONFIG_BLK_DEV_NVME` (default on most distros) and a namespace. Tools:
libnvme / nvme-cli discovery.

**Step 8.2: DETERMINE THE TRIGGER CONDITIONS**

Record:
- Trigger: `read` of `/sys/block/nvmeXnY/nuse` while Identify NS returns
  a **non-zero NVMe status** (and the 5s ratelimit allows a command).
- Uncommon on a healthy device; realistic on reset, interconnect errors,
  or a controller that fails Identify.
- Unprivileged readable (`DEVICE_ATTR_RO` = 0444).

**Step 8.3: DETERMINE THE FAILURE MODE SEVERITY**

Record:
- DNR (or any status ≥ `PAGE_SIZE`): **kernel WARN** in
  `sysfs_kf_seq_show` (“OOB write or bad count”) — **HIGH** (WARNING;
  panic if `panic_on_warn`).
- Smaller status: successful short read of zeros instead of an error —
  **MEDIUM** (wrong ABI; tools may treat NUSE as 0 or fail to parse).
- Not UAF, not filesystem corruption, not a hard deadlock.

**Step 8.4: CALCULATE RISK-BENEFIT RATIO**

Record:
- **Benefit:** medium–high — stops a real WARN and a bogus sysfs success
  on a widely deployed driver.
- **Risk:** very low — 3 lines, error path only, established `-EIO`
  mapping.
- **Ratio:** favorable.

---

## PHASE 9: FINAL SYNTHESIS

**Step 9.1: COMPILE THE EVIDENCE**

**FOR backporting**
- Real bug: sysfs show returns a positive NVMe status as a byte count.
- Can `WARN` when status includes `NVME_STATUS_DNR` (0x4000) on 4K/16K
  pages.
- Userspace can get a successful empty/short read instead of an error.
- 3-line, obviously correct; Hellwig reviewed; Busch applied.
- Same pattern already used in NVMe hwmon.
- Code and bug exist in this 7.3 tree (since v6.8).
- No new API/feature; no series dependencies.

**AGAINST backporting**
- No user/syzbot report; found by inspection.
- Identify NS rarely fails on a live healthy namespace.
- Not a UAF/panic/data-corruption class bug in the common success path.

**UNRESOLVED**
- Stable@ archives could not be fetched (403/bot). No evidence of a
  prior rejection.

**Step 9.2: APPLY THE STABLE RULES CHECKLIST**

1. Obviously correct and tested? **PASS** — reviewed by Hellwig, applied
   by Busch, matches documented return contract.
2. Fixes a real bug that affects users? **PASS** — wrong sysfs return;
   WARN on DNR Identify failures.
3. Important issue? **PASS** — WARN_ON-class (and wrong userspace ABI).
   Severity HIGH for the WARN path, MEDIUM otherwise.
4. Small and contained? **PASS** — +3/−1, one function.
5. No new features or APIs? **PASS**
6. Can apply to the local tree? **PASS** — `nuse_show` present; hunk
   matches.

**Step 9.3: CHECK FOR EXCEPTION CATEGORIES**

Record: Not a device-ID/quirk/DT/build/docs exception. Ordinary small
driver bugfix.

**Step 9.4: MAKE YOUR DECISION**

This tree is **7.3.0-rc4**. The `nuse` sysfs attribute exists here. A
positive NVMe Identify status must not be returned as a sysfs byte
count; that can WARN and confuse management tools. The patch is tiny,
already the established NVMe conversion, and has maintainer review.
Benefit outweighs risk.

### What the commit solves for this tree

`nuse_show()` refreshes Namespace Utilization via Identify NS. Command
errors come back as **positive** NVMe status. Returning that from a
`DEVICE_ATTR_RO` show handler makes kernfs treat it as a length: zeros
to userspace, or a **sysfs “bad count” WARN** when the status is ≥
`PAGE_SIZE` (typical with DNR). Mapping `ret > 0` to `-EIO` restores the
sysfs contract.

### Risk vs benefit

Very low risk, clear correctness win on a user-visible NVMe sysfs file.

---

## Verification

- **[Phase 1]** Parsed message: no Fixes/Reported-by/stable Cc;
  Reviewed-by Hellwig; SOB Garry + Busch.
- **[Phase 2]** Diff: +3/−1 in `nuse_show()` only; `if (ret)` → `ret <
  0` / `ret > 0` → `-EIO`.
- **[Phase 2]** `__nvme_submit_sync_cmd()` comment and
  `nvme_execute_rq()`: positive value is NVMe status
  (`nvme_req(rq)->status`).
- **[Phase 2]** `nvme_try_complete_req()`: `rq->status =
  le16_to_cpu(status) >> 1`; `NVME_STATUS_DNR = 0x4000`.
- **[Phase 2]** `fs/sysfs/file.c` `sysfs_kf_seq_show`: `count >=
  PAGE_SIZE` → `WARN(1, "OOB write or bad count")`.
- **[Phase 2]** Same conversion in `drivers/nvme/host/hwmon.c` lines
  31–32 and 54–55.
- **[Phase 3]** Blame: buggy `if (ret)` from `a1a825ab6a603` (v6.8); fix
  is `dd516cd762464`.
- **[Phase 3]** `git merge-base --is-ancestor a1a825ab6a603 HEAD` — yes;
  `dd516cd762464` also ancestor.
- **[Phase 3]** Related: `8d0d2447394b1` double-free in `ns_update_nuse`
  — different bug, already here.
- **[Phase 3]** Author log: standalone; not a multi-patch series.
- **[Phase 4]** `b4 dig -c dd516cd762464`: lore msgid
  `20260630102717.2671475-1-john.g.garry@oracle.com`.
- **[Phase 4]** `b4 dig -a`: v1 only.
- **[Phase 4]** `b4 dig -w`: linux-nvme + Hellwig, Busch, Grimberg,
  Axboe.
- **[Phase 4]** mbox: Hellwig “Looks good”; Busch “applied to nvme-7.3”;
  no NAK.
- **[Phase 4]** WebFetch lore/stable: 403/bot — UNVERIFIED stable@
  traffic.
- **[Phase 5]** semcode MCP not available; used grep. Callers: sysfs RO
  attr `nuse`.
- **[Phase 5]** ABI: `/sys/block/nvmeXnY/nuse` since 6.8; Identify on
  read; `DEVICE_ATTR_RO` → 0444.
- **[Phase 6]** `git describe HEAD`: v7.3-rc4-27-gf0100363d8c37;
  kernelversion 7.3.0-rc4.
- **[Phase 6]** Current `nuse_show` already has the fix; buggy pattern
  exists in history of this file.
- **[Phase 8]** Failure: WARN (HIGH) or bogus short sysfs read (MEDIUM);
  trigger = Identify NS error on nuse read.

The fix is small, surgical, and meets the stable criteria for this tree.

**YES**

 drivers/nvme/host/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 16c6fea4b2db6..12478e0297356 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -239,8 +239,10 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 		ret = ns_head_update_nuse(head);
 	else
 		ret = ns_update_nuse(disk->private_data);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	else if (ret > 0)
+		return -EIO;
 
 	return sysfs_emit(buf, "%llu\n", head->nuse);
 }
-- 
2.53.0


