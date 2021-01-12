Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84577C433E9
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 12:57:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2877A23129
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 12:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2877A23129
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DdmAdM/98IE4TrhNbqxhqpkyNLaWFOVP0CnTj0rNhlA=; b=1ApvlaZrlOGo2wByICIGPOizY
	LA6u/o9WRy+c7gEjI/5AlcNlz3GheQqgYpP1sNl3fuxRTY4kylRwvVbYuQxUfxJnt908AoFeapgzu
	OADMOvnDR63UcJmNYYVsv4pIoKtyJJfd8CvAHE6+v7IujZ8Ep1auudb0vfn12RVdHmF2NGF87qd5Q
	ivzLsDpH3OQfpxc0T2xxbjxYzjz6m+PIvfz9V8cM2CGHVi125rxzg6+iEha7yJYrbqxDCm+VEiyTQ
	sztphE/kxXY4qIME6dGANU3+vyGkHQ+ULBQvoRgjKWaDMAewsEtSSFdXBAsFCpWwLwE33CrMrtefB
	0i8vw2+ww==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzJEO-0000Zh-Gr; Tue, 12 Jan 2021 12:57:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzJDn-0000Gv-5e
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 12:56:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6E102313E;
 Tue, 12 Jan 2021 12:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610456186;
 bh=6F7ZdDt4Gdnvj9HB0/c8v4mGbdGjGQCEU00+4wZsiBk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ULvVA36tYqVFn36aykf8KsrthytzYGv2yJGbJ8u55R06T92yYq0b4qSDPteDHGw9V
 Bwd6ngccJtFnFLe7beHlhjqm91Q6hKJPVNUf6H3Uf41JjnrOpjStV5JpoM52JpLy1d
 iwRdm5ckQNgL51f6MLGZJfMQDHmftf8cdpFaZ/ScVQUOwDW6C3NRnEZv6b6prxC5kP
 +BcWB8+JfHT2i7yrzrVeE/NAmUukPwDn58fWJ6PiuPhV8C4IFfRIoTYAmPaeCPg6Gz
 C+5wUvmjIuLrNmiWVY4ugRhpdFFKvQ7iG9DxT7bGn7MzWEnMGij8tCGKfZ1C6KwoIV
 TlFghPJR7nhgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 39/51] nvme: avoid possible double fetch in
 handling CQE
Date: Tue, 12 Jan 2021 07:55:21 -0500
Message-Id: <20210112125534.70280-39-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210112125534.70280-1-sashal@kernel.org>
References: <20210112125534.70280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_075627_357062_DDC4B0D4 
X-CRM114-Status: GOOD (  12.57  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>,
 Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>

[ Upstream commit 62df80165d7f197c9c0652e7416164f294a96661 ]

While handling the completion queue, keep a local copy of the command id
from the DMA-accessible completion entry. This silences a time-of-check
to time-of-use (TOCTOU) warning from KF/x[1], with respect to a
Thunderclap[2] vulnerability analysis. The double-read impact appears
benign.

There may be a theoretical window for @command_id to be used as an
adversary-controlled array-index-value for mounting a speculative
execution attack, but that mitigation is saved for a potential follow-on.
A man-in-the-middle attack on the data payload is out of scope for this
analysis and is hopefully mitigated by filesystem integrity mechanisms.

[1] https://github.com/intel/kernel-fuzzer-for-xen-project
[2] http://thunderclap.io/thunderclap-paper-ndss2019.pdf
Signed-off-by: Lalithambika Krishna Kumar <lalithambika.krishnakumar@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 143f16a9f8d7e..a89d74c5cd1a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -967,6 +967,7 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
+	__u16 command_id = READ_ONCE(cqe->command_id);
 	struct request *req;
 
 	/*
@@ -975,17 +976,17 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 	 * aborts.  We don't even bother to allocate a struct request
 	 * for them but rather special case them here.
 	 */
-	if (unlikely(nvme_is_aen_req(nvmeq->qid, cqe->command_id))) {
+	if (unlikely(nvme_is_aen_req(nvmeq->qid, command_id))) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
 				cqe->status, &cqe->result);
 		return;
 	}
 
-	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), cqe->command_id);
+	req = blk_mq_tag_to_rq(nvme_queue_tagset(nvmeq), command_id);
 	if (unlikely(!req)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
-			cqe->command_id, le16_to_cpu(cqe->sq_id));
+			command_id, le16_to_cpu(cqe->sq_id));
 		return;
 	}
 
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
