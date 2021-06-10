Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AD5C48BCD
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B8E161406
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8E161406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E8UqDfuDONr+4uh57OwwXqi9hwA0yIYeKLgZHjziopY=; b=UM2NHPr9XDYgRV
	wJ31Fu/F858ToSVl7qLXHuRs2QQ2HXxtPIR0rDTja1AWNaf5N6xQZ8vAIqOQk6786oG8gtLBDPSJK
	HDqEW8pNWZW+YpPsG+CT/LTiAgyHPs2domjyoNHYMYyhKpLxHnm4OfTsmuF/MuY8KgxImmXuUbxrp
	gzNTzTSf8A1mzit7oGl9/QFwpXGrr6Nn5VHLfEc7iWhG4+R+Kz29Qgb5fED2CfTRhN4WgSau99l5n
	2842nK/6pbRFo0pnM7Hr2VRJbWnBZiWzYmCfVQXcG/CSZKA45cbg0J/a+fAne9MqKAbOvpUXqD21f
	8wPVXQEugtO8otjfLH5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9ZX-00GGe3-Od; Thu, 10 Jun 2021 01:33:27 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9ZL-00GGae-TR
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:33:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623288795; x=1654824795;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R/f8Bm19V5/mcqXAclWPl6QyH7YmCPjeKb2p9RI6rVs=;
 b=hYAvQFCPpB6UaxMYLQ8T7qUWxpGo8n4wzQjuafH/COxh0u6haZ6wj4FH
 GqDazCEsUCkwxA8nclVh93zb1coseeCAp8HVgXUROk1/A0AjXR2m24Iak
 qWhui0wVGE9LaUhclywbFaiQmze5b2kKc2KRNaAwCjU9gu22zBA/pd12F
 nMgohma4qhmP1tFT/Z568W8HDGlcIodkHUVJJtbCly+xpjjvLldmc3QRC
 5VQxius4Jrh6ipuYdpM0lW8g0KULoQx1QdyXQf7SDL3hJYBTKSguZZBkr
 NVXmw1Qa+OFauTo5408uMVMFv4dljQqiEZssUfw3D8CrJE/Cy0JjrTM+v Q==;
IronPort-SDR: MV82IU7nFCDP3Nv89gCYD8jo+hlBJ2bD/Tium4hYajOVf1PDm8Pd9M/daMneJaeATUjPATGqm1
 IyfT0u07+8pzyCPiCLSxrfs3DPZRW8xqCkJFm4l3p1GId5BjSEndVmve7q8WGeHN5tJj8IP3IP
 vlWD9VwlrST0Dz7KuGkBomLO/bnu37y9X96BIqvrWx/YQUAfgZ5RmPVFtrPoil045m6kEPNifI
 ZeRAhZh512UFWirEFVMl0ksD5GLVT8QG82Niqb/iBbeGv77oxuVvt+mkpPYYIIstVffXfBauUr
 tec=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="282813639"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:33:15 +0800
IronPort-SDR: dRXAk7I5xhj+LjURZPUuhYH+pjYBJDtgNkJB9+Ybft5VQORvUIOJp5P/NRABqN6Ab76Q2Mf4RB
 F/OCE1vvHl8RYj2ghf0aM2eHR/H/CJdv+aI4luuCVlIyLf6q9tLD4iAde+QbcMpmjD7Fey9Zbj
 36MrdGAl5GXt9tcJ86vbG6PmRl+WMQTq5/P/Wh4AixvNrf+hLWoeYYpXcurwrqfGkqWJX5pLiL
 9s1905MK87hC5wtraXodWOi0dMbVIYe/nqEiKLfDQwrZcWf4J1VBbzLWvlftuIhl6/N1+osJc8
 Wk3B1RGO7nVrsKs16h9l9Uad
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:10:54 -0700
IronPort-SDR: pMUdnKrfGL394N0ia1FZoMrH7RFL/TsF+svXAgDi0RybBSxoR63R0pmZZGRj4jfSGPbDyAQ03u
 NTGPqEUL+h+4VxV2kvEuqmrqdrJsWED79HhG1DAiT1sGFCmBxjfVbz7/V7Ny2LKwI9SR26H6JC
 F/V6kz372PyZ4v4BrzH181y9DgIkW+nhT/e1ardxDUTuRQy5cyl0dY5Iga5vfy9fnIJnHsMomS
 6of4Wokot8MyTeYkjzEmFV72aRw87TOjqIFqJ+ltD81/cKoycs+Ep6x6JE/f+0w3Xl0p2e/39u
 bnc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Jun 2021 18:33:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, sagi@grimberg.me, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V15 2/5] nvmet: add req cns error complete helper
Date: Wed,  9 Jun 2021 18:32:49 -0700
Message-Id: <20210610013252.53874-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_183315_991812_96FFCFA7 
X-CRM114-Status: GOOD (  11.83  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We report error and complete the request when identify cns value is not
handled in nvmet_execute_identify(). This error reporting is also needed
for Zone Block Device backend for NVMeOF target.

Add a helper nvmet_req_cns_error_compplete() to report an error and
complete the request when idenitfy command cns not handled value.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 5 +----
 drivers/nvme/target/nvmet.h     | 8 ++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index cd60a8184d04..3de6a6c99b01 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -637,10 +637,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_desclist(req);
 	}
 
-	pr_debug("unhandled identify cns %d on qid %d\n",
-	       req->cmd->identify.cns, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_cns_error_complete(req);
 }
 
 /*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index bd0a0b91d843..f53ce96df498 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -624,4 +624,12 @@ static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
 	       req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC;
 }
 
+static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
+{
+	pr_debug("unhandled identify cns %d on qid %d\n",
+	       req->cmd->identify.cns, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_identify, cns);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
