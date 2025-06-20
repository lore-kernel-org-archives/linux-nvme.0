Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8DFC7115C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jun 2025 17:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LZHCVpRfqA1ZoANSnSbT28oQCdLRuu6wzz22Z7s4YUQ=; b=MBQf/gKVL3hRKgzFtya1ZYe8Kg
	ATu1DCLqEntOpkGHMKiRyp98f2wOC2mvConr4K83PqGGNRJMrdMR2vhn/GqoahEpcCEf5ytaBYryc
	iHrAHIV7Mzpr0YiL7blsRgDq0WoYI0rbOe822lXHMOlDiBcRLe38pobV7pCFhFxeAK3gH8yCjHeVk
	113nKf7XWpAL9wRBoc+XQGyo5gwKXbbuG/inEuKy4vlJ6qN+aIZX+AKx/7FVOHdSnuvnNi9ZFdhDk
	osTgF5YXLNubYxB9tSQlb45mxRWvrfQzWxAtR7kf/Ui0zaCnXVsx30SB+EXHTbqm+67eq5wBmvOrw
	3lFuDxdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSfzo-0000000GJFN-3Tst;
	Fri, 20 Jun 2025 17:57:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSfzm-0000000GJE7-0j07
	for linux-nvme@lists.infradead.org;
	Fri, 20 Jun 2025 17:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750442265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LZHCVpRfqA1ZoANSnSbT28oQCdLRuu6wzz22Z7s4YUQ=;
	b=WhzeY4ku0h1i+7/fLF+Y3C9A9wIvivzWPQJdzNNlSMv/3b8XCcsnMpNeATkBc9+WPEi73y
	QOifw0a+5u4i0B/vZvLR2egWQvL+R6S1/KVh2S1xW3a5ekedOsvr9ZqcSIBC17WyNUzkYq
	7XotNZTSEgwqUrkKX+zv2jRVOuXs5p4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596--XMLh-CfO1SVYbYkGlfotg-1; Fri,
 20 Jun 2025 13:57:43 -0400
X-MC-Unique: -XMLh-CfO1SVYbYkGlfotg-1
X-Mimecast-MFC-AGG-ID: -XMLh-CfO1SVYbYkGlfotg_1750442262
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2187819560BC;
	Fri, 20 Jun 2025 17:57:42 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.80.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48973180035E;
	Fri, 20 Jun 2025 17:57:38 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	bgurney@redhat.com,
	jmeneghi@redhat.com
Subject: [PATCH v6 4/6] lpfc: enable FPIN notification for NVMe
Date: Fri, 20 Jun 2025 13:57:32 -0400
Message-ID: <20250620175732.34731-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_105746_291607_B552EE46 
X-CRM114-Status: GOOD (  10.06  )
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

From: Hannes Reinecke <hare@kernel.org>

Call 'nvme_fc_fpin_rcv()' to enable FPIN notifications for NVMe.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Tested-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 959603ab939a..396ed1a05bc9 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -33,6 +33,7 @@
 #include <scsi/scsi_transport_fc.h>
 #include <uapi/scsi/fc/fc_fs.h>
 #include <uapi/scsi/fc/fc_els.h>
+#include <linux/nvme-fc-driver.h>
 
 #include "lpfc_hw4.h"
 #include "lpfc_hw.h"
@@ -10248,9 +10249,15 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 		fpin_length += sizeof(struct fc_els_fpin); /* the entire FPIN */
 
 		/* Send every descriptor individually to the upper layer */
-		if (deliver)
+		if (deliver) {
 			fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
 					 fpin_length, (char *)fpin, 0);
+#if (IS_ENABLED(CONFIG_NVME_FC))
+			if (vport->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
+				nvme_fc_fpin_rcv(vport->localport,
+						 fpin_length, (char *)fpin);
+#endif
+		}
 		desc_cnt++;
 	}
 }
-- 
2.49.0


