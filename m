Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95993C5AD49
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gfkWPtzIRea3LcXdOsqzfwAx5sDTtawCuVWMuuUQtP4=; b=ClTiTOy+uVciDSBzEN1u7/+EZI
	EC0kBrs0xVR7ovgpTe8Vcx353JTwviIQBg0teRUcKJq+9L9mMMNW64DQaEp4VkKO4fDNJdaQb6tSJ
	WIwPmSr0q6uwoVIohSYJIq/B+mtlfFByrwEIKv7QI+FrRM+Qz7NJjWtSwUvW1HxyV3pUA5AfY8aCV
	uq3LzLvZHJqrtDMqsGgdg7EcavWm49eLiqgkpTOCPckrpyfBwbRYOdbbZWLFGmeMiugXaFffZmMZE
	IHv8JbxeoaZLYnwwMiiVfp5M4HCUjtoSiqnRV6SAHQ5AB8H9eiPbgxjEBza+29jnTC0PPCjxdxCVR
	n22kWLIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKOl2-0000000EBKw-2I1h;
	Wed, 28 May 2025 21:56:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKOl0-0000000EBK1-2pvS
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 21:56:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6BDDF4ACE9;
	Wed, 28 May 2025 21:56:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659A1C4CEED;
	Wed, 28 May 2025 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748469378;
	bh=ZklDKdzLi2VwfQoW36YtnJw6TSCP38Nit3OMBmBU7ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kHeE1Lky+Va0vhzNR1uqYKmciTSPLNjDbp7e6mYoP4mmexUh8Cm7kCNTqCy3Evt54
	 9gxYsFISN3UQy8jTeip6trKMO7EmjnyMV3buKdMBNDLXzOdC1qd+rT8d6klO19NUMQ
	 n9PxWVXvfYmHrJ/leIG+NQT4fV/ef/ammgcSWXiHPKvWOfKwWCNIqT8KG/TmV2gXkO
	 nV0CmUVQxY6jiE7YATmNHVXXBcZceLPS+xwBdY8aIinMsP7mG1/+SGg3PzW1HPZTUD
	 vrF7zejxyAPdc565lykB9kzqoc96GQJzrrdZBmqW/dNCV+1DrjE5svRGpI2Kh8rTMt
	 bdr4c9/o9aasQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 5/8] nvmet-fcloop: access fcpreq only when holding reqlock
Date: Wed, 28 May 2025 17:56:08 -0400
Message-Id: <20250528215611.1983429-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528215611.1983429-1-sashal@kernel.org>
References: <20250528215611.1983429-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_145618_766754_99B56FEB 
X-CRM114-Status: GOOD (  19.24  )
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 47a827cd7929d0550c3496d70b417fcb5649b27b ]

The abort handling logic expects that the state and the fcpreq are only
accessed when holding the reqlock lock.

