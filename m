Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2749FC43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXfcJneCswxY0d+5izy08cLa3JXCrhGqjXXZwX5zRbU=; b=D3c8H3wubGweIWOCCj7jSn4xVS
	mPC8zJSzKixXrY9jTUG6xAyBzUveOCEQIFUNvK4ioajhSxHFxAp7XPzJUMcXxo+/H6dybABibk7Ke
	bYpSMqj++HTChgI1gDraTT18+NnIEcHxR3ts749mhqmvmRYd2Z2MQLc9JfTE6wDaXEl6W1QextI43
	XcvvdgGR0BCZpcht0KE3qg1gTBcWeyG/lnSlqUAJzGXRMy2fUlZ89+P9ARt0Z+6cWFIgqqIHmdZiX
	2djzdK+Lmxs0ryfG5KF9YEUp5k0tF2QS9zUSSelalHPcEe8BPOjpRPKWQo/JXe+gcaRbsZWSDIfu3
	xs+dBVpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whjTz-00000001M3i-3kqL;
	Thu, 09 Jul 2026 07:47:43 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whjTq-00000001M1T-33R2
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 07:47:42 +0000
X-UUID: 6c6dfd187b6a11f1aa26b74ffac11d73-20260709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:76bf7ac3-08c2-4e0e-8db1-f28975b64b06,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:02701c8ee1510f5f6419f0d73b68bcf0,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6c6dfd187b6a11f1aa26b74ffac11d73-20260709
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1872690120; Thu, 09 Jul 2026 15:47:24 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, liuxixin@kylinos.cn
Subject: [PATCH nvmet-v1 1/1] nvmet: zns: reject full zone report when buffer is too small
Date: Thu, 9 Jul 2026 14:51:39 +0800
Message-ID: <a7c3e91b4d20.1783579899.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1783579899.git.liuxixin@kylinos.cn>
References: <cover.1783579899.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_004735_071428_B0CB0099 
X-CRM114-Status: GOOD (  12.61  )
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

Zone Management Receive uses the Partial Report (PR) bit in dword 13.  On a
partial report (PR bit set), the host accepts an incomplete listing and
Number of Zones must not exceed the zone descriptors copied to the host
buffer.  On a full report (PR bit clear), Number of Zones is the total
number of matching zones and every descriptor must fit in the buffer (ZNS
Command Set Specification Rev 1.2, section 3.4.2).

nvmet_bdev_zone_zmgmt_recv_work() already caps Number of Zones for partial
reports, but on a full report it may still succeed when the buffer only
holds part of the matching descriptors.  Reject the command in that case.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/target/zns.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index f00921931eb6..a53986fcc04a 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -295,11 +295,20 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
 	}
 
 	/*
-	 * When partial bit is set nr_zones must indicate the number of zone
-	 * descriptors actually transferred.
+	 * Partial report (PR bit set): the host accepts an incomplete listing,
+	 * so cap Number of Zones to the descriptors that fit in the buffer.
+	 * Full report (PR bit clear): Number of Zones is the match count; fail
+	 * if the buffer cannot hold every matching zone descriptor.
 	 */
-	if (req->cmd->zmr.pr)
+	if (req->cmd->zmr.pr) {
 		rz_data.nr_zones = min(rz_data.nr_zones, rz_data.out_nr_zones);
+	} else {
+		if (rz_data.nr_zones > rz_data.out_nr_zones) {
+			req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, numd);
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+			goto out;
+		}
+	}
 
 	nr_zones = cpu_to_le64(rz_data.nr_zones);
 	status = nvmet_copy_to_sgl(req, 0, &nr_zones, sizeof(nr_zones));
-- 
2.43.0


