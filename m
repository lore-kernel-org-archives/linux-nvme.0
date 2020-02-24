Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB0AC38BE0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 401E920836
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IaygSlmj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4OFz+a7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 401E920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=dL+VKyHpRRaokfJUOXfOkCVLGp8gpLZekd427CyHfWo=; b=IaygSlmj41hnIh/NYUGJKGSAVa
	fb8fdnyXwS8yKoTf2gd2U4rOxszg9eYPRo5ROsIp+T7exb0O4TdNCNGYRTlfzsGlwGjq8/tBxkOyt
	VcNM2A1IlnJebG0+8kw+HKtCereWjFv+6eY2kIGhEhiGCDm9tUcIyGEi1dyKhHQBpw+CjTVgw8uyb
	O/XaDsvPBbX+rZtMhOfiKBKq+3QajEar7ryeuxm689I6mdvaw11duiUS+QYuWJqz82Ty6s0nlhvuv
	VNJPhmAGNa+//ujp1xDP86KtLbPnkZv2ld5WCn4wLD4dwd4k0iuosGap/FZhN83ShaJho3yOuKLdR
	i8LJSzTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6IoF-00012L-NY; Mon, 24 Feb 2020 18:50:27 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6InC-0007MJ-Qq
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 18:49:25 +0000
Received: by mail-wm1-x32f.google.com with SMTP id q9so361437wmj.5
 for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2020 10:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=m6TkHC6swSJDnkvGhDdj4nTZ5RHMsdI+fJ1Ci1vrJ+0=;
 b=o4OFz+a70kPSiv55WyFHyTC2Jgf82ql6ddp4S34xBTgt9m6eGk0tM1FJJEmk4zrm+r
 Uubx+GtEJ964AhIibR5rdNYK9EulMqQd7wxfQbbFCDTD2FExp3cKxYTsVw7gKCqlCvr+
 k4xpjuHv3yo0H1LQKFGPuk9PaiE851Qmx0IPWh/jWSg7plv/epIvaRh8hF33C/FXa21M
 +szd2sO3v/ydIv/c34Wp1zzD4turOaJs215K4eTluMN6cELJFVMMr7GbZiV7SbnPpepB
 4haWLcujlS4LH93xTHywrxJ1qckTEQs3SLneBnDX+YFs4c+KdhjSFuDxBM8Mp5BUYP6O
 LelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=m6TkHC6swSJDnkvGhDdj4nTZ5RHMsdI+fJ1Ci1vrJ+0=;
 b=gWk+3oNEvF5p7v1vaZYkU3wEc84QRGUeqvNBFrs2ImtHbr0evENuYTBGmePYQcZKCU
 CeaMAev4QwpHwMag9I//y3jtI10fSBFZ1iN4dT/uXjvmk6XGu+H8qGKpFJkBhadxI6ul
 V6o3LuT2L4Q8PRTaYl6f+bl5REVPSgrCr3Hfw1zjgA9B4b4LpjfOkpX7HsdmDN7sSycL
 S9Euf6+UQfiWchEJRg4plLocfk96QRYoVxNuyY10OJAxyjhlxBHzWqUwXuhiOlQg5uM6
 u7SdB5vOal7CdhePeFD+PNsd0x4TzqKQhWdrbAsseUwaXlE4PEuM+b/ASHJKaxirYCkj
 J1gw==
X-Gm-Message-State: APjAAAUOw4VDpqqTEPFLhOk1b6spMT3ucZgFUwj/qaQdOuKMJkGAKVXX
 Zq9E3X0o4tXSDY/pnR4d6KjOJ2p/
X-Google-Smtp-Source: APXvYqxi/GcJShaE0UeaIb0+f4N3Wpe2+oD6cAPcK7LBQEvk37ZkIwGF9ikAlHlXenvB7CRdMC41Rw==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr451144wmi.10.1582570156304;
 Mon, 24 Feb 2020 10:49:16 -0800 (PST)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l8sm460047wmj.2.2020.02.24.10.49.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:49:15 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC 5/6] nvme: Add pi_flags to nvme_request for transport pi support
Date: Mon, 24 Feb 2020 10:48:58 -0800
Message-Id: <20200224184859.20995-6-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224184859.20995-1-jsmart2021@gmail.com>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_104922_878213_5CE11C04 
X-CRM114-Status: GOOD (  20.40  )
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

