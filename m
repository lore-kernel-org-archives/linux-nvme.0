Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C5FC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 22:00:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB5522202
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 22:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB5522202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r1Uj8EbMg8XMi6cwIytXps7yfZFsXeQztwLcKw/pyn4=; b=qEp3izhb7HKMCXRX+PoDvDZStL
	37C0aqv7NVNb2pT4P6ZUj8YbzsPVs3fQFlvM+yEe7NnPaacVm1D1JcBQKz9ci4vlCenw6Ntdm16Ft
	dWBFx75/hoddDjZ7UXpBdLMo6yxT5qv9DlMqsJElYS2IXkCOn9vaD4lPfzMpGxSo0T4HTDhU9TJiI
	M3GiEbiFI9LWsMi2LGQshT5iIDCGp50ZyjEh9u0Eeq9cPkVn2gT18J3izGD/4d7M8XkJAeXcmRtPg
	SKaktCo41GGSJXBKPjpOEyXSfm7TgiLo7r/mwdLt09GjC39dvW2+KHh+nJtQFvx0Pt2wtzd1/pB+N
	57fqG4Dg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ksCBB-0005bf-U8; Wed, 23 Dec 2020 22:00:21 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ksCB8-0005b6-Au
 for linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 22:00:20 +0000
IronPort-SDR: /DAbHO/e2JOtnlKAehY6G2wNtQ7Xv6B2U/P67VNtkzfzHcSJg6HyFR9xyxLymJL7jqk0dmvSzt
 fxW+eWLmT1DQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="173506001"
X-IronPort-AV: E=Sophos;i="5.78,442,1599548400"; d="scan'208";a="173506001"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2020 14:00:13 -0800
IronPort-SDR: ZE9vjT+jio/b1tX/7pX6GuRO1MMz0A/r592uY2dF3aio3SMMoiiIkjBp9UmgFnM3q33hFK7d/E
 VHy+ZG29weww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,442,1599548400"; d="scan'208";a="398209958"
Received: from sbensaid-test1.sc.intel.com ([172.25.206.207])
 by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2020 14:00:12 -0800
From: lalithambika.krishnakumar@intel.com
To: kbusch@kernel.org,
	hch@lst.de,
	axboe@fb.com,
	sagi@grimberg.me
Subject: [PATCH] nvme: avoid possible double fetch in handling CQE
Date: Wed, 23 Dec 2020 14:09:00 -0800
Message-Id: <20201223220900.11234-1-lalithambika.krishnakumar@intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_170019_336210_187410EC 
X-CRM114-Status: GOOD (  11.09  )
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
Cc: lalithambika.krishnakumar@intel.com, dan.j.williams@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>

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
---
 drivers/nvme/host/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b4385cb0ff60..88a7cb3fe2a2 100644
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
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