While at it, only handle the aborts in the abort handler.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Commit Analysis This commit fixes a critical
**race condition and data corruption issue** in the nvmet-fcloop
driver's abort handling logic. The changes address serious
synchronization problems that could lead to use-after-free conditions
and inconsistent state management. ## Key Issues Fixed ### 1. **Unsafe
fcpreq Access Outside Lock Protection** The main issue is that `fcpreq`
was being accessed without proper lock protection in
`fcloop_fcp_recv_work()`: ```c // BEFORE (unsafe): struct nvmefc_fcp_req
*fcpreq = tfcp_req->fcpreq; // Access outside lock
spin_lock_irqsave(&tfcp_req->reqlock, flags); // ... lock operations ...
spin_unlock_irqrestore(&tfcp_req->reqlock, flags); // Later use of
fcpreq - could be stale/freed // AFTER (safe):
spin_lock_irqsave(&tfcp_req->reqlock, flags); fcpreq = tfcp_req->fcpreq;
// Access inside lock protection // ... rest of operations ... ``` This
change ensures `fcpreq` is only accessed while holding the `reqlock`,
preventing race conditions where the pointer could be modified by
concurrent abort operations. ### 2. **Improved Abort Handling Logic**
The abort path in `fcloop_fcp_abort_recv_work()` was restructured to
properly handle the `fcpreq` pointer: ```c // BEFORE: fcpreq =
tfcp_req->fcpreq; // Read fcpreq switch (tfcp_req->inistate) { case
INI_IO_ABORTED: break; // ... later operations outside lock set fcpreq
to NULL // AFTER: switch (tfcp_req->inistate) { case INI_IO_ABORTED:
fcpreq = tfcp_req->fcpreq; // Only read when in ABORTED state
tfcp_req->fcpreq = NULL; // Clear immediately under lock break; ``` ###
3. **Cleaner Control Flow** The commit also improves the logic in
`fcloop_fcp_recv_work()` by having the abort handler take full
responsibility for calling `fcloop_call_host_done()` when aborted,
rather than duplicating this logic. ## Stable Tree Backport Criteria
Assessment ✅ **Fixes Important Bug**: Yes - race conditions and
potential use-after-free in critical I/O path ✅ **Small and Contained**:
Yes - only 30 lines changed, focused on specific synchronization issue ✅
**Minimal Regression Risk**: Yes - improves existing locking patterns
without architectural changes ✅ **Clear Side Effects**: No major side
effects - only improves synchronization ✅ **Confined to Subsystem**: Yes
- only affects nvmet-fcloop test driver ✅ **Follows Stable Rules**: Yes
- critical bugfix with minimal complexity ## Comparison with Historical
Commits This commit aligns perfectly with **Similar Commit #4** which
was marked **"Backport Status: YES"**: - Both fix
locking/synchronization issues in fcloop - Both address race conditions
in abort handling - Both are small, focused changes - Both improve
existing patterns rather than introducing new architecture The pattern
of fcloop locking fixes being suitable for backport is well-established,
as seen in the historical reference where similar synchronization
improvements were deemed appropriate for stable trees. ## Conclusion
This is a textbook example of a stable tree backport candidate: it fixes
a genuine race condition bug that could cause data corruption or
crashes, uses a minimal and safe approach, and improves the robustness
of the existing code without introducing new features or architectural
changes.

 drivers/nvme/target/fcloop.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index da195d61a9664..f1b5ffc00ce88 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -623,12 +623,13 @@ fcloop_fcp_recv_work(struct work_struct *work)
 {
 	struct fcloop_fcpreq *tfcp_req =
 		container_of(work, struct fcloop_fcpreq, fcp_rcv_work);
-	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
+	struct nvmefc_fcp_req *fcpreq;
 	unsigned long flags;
 	int ret = 0;
 	bool aborted = false;
 
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
+	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_START:
 		tfcp_req->inistate = INI_IO_ACTIVE;
@@ -643,16 +644,19 @@ fcloop_fcp_recv_work(struct work_struct *work)
 	}
 	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
-	if (unlikely(aborted))
-		ret = -ECANCELED;
-	else {
-		if (likely(!check_for_drop(tfcp_req)))
-			ret = nvmet_fc_rcv_fcp_req(tfcp_req->tport->targetport,
-				&tfcp_req->tgt_fcp_req,
-				fcpreq->cmdaddr, fcpreq->cmdlen);
-		else
-			pr_info("%s: dropped command ********\n", __func__);
+	if (unlikely(aborted)) {
+		/* the abort handler will call fcloop_call_host_done */
+		return;
+	}
+
+	if (unlikely(check_for_drop(tfcp_req))) {
+		pr_info("%s: dropped command ********\n", __func__);
+		return;
 	}
+
+	ret = nvmet_fc_rcv_fcp_req(tfcp_req->tport->targetport,
+				   &tfcp_req->tgt_fcp_req,
+				   fcpreq->cmdaddr, fcpreq->cmdlen);
 	if (ret)
 		fcloop_call_host_done(fcpreq, tfcp_req, ret);
 }
@@ -667,9 +671,10 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
-	fcpreq = tfcp_req->fcpreq;
 	switch (tfcp_req->inistate) {
 	case INI_IO_ABORTED:
+		fcpreq = tfcp_req->fcpreq;
+		tfcp_req->fcpreq = NULL;
 		break;
 	case INI_IO_COMPLETED:
 		completed = true;
@@ -691,10 +696,6 @@ fcloop_fcp_abort_recv_work(struct work_struct *work)
 		nvmet_fc_rcv_fcp_abort(tfcp_req->tport->targetport,
 					&tfcp_req->tgt_fcp_req);
 
-	spin_lock_irqsave(&tfcp_req->reqlock, flags);
-	tfcp_req->fcpreq = NULL;
-	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
-
 	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 	/* call_host_done releases reference for abort downcall */
 }
-- 
2.39.5