Create a new field called pi_flags in the nvme request.   This field
uses the enum nvme_transport_flags definition. However, they are set in
a different manner:
 NVME_F_FABRICS and NVME_F_PCI_P2PDMA will not be set.
 NVME_F_METADATA_SUPPORTED will not be set. The transport must look
   for blk_request_rq() to determine that there is metadata.
   Note: There may or may not be PI when set.
 If there is PI and metadata, only the NVME_F_PI_TYPE_xxx flag for the
   ns's pi type will be set.
 If there is PI and no metadata, the NVME_F_PI_TXINSERT_RXSTRIP flag
   may be set.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/core.c | 56 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ab03311105c3..ec808e7d395d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -470,6 +470,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 		nvme_req(req)->retries = 0;
 		nvme_req(req)->flags = 0;
 		nvme_req(req)->ns = NULL;
+		nvme_req(req)->pi_flags = 0;
 		req->rq_flags |= RQF_DONTPREP;
 	}
 }
@@ -704,28 +705,73 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	if (ns->ms) {
 		/*
-		 * If formated with metadata, the block layer always provides a
-		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
-		 * we enable the PRACT bit for protection information or set the
-		 * namespace capacity to zero to prevent any I/O.
+		 * When formatted for metadata, a separate metadata buffer
+		 * is required (via blk_integrity_rq()) with one exception:
+		 * if the ns is formatted for PI, then either the host
+		 * transport can insert/strip the pi metadata or the io
+		 * can be issued with PRACT=1 to have the controller
+		 * insert/strip. It's preferred the host transport does
+		 * the insert/strip if possible as it protects fabric
+		 * traversal.
 		 */
 		if (!blk_integrity_rq(req)) {
 			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
 				return BLK_STS_NOTSUPP;
+			/* set both flags for now. Code below will resolve
+			 * to one setting after host support of pi type is
+			 * checked.
+			 */
+			nvme_req(req)->pi_flags |=
+				ctrl->t_flags & NVME_F_PI_TXINSERT_RXSTRIP;
 			control |= NVME_RW_PRINFO_PRACT;
-		}
+
+		} else if (!(ctrl->t_flags & NVME_F_METADATA_SUPPORTED) ||
+			   (!ns->ext && ctrl->t_flags & NVME_F_FABRICS) ||
+			   (ns->ext && !(ctrl->t_flags & NVME_F_FABRICS)))
+			return BLK_STS_NOTSUPP;
 
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
+			nvme_req(req)->pi_flags |=
+				ctrl->t_flags & NVME_F_PI_TYPE3_PROTECTION;
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
 			break;
 		case NVME_NS_DPS_PI_TYPE1:
+			nvme_req(req)->pi_flags |=
+				ctrl->t_flags & NVME_F_PI_TYPE1_PROTECTION;
+			goto set_guard_check;
 		case NVME_NS_DPS_PI_TYPE2:
+			nvme_req(req)->pi_flags |=
+				ctrl->t_flags & NVME_F_PI_TYPE2_PROTECTION;
+set_guard_check:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD |
 					NVME_RW_PRINFO_PRCHK_REF;
 			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
 			break;
 		}
+
+		/* resolve insert/strip:
+		 * if no host pi support, leave PRACT. Otherwise, clear PRACT.
+		 */
+		if (nvme_req(req)->pi_flags & NVME_F_PI_TXINSERT_RXSTRIP) {
+			if (!(nvme_req(req)->pi_flags & NVME_F_PI_TYPE_MASK))
+				nvme_req(req)->pi_flags &=
+						~NVME_F_PI_TXINSERT_RXSTRIP;
+			else
+				control &= ~NVME_RW_PRINFO_PRACT;
+		}
+
+		/* If no metadata:
+		 *  Either the transport or controller will insert/strip
+		 *  metadata.
+		 * If separate metadata:
+		 *  Pci transport will pass metadata as separate buffer to
+		 *    controller and controller will perform PI actions.
+		 *  Fabric transports will minimally multiplex the separate
+		 *    buffer into interleaved data for the controller.
+		 *    If PI flags are set, the transport may perform
+		 *    PI checking as payload egresses/ingresses.
+		 */
 	}
 
 	cmnd->rw.control = cpu_to_le16(control);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 88e82250bb3d..bedee3fa9d41 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -141,6 +141,7 @@ struct nvme_request {
 	u16			status;
 	struct nvme_ctrl	*ctrl;
 	struct nvme_ns		*ns;
+	u32			pi_flags; /* see enum nvme_transport_flags */
 };
 
 /*
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
