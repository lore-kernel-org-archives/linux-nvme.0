Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8B8CDE00B
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 00:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P1KxTrpsEdjc0gMqT+MTmkuSZ83IEpaesI/O2S6diYE=; b=nmfRmvXG7gE/lVvchmBLAxtICK
	AUBkyPEbDQ/uQ9stFp2CaIWIV3aRFedF1uvCmxxIUws5ud8w11BKC0nm3jLD6cRyDYU1OvmCl5IQy
	dfoQELQ7D9VxKPVBdpZwTcMRF4C7x2WQ6Dv9ulKHoPavsRBUVG63a8xFboUMeniw8DAri3UktZ2VT
	8b+a1A9bCj4mIsSeQ16dfHBwJBcS2H5GE5xqrJ8irjWZkwcBBJNpa/Hm/VuTDNKiHcbtYbvC7d7mI
	b43sV8QZ3AXQG1+RGpm2KUKYRz/E+OF9qfegqk4ZOiaUD1XiA1TZGYzBGqtqoa43N8uewfbb8uSOo
	wDEmhGqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcuuh-0000000A3pa-2NPJ;
	Fri, 26 Jun 2026 00:59:23 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcuue-0000000A3o0-2iVx
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 00:59:22 +0000
X-UUID: 3d9800e470fa11f1aa26b74ffac11d73-20260626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:819c0f4c-16c7-4b9e-9e84-c91072bc9528,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:e153648a635b3349d862e95b5ab195e7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d9800e470fa11f1aa26b74ffac11d73-20260626
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1330636986; Fri, 26 Jun 2026 08:59:10 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 0/2] nvme: zns: cap zone report nr_zones by DMA buffer size
Date: Wed, 25 Jun 2026 10:00:00 +0800
Message-ID: <cover.v2.1782280600.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1782280420.git.liuxixin@kylinos.cn>
References: <cover.1782280420.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvme-ecn124/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_175920_997036_E616E5B5 
X-CRM114-Status: UNSURE (   5.94  )
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

Hi Christoph,

Thanks for the review.  Split the zone index logging change into its
own patch (2/2).  The nr_zones / buflen fix is unchanged in 1/2.

Thanks,
Xixin Liu

---

Xixin Liu (2):
  nvme: zns: cap zone report nr_zones by DMA buffer size
  nvme: zns: include zone index in invalid zone type error

 drivers/nvme/host/zns.c | 12 ++++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)


-- 
2.43.0


