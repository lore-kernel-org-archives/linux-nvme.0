Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2204CC433FE
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Oct 2022 10:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SoNvTTmabEG0+J8c3TEHXdmJWbLdUzXSav/5pa81vPY=; b=Ajd3paH0ODQxtnpTV4pg+IvGOB
	cvANOmz6NFKLVDBxHavOb1csxmgwVvoGDaJA0OsUcJME7mx0gfX5mQAEyZSEn1EmTMgSECynZyOdk
	f8TMJgnlyZ9USA5EB/ux4dDFRoep69P8HHNElzMjZ5tEai8wEAS379xudHpkdlzLsJfLmi30VIr9P
	hZ8Hrq9K86ktHYQQcLlCqrqhKZroc2nhOzPU0Q2zsQuab9KBcFMLYQVnNLgQDylhGzIchq2lxZPCR
	CRiv0HO+PqM2VR7aVl2dVWVZYqT5a+bC7blcUZNsOt5C3aJPXcne/0VbWhnaXgROFtOGIHHYdPiSB
	N+0Jonvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oevlR-000d4o-Sr; Sun, 02 Oct 2022 10:00:01 +0000
Received: from smtp06.smtpout.orange.fr ([80.12.242.128] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oevlO-000d2o-Nw
	for linux-nvme@lists.infradead.org; Sun, 02 Oct 2022 10:00:01 +0000
Received: from pop-os.home ([86.243.100.34])
	by smtp.orange.fr with ESMTPA
	id evlFoljJdC5LCevlFowjLR; Sun, 02 Oct 2022 11:59:51 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Oct 2022 11:59:51 +0200
X-ME-IP: 86.243.100.34
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: Improve memory usage in nvme_fc_rcv_ls_req()
Date: Sun,  2 Oct 2022 11:59:45 +0200
Message-Id: <87a93f5fadd6e3cba2bb263b8853a5d33f589287.1664704751.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221002_025958_953390_7C4FF50A 
X-CRM114-Status: GOOD (  16.55  )
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

sizeof( struct nvmefc_ls_rcv_op ) = 64
sizeof( union nvmefc_ls_requests ) = 1024
sizeof( union nvmefc_ls_responses ) = 128

So, in nvme_fc_rcv_ls_req(), 1216 bytes of memory are requested when
kzalloc() is called.

Because of the way memory allocations are performed, 2048 bytes are
allocated. So about 800 bytes are wasted for each request.

Switch to 3 distinct memory allocations, in order to:
   - save these 800 bytes
   - avoid zeroing this extra memory
   - make sure that memory is properly aligned in case of DMA access
    ("fc_dma_map_single(lsop->rspbuf)" just a few lines below)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is only a RFC to see if this kind of approach makes sense or
not.
I've not checked all paths, so it is likely that it is incomplete.

Anyway, it is just a trade-of between memory footprint and CPU usage (3
kzalloc() instead of 1)

I don't know if it is a slow path or not, nor if the "rport->ls_rcv_list"
list can get big (each item overuses these 800 bytes of memory)

3 kzalloc is more than just 1 (sic!), but with this patch, 800 bytes are
not zeroed anymore. Moreover, maybe the zeroing of rqstbuf and/or rspbuf
can be saved as well.
So, it could balance the impact of the 3 kzalloc().

So, if it looks promising, s.o. with the corresponding hardware should
make some measurements on memory and CPU usage.
---
 drivers/nvme/host/fc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5d57a042dbca..2d3c54838496 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1475,6 +1475,8 @@ nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 	fc_dma_unmap_single(lport->dev, lsop->rspdma,
 			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
 
+	kfree(lsop->rspbuf);
+	kfree(lsop->rqstbuf);
 	kfree(lsop);
 
 	nvme_fc_rport_put(rport);
@@ -1751,20 +1753,17 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 		goto out_put;
 	}
 
-	lsop = kzalloc(sizeof(*lsop) +
-			sizeof(union nvmefc_ls_requests) +
-			sizeof(union nvmefc_ls_responses),
-			GFP_KERNEL);
-	if (!lsop) {
+	lsop = kzalloc(sizeof(*lsop), GFP_KERNEL);
+	lsop->rqstbuf = kzalloc(sizeof(*lsop->rqstbuf), GFP_KERNEL);
+	lsop->rspbuf = kzalloc(sizeof(*lsop->rspbuf), GFP_KERNEL);
+	if (!lsop || !lsop->rqstbuf || !lsop->rspbuf) {
 		dev_info(lport->dev,
 			"RCV %s LS failed: No memory\n",
 			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
 				nvmefc_ls_names[w0->ls_cmd] : "");
 		ret = -ENOMEM;
-		goto out_put;
+		goto out_free;
 	}
-	lsop->rqstbuf = (union nvmefc_ls_requests *)&lsop[1];
-	lsop->rspbuf = (union nvmefc_ls_responses *)&lsop->rqstbuf[1];
 
 	lsop->rspdma = fc_dma_map_single(lport->dev, lsop->rspbuf,
 					sizeof(*lsop->rspbuf),
@@ -1801,6 +1800,8 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 	fc_dma_unmap_single(lport->dev, lsop->rspdma,
 			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
 out_free:
+	kfree(lsop->rspbuf);
+	kfree(lsop->rqstbuf);
 	kfree(lsop);
 out_put:
 	nvme_fc_rport_put(rport);
-- 
2.34.1


