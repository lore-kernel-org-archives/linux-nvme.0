Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E323D10F6FCC
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mvU/lZdi2hYsgWu6W9JVHisJHcxM5S1ZidU29vypwvM=; b=J6QH608dIkavlPgptL3Ee0oKYx
	uNsTM9mIHammj86H1i1HhEUrvfOe0ZkAAPFv4UWSHq2yd00Uc4oMYXyQZL0P7nFGR/QaISoeqP1uw
	fx+frTdQ+GT8xD5oNqMO6PNa0rkIPumzC0X06cEwqJnZh7fjEzyOsbd/EBiDNsp6mn75iZN/SXkXc
	B4lkyQZ5AL9k6q4IlAQMZEtDwy4+XUXKwt/L7SmCU9dnKMe0l+XLY1WrB8VH07TNrFb74IEEZ34+n
	es2/Dq8U+Rn+tT6bWL/KJnfaMqOqpr0haPygyNNKhs2ZUI3Nech98tjUI1wbIal20KJv+rJ6hzKjm
	byyp5Www==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7x5E-0000000FZ0A-0R84;
	Wed, 01 Apr 2026 15:02:16 +0000
Received: from iad-out-010.esa.us-east-1.outbound.mail-perimeter.amazon.com ([34.197.254.9])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7vkv-0000000FKUa-3hFQ;
	Wed, 01 Apr 2026 13:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775050633; x=1806586633;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=mvU/lZdi2hYsgWu6W9JVHisJHcxM5S1ZidU29vypwvM=;
  b=HBXkj7eohoGwGlpwr4zO8K1rtRaZufrttn8xXmabrONozxprRIQiOXW3
   FYxvK9tRqnow1JEDdIL7ItJymPk5I4wOnKwJE2UemhxwZynEUCaWuMqMJ
   HqkO+QuRvLRq+uWuonhetMweIlII6WBrx7YLEUF+qSjWQLfKN+C9vKj3v
   1cgtbGGXmttrMapqx4iQPwJxDcPIxO4silqLRop8JZmY2lB+1sQ5MnvqS
   Vd/l2HKWbiKWR/W6FhKAkZ5tgYLWHyXdUy0l+0XqtgVggEUPmzQgpjhkh
   eRtqroR5iE6knEHO87G4IwIsJJ6zVVY8+MxP/GPyaB68TxUE8zucaAs+9
   w==;
X-CSE-ConnectionGUID: yfdDpBFSR3GzxI8zBmj5yg==
X-CSE-MsgGUID: 8EJ0aWTvTGCaKUpocoCCkA==
X-IronPort-AV: E=Sophos;i="6.23,153,1770595200"; 
   d="scan'208";a="15009820"
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-010.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 13:37:09 +0000
Received: from EX19MTAUEB002.ant.amazon.com [72.21.198.67:10436]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.56.32:2525] with esmtp (Farcaster)
 id d89d7eaa-5429-439e-9de0-f92aa02d1cf4; Wed, 1 Apr 2026 13:37:09 +0000 (UTC)
X-Farcaster-Flow-ID: d89d7eaa-5429-439e-9de0-f92aa02d1cf4
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:37:08 +0000
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19D012UEC003.ant.amazon.com (10.252.135.160) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 1 Apr 2026 13:37:08 +0000
Received: from EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9]) by
 EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9%3]) with mapi id
 15.02.2562.037; Wed, 1 Apr 2026 13:37:08 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, Jens Axboe
	<axboe@kernel.dk>, Hector Martin <marcan@marcan.st>, Sven Peter
	<sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "James E.J.
 Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Alim Akhtar <alim.akhtar@samsung.com>, "Avri
 Altman" <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, "Sasha
 Levin" <sashal@kernel.org>, Peter Wang <peter.wang@mediatek.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Seunghui Lee
	<sh043.lee@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Bean Huo
	<beanhuo@micron.com>, Brian Kao <powenkao@google.com>, Sanjeev Yadav
	<sanjeev.y@mediatek.com>, Wonkon Kim <wkon.kim@samsung.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: [PATCH 6.1.y 8/8] nvme: fix admin queue leak on controller reset
Thread-Topic: [PATCH 6.1.y 8/8] nvme: fix admin queue leak on controller reset
Thread-Index: AQHcwdyiGHZGxTNpyEix/f1qqxhIpQ==
Date: Wed, 1 Apr 2026 13:37:08 +0000
Message-ID: <20260401-bayou-lager-0ca6402b@mheyne-amazon>
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
X-CRM114-CacheID: sfid-20260401_063714_053502_DC0C7DDF 
X-CRM114-Status: GOOD (  12.55  )
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

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b84bb7bd913d8ca2f976ee6faf4a174f91c02b8d ]

When nvme_alloc_admin_tag_set() is called during a controller reset,
a previous admin queue may still exist. Release it properly before
allocating a new one to avoid orphaning the old queue.

This fixes a regression introduced by commit 03b3bcd319b3 ("nvme: fix
admin request_queue lifetime").

Cc: Keith Busch <kbusch@kernel.org>
Fixes: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime").
Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAHj4cs9wv3SdPo+N01Fw2SHBYDs9tj=
2M_e1-GdQOkRy=3DDsBB1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ Have to do analogous work in nvme_pci_alloc_admin_tag_set in pci.c due
  to missing upstream commit 0da7feaa5913 ("nvme-pci: use the tagset
  alloc/free helpers") ]
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 drivers/nvme/host/core.c | 7 +++++++
 drivers/nvme/host/pci.c  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f17318f6c82b0..09439fa7d083a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5012,6 +5012,13 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl,=
 struct blk_mq_tag_set *set,
 	if (ret)
 		return ret;
 =

+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (ctrl->admin_q)
+		blk_put_queue(ctrl->admin_q);
+
 	ctrl->admin_q =3D blk_mq_init_queue(set);
 	if (IS_ERR(ctrl->admin_q)) {
 		ret =3D PTR_ERR(ctrl->admin_q);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e8b7b0004086c..07ca1e1d920b8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1804,6 +1804,13 @@ static int nvme_pci_alloc_admin_tag_set(struct nvme_=
dev *dev)
 		return -ENOMEM;
 	dev->ctrl.admin_tagset =3D set;
 =

+	/*
+	 * If a previous admin queue exists (e.g., from before a reset),
+	 * put it now before allocating a new one to avoid orphaning it.
+	 */
+	if (dev->ctrl.admin_q)
+		blk_put_queue(dev->ctrl.admin_q);
+
 	dev->ctrl.admin_q =3D blk_mq_init_queue(set);
 	if (IS_ERR(dev->ctrl.admin_q)) {
 		blk_mq_free_tag_set(set);
-- =

2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


