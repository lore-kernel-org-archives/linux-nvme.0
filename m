Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DABDC5DF88
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UgQ0/LJ6jHTbmKzscRj3cHZVZJvzjwADSR/yIePBg00=; b=bYTP/YQ3/M508mbsedm7iTbCVr
	7hdl5o2Hl6Uaa/5v4mG3LLQuMxj0FRpytB9XWHTvD/FSxvP3Q6hYAqsoXZR+KWcpmymTm09vemUjL
	CIA6vL57eMWGZ6HN6vYfG3TOoZwGYDXnw/kaj7+sT3yXhYCmkclYZ/EoKU0bUDsSQbiM75dPvv9+N
	mSLNEm/bG7cXLEqwzrWTV0KVugYsLKfSYvxGXsbElKE3Z0XZipVVT+l/NkSyYDNE03CWu2jlwyZKN
	kjGdnwjfXWwU1eiDwUYd7k1hMRO+DL44KKQrspbaTy0ybOhtWTjWpasF0FI4FEk2P6AVhneH2eU2j
	t8SWAIAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwehG-00000009gnz-1oOM;
	Wed, 19 Aug 2026 11:43:06 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwehA-00000009gkf-3SPE
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 11:43:02 +0000
X-UUID: 1aa251ea9bc311f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cb4c916c-2845-4fd9-b128-f341a4cdf898,IP:0,U
	RL:0,TC:0,Content:0,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:66d5c9c2b9fe0ec957e78ccb3bca61a6,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:2
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1aa251ea9bc311f19a56ed5b684f684d-20260819
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1992757633; Wed, 19 Aug 2026 19:42:49 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Hannes Reinecke <hare@kernel.org>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH 1/2] scsi: fnic: initialize the NVMe local port info before registering
Date: Wed, 19 Aug 2026 19:42:41 +0800
Message-Id: <20260819114242.3598034-2-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819114242.3598034-1-lilinmao@kylinos.cn>
References: <20260819114242.3598034-1-lilinmao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_044301_739607_58435696 
X-CRM114-Status: GOOD (  11.87  )
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

nvfnic_add_lport() declares struct nvme_fc_port_info on the stack and
fills in four of its five members, leaving dev_loss_tmo holding whatever
the stack happened to contain before the call.  The structure is then
handed to nvme_fc_register_localport().

nvfnic_add_tport(), which registers the remote port a few lines further
down, memsets its own struct nvme_fc_port_info first, so only the local
port path passes uninitialized data across the transport interface.

The NVMe/FC transport documents dev_loss_tmo as "Used only on a
remoteport" and does not read it in nvme_fc_register_localport(), so
there is no behavioural change today.  Initialize the structure anyway:
the driver must not depend on which members the transport happens to
consume, and any member added to struct nvme_fc_port_info later would
silently start out as stack garbage.

Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/scsi/fnic/fnic_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_nvme.c b/drivers/scsi/fnic/fnic_nvme.c
index b237948dcafdc..00d9d5d439a38 100644
--- a/drivers/scsi/fnic/fnic_nvme.c
+++ b/drivers/scsi/fnic/fnic_nvme.c
@@ -2216,7 +2216,7 @@ int nvfnic_add_tport(struct fnic *fnic, struct fnic_tport_s *tport,
 
 int nvfnic_add_lport(struct fnic *fnic)
 {
-	struct nvme_fc_port_info pinfo;
+	struct nvme_fc_port_info pinfo = {};
 	struct fnic_iport_s *iport = &fnic->iport;
 	int ret = 0;
 
-- 
2.25.1


