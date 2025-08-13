Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1CFCA0EE0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5JRk3yn3Askv8wda4/P5aQeyaHdr8Z99f60OEH4jfr0=; b=2nJq0VATATXjaKnTgw1LrcksPO
	s8lkqnjgTshbG12Qfy3hkO4eDEUqkCj0wN5WVko0iObHFc3azM27MvYmw3iLJdC7RuZG1Cyohp1fW
	MFUm75jHQsUhOzeGbyv3mHCudTVRFenLhO2S5E1h+DGcTGvinBsNQmkGFKSsOQ5oZRgDsPWK3wRJS
	CoYXuoBTOx/9sy+mTSO8Bl7m9RqRnUVfmeWKP/KeCRT3ioP74bjet3M4f0WhwE3Cbup8n38ZTyGPb
	cH7wbv8FcdnSart1rOzQUrcadwt16J0gw//Bf8IOK0RpmfjM4f9gRHo/BFMzenNdNQmqESSP2WglS
	bEfgnYAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umHm9-0000000Euad-19Zr;
	Wed, 13 Aug 2025 20:08:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umHm6-0000000EuZf-1Bho
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 20:08:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755115721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JRk3yn3Askv8wda4/P5aQeyaHdr8Z99f60OEH4jfr0=;
	b=Rr3k109VQU8oIwHeDVJpoqMHY83TexG+7jlzeFTOzrfjs4jYHr91WYyVT1BGtgKn+fSPSa
	cTVBOly51WWjOFeSJpuPWaoPUglV7lumVMYYK23gyO6nDQ2CenmvftguYJOtJSB/mA1FGH
	qEVUjzp7x9iyiT6PsxB6HU8JtfGyxnU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-kO0Ax4JMPS2gjyE7JeKkAA-1; Wed,
 13 Aug 2025 16:08:37 -0400
X-MC-Unique: kO0Ax4JMPS2gjyE7JeKkAA-1
X-Mimecast-MFC-AGG-ID: kO0Ax4JMPS2gjyE7JeKkAA_1755115715
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BE6618011C6;
	Wed, 13 Aug 2025 20:08:35 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.44.32.39])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74B4E180028F;
	Wed, 13 Aug 2025 20:08:28 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	bgurney@redhat.com,
	jmeneghi@redhat.com,
	emilne@redhat.com
Subject: [PATCH v9 5/9] lpfc: enable FPIN notification for NVMe
Date: Wed, 13 Aug 2025 16:07:40 -0400
Message-ID: <20250813200744.17975-6-bgurney@redhat.com>
In-Reply-To: <20250813200744.17975-1-bgurney@redhat.com>
References: <20250813200744.17975-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_130842_397618_81FD8898 
X-CRM114-Status: GOOD (  11.20  )
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
Tested-by: Muneendra Kumar <muneendra.kumar@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index c7cbc5b50dfe..146ed6fd41af 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -33,6 +33,7 @@
 #include <scsi/scsi_transport_fc.h>
 #include <uapi/scsi/fc/fc_fs.h>
 #include <uapi/scsi/fc/fc_els.h>
+#include <linux/nvme-fc-driver.h>
 
 #include "lpfc_hw4.h"
 #include "lpfc_hw.h"
@@ -10249,9 +10250,15 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
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
2.50.1


