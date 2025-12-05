Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA13D2E01F
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 07:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqG28S1MxaCpEUBAQ7D9PXYxspGCym86kji6cCqP7v0=; b=yVynMY9sbfqCJGsNzILmfUSaH7
	EsadhB3ta/7h9AtQ9wQ5S6htVlj26cRDwrr6unmMCI4uqxuJ+X6DzgTDqw+GiGtpZZbFZ2mYosjt8
	T5wYzWampuUkX0e+WQTMASQ+GJGurB766xNPuZH6vnU6JITYo+zY0ohnwGpSRwP7zi6nWQ9vPeIri
	mC9p7yWzNvyQo3rabfmQlILnvmqIkFTEInJ/bx9NDCvfSgmDF80hU1VbFPgkF/sulKN/aU9vVyYvT
	P3gmN1HRuLoLwXF5YuukTN63NTp/Gbqw97/d+w+M1JXzg9brjHghD7TugwJbF3kaTgt65woG2erJR
	bxHse+bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRQJq-00000009AVO-1TuW;
	Fri, 05 Dec 2025 07:33:34 +0000
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([18.199.210.3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRQJn-00000009AUl-146f
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 07:33:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1764920011; x=1796456011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=JqG28S1MxaCpEUBAQ7D9PXYxspGCym86kji6cCqP7v0=;
  b=p5UA12U+FAk4JM0lsq/y4XjAuqcSt1PkmyrZ75oyy9A/GY/tvMp9cwH2
   HrrqdWb9E/pEAd5O1xAp1oBvgQY8DWMLD7PSuQgVmwcy8VZcs+H4WhEHG
   eef1ofnABdRq6BUA+fhAM8sEqZi0zOis+Ab9r4/B7lih64HEPgK107hWz
   dsPLb2jaCPvJ7MFSko+nVRzFlPaMmP658r/+CBzf22W/siczR96OJuhyB
   H+QABDvvAUQYSLe6euqi3pxCJTwHlnXOwE8syARPl9UoXxM2rvs7wX9WP
   UNVWaWcA6bmC/DxfWzO23mHfDkeR1wYj+UX7MH1gUxDS+Fu4og2aJmBvu
   Q==;
X-CSE-ConnectionGUID: uOm8kWmpTJ6Q/7w5vRsCSg==
X-CSE-MsgGUID: jsPVtH6uRtKnmQSmggC61g==
X-IronPort-AV: E=Sophos;i="6.20,251,1758585600"; 
   d="scan'208";a="6168440"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 07:33:12 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:31978]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.24.148:2525] with esmtp (Farcaster)
 id 8976f090-f6c2-4d23-8f4d-e2c6d152203d; Fri, 5 Dec 2025 07:33:12 +0000 (UTC)
X-Farcaster-Flow-ID: 8976f090-f6c2-4d23-8f4d-e2c6d152203d
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 07:33:11 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 07:33:11 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.029; Fri, 5 Dec 2025 07:33:11 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Keith Busch <kbusch@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
Thread-Topic: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
Thread-Index: AQHcZVUAJ2T0ZF2M10Kiw4GQ0UHdFrUSqCSA
Date: Fri, 5 Dec 2025 07:33:10 +0000
Message-ID: <20251205-myopia-been-ed739f86@mheyne-amazon>
References: <20251204-tests-bryce-8b3b2823@mheyne-amazon>
 <aTGzL5t7Gu1tpebp@kbusch-mbp> <20251204-pause-lima-29ecb942@mheyne-amazon>
In-Reply-To: <20251204-pause-lima-29ecb942@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.68.42]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4D2DBAF2ADE784397DC651D48127B63@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251204_233331_592719_10397921 
X-CRM114-Status: GOOD (  23.61  )
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

On Thu, Dec 04, 2025 at 07:34:26PM +0000, Heyne, Maximilian wrote:
> On Thu, Dec 04, 2025 at 09:13:35AM -0700, Keith Busch wrote:
> > On Thu, Dec 04, 2025 at 02:11:50PM +0000, Heyne, Maximilian wrote:
> > > @@ -724,10 +724,8 @@ void nvme_init_request(struct request *req, stru=
ct nvme_command *cmd)
> > >  		struct nvme_ns *ns =3D req->q->disk->private_data;
> > >  =

> > >  		logging_enabled =3D ns->head->passthru_err_log_enabled;
> > > -		req->timeout =3D NVME_IO_TIMEOUT;
> > >  	} else { /* no queuedata implies admin queue */
> > >  		logging_enabled =3D nr->ctrl->passthru_err_log_enabled;
> > > -		req->timeout =3D NVME_ADMIN_TIMEOUT;
> > >  	}
> > =

> > I was trying to think of any in-kernel path using __submit_sync_cmd with
> > an IO queue, and quick search shows there's just one: zns report zones.
> > =

> > Everything else uses the admin queue, which doesn't have a sysfs tunable
> > for its request_queue's default timeout. All we have is the nvme module
> > parameter, which is writable after loading. Since that's the only way a
> > user can modify the default time for that queue, I think we need to
> > leave that req->timeout value as-is.
> =

> Ok sound like a v3 is needed where I only delete the line with
> NVME_IO_TIMEOUT but leave the NVME_ADMIN_TIMEOUT and add a comment about
> it. Will prepare such a patch.
> =


I thought about this a bit more. Considering that the module parameters
can be written to produces even more inconsistencies. =


With my proposed change we will have the following situation:
1) when a device is probed current settings for IO and admin timeout from
   the module parameters will be the respective default timeouts
2) almost all admin commands to the device will default to the initial
   admin timeout
3) almost all IO commands will adhere to whatever is set via sysfs or
   the initial default

-> changes to the module parameters will (mostly) not affect already
   probed devices

When we keep initializing the admin timeouts to the module parameter as
you suggest (so half of my patch), we'll have the following situation:

1) same as above
2) some admin commands will use the module parameters admin timeout,
   some (ioctl's via nvme_submit_user_cmd) will use the admin queue's timeo=
ut set in 1).
   This can be made consistent if we fix nvme_submit_user_cmd.
3) same as above; IO timeout not affected by module parameter changes.

-> changes to the module parameters affect only the admin commands but
   (mostly) not the IO commands which is inconsistent behavior.

Therefore, I wonder whether people are actually making changes to the
module parameters at runtime to adjust all device's admin timeouts. In
that case it's at least broken for ioctl's currently.
Should we make that timeout runtime configurable per-device too instead?

In summary, I think my patch as-is leads to better consistency.



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


