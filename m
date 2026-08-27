Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F007C61DBD
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 02:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UkavVg9fPsK/NC/Egk5MfMPlnqTD6iqMfr3Sm7JFtyc=; b=w1BU1lqbn99uuZyEAVOYyJdRjR
	7ppiAEDNEocxZlHteuT9TjAn83gr9dcRM1k4xpWo0Hhnw8NIW2EjbAAV+ArAPDwZ+ceRcxrONjI+A
	9ZnMRsgrvrG9XQL8vChphO1pblKqAgbgPKFmRmaTWjQO9gXYGCrKAUz58+5+mq3nM9QfstiHCGdi8
	ricmfNAfjSjLtovooU4q3oV0y0tkYDX/YTTFh9RWVdej3hOtRXFsR34zaOXacgYqd/0+7DwpsYpOv
	oBQlZ7IwACKd/UM7kchJdxsQolOoRqWDGD2m85ce3YxZHJi3dPahQrJd+8E+KgKeIzj5q0OngcfKA
	Bmzade3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzQ7r-00000003Jvq-3otA;
	Thu, 27 Aug 2026 02:45:59 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzQ7p-00000003Juy-3e8O
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 02:45:59 +0000
X-UUID: 6a53b9faa1c111f19a56ed5b684f684d-20260827
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:9de7c10d-7fa3-4876-97dd-5191811ee0c2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:74741afd7e287d08cbb00f419265b54d,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6a53b9faa1c111f19a56ed5b684f684d-20260827
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 435989249; Thu, 27 Aug 2026 10:45:50 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v2 0/1] nvme-tcp: fix wrong status on deferred digest error
Date: Thu, 27 Aug 2026 09:05:00 +0800
Message-ID: <cover.nvme-tcp-req-status.v2.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
References: <cover.nvme-tcp-req-status.v1.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_194558_578769_576026BF 
X-CRM114-Status: UNSURE (   7.08  )
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

Thanks Hannes for the review on v1.

Changes since v1:
- keep req->status as __le16
- only fix the rsp path: shift left when a deferred host error is stored

Same loopback test as v1, PASS.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  nvme-tcp: fix wrong status on deferred digest error

 drivers/nvme/host/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.53.0


