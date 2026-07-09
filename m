Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FE6C44503
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 07:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4sfPQozTglJO91ZYj/1163Y2lzjvibu5SdwcszkirX8=; b=xRK1GdSbPfoee6rNNw6f2SIPkA
	ai3Hks5TarwbIXOZkx5CMZPCZs8xntgBrISdHE6vpb16ZNrA+yok1obcLWTbHXYisWI4PAdxlR9km
	ApddrX04ZBJIja0KlCfFxqQOQA77m2hbe3Z5A0h6PyrFSkPLNauDbohyfZApKE3eJvceCBh6f0wuZ
	EPlcZ5/eUHaLtdtgHj/1pi4eLaJ8+bBHOGUQooifZLT//I7Hq3EIj5hYJ1gCGdqUi+yeHlDQPX355
	ZNPVQxlOuy9PMZ8MwjBXIU9oc4wI12XY3tlDhK3siSwFVUnAwLi5DG2NkvcIb4MVol2k44URmzi7z
	9nX4F4Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whjTy-00000001M3G-3L9C;
	Thu, 09 Jul 2026 07:47:42 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whjTp-00000001M1U-1RVE
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 07:47:41 +0000
X-UUID: 6b1921867b6a11f1aa26b74ffac11d73-20260709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1d910395-0a2b-4cd4-abe4-7dac663e23a2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:593bacc5886ed2a3f1b20265900b427b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6b1921867b6a11f1aa26b74ffac11d73-20260709
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 539566491; Thu, 09 Jul 2026 15:47:21 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, liuxixin@kylinos.cn
Subject: [PATCH nvmet-v1 0/1] nvmet: zns: reject full zone report when buffer is too small
Date: Thu, 9 Jul 2026 14:51:39 +0800
Message-ID: <cover.1783579899.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_004733_698489_5395558A 
X-CRM114-Status: UNSURE (   4.74  )
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

Hi,

A Zone Management Receive partial report (PR bit set) may return fewer zone
descriptors than zones matched.  A full report (PR bit clear) must fit
every matching descriptor in the data buffer.

nvmet already caps Number of Zones on partial reports, but may return success
on a full report when the buffer is too small.  Reject those commands with
INVALID_FIELD.

Tested on nvmet-tcp loopback with io-passthru.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvmet: zns: reject full zone report when buffer is too small

 drivers/nvme/target/zns.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
2.43.0


