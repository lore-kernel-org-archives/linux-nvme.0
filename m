Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D2CC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:53:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77983206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DlsSUNXK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuJ5VHJu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77983206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=v5HF2DXHHq/ilzSc8MMvBqe1K+PsITFgsKm/eyeXY+g=; b=DlsSUNXKBGSdoiCvJdcqF3IbXk
	ntVTzkWvxTl/mVGT9U+ZG090UfoYl8Q1FfwQXCr0hOagUDSHiJHxuGt6XJY4HmUT408RnS2Jg0IC4
	mvKt3LurFPsKnk9oIu0MryVqumpUyYnhHFlLgCX+yT4qlIu/ZvGHhX0InEwZkKiLfMwXG2YcOtCKZ
	3WFRRpZy5cKLMSHUMSPNxNOenV75TGcL31vwIPYNuuaXwGWzYNb4A6B5QBiyEylh//CDDoXVOWYuH
	Pfw+JbfRkE9soaQ7FP49X6uu71L2jW98lX599SmhditSFL1TCxmWI94B4rNu+ByjU2Fx5qrIDBl0A
	DjpUj1tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK9C-0006kf-5c; Tue, 31 Mar 2020 16:53:54 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK67-0004lc-61
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:48 +0000
Received: by mail-wr1-x441.google.com with SMTP id u10so26902204wro.7
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hibSoh9qgmQtp1WobFBYw6Uhj1Dbis9lBXHK79oIydM=;
 b=TuJ5VHJu5G7+bhGXetZYhpor2dUGxFDWIp97yNjHfQiownF9KAjH+fUcpPw7TUhq5K
 Ruii5VI+n0fE2YtwBXMcawRbEjJ3uS5J+5NBT9b8EtEYUXfpt3Vyf+gTPEqFkUIF6174
 wRdoXtCOBuNAdR6AW/zt694UiU86wWQddPlaTFwXuUd+z+9XL9iyAKCs/T/Trwdu378k
 olp7vw7tOcGzAC0jjOU2oHqS6LUnkEpvHFCNaI/iIY8jlyDYnWKCnBrtYYMJ+PYWVtmy
 4URv8GEipC8mKaEsNTOE7AXp/+tI5YO6I46NytbmtsJex1Ln6RDliv7uzNW2WCOZ6r+b
 x5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hibSoh9qgmQtp1WobFBYw6Uhj1Dbis9lBXHK79oIydM=;
 b=caALIXYSpw8NdQHHgQRAlJWTLIEDUzJrcHby9AIHawMoJONmNcPa5Ow4QaLlQWsz/3
 Ci61YULZc5rusmugpZVO+Rv9aJ9PT85yi73ua+H5Prc+cyNYrqV9+5oIVETLwioE8Oe3
 Czjc7hfGy/GC0IzQ66owfvyovSQ9F5ZHk9GwhCDrxgS0F3y4FUIS6bjER6hqQ+RfFWP8
 lbDbUlIKEh7U+FGOeYBogxB3y/vTujYpce9yjH6SJ7EMpIejWQNvApHyJz7MXBcQZg5o
 gzuieCW8l/9yhSRLjcbyttEYEyKe0hRbVuay6WkxRIhTrgxTjZe8n+uphAcfkM5CJpZ6
 WsLg==
X-Gm-Message-State: ANhLgQ1aQkz/j47jHtV/kZOFPwNtX0FdEr0NzI3+pcY5tuFWF29fnNO9
 5dTbT2hPf0GgPN6KJ4ZC762Kr6So
X-Google-Smtp-Source: ADFU+vsdiTDW8Gov5+n812QNu1Xypo/hpv30yq6XQ0XVnRBh4eoXiA4po5CyrK/dfeN3fyxEtb3Zfg==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr23135060wrp.276.1585673440899; 
 Tue, 31 Mar 2020 09:50:40 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:40 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 13/26] nvmet-fc: rename ls_list to ls_rcv_list
