Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361F710F6FC2
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eECRtkLdb1g6Rdy8JYnmlSQYVnKt6oeRbBYfuuRf+YQ=; b=po1gNH/aErmd9MdK5I3UEl6gUI
	N8hjqc8+XQjqXQKqYFAoOdki9ESqK1J9bDRCBF4MwJ9ZGhk+48sP8M1eMk6UDx0lNeXrJJVps0Tzl
	gMmO2NR8Air2ExzOWvew1s9RXVyPVIYJ6N4eE0KnAkj8+aQ8sYcqLMwUzTLp+Flth9yTkklVlD7K4
	PBEwoNoQSJc3fEtAaFzl0ajTwk3UXhY/NGFNputf0Omq9f5+k3g8XVRvWUQDrckk8Ms93RPi79T0d
	lhJLPPiJTKd288sTkIbAIgF6hD9YA8JTECMwpUnqjvq5GNWMsGJfqUekPqHx1er+snq/yw9BrR85n
	LAdJQgMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7x5C-0000000FYy3-21xn;
	Wed, 01 Apr 2026 15:02:14 +0000
Received: from iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com ([3.221.209.22])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vko-0000000FKNI-2jW3;
	Wed, 01 Apr 2026 13:37:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775050626; x=1806586626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eECRtkLdb1g6Rdy8JYnmlSQYVnKt6oeRbBYfuuRf+YQ=;
  b=HYunzSQvET+cZKpIgF2ww4iSwVpsfovP0HAXhjvG/RW1bqKlwyqP/5/l
   4y5ZpX44Qcu5r1vU0exrS/Kpavd6j5pFM6uhbzU64WdtCkBMGE29JqMbX
   pACLve4W1f/XkE1jx03UAio1OQFb/bHKfD6jnV2A34eZkKHZygzDzqpo+
   k7SimSEyaWDjefMfYeaWktUDwVOkg/K0MrZTsM8p7tWUpZcjv99BxnoWo
   CUpv0KoxVzEKsY0+U+4+X9OxzgrhoZ7XIQE+escl4ZFeHHZMcq2i4pamz
   6xv7N7QcF/bgHqvW2++7RTyUwCdlPE5K9DKp+iYxAPMxULSREGO9zu5xp
   w==;
X-CSE-ConnectionGUID: 694XnSJxShO0NhfHByps2g==
X-CSE-MsgGUID: ZX07A88/RO6AxJBRbXwRoA==
X-IronPort-AV: E=Sophos;i="6.23,153,1770595200"; 
   d="scan'208";a="15299610"
Received: from ip-10-4-17-41.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.17.41])
  by internal-iad-out-007.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:36:57 +0000
Received: from EX19MTAUEC001.ant.amazon.com [52.94.133.134:25533]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.17.255:2525] with esmtp (Farcaster)
 id f8ee6624-5584-41dc-b791-6710bae090c0; Wed, 1 Apr 2026 13:36:57 +0000 (UTC)
X-Farcaster-Flow-ID: f8ee6624-5584-41dc-b791-6710bae090c0
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:36:55 +0000
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19D012UEC003.ant.amazon.com (10.252.135.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:36:55 +0000
Received: from EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9]) by
 EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9%3]) with mapi id
 15.02.2562.037; Wed, 1 Apr 2026 13:36:55 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Jens Axboe <axboe@kernel.dk>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, "Alyssa
 Rosenzweig" <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Alim Akhtar <alim.akhtar@samsung.com>, "Avri
 Altman" <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, "Sasha
 Levin" <sashal@kernel.org>, Peter Wang <peter.wang@mediatek.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Thomas Yen
	<thomasyen@google.com>, Bean Huo <beanhuo@micron.com>, Brian Kao
	<powenkao@google.com>, Seunghui Lee <sh043.lee@samsung.com>, Sanjeev Yadav
	<sanjeev.y@mediatek.com>, Wonkon Kim <wkon.kim@samsung.com>, Ming Lei
	<ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
	<kch@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: [PATCH 6.1.y 0/8] nvme: correctly fix admin request_queue lifetime
Thread-Topic: [PATCH 6.1.y 0/8] nvme: correctly fix admin request_queue
 lifetime
Thread-Index: AQHcwdyaXGNYIO/hmUiMYmXEd9VHmw==
Date: Wed, 1 Apr 2026 13:36:55 +0000
Message-ID: <20260401-defer-gleam-5226cb65@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.235.223]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_063706_815001_4E0B88A6 
X-CRM114-Status: GOOD (  13.83  )
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

The initial attempt to backport upstream commit 03b3bcd319b3 ("nvme: fix
admin request_queue lifetime") was not correct leading to refcount
underflows and not even fixing the problem.

I've tested the reproduction steps from [1] (adding a delay to
nvme_submit_user_cmd and 'echo 1 | sudo tee
/sys/class/nvme/nvme0/delete_controller') on the nvme-tcp driver which
printed the KASAN UAF blurb.

Fixing the issue in the 6.1 series requires a few dependent patches.
This is mainly the upstream commit 2b3f056f72e5 ("blk-mq: move the call
to blk_put_queue out of blk_mq_destroy_queue") which allows to move the
blk_put_queue to a different location. While at it, I'm backporting the
whole patch series for completeness. However, the scsi and apple patches
are not strictly required and could be dropped from this series.

The backport of commit 03b3bcd319b3 ("nvme: fix admin
request_queue lifetime") needed a tweak to the nvme pci driver.

Furthermore, in this patch series I've also included a follow-up fixup
from upstream commit b84bb7bd913d ("nvme: fix admin queue leak on
controller reset"), again with an adaption to the nvme pci driver. This
issue could easily be reproduced by resetting the controller (no need to
run full blktests):

  echo 1 > /sys/class/nvme/nvme0/reset_controller

[1] https://lore.kernel.org/all/20251029210853.20768-1-cachen@purestorage.c=
om/

Christoph Hellwig (5):
  blk-mq: move the call to blk_put_queue out of blk_mq_destroy_queue
  scsi: remove an extra queue reference
  nvme-pci: remove an extra queue reference
  nvme-apple: remove an extra queue reference
  nvme-pci: put the admin queue in nvme_dev_remove_admin

Keith Busch (1):
  nvme: fix admin request_queue lifetime

Maximilian Heyne (1):
  Revert "nvme: fix admin request_queue lifetime"

Ming Lei (1):
  nvme: fix admin queue leak on controller reset

 block/blk-mq.c            |  4 +---
 block/bsg-lib.c           |  2 ++
 drivers/nvme/host/apple.c |  8 --------
 drivers/nvme/host/core.c  | 16 ++++++++++++++--
 drivers/nvme/host/pci.c   | 14 +++++++-------
 drivers/scsi/scsi_scan.c  |  1 -
 drivers/ufs/core/ufshcd.c |  2 ++
 7 files changed, 26 insertions(+), 21 deletions(-)

-- =

2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


