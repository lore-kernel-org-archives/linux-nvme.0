Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8AF9C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 19:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vWRtja9QCe0B86RGsho3XdkYyc/UQEm8tjcjyaostnE=; b=q4+umo/DSPcpkYSK1JLJi37F53
	Hhhwh+4s+ecHszagRSBnZwH/+O8F+DTCEHWkivcrStpOH8MRwoMPEkrcmiqAwcELPxpKF+wR/tDFS
	F8w4uuGndkq/96XfrWtw9svQ6Cnid3n2V9gopqemFlx7tOgn5Ki3xigcy99t2Z0RT1UCbA0raPh1+
	3eTBUZuGTa9uLl2WV2D4SacPTrNEbFQGBlc3NZEoHKJilpcQJeddUeFArGOfCHhk1eOlj3edPIWZ4
	5nMhmd1R2mvaWlxtS9x4OTjDBYFuLjfOkRNuldS/+We2RMU/DYxponN25ZC3fkpif1bVctxy91tgY
	fprJqRQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOMn-0000000DHNq-1GOl;
	Tue, 06 May 2025 19:54:13 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKKL-0000000CW6G-2gPp
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 15:35:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5C72449D39;
	Tue,  6 May 2025 15:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04CDC4CEE4;
	Tue,  6 May 2025 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746545725;
	bh=DtgB78c22WRxRHquo4Lc4gpJsP7CtmpqK7YEdDZ6p1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YbB8H23uIUPNOa0eH3twGvc5IctHTup8v9HJyJ4sJ3oMUKoTY00CWx4T1xa5/fpDA
	 VCj06cwoCct8YLNFmkLlHCklY/UDJm2pJgC0waCCst9A0mmzEwZW9UcXMdcptvRTbw
	 OWxgxYuHg5t3EaLPoG3oKdv75U5JAyVsl2DAuBxj2kfZ0lGQMJpuki6TokoqqtYXgt
	 y6hAlAnU12jzwJLHoepTzDoL0HbLp07BLAoAX72TkpUuczFtUKohE3yOV2vvMyfBbk
	 B7/BlV/fxYNV/AXljsGnMPqB9BahGoWD0IKedrtiC0t+V21OyjfpzZDfwQ0bZZkoqs
	 w0WTut6yMQOzA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/5] lpfc: enable FPIN notification for NVMe
Date: Tue,  6 May 2025 17:35:06 +0200
Message-Id: <20250506153507.83094-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250506153507.83094-1-hare@kernel.org>
References: <20250506153507.83094-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_083525_693051_2B6B51AC 
X-CRM114-Status: GOOD (  10.89  )
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

Call 'nvme_fc_fpin_rcv()' to enble FPIN notifications for NVMe.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
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
2.35.3


