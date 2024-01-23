Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D48C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m9lNAatKR1uJ0FWoXVGaFk+j52kcK+4DyLm1/iPa/jk=; b=ocJuIgD5UyJQNQWfCrgO4/0nnG
	832KrA5jqfiAaDOIjXlY4lZrKeLrj64T52XNP8ypz4K5xxTWotTjr65/vb8W2u/FLjsJZkUMUftDw
	rm5rfzN5twORLGwVtyDUmBHIwWRZIpyRYSVLmrDJpTApCfIWVopdwef5vd8gANkKCT5BwmuDFSxEA
	LFny3GGurJ5LP24BkGiB/zR1f0lRbtwpKODoRS3/zAI4otMjyIR4l251LSHeeoDSkHKh5+UkeUmzT
	T+uLtLtsnWeiLvHQt4fhGrW0EjVd95RWf0cwDjlomT6/5VtpEHwQio+MSt/CRrypNh5JPNb2G9m1r
	9yFH3SOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHco-00Gm0z-27;
	Tue, 23 Jan 2024 14:19:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHcm-00GlzN-2Y
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:19:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 39035618B8;
	Tue, 23 Jan 2024 14:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA3EC433B2;
	Tue, 23 Jan 2024 14:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019575;
	bh=pjiiv8KMmTakeYhu0r5KqfsHRedGlj15qANEtP6EvyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNaSyuP4FQORGANUWOyGTosEEw/B1kQ/qgfAbUlx02QLZYjG9o136rDegvaW/SpQ6
	 aiYJbmYkAXyhSxK9c5hEn+6Iwb+c7Sl1sMS86RMj1b0Iq2CGN/5lhCIbmlcrPsKtDh
	 D8jXOnamWWjNJJ57goTNkNrxf5mvVohGZ+m/CqaIPcJyWkcV5LZ/DOHym1P0y8LBge
	 JR1P/ztoa1TtcmNrk8gZJYJ57MT7xdfWDKd6yji+hjdX0L/LB1j0vrwL5ONjQiQukz
	 L5Yncs5DTeJXy0ChlH98q8LpnbIi4yDGZxv6SsfZq9+H17nGjAUarnwhDPt6NT5qYl
	 P/49OdO/anezA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/11] nvme-fabrics: authentication errors are not retryable
Date: Tue, 23 Jan 2024 15:19:06 +0100
Message-Id: <20240123141909.79061-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123141909.79061-1-hare@kernel.org>
References: <20240123141909.79061-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_061936_890374_626108E7 
X-CRM114-Status: GOOD (  10.73  )
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

From: Hannes Reinecke <hare@suse.de>

Whenever authentication failed the error is non-retryable as the
authentication solely depends on the passed parameters, which do
not change during retry.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index a7da088331dc..c6feb6e1e05f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -465,7 +465,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -473,7 +473,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
@@ -537,7 +537,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -545,7 +545,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 		} else {
 			ret = nvme_auth_wait(ctrl, qid);
 			if (ret)
-- 
2.35.3


