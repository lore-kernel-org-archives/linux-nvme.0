Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3F5EA8550
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 09:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWPG6f0umUElgamU4vaPcWweBryjQe6A7L+WPXoCQfo=; b=woEV0554HdFScio9F73Dbzm03X
	Al9Tlw8n9Z2N1XK75e3cB6JDTly2TMBBgg/GpTAXIQQRbasvDQ37iduGSApFDaZoBPEgsNKco7hQA
	JiiSEEYIqVkXXk+GegLztPei7MLVMyjxaswnz2qmtb8afImyaKD1lcg138r/qt1frdGe988E030c9
	zteZlX7fwA4dfmWLdU9pt5pBUTPlDhUGZMY/R8NboVuww8RD8PNvCezeEVR7zYUpUQgQDo//lWKUi
	7hbhVX9JoUY0032hM0EaDXFHYEJpoLEO2gPYJo7elJfgW7mx4cSNMbThrhYI6AdCXMailWIagdIws
	AHEPFQfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzsz1-000000091GE-0BXQ;
	Tue, 10 Mar 2026 09:02:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzsz0-000000091Fi-0Cqu
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 09:02:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3856A60127;
	Tue, 10 Mar 2026 09:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F52C2BC86;
	Tue, 10 Mar 2026 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133348;
	bh=FT1LTEGZKFWyTdeQXz8Pd49Q+Up7cZPSdROArkqTbuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1lhhe5A87xhrsmZcVbHjiPiEns8dbZ5mR07DM39w1LajJvx1b4/RrLmPV7LNSluz
	 1XzPpSYmc1xfGxDnmrqJTbKZGpfd2HSEzPqvOefAYxNTUZ6lAVYalq1dHMutv43s9g
	 tC2gScSmYVPaAWRbQsFnkdXR0m1k1UAI5ldqqTBOVrk6F2AhY9x6S13/yIiTcGYW7e
	 hXkE2fF6+seHKtHLJfA1TgJGrSPFP3hqEGYW7puz6lFalmbXowOpX2E4+wSO98/wql
	 95gpLe72K87NUSRkhkaomnSd06S7DLicx1ZYFBofzw/S8X1aW2Fkbn1Dob4vBoqu1y
	 3YDT4fPqBX05w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.15] nvme-pci: cap queue creation to used queues
Date: Tue, 10 Mar 2026 05:01:29 -0400
Message-ID: <20260310090145.2709021-29-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310090145.2709021-1-sashal@kernel.org>
References: <20260310090145.2709021-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 4735b510a00fb2d4ac9e8d21a8c9552cb281f585 ]

If the user reduces the special queue count at runtime and resets the
controller, we need to reduce the number of queues and interrupts
requested accordingly rather than start with the pre-allocated queue
count.

Tested-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete understanding. Let me summarize the analysis.

## Analysis

### What the commit does

This is a one-line functional change (replacing
`dev->nr_allocated_queues - 1` with `min(nvme_max_io_queues(dev),
dev->nr_allocated_queues - 1)`) in the NVMe PCI driver's
`nvme_setup_io_queues()` function.

### The bug

The `write_queues` and `poll_queues` module parameters are writable at
runtime (permission 0644). At probe time, `nr_allocated_queues` is set
to `nvme_max_io_queues(dev) + 1`, based on the CPU count plus write/poll
queue counts at that time. If the user later **reduces** these
parameters and then triggers a controller reset,
`nvme_setup_io_queues()` would still use the old, larger
`nr_allocated_queues - 1` as the starting queue count, requesting more
interrupts and queues than actually needed.

### Historical context

Interestingly, there **was** a `min()` cap here originally. Commit
`ff4e5fbad06f7` (v5.11) removed it with the reasoning that
`nr_allocated_queues` equals `nvme_max_io_queues() + 1` so the min is
redundant. That reasoning is correct **at probe time** but breaks when
module parameters change at runtime. This commit effectively restores
the `min()` to handle the runtime modification case.

### Consequences of the bug

