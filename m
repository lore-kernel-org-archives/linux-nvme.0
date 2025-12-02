Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A358D1171E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Dec 2025 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sq3/uyeuFrXhQAVmVJjbGubVsI3fsJsI0zwIy0cR2aY=; b=eBQsjIqdB7CTHQUR96JsHdhQei
	XsByzPD2bR8/r3Rv5wHoMx8jE6AJ2XgNinWRH5oqFmmjGugUcDf789OPxdv2ONB6N5C2t/QA6a8gS
	TFEuCEzIaX3B7ffsdupfFfxpax/wvXstdDPfj/N7WINEtxt1uDcBgcX1qTLqFou0lbzdMCfvU46Dy
	BmjT6p4sXffYbMRbOMnVB6+dLLrfmrdFFRYTE669qgrlnqh56jfYNNnn0jsImXszy0nyl2uU/QS2o
	28kA2+42zVw5enmEpQFA6nCSAbgEjU3WOLuxPcpH48J+umYCsU0q9lbSe4ysYvxQcOHumn0mSPHXG
	twLnDOBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQUXv-00000005gjB-1Teg;
	Tue, 02 Dec 2025 17:52:15 +0000
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([3.75.33.185])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQUXs-00000005giq-462r
	for linux-nvme@lists.infradead.org;
	Tue, 02 Dec 2025 17:52:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764697933; x=1796233933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=sq3/uyeuFrXhQAVmVJjbGubVsI3fsJsI0zwIy0cR2aY=;
  b=TB3UnkDL1RhOyQLl2fU6f6tJRFdNngRNFPlIyOA0Rb0x5TpD7zcxB2Q+
   Qq01CCE6OyF4pFm7aQYTK1e0TZFHhHMbVmyxt0iXEuO5x2t3wo72dvHWl
   5vLtRViNh5t2LvcbDNs1lWEjnZrs2PvZmfNjqxM3Mo7sm4FADp3Xk2Z2H
   4C+KAoLv+OhXwlglHcQV/DN9XEuMbBFl0oapBcqN86S9Wyxnk3StaI4gI
   NXgc3CgsOovxRkU8kFfS88bKufym5UT+ugKAU8SHSWLf2N1F+/rtQ5Y0m
   tBRHQ7jhCLcIDQgGrdml1j1k1t4DF6qdgQJ1nmIayuHXy1NYEIOhYJTFX
   w==;
X-CSE-ConnectionGUID: PEKxHDPZTNWfnPTkd2uiww==
X-CSE-MsgGUID: iTmpsolST/OALeUqjMdEag==
X-IronPort-AV: E=Sophos;i="6.20,243,1758585600"; 
   d="scan'208";a="6132405"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 17:51:44 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:19767]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.46.211:2525] with esmtp (Farcaster)
 id 59332ee5-d083-42ff-8e8e-68e6e0ab314c; Tue, 2 Dec 2025 17:51:44 +0000 (UTC)
X-Farcaster-Flow-ID: 59332ee5-d083-42ff-8e8e-68e6e0ab314c
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 17:51:36 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 17:51:36 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.029; Tue, 2 Dec 2025 17:51:36 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Let the blocklayer set timeouts for requests
Thread-Topic: [PATCH] nvme: Let the blocklayer set timeouts for requests
Thread-Index: AQHcY7RNpRG0rKo2fE2fBNMXvetFmw==
Date: Tue, 2 Dec 2025 17:51:36 +0000
Message-ID: <20251202-78-chops-11b0312d@mheyne-amazon>
References: <20251202-arrow-debris-c25524e1@mheyne-amazon>
 <aS8kP-bfOmZ-3W9E@kbusch-mbp>
In-Reply-To: <aS8kP-bfOmZ-3W9E@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.68.42]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <163DC25D524D114CA2879E5DC661D2C5@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251202_095213_337618_884B9CDB 
X-CRM114-Status: GOOD (  21.80  )
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

On Tue, Dec 02, 2025 at 10:39:11AM -0700, Keith Busch wrote:
> On Tue, Dec 02, 2025 at 01:58:19PM +0000, Heyne, Maximilian wrote:
> > When initializing an nvme request which is about to be send to the block
> > layer, we do not need to initialize its timeout. If it's left
> > uninitialized at 0 the block layer will use the request queue's timeout
> > in blk_add_timer (via nvme_start_request which is called from
> > nvme_*_queue_rq). These timeouts are setup to either NVME_IO_TIMEOUT or
> > NVME_ADMIN_TIMEOUT when the request queues were created.
> > =

> > Because the io_timeout of the IO queues can actually be modified via
> > sysfs, the following situation can occur:
> > =

> > 1) NVME_IO_TIMEOUT =3D 30 (default module parameter)
> > 2) nvme1n1 is probed. IO queues default timeout is 30 s
> > 3) manually change the IO timeout to 90 s
> >    echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
> > 4) nvme zns report-zones /dev/nvme1n1
> >    This command issues IO commands with timeout 30 s instead of the
> >    wanted 90 s which might be more suitable for this device.
> =

> Does this example really use 30s, though? User space commands should be
> going through nvme_submit_user_cmd(), which overrides the timeout set
> from the nvme_init_request with whatever the user requested (usually 0).

You're right. I actually worked on multiple (older) kernel versions and
forgot about this case. It was actually commit 470e900c8036ff ("nvme:
refactor nvme_alloc_request") which subtly changed the behavior but only
for the ioctl case. So ioctl's are fine then but, for example,
everything which goes via nvme_submit_sync_cmd shows the issue. So we
need to update the commit message accordingly. Sorry for that. I'll give
it a day or two for further comments on this patch and then send it with
a more correct message.



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


