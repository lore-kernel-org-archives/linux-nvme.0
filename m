Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5B0E95A97
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 08:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WWsp2lZYjNABdfJu4pN0mVKmqaG1Tm315z3OevtQvHU=; b=vxPCh/qIbUrZG0Fk79TXOTasDW
	ZN89nGl8Bv/4aj3vlMkTyGlllaCwIbczo3yATHWMdHxbqeHRLqMLI5/bbUjDF5M7dEAxHqhHcw8og
	DkfE/6zKb5oRyup3RBspAUmkx7Dyi0yHwOyGdJvZOrfAq4vMmvKY6mPAKmtJfeVkmZ9Z2bnuKV3xS
	XLHhpuygIGRkbrFgJvrSAKcuWyRLE8uMiU15lksvyaOruTyCf3rmvkF5RFmhiwu1XZ8jywVTQcOzD
	/aP7AARG+RcDtPxtoRWZN85/O1ekZtzsTVG4PXnreGPd5ktdVby+WqnslRgvD6xAcrjHOI/vgC7rr
	eB9CAchw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqUqa-00FFtT-0U;
	Wed, 11 Oct 2023 08:45:40 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqUqX-00FFqf-1X
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 08:45:38 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C3954240101
	for <linux-nvme@lists.infradead.org>; Wed, 11 Oct 2023 10:45:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697013934; bh=HoFGL1O1u5jeH2eaAc/NSgPYTeO+yRIjCCiIYzJbT6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=fPB/cjVYgK9Fdfzt2+GmxUYKzlWxtsNpfGkoBdJ6va1ELOt/MEEsTHthx0gQpyMSo
	 3zPVMDIwaZEtIgVLdIrk58uwS+fijwmAVPtz+GVbwkLaZdGOIpk29OPBI6qPFTVYd3
	 TxBGn065nSqNGh9CH3RqMtRKWBzmxpQYZ95MOSZAQySq6vAfEzf70PorNtyG6KXonQ
	 PDoGFhSQrTzN6b+H5yKQpKAHwdaUcNKProTXIZHetLMHaHZp6yQ4y0mQxbaQxH5c87
	 9sqhmlTKLqcIUa9Swp75a1Uoe4f1Hs2hiyV7G2XbxmbWXZkMP/hfW5ZvBO+zjU5eC+
	 MZaPwYHEsusbA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S55vK1M9Pz6tw0;
	Wed, 11 Oct 2023 10:45:33 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH 2/2 RESEND] nvme-auth: set explanation code for failure2 msgs
Date: Wed, 11 Oct 2023 08:45:12 +0000
Message-Id: <20231011084512.1835614-2-shiftee@posteo.net>
In-Reply-To: <20231011084512.1835614-1-shiftee@posteo.net>
References: <20231011084512.1835614-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_014537_666111_99E467A6 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
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

Some error cases were not setting an auth-failure-reason-code-explanation.
This means an AUTH_Failure2 message will be sent with an explanation value
of 0 which is a reserved value.

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v1->v2: Set failure explanation in a single place if the error handling
code has not already done so.
---
 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e1a98647c3a2..9556cfc4f5f3 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -839,6 +839,8 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	}
 
 fail2:
+	if (chap->status == 0)
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 	dev_dbg(ctrl->device, "%s: qid %d send failure2, status %x\n",
 		__func__, chap->qid, chap->status);
 	tl = nvme_auth_set_dhchap_failure2_data(ctrl, chap);
-- 
2.39.2