Date: Tue, 31 Mar 2020 09:49:58 -0700
Message-Id: <20200331165011.15819-14-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095043_329262_2003D9F7 
X-CRM114-Status: GOOD (  12.68  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In preparation to add ls request support, rename the current ls_list,
which is RCV LS request only, to ls_rcv_list.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 3ccf27c328b2..6a5af99f19ba 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -29,7 +29,7 @@ struct nvmet_fc_ls_iod {
 	struct nvmefc_ls_rsp		*lsrsp;
 	struct nvmefc_tgt_fcp_req	*fcpreq;	/* only if RS */
 
-	struct list_head		ls_list;	/* tgtport->ls_list */
+	struct list_head		ls_rcv_list; /* tgtport->ls_rcv_list */
 
 	struct nvmet_fc_tgtport		*tgtport;
 	struct nvmet_fc_tgt_assoc	*assoc;
@@ -90,7 +90,7 @@ struct nvmet_fc_tgtport {
 
 	struct nvmet_fc_ls_iod		*iod;
 	spinlock_t			lock;
-	struct list_head		ls_list;
+	struct list_head		ls_rcv_list;
 	struct list_head		ls_busylist;
 	struct list_head		assoc_list;
 	struct list_head		host_list;
@@ -346,7 +346,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 	for (i = 0; i < NVMET_LS_CTX_COUNT; iod++, i++) {
 		INIT_WORK(&iod->work, nvmet_fc_handle_ls_rqst_work);
 		iod->tgtport = tgtport;
-		list_add_tail(&iod->ls_list, &tgtport->ls_list);
+		list_add_tail(&iod->ls_rcv_list, &tgtport->ls_rcv_list);
 
 		iod->rqstbuf = kzalloc(sizeof(union nvmefc_ls_requests) +
 				       sizeof(union nvmefc_ls_responses),
@@ -367,12 +367,12 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 
 out_fail:
 	kfree(iod->rqstbuf);
-	list_del(&iod->ls_list);
+	list_del(&iod->ls_rcv_list);
 	for (iod--, i--; i >= 0; iod--, i--) {
 		fc_dma_unmap_single(tgtport->dev, iod->rspdma,
 				sizeof(*iod->rspbuf), DMA_TO_DEVICE);
 		kfree(iod->rqstbuf);
-		list_del(&iod->ls_list);
+		list_del(&iod->ls_rcv_list);
 	}
 
 	kfree(iod);
@@ -391,7 +391,7 @@ nvmet_fc_free_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 				iod->rspdma, sizeof(*iod->rspbuf),
 				DMA_TO_DEVICE);
 		kfree(iod->rqstbuf);
-		list_del(&iod->ls_list);
+		list_del(&iod->ls_rcv_list);
 	}
 	kfree(tgtport->iod);
 }
@@ -403,10 +403,10 @@ nvmet_fc_alloc_ls_iod(struct nvmet_fc_tgtport *tgtport)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
-	iod = list_first_entry_or_null(&tgtport->ls_list,
-					struct nvmet_fc_ls_iod, ls_list);
+	iod = list_first_entry_or_null(&tgtport->ls_rcv_list,
+					struct nvmet_fc_ls_iod, ls_rcv_list);
 	if (iod)
-		list_move_tail(&iod->ls_list, &tgtport->ls_busylist);
+		list_move_tail(&iod->ls_rcv_list, &tgtport->ls_busylist);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 	return iod;
 }
@@ -419,7 +419,7 @@ nvmet_fc_free_ls_iod(struct nvmet_fc_tgtport *tgtport,
 	unsigned long flags;
 
 	spin_lock_irqsave(&tgtport->lock, flags);
-	list_move(&iod->ls_list, &tgtport->ls_list);
+	list_move(&iod->ls_rcv_list, &tgtport->ls_rcv_list);
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 }
 
@@ -1170,7 +1170,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	newrec->dev = dev;
 	newrec->ops = template;
 	spin_lock_init(&newrec->lock);
-	INIT_LIST_HEAD(&newrec->ls_list);
+	INIT_LIST_HEAD(&newrec->ls_rcv_list);
 	INIT_LIST_HEAD(&newrec->ls_busylist);
 	INIT_LIST_HEAD(&newrec->assoc_list);
 	INIT_LIST_HEAD(&newrec->host_list);
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
