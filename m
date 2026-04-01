Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382E10F6FCD
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OF/Wc7TK+OsFr31ZdtePyiprlbzI65l7D2fgL0og7g8=; b=cMUDuX3Gi/UcaggXW1da/qotbs
	3o2pd+Ve7gx69EydUOte+TIIk1xOMdY6z1r8RJeV4ZmK8QJnhz9ECS6onIMrHDX3jninhqzaWvE0Z
	AKJNyE/NbLvGlcMzmm/iJa9gMXtLqw6iRtAxawpwBmXaKyh3Imktym4wMA5EA2hSqXDQKxVDhzQLz
	bRI/LgRyZZz4d8++yjgQ/Y0mi2X8nBGlPSh2UM/WuXsFJrPPX5bysW2H9Ee357wojMpNNCvITVjB/
	haiC6Vj3BYI7zmEwSR7bqCBsswnAuuTk6QHyj7lxh2ZrMH9x04Oh7aWCrM8ww1lGoU0Bw2hnD2zQG
	7civDeaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7x5E-0000000FZ0l-1tju;
	Wed, 01 Apr 2026 15:02:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vky-0000000FKYO-0AfH;
	Wed, 01 Apr 2026 13:37:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=OF/Wc7TK+OsFr31ZdtePyiprlbzI65l7D2fgL0og7g8=; b=SkZrreu3f57WL6eHkFrUO5JOHl
	qhkHztoi5vs8qGnyCrYXazjPEjZ6fTWT2oJEkvAQyyfURYwd9T1Nrd4Y7LrmbDQQX/dh7LAN5zhMo
	frqLMG1UMzbUUxbIkX7rhavXii/mtBYV+HCFJWS/77sMDyg/0AvU1EpTtfhE4yK65HvkjhS4po8tq
	98muIBnwRtac/ksTbcb2ZnffFMeWx6L/SxVtbRgRFScL+wxQOVe+md3ZWRW8IpwbQMbGYwEjmwXY5
	3wgODql/GC8b1lO5oW8V1FggoammhUeitNZHEtVchJbmtuv0S+K56O831kA8XgrqoOjzVwkH+/sLR
	BofhfpVg==;
Received: from iad-out-005.esa.us-east-1.outbound.mail-perimeter.amazon.com ([3.211.80.218])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vku-00000000TiQ-0xG4;
	Wed, 01 Apr 2026 13:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775050632; x=1806586632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=OF/Wc7TK+OsFr31ZdtePyiprlbzI65l7D2fgL0og7g8=;
  b=DRN4B/AzEq9OCPB4Hh7gxPmIFT/2dgYE8xbJA3/zeTaSvc59/JNk3BSB
   927J5zhkpd+0dGlkcSXZ0HidS0m1zJij8bMjF/GkizUAuJyRQ1lh+rVQF
   uP5BF+iOdYeCLw2CPZwSGMSgKDqZeh5fPWHvyX1nCt6X4XcCKUIfmfIz1
   8xs6dQ+VzInYGgh/hKSgcczGBogdSmVAm5GRAOpPY6aQGC4PAuMPZQJZn
   ppeF3nWAbxp/Pg/FQ7Svl4Kxh+1enSqpvpJytTuVVQxrb0Xv2M6VwMRrg
   UmE0a+biRO5+sGHAg0ptNoMjnvUzcrp7qPxnqJ6upfeXAhOUZuGjqLSCF
   w==;
X-CSE-ConnectionGUID: UMssy2gNTFW+S4U/A5mK4A==
X-CSE-MsgGUID: j2rWxdH+QcqQjtHpTDJFrQ==
X-IronPort-AV: E=Sophos;i="6.23,153,1770595200"; 
   d="scan'208";a="15275470"
Received: from ip-10-4-7-229.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.7.229])
  by internal-iad-out-005.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:37:04 +0000
Received: from EX19MTAUEC002.ant.amazon.com [72.21.198.66:5147]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.8.197:2525] with esmtp (Farcaster)
 id 5da5a075-cb06-4684-aedc-ecbaf014acc0; Wed, 1 Apr 2026 13:37:04 +0000 (UTC)
X-Farcaster-Flow-ID: 5da5a075-cb06-4684-aedc-ecbaf014acc0
Received: from EX19D012UEC001.ant.amazon.com (10.252.135.206) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:37:03 +0000
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19D012UEC001.ant.amazon.com (10.252.135.206) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:37:03 +0000
Received: from EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9]) by
 EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9%3]) with mapi id
 15.02.2562.037; Wed, 1 Apr 2026 13:37:03 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Sven Peter <sven@svenpeter.dev>, "Chaitanya
 Kulkarni" <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig
	<alyssa@rosenzweig.io>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart Van Assche
	<bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>, Peter Wang
	<peter.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Seunghui Lee <sh043.lee@samsung.com>, Sanjeev Yadav <sanjeev.y@mediatek.com>,
	Wonkon Kim <wkon.kim@samsung.com>, Brian Kao <powenkao@google.com>, "Hannes
 Reinecke" <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: [PATCH 6.1.y 5/8] nvme-apple: remove an extra queue reference
Thread-Topic: [PATCH 6.1.y 5/8] nvme-apple: remove an extra queue reference
Thread-Index: AQHcwdyfxKwQXg5Z9kGUiGR8yB37yw==
Date: Wed, 1 Apr 2026 13:37:03 +0000
Message-ID: <20260401-pliny-ashley-ff03a0b6@mheyne-amazon>
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
X-CRM114-CacheID: sfid-20260401_143712_532258_542D5A25 
X-CRM114-Status: GOOD (  10.49  )
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

[ Upstream commit 941f7298c70c7668416e7845fa76eb72c07d966b ]

Now that blk_mq_destroy_queue does not release the queue reference, there
is no need for a second admin queue reference to be held by the
apple_nvme structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Sven Peter <sven@svenpeter.dev>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20221018135720.670094-5-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/apple.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index c5fc293c22123..c84ebfcfdeb88 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1507,15 +1507,6 @@ static int apple_nvme_probe(struct platform_device *=
pdev)
 		goto put_dev;
 	}
 =

-	if (!blk_get_queue(anv->ctrl.admin_q)) {
-		nvme_start_admin_queue(&anv->ctrl);
-		blk_mq_destroy_queue(anv->ctrl.admin_q);
-		blk_put_queue(anv->ctrl.admin_q);
-		anv->ctrl.admin_q =3D NULL;
-		ret =3D -ENODEV;
-		goto put_dev;
-	}
-
 	nvme_reset_ctrl(&anv->ctrl);
 	async_schedule(apple_nvme_async_probe, anv);
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


