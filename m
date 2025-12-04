Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F00D2A520
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tt0jeeHG96lYyQ3MRmKmVjXhW+gT4Y5+n4BDpq9oRuM=; b=thVRUdzWQeWr6EE8jOU1X022Aa
	rv17G9mUcASwbagJyJVNwH5d4UOmYk4wsN2EyMwJGQThfspMV26hlzwi+JKonNqJSpiQ54FHGnN5M
	6Xd6ZmTM/TXLwCUl8wyWjn/4bGdlH3IPqSt95oU1lSZZpcGro8YKRZYHko0BtLVfG3Ps7qwyZ80uy
	p6SByThNlwWyGA4BnBWDSX8qxPjSwv4KlEBm8Fi4xnZRptPJbfpSZsDG8ZAz44fLEpmTSyjvuuXxj
	gRBVEf+0wxKJ6OYNCRJQSSSfT3Til5texm+/pnQBQZUXISYePX9Dv3W5wxrDS/HOICx+tKasG8smD
	VofOGWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRF6I-00000008Vly-0Mh4;
	Thu, 04 Dec 2025 19:34:50 +0000
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([63.178.143.178])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRF6D-00000008VlV-45bK
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 19:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764876886; x=1796412886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=tt0jeeHG96lYyQ3MRmKmVjXhW+gT4Y5+n4BDpq9oRuM=;
  b=Zvw1px6IoUcj9fo71SWW8Vjbo741vkyBXgwFtVQpXM7HYvSvLaE20fZC
   J71x16e0kBz3MUyHXIbJeNdidLNw/Lf2SasATNeWNi7KTv0ri+2Cazw/q
   qgWKRUOQDEGHlkmLm961okcmBCoH8bJAyZt0OCblslM+imw/IDjXBe2iw
   W/zZWmtp7G8bXCEhhDfp28CGE8ZTEbKuxHAUa5A2efeXpmgu5QXEC+Fo6
   +9bLLt5otp1qdSdosEcQ3aSV8w+r8vZVgCxsboL3m8V4RK+EtLaYYdV6Z
   bPdAdRZG8exCZVAY528tGZD8txb81v5sQ71/QU/UUA6Ll/tcCwHbuno/L
   w==;
X-CSE-ConnectionGUID: tUVq+AV9RNqo+IgycCjtvQ==
X-CSE-MsgGUID: Mor2QI/JT96/9N6jeVNQag==
X-IronPort-AV: E=Sophos;i="6.20,249,1758585600"; 
   d="scan'208";a="6152081"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 19:34:27 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:10065]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.37.108:2525] with esmtp (Farcaster)
 id ddf07f3e-1eb0-4f32-8d0d-4abba4de6cf9; Thu, 4 Dec 2025 19:34:27 +0000 (UTC)
X-Farcaster-Flow-ID: ddf07f3e-1eb0-4f32-8d0d-4abba4de6cf9
Received: from EX19D008EUC002.ant.amazon.com (10.252.51.146) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 4 Dec 2025 19:34:27 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC002.ant.amazon.com (10.252.51.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 4 Dec 2025 19:34:26 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.029; Thu, 4 Dec 2025 19:34:26 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
Thread-Topic: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
Thread-Index: AQHcZVUAJ2T0ZF2M10Kiw4GQ0UHdFg==
Date: Thu, 4 Dec 2025 19:34:26 +0000
Message-ID: <20251204-pause-lima-29ecb942@mheyne-amazon>
References: <20251204-tests-bryce-8b3b2823@mheyne-amazon>
 <aTGzL5t7Gu1tpebp@kbusch-mbp>
In-Reply-To: <aTGzL5t7Gu1tpebp@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.68.42]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <449F71F3AF39C94CA8FB419F2C3D9BC5@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_113446_301930_A41AFD68 
X-CRM114-Status: GOOD (  16.62  )
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

On Thu, Dec 04, 2025 at 09:13:35AM -0700, Keith Busch wrote:
> On Thu, Dec 04, 2025 at 02:11:50PM +0000, Heyne, Maximilian wrote:
> > @@ -724,10 +724,8 @@ void nvme_init_request(struct request *req, struct=
 nvme_command *cmd)
> >  		struct nvme_ns *ns =3D req->q->disk->private_data;
> >  =

> >  		logging_enabled =3D ns->head->passthru_err_log_enabled;
> > -		req->timeout =3D NVME_IO_TIMEOUT;
> >  	} else { /* no queuedata implies admin queue */
> >  		logging_enabled =3D nr->ctrl->passthru_err_log_enabled;
> > -		req->timeout =3D NVME_ADMIN_TIMEOUT;
> >  	}
> =

> I was trying to think of any in-kernel path using __submit_sync_cmd with
> an IO queue, and quick search shows there's just one: zns report zones.
> =

> Everything else uses the admin queue, which doesn't have a sysfs tunable
> for its request_queue's default timeout. All we have is the nvme module
> parameter, which is writable after loading. Since that's the only way a
> user can modify the default time for that queue, I think we need to
> leave that req->timeout value as-is.

Ok sound like a v3 is needed where I only delete the line with
NVME_IO_TIMEOUT but leave the NVME_ADMIN_TIMEOUT and add a comment about
it. Will prepare such a patch.

Thanks for you reviews.



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


