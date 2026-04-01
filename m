Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB1910F6FCB
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wuthZuZJNuIVCbef4TvR92fybPm79mBQ8LikDhPWnf0=; b=MX2FT3jQrcfezx4oB21RgHZB+A
	7tpw5Uhh4N7jShsP7+29MFxZq7CNwDbCX2LUSQpB8bjyM76d5+DliZIVUoWhUX4QJuIR9dwGNeVo1
	seXOKZP0UBBN7t/FjvmV3/nJ8it/h2uALTZOvpbOAVIC1S7gjL690woFF3PFJtRkvErcN9RNA1wPH
	uCf5ysPdSHlPlAWK+RjLeTJ7iLHKvMjZnmRBZCFLOo3AYBk6sJBy31cOTNQ696Sks+3JPLCqUIPrv
	b+C+awEyUYxUFtRx/4y/Oo/yMAjFx/MRrdEoNbHki2Mlj7DpPgoPxdgo5Ls8/QAVCRwB5yUF46rmq
	DAbe6oUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7x5D-0000000FYzo-3I3W;
	Wed, 01 Apr 2026 15:02:15 +0000
Received: from iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com ([34.198.218.121])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vkt-0000000FKQ5-0KAO;
	Wed, 01 Apr 2026 13:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775050631; x=1806586631;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=wuthZuZJNuIVCbef4TvR92fybPm79mBQ8LikDhPWnf0=;
  b=ECm7LhN9wN0h5TTJm67izOrMnbcbLjijWaQuKTHr1ieFRv2CWMjiqChD
   bNWidDs18jIZZmGFYK8vV7PmbL7lmGrkXPS0xv7y6Yc/+43wpr1kcPvzT
   nAhYyUSXjfg4fIvbXye3RTvRFT3cflNY2Qd75K5Qf5qUtVzz7eTsE5AAH
   y0fDzwRPdDYQbvMLrAtu2QYD/7iRzQCsRapqbPmZfL6IuxQ/eB+uKrW4T
   6MLz0yDfX/ZfSrcQzQx9d+1lSUlhgzpvnPjCaYnTEcTl2W8KPr67Pi2SO
   xBLRsZej4sy81SAu8BqTo2t8/D5VdEVmAx0OvEwvY57JULBnEJguj8Toa
   w==;
X-CSE-ConnectionGUID: Y52wK3WyQnCQaxue3N9eZw==
X-CSE-MsgGUID: BvBLo81GSHqURNQ2EZY2FQ==
X-IronPort-AV: E=Sophos;i="6.23,153,1770595200"; 
   d="scan'208";a="14740612"
Received: from ip-10-4-7-229.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.7.229])
  by internal-iad-out-013.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:37:04 +0000
Received: from EX19MTAUEB002.ant.amazon.com [72.21.198.67:21684]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.8.197:2525] with esmtp (Farcaster)
 id b3ce9a85-508e-4dd2-9849-9f140f408e54; Wed, 1 Apr 2026 13:37:03 +0000 (UTC)
X-Farcaster-Flow-ID: b3ce9a85-508e-4dd2-9849-9f140f408e54
Received: from EX19D012UEC004.ant.amazon.com (10.252.135.219) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:37:02 +0000
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19D012UEC004.ant.amazon.com (10.252.135.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:37:01 +0000
Received: from EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9]) by
 EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9%3]) with mapi id
 15.02.2562.037; Wed, 1 Apr 2026 13:37:01 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, "Keith
 Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Hector Martin
	<marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
	<alyssa@rosenzweig.io>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart Van Assche
	<bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>, Peter Wang
	<peter.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bean Huo <beanhuo@micron.com>, Brian Kao <powenkao@google.com>, Wonkon Kim
	<wkon.kim@samsung.com>, Seunghui Lee <sh043.lee@samsung.com>, Sanjeev Yadav
	<sanjeev.y@mediatek.com>, Hannes Reinecke <hare@suse.de>, Ming Lei
	<ming.lei@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: [PATCH 6.1.y 4/8] nvme-pci: remove an extra queue reference
Thread-Topic: [PATCH 6.1.y 4/8] nvme-pci: remove an extra queue reference
Thread-Index: AQHcwdyeS0oU7vvtXEuRvFkEk0UbGA==
Date: Wed, 1 Apr 2026 13:37:01 +0000
Message-ID: <20260401-oat-connect-4976b717@mheyne-amazon>
References: <20260401-defer-gleam-5226cb65@mheyne-amazon>
In-Reply-To: <20260401-defer-gleam-5226cb65@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.235.223]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_063711_251945_61B93D99 
X-CRM114-Status: GOOD (  10.67  )
X-Mailman-Approved-At: Wed, 01 Apr 2026 08:02:12 -0700
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7dcebef90d35de13a326f765dd787538880566f9 ]

Now that blk_mq_destroy_queue does not release the queue reference, there
is no need for a second admin queue reference to be held by the nvme_dev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20221018135720.670094-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 727585f580362..13c0098939ec0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1782,7 +1782,6 @@ static void nvme_dev_remove_admin(struct nvme_dev *de=
v)
 		 */
 		nvme_start_admin_queue(&dev->ctrl);
 		blk_mq_destroy_queue(dev->ctrl.admin_q);
-		blk_put_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
 }
@@ -1811,11 +1810,6 @@ static int nvme_pci_alloc_admin_tag_set(struct nvme_=
dev *dev)
 		dev->ctrl.admin_q =3D NULL;
 		return -ENOMEM;
 	}
-	if (!blk_get_queue(dev->ctrl.admin_q)) {
-		nvme_dev_remove_admin(dev);
-		dev->ctrl.admin_q =3D NULL;
-		return -ENODEV;
-	}
 	return 0;
 }
 =

-- =

2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