Without this fix, after reducing queue parameters and resetting:
1. Too many interrupt vectors are requested via
   `pci_alloc_irq_vectors_affinity()`
2. The retry loop at lines 3022-3030 may be triggered unnecessarily when
   the controller can't create all requested queues
3. Unnecessary resource waste (interrupt vectors, queue slots)
4. Potential allocation failures on systems with limited interrupt
   resources

### Stable criteria assessment

- **Fixes a real bug**: Yes - incorrect behavior when runtime-modifiable
  parameters change
- **Obviously correct**: Yes - it's restoring a `min()` that was
  previously there, with well-understood semantics
- **Small and contained**: Yes - 1 functional line change (7 lines with
  comment)
- **No new features**: Correct - purely a bug fix
- **Tested and reviewed**: Has Tested-by, Reviewed-by from Kanchan Joshi
  and Reviewed-by from Christoph Hellwig (NVMe subsystem maintainer)
- **Author**: Keith Busch is the NVMe maintainer himself
- **Risk**: Very low - `min()` can only reduce the initial queue count,
  never increase it; the previous value was always valid, so this can
  only make things better

### Dependencies

This commit is standalone. The `nvme_max_io_queues()` function has
existed since v5.10 (commit `e3aef0950a30e`). The related commit
`02bfc966463a7` ("do not try to add queue maps at runtime") was applied
to the same stable tree but is independent - it handles a different
aspect (preventing addition of queue map types at runtime), while this
commit handles queue **count** capping.

The code at lines 2923-2933 (tagset nr_maps check from the "do not try
to add queue maps" commit) executes before this line and can further
reduce `dev->nr_write_queues`/`dev->nr_poll_queues`. While this commit
works fine without that prerequisite (both independently reduce the
queue count for different reasons), having the prerequisite makes the
`min()` even more effective since `nvme_max_io_queues()` returns the
properly capped value.

### Verification

- **git show ff4e5fbad06f7**: Confirmed that a `min()` with
  `nvme_max_io_queues()` existed before v5.11 and was removed because it
  was considered redundant at the time
- **git tag --contains ff4e5fbad06f7**: Confirmed the `min()` removal is
  in stable trees from v5.11 onward, meaning all actively maintained
  stable trees (5.15.y, 6.1.y, 6.6.y, etc.) have the bug
- **Module parameter permissions**: Confirmed `write_queues` and
  `poll_queues` are 0644 (runtime writable) at line 265 and 271 of pci.c
- **nvme_max_io_queues()**: Confirmed it exists since v5.10 (commit
  e3aef0950a30e), so the function is available in all stable trees
- **git show 4735b510a00fb**: Confirmed upstream commit exists and the
  diff matches exactly
- **git show 02bfc966463a7**: Verified the related "do not try to add
  queue maps" commit is independent; it adds the tagset check (lines
  2923-2933) which is additive and doesn't conflict
- **git log --author="Keith Busch"**: Confirmed Keith Busch is the NVMe
  maintainer and author of related fixes
- Could NOT independently verify whether the retry loop causes user-
  visible failures vs just being wasteful (unverified, but requesting
  excess interrupts is clearly wrong behavior)

### Conclusion

This is a small, surgical, well-reviewed bug fix by the NVMe subsystem
maintainer that restores a necessary safety cap for a realistic user
scenario (modifying module parameters at runtime). It has minimal risk -
`min()` can only reduce the queue count. The affected code exists in all
maintained stable trees. It meets all stable kernel criteria.

**YES**

 drivers/nvme/host/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d86f2565a92ca..74aca8846fffe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2776,7 +2776,13 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 
-	nr_io_queues = dev->nr_allocated_queues - 1;
+	/*
+	 * The initial number of allocated queue slots may be too large if the
+	 * user reduced the special queue parameters. Cap the value to the
+	 * number we need for this round.
+	 */
+	nr_io_queues = min(nvme_max_io_queues(dev),
+			   dev->nr_allocated_queues - 1);
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
2.51.0


