Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FEFE9A047
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=azsZpcvQavPH76tUFHUUDA6k44L1vSUdkP+eQAZBtLw=; b=ZK370iGv22nLBqOFYOJjjKOMFj
	r7OolgHs0xJMtcVPw8ASlRX8w2zI1HBx97Ttm9qnSIqZoJN4SrTIV6XOyAsNnXvnDn3x+ODLgNix0
	eZmMEkXN9QQUDbnzJcoOV0N/9cJZ7DzClcQXdJhC+617q+Te3SGVUowJINvJCH8knC0SVjHdlduvi
	PyR6AxFm/MRYtW/o778exRMxaKLCQbRgDo7ituvT98EBvRP2IOfbQcrOx1hkOwwCmtiKdK/KtbZbb
	P2yoMcAjdBjU2wKFqb9PQoX1CuBXMRT994oq+4Ew4ksPcxIL8EvOwTiy2sEMHoGT8sxQQRDwaV2gh
	uQl7to+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsgWT-00000009mGH-0ZNZ;
	Wed, 18 Feb 2026 12:19:17 +0000
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([52.28.197.132])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsgWP-00000009mEd-3Uyz
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 12:19:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1771417153; x=1802953153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=azsZpcvQavPH76tUFHUUDA6k44L1vSUdkP+eQAZBtLw=;
  b=ZJnNWAB38TBs/2tZ5fx0R7FqCkQ/pmHyJ5VDYUvWPJdVi0CFvUUTJFn/
   fX9mzL+I4TGVKKtYCqzamO43OIQApHodBuh5Y+LMs0aHmlOUn2K4MZnBr
   XmagejitfGppctzt4cIaDu84zpe/kvLwciKS2RnAXspE87FzY8ZRBE7wo
   NbQNcwi9CioiyfIE8Lqf1JIFcpsE66lBY2CcczjygiuE8FO1qPT6Z+D9N
   hUgX1JHOOtTDf2F4zW7DsyHUY5WAmyx/OiRM8zV2zVyslYchb8yuKla/4
   kQZqO3sh+xLFqvdxeVRs4wg4wMBy4MWUtV1bEp3Dr03N6yfHodMNW9bh1
   Q==;
X-CSE-ConnectionGUID: RxQKkXvWRKmKBayZVhyknA==
X-CSE-MsgGUID: pqPVgPE0SgKspBq/vpU0Cg==
X-IronPort-AV: E=Sophos;i="6.21,298,1763424000"; 
   d="scan'208";a="9503217"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 12:19:08 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:29645]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.4.79:2525] with esmtp (Farcaster)
 id 352cb0ec-2a39-4ffb-87ff-4d5cfb4f91e8; Wed, 18 Feb 2026 12:19:07 +0000 (UTC)
X-Farcaster-Flow-ID: 352cb0ec-2a39-4ffb-87ff-4d5cfb4f91e8
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 12:19:07 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 12:19:07 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.035; Wed, 18 Feb 2026 12:19:06 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
CC: Maurizio Lombardi <mlombard@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "emilne@redhat.com" <emilne@redhat.com>,
	"jmeneghi@redhat.com" <jmeneghi@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "dwagner@suse.de" <dwagner@suse.de>,
	"mlombard@bsdbackstore.eu" <mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 1/5] nvme: Let the blocklayer set timeouts for
 requests
Thread-Topic: [PATCH RFC 1/5] nvme: Let the blocklayer set timeouts for
 requests
Thread-Index: AQHcoNDGJkUbx/SH5Ua6SirYbW1nVg==
Date: Wed, 18 Feb 2026 12:19:06 +0000
Message-ID: <20260218-blank-anne-7bb26acd@mheyne-amazon>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-2-mlombard@redhat.com>
 <20260217201512.GG3435530-mkhalfella@purestorage.com>
In-Reply-To: <20260217201512.GG3435530-mkhalfella@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.68.42]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E9670801498BB745A96D9985FCD1222F@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_041914_170170_9E1B2E95 
X-CRM114-Status: GOOD (  30.14  )
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

On Tue, Feb 17, 2026 at 12:15:12PM -0800, Mohamed Khalfella wrote:
> On Thu 2026-02-12 13:09:47 +0100, Maurizio Lombardi wrote:
> > From: "Heyne, Maximilian" <mheyne@amazon.de>
> > =

> > When initializing an nvme request which is about to be send to the block
> > layer, we do not need to initialize its timeout. If it's left
> > uninitialized at 0 the block layer will use the request queue's timeout
> > in blk_add_timer (via nvme_start_request which is called from
> > nvme_*_queue_rq). These timeouts are setup to either NVME_IO_TIMEOUT or
> > NVME_ADMIN_TIMEOUT when the request queues were created.
> > =

> > Because the io_timeout of the IO queues can be modified via sysfs, the
> > following situation can occur:
> > =

> > 1) NVME_IO_TIMEOUT =3D 30 (default module parameter)
> > 2) nvme1n1 is probed. IO queues default timeout is 30 s
> > 3) manually change the IO timeout to 90 s
> >    echo 90000 > /sys/class/nvme/nvme1/nvme1n1/queue/io_timeout
> > 4) Any call of __submit_sync_cmd on nvme1n1 to an IO queue will issue
> >    commands with the 30 s timeout instead of the wanted 90 s which might
> >    be more suitable for this device.
> > =

> > Commit 470e900c8036 ("nvme: refactor nvme_alloc_request") silently
> > changed the behavior for ioctl's already because it unconditionally
> > overrides the request's timeout that was set in nvme_init_request. If it
> > was unset by the user of the ioctl if will be overridden with 0 meaning
> > the block layer will pick the request queue's IO timeout.
> > =

> > Following up on that, this patch further improves the consistency of IO
> > timeout usage. However, there are still uses of NVME_IO_TIMEOUT which
> > could be inconsistent with what is set in the device's request_queue by
> > the user.
> > =

> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > ---
> >  drivers/nvme/host/core.c | 2 --
> >  1 file changed, 2 deletions(-)
> > =

> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 7bf228df6001..b9315f0abf80 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
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
> >  =

> >  	if (!logging_enabled)
> > -- =

> > 2.53.0
> > =

> > =

> =

> I wonder what was the impact of these lines given that req->timeout is
> set to 0 by blk_mq_rq_ctx_init() when the request is allocated?
> =


Looking through the nvme code. blk_mq_rq_ctx_init is always called
(indirectly, e.g. via blk_mq_alloc_request) before nvme_init_request and
therefore the timeouts are set to NVME_IO_TIMEOUT/NVME_ADMIN_TIMEOUT.
Now with these lines removed the timeout is 0 which means the
request_queue's rq_timeout will be used, see blk_add_timer.



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


