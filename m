Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CC6D3942F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hMUdY6WjkBIAJVkybt2uz62AC89MtKqIA+KLS7wHlyY=; b=a9naDCSEmI9EENwa+KOF71rrBp
	t0Rhm+yZb//x3GthCH4WDOsc4NRo7kEWvZ1GHAweJS4MaHgoPFQU7lEGdk1qbk3jHedDEEIsLh2nx
	aHWm1gw/FoTzOlATiu5V84PGeuBFhO6y4huI4mEUHFYdQ3zfH+z9qqG/BNE0WLmgcqswGnGZAlZ9w
	iGGUiQz+I1uwxt1Z201g0KQA3HAo+wTvFv9cKXh1aWGBL8SEgcyKa2sGsZ5GyOGyRA1HmyMonDF6/
	PB2EiHMjWjO3Poh2a6J6AqJt0+ZOe5YUuvGwfxjwW5DidqX0BGrBTRCBtL1wDBj0MJTMY+qQZhXID
	e3rNDZZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Iou-00000000GYn-3jC6;
	Thu, 02 Apr 2026 14:14:52 +0000
Received: from iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com ([50.16.246.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8IXy-00000000Dpp-11gw;
	Thu, 02 Apr 2026 13:57:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775138242; x=1806674242;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hMUdY6WjkBIAJVkybt2uz62AC89MtKqIA+KLS7wHlyY=;
  b=onGaKDTjqUSHTU30tZzpRmszjK+Y8ZXEaSlecLeFW0YXEXgCm9HIl271
   N6UyOT9/cyaKgT2SLuvGG3/hSII1bIDzOvMwyXk3wDODMpfainPRTC7F8
   rtCWgOmksks/pIhSj8LgMNnPzVDh8VCfOlRakvc4Bf2VlGjO8rJmzDD3x
   6TGBvulX4dPK+UG6b4WRYCKHDp5yj7+kpVLVXNwCqvv8vSHVwT5IoX1e6
   NcaUEw7keyWufZ0d3TFLa6jaXgyWgCUrgpwWD0bHzrTYKlMrDerQP8enD
   lljaHA7VtdBz4Iv7bVopfyYq+1q3oslgmtbro/zmVN/jVGp6ElB6HQZHS
   A==;
X-CSE-ConnectionGUID: gH0AQ+v0Qgie1+XG0e5oqA==
X-CSE-MsgGUID: bqVpYZ3bRAqEa50Nri7RmQ==
X-IronPort-AV: E=Sophos;i="6.23,155,1770595200"; 
   d="scan'208";a="14829483"
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 13:57:13 +0000
Received: from EX19MTAUEA001.ant.amazon.com [72.21.196.67:20344]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.17.255:2525] with esmtp (Farcaster)
 id f908d55e-394b-4888-93e4-d21ff27dfe17; Thu, 2 Apr 2026 13:57:12 +0000 (UTC)
X-Farcaster-Flow-ID: f908d55e-394b-4888-93e4-d21ff27dfe17
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 2 Apr 2026 13:57:12 +0000
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19D012UEC003.ant.amazon.com (10.252.135.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 2 Apr 2026 13:57:12 +0000
Received: from EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9]) by
 EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9%3]) with mapi id
 15.02.2562.037; Thu, 2 Apr 2026 13:57:12 +0000
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
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Adrian Hunter
	<adrian.hunter@intel.com>, Seunghwan Baek <sh8267.baek@samsung.com>, Seunghui
 Lee <sh043.lee@samsung.com>, Thomas Yen <thomasyen@google.com>, Brian Kao
	<powenkao@google.com>, Sanjeev Yadav <sanjeev.y@mediatek.com>, Wonkon Kim
	<wkon.kim@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke
	<hare@suse.de>, Ming Lei <ming.lei@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "asahi@lists.linux.dev"
	<asahi@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: [PATCH 6.1.y v2 0/6] nvme: correctly fix admin request_queue lifetime
Thread-Topic: [PATCH 6.1.y v2 0/6] nvme: correctly fix admin request_queue
 lifetime
Thread-Index: AQHcwqiaxpzJWVl8SE+TNUtR0mcVxw==
Date: Thu, 2 Apr 2026 13:57:12 +0000
Message-ID: <20260402-moral-jockey-f072379b@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.235.223]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_065722_413745_D3ACEB89 
X-CRM114-Status: GOOD (  13.53  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:40 -0700
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
blk_put_queue to a different location.

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

---
Changes in v2:
    - dropped 2 patches from the series that are unnecessary (scsi and
      apple). The apple-nvme patch was even wrong (Thanks Fedor for
      pointing that out)

Christoph Hellwig (3):
  blk-mq: move the call to blk_put_queue out of blk_mq_destroy_queue
  nvme-pci: remove an extra queue reference
  nvme-pci: put the admin queue in nvme_dev_remove_admin

Keith Busch (1):
  nvme: fix admin request_queue lifetime

Maximilian Heyne (1):
  Revert "nvme: fix admin request_queue lifetime"

Ming Lei (1):
  nvme: fix admin queue leak on controller reset

 block/blk-mq.c            |  4 +---
 block/bsg-lib.c           |  2 ++
 drivers/nvme/host/apple.c |  1 +
 drivers/nvme/host/core.c  | 16 ++++++++++++++--
 drivers/nvme/host/pci.c   | 14 +++++++-------
 drivers/scsi/scsi_sysfs.c |  1 +
 drivers/ufs/core/ufshcd.c |  2 ++
 7 files changed, 28 insertions(+), 12 deletions(-)

-- =

2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


