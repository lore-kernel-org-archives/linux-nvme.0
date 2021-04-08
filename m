Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78970C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 11:28:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A75161105
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 11:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A75161105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HA9k1ULLosP/qCC2UC2pvrlONivbsrbiIrgpi2SJCGU=; b=pwra0a+MV4Qrjlj7dFuDDyJ6P
	ctINUHNSmDydmpF4SUg1VgSR6E/3tORajtyCnHCOyQfaWsnOIwm8EfTzkrBHyc5RpfYujADkthc/9
	DgplDC4a5xCZcd0I0KCHw6KXTCSiFh6S0nJWLxhXTiLlEPHw3awlli3HQyhQ+632+bbnoHoEGQLWR
	VuFmu6v55J+OGbdHIGu70rSmRy6BgfOMQ8MkIDjYPo4k2VyeDFaehJoEcI63mTEtMfWAMpkBMQSfd
	rYqxvgcx5/R8wkIIS9SiPzPZ7TN5n0y/hBhHGCQkgKQ/BLC+e4fHWUZpV9jK290f/KQ5VyqYmw+uM
	i8GLwe1RA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUSpB-007prt-6c; Thu, 08 Apr 2021 11:27:49 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUSp5-007prC-6O
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 11:27:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 88ED768BEB; Thu,  8 Apr 2021 13:27:40 +0200 (CEST)
Date: Thu, 8 Apr 2021 13:27:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Kanchan Joshi <joshiiitr@gmail.com>
Subject: Re: [PATCH V2 1/1] nvme: introduce generic per-namespace chardev
Message-ID: <20210408112740.GA9567@lst.de>
References: <20210407142152.GA20466@lst.de> <20210407153536.GA8667@localhost>
 <20210407154730.GC8667@localhost> <20210407164818.GA31878@lst.de>
 <20210407170905.GB9994@localhost>
 <CGME20210407171407eucas1p2e8bf869cecf13d6810d797515afff126@eucas1p2.samsung.com>
 <20210407171400.GA32592@lst.de>
 <20210408071128.pps76zydao3oufqn@mpHalley.localdomain>
 <20210408072641.GA24793@lst.de>
 <20210408102625.2u6sarhs2qss35ft@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210408102625.2u6sarhs2qss35ft@mpHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_122745_295904_D4BE1278 
X-CRM114-Status: GOOD (  13.99  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 08, 2021 at 12:26:25PM +0200, Javier Gonz=E1lez wrote:
> In this case, I believe we should still create the char device so that
> any OME-specific NVMe device can still be used from user-space without
> requiring SPDK and a PCI detach.

OME?

> Does this sound good to you?
>
> Regarding the current logic, I would not mind that the block device
> still appears as a zero capacity too. We can think of removing this in
> the future as this path becomes more stable. It requeries Kanchan's work
> on io_uring to be usable for I/O.

I think with the current path this should just work.  If you have
a device that triggers this case please test it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
