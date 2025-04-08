Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F26AC369A2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HghjaV7Fq7/CUYehNtYZwnXfcSlRz87VZxy9NEC+j5w=; b=YhvjjEvln8m1ZCTZowcI63wqDT
	Tv0ENu0SBkSLA/Gmwup4b1EAOS874BSnJaCS7hHQ9E4OrvL+QYnoLkdFCEBElrTGV+bkvX/xbcxJu
	RV7lm2XDAGNzZ0ZLP5ZscGLu4nZhUogbS28X11Uujuitu+w8gcs8PbEUxCvxMaVqBM2uc809z8yET
	dAxhzE/nSlWjJs0SXawn0BaYuQOtM+pEcGHxpaQSIDMsS2LWAWsSM8eBs6bK/8wUYJoj026MFYAcv
	EujjEOBsSPRrZ9rsSIN71KhDvcAexkgy7wjWjlk1VANzFRIgVHDTQbWv2PvGXSPZCHNn8S8dmBH4U
	nrj/+k3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2Atg-00000004cPE-1hNZ;
	Tue, 08 Apr 2025 15:29:56 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2At2-00000004cGd-2JgX
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 15:29:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A2BCD68441;
	Tue,  8 Apr 2025 15:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D702BC4CEE5;
	Tue,  8 Apr 2025 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126155;
	bh=ceT3G4N2zSseN3NqLnEA5gWCVWS4Ndi292BWL+Gup0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=czlxT9kRhBLmtKGT/QixXHY0itWmeybUxG5ZqaqSBmYjH1weGRUNa84JgtPtlpm33
	 DNWnlbt6gUs8BK/lwxoRmRWJ/U5KiYFXJnXl7O8k5T4qCZxDj/T2Lmyv8Z8ecpwBdR
	 Ozl3Xm1Bc9WXcn3apefwESxbxTO50ud+v9RfLnOh1PlB3FF5yeIvWf4q8GC3wLo1We
	 z2bOeQwv6gDZoORGAjL053llN3+iLmbbdDwvDEyJT5icbRRJcWwi/OamuMPLghjQGW
	 u17RzhBw8YXLQ/vregQtW9wLrYVs4O1Nfflhb19DvOTfSoa+CAP6cvYcPxE3b8nTra
	 jFpVP32wP6UFw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 08 Apr 2025 17:29:03 +0200
Subject: [PATCH 1/8] nvmet-fcloop: swap list_add_tail arguments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-nvmet-fcloop-part-one-v1-1-382ec97ab7eb@kernel.org>
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
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

The newly element to be added to the list is the first argument of
list_add_tail. This fix is missing dcfad4ab4d67 ("nvmet-fcloop: swap
the list_add_tail arguments").

Fixes: 437c0b824dbd ("nvme-fcloop: add target to host LS request support")
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index e1abb27927ff74c9c55ddefd9581aab18bf3b00f..da195d61a9664cba21880a4b99ba0ee94a58f81a 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -478,7 +478,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 	if (targetport) {
 		tport = targetport->private;
 		spin_lock(&tport->lock);
-		list_add_tail(&tport->ls_list, &tls_req->ls_list);
+		list_add_tail(&tls_req->ls_list, &tport->ls_list);
 		spin_unlock(&tport->lock);
 		queue_work(nvmet_wq, &tport->ls_work);
 	}

-- 
2.49.0


