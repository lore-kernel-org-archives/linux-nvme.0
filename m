Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF682CAC5B5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 00:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=avR9HzpeWIVFloMhMV4QtPG2R/sAjZzj6Xge04iSKcY=; b=EdrCDOhuDIJpNO9Yq12zyxEVby
	geMRnX1O6wFX4txIJ3ZjF+QC3oKIxb+8sTYy7jW64kvrc8iCSaknAMi4BMQ9TCPEIsL3JSjJWGgpI
	iWaf4NZ2hDjIhkFO04F5EbHMMwcoS94Wpco3dZ0/8A9uMps40+/vSjAq1K7LSylbSTXZuGu04hExR
	fwnqEvW9NUQvQkqhIXD71tp3TNJF0m7UePU8FjIQav68AQFNhhPwELpL3XFllP08MhYB46L2PVmUU
	fVAPcLcIGAqySqcZhm8Asqx1G/JwPjGLg9R5l1iQRWIRnyt07ETNPASwSX/ea0McJu1pzBRn3TLM/
	o0M2eNgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vv9-0000000EAwF-0r28;
	Fri, 26 Sep 2025 00:02:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1vv6-0000000EAsW-3Odm
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 00:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758844960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avR9HzpeWIVFloMhMV4QtPG2R/sAjZzj6Xge04iSKcY=;
	b=fbTXYj3IDTGJ5OOhWwY1Kw88x56QUxlTRtjklCHN2CnjVNYOPk7Lq1oOzsQ9aJtNde93Jm
	HdODetVCGBxt/UmLAQPA/Lnpr97RE52r4tdyNwgtsUyK983D7891WeKRSR9yRumXVL7baO
	yF2MP2RSWeDsQrHvPavazdV6XFFggu0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-YCMiM_KoPZ6ZUQ42SWObGg-1; Thu,
 25 Sep 2025 20:02:36 -0400
X-MC-Unique: YCMiM_KoPZ6ZUQ42SWObGg-1
X-Mimecast-MFC-AGG-ID: YCMiM_KoPZ6ZUQ42SWObGg_1758844954
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE4A7195609F;
	Fri, 26 Sep 2025 00:02:34 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen7.rmtusnh.csb (unknown [10.22.81.200])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 122A91800579;
	Fri, 26 Sep 2025 00:02:31 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: hare@suse.de,
	kbusch@kernel.org,
	martin.petersen@oracle.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: bgurney@redhat.com,
	axboe@kernel.dk,
	emilne@redhat.com,
	gustavoars@kernel.org,
	hch@lst.de,
	james.smart@broadcom.com,
	jmeneghi@redhat.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	njavali@marvell.com,
	sagi@grimberg.me
Subject: [PATCH v10 08/11] scsi: lpfc: enable FPIN notification for NVMe
Date: Thu, 25 Sep 2025 20:01:57 -0400
Message-ID: <20250926000200.837025-9-jmeneghi@redhat.com>
In-Reply-To: <20250926000200.837025-1-jmeneghi@redhat.com>
References: <20250926000200.837025-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_170241_271793_3AFE90F0 
X-CRM114-Status: UNSURE (   9.46  )
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

Call fc_host_fpin_set_nvme_rport_marginal() to enable FPIN notifications
for NVMe.

Co-developed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Tested-by: Bryan Gurney <bgurney@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 1511cabac636..bfd9ba4552f3 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -10256,9 +10256,14 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 		fpin_length += sizeof(struct fc_els_fpin); /* the entire FPIN */
 
 		/* Send every descriptor individually to the upper layer */
-		if (deliver)
+		if (deliver) {
 			fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
 					 fpin_length, (char *)fpin, 0);
+			if (vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME) {
+				fc_host_fpin_set_nvme_rport_marginal(lpfc_shost_from_vport(vport),
+								fpin_length, (char *)fpin);
+			}
+		}
 		desc_cnt++;
 	}
 }
-- 
2.51.0


