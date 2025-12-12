Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2197D43366
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 02:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fXlZVhtLotRerpPWNFiiXKC0ukpBwHb2+hVQf9dlHs0=; b=Q95nPF0rMGmXsIuj5jx02pZpsj
	CDLMQN4Pis9clTYqtXZnUCUEbbhByL3cU++0GbQkafZS6KpqG3Yq6Db31Q+dNOcIqd4jYong6IAt5
	WSvTmjHtZKMFs2JT4mjTNk4xLX6ld4DM/Wj3WkJtmCz4/TzIXJiJUjdHvVVzMOWtPcLTgcuXDUJkS
	N09yJQ9T8NWqbfONlPO700k5LSyKsNIckGVYTTSKpoQaH3y3Keuq2gKUt1DApMQo92ZDQ9cHGE7Q5
	7WuistieFUHCx2Xytb6N1LvnlaRuN/YSR1ljL0x/6gpVHGILtSV85sO+8fYHrx2TqicKhhv+ZK9ua
	LNTIRcrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTsaq-0000000HWqO-1S7z;
	Fri, 12 Dec 2025 02:09:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTsan-0000000HWpp-2wuC
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 02:09:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D9D8A442B6;
	Fri, 12 Dec 2025 02:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69871C4CEF7;
	Fri, 12 Dec 2025 02:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765505350;
	bh=KnJsrnXdPjvwLRxT8xQ5io/nClckJO+dlwBTKMBT3Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKV934mDOq1WnJ/cD/czLvDSDtA666xFoywI75Z9YBxboMrHsy+mwhFjZA3wgwWDX
	 udaJWVXp0E0aS2lOuGdcC6XeZwt2CxgqtViFI0bwSj68eumWMdRiJds1vGl4wPPRb3
	 AUgbXA9bKA6iJUnd0Z06+Tji1xIPthfArXvQZRk3BAhQ5M7tjvzuI/Q7tfAmDS79NJ
	 MN5ryI3jytYy+8cnJM/3l4hWzKtU4cLRWnyqEeZsM8ai66rLEozYg2YyQ2XrPfWYbu
	 O/XNkPyDW88tOKBrNxhr1BjAts0vX0yRRJOatusgiJfNZo91+76u+z6ByiWOqGgsp+
	 s58emRBA4SVww==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.18-5.10] nvme-fc: don't hold rport lock when putting ctrl
Date: Thu, 11 Dec 2025 21:08:54 -0500
Message-ID: <20251212020903.4153935-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251212020903.4153935-1-sashal@kernel.org>
References: <20251212020903.4153935-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_180913_785692_71DEF161 
X-CRM114-Status: GOOD (  17.24  )
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

[ Upstream commit b71cbcf7d170e51148d5467820ae8a72febcb651 ]

nvme_fc_ctrl_put can acquire the rport lock when freeing the
ctrl object:

nvme_fc_ctrl_put
  nvme_fc_ctrl_free
    spin_lock_irqsave(rport->lock)

Thus we can't hold the rport lock when calling nvme_fc_ctrl_put.

Justin suggested use the safe list iterator variant because
nvme_fc_ctrl_put will also modify the rport->list.

Cc: Justin Tee <justin.tee@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This shows the affected function was introduced in v5.8-rc1
(`14fd1e98afafc`), meaning this deadlock bug has existed since **Linux
5.8** and affects all stable kernels from 5.8 onwards (5.10.y, 5.15.y,
6.1.y, 6.6.y, etc.).

### SUMMARY

**What the commit fixes:**
A **deadlock bug** in the NVMe-FC (Fibre Channel) driver where
`nvme_fc_match_disconn_ls()` holds `rport->lock` while calling
`nvme_fc_ctrl_put()`. When the reference count hits zero,
`nvme_fc_ctrl_free()` tries to acquire the same lock, causing a
deadlock.

**Stable kernel criteria:**
| Criterion | Assessment |
|-----------|------------|
| Obviously correct | ✅ Uses canonical lock drop/reacquire pattern |
| Fixes real bug | ✅ Deadlock - system hang |
| Important issue | ✅ Deadlocks in storage paths are critical |
| Small and contained | ✅ ~6 lines in one function |
| No new features | ✅ Pure bug fix |
| Expert reviewed | ✅ Christoph Hellwig |

**Risk vs Benefit:**
- **Risk:** LOW - The fix uses a well-established kernel pattern
  (`list_for_each_entry_safe` + lock release/reacquire)
- **Benefit:** HIGH - Prevents deadlock in NVMe-FC storage driver used
  in enterprise environments

**Concerns:**
- No explicit `Cc: stable` tag, but this is not required for obvious bug
  fixes
- No `Fixes:` tag, but we've identified the bug exists since v5.8
- The fix should apply cleanly to any kernel with the affected function
  (5.8+)

### CONCLUSION

This commit fixes a clear deadlock bug in the NVMe-FC driver that has
existed since Linux 5.8. The fix is:
- Small and surgical (only ~6 lines changed)
- Uses well-understood, standard kernel locking patterns
- Has been reviewed by a respected kernel developer (Christoph Hellwig)
- Signed off by the NVMe maintainer (Keith Busch)
- Affects enterprise storage users who rely on NVMe over Fibre Channel

Deadlocks in storage drivers are serious issues that warrant stable
backporting. The minimal scope and established fix pattern make this a
low-risk, high-value backport.

**YES**

 drivers/nvme/host/fc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2c903729b0b90..8324230c53719 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1468,14 +1468,14 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 {
 	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
 					&lsop->rqstbuf->rq_dis_assoc;
-	struct nvme_fc_ctrl *ctrl, *ret = NULL;
+	struct nvme_fc_ctrl *ctrl, *tmp, *ret = NULL;
 	struct nvmefc_ls_rcv_op *oldls = NULL;
 	u64 association_id = be64_to_cpu(rqst->associd.association_id);
 	unsigned long flags;
 
 	spin_lock_irqsave(&rport->lock, flags);
 
-	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+	list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
 		if (!nvme_fc_ctrl_get(ctrl))
 			continue;
 		spin_lock(&ctrl->lock);
@@ -1488,7 +1488,9 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
 		if (ret)
 			/* leave the ctrl get reference */
 			break;
+		spin_unlock_irqrestore(&rport->lock, flags);
 		nvme_fc_ctrl_put(ctrl);
+		spin_lock_irqsave(&rport->lock, flags);
 	}
 
 	spin_unlock_irqrestore(&rport->lock, flags);
-- 
2.51.0


