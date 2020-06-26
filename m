Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4194C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:07:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B1B206C0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 10:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ujt4U9Wj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PW+73Bms";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Y4ie8kxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B1B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CqJ0ZOpE/s2pA8V/4o5LMDQlETXqFqEIQyLuVZDqrwg=; b=Ujt4U9Wjam8kfA5NEnI2uomUB
	xVVHwuEphxuU4Sz+tSRPPhoT6QOuLZTfChCHz2uYcrl2AHovqcWAxrjFJlB6FPVh4wW8LmVTLYdGc
	IdoXoBvn9DrhL077sAnpOOymsSIyWBVVKxbLj+fKQsZpecAmDe9sfQDnkrdXGR0t5SRzyPYx7Tyi/
	UuNNlg0zbH9ceTXXojbHz+dOMi1r5+aqdT2EUsil0dpOD6JGh9YHalU+Tl+qOhGTYfZjJ5xkGX+Bw
	kLl7f1+atO9Cr/oHQSL9Qo6EuQVOM3OoybwzPNlIbZxVdhesrfO/C6ZfAeAnmk8HgXhMIsHJ63EX+
	7iF/dr+hQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jolGi-00027r-FD; Fri, 26 Jun 2020 10:07:36 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolDI-0000aR-Hf
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:04:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=F/dCW4v8WLTt9ErWAm/mwA0WZI03Ih/ZKlSgwSD72N4=; b=PW+73Bmsz6fjE5fd1Uq832TtXH
 G81JvKT/8ZWoEqgJ6wDgO0aomwgQ2KmAnuQ1L/ImTzgrzeG3c0rWIi1HUbgriQgIoYqAqtkmPU5Nu
 z4ArM+tv3qj2OAf08LZtmD2vkLbXhb3Nn3dnlMyTHPtw2ZJSv7ir0sPttJIQLq+6Ih4tRPQKuBJ7V
 L5krYhHv6oKVDv17KoGuB5hoYlc45stYSIJ2CfzqCJLE08u20PR4VAg9IX47PaVd3kR0Yb3wOKfHL
 rLed/cq05EIU+plnRFqWm/q+ZG6VJYay0r1NMyMMGuizg2sTR3EBNXc462t1HBqIyIStgyuuzSvyZ
 D/NuZn3g==;
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolBz-00043Q-ST
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 10:03:07 +0000
Received: by mail-ed1-x543.google.com with SMTP id b15so6453080edy.7
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 03:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=F/dCW4v8WLTt9ErWAm/mwA0WZI03Ih/ZKlSgwSD72N4=;
 b=Y4ie8kxw0NUY26G2pWnnE8ZmchVi0do4H7HZegWCb20g6pCB2kfjo3h2cdXWbOOlSC
 qWDt2MLXbBb6lE30qGkMm/TaQq0NtZGSdDf9h/J5ovXv/o4saQ6/X8bjbKuBaE1CNZm2
 20+KIl0swwqz6mRyZN9ZtHZbIXKyLJyfSZrXozRQlciT/eGisPadjiPTOACDDJG7NdVa
 31vKIhqzFeyWfPStqycEu0Kd7vwTvqKAw69JyAENl8gIQ2e83PjeFm9GBiSf65jgxWip
 Ky/ckLU3xh9hIz2/weBQwKKFPQaEXIcD2IY539v5QWxjRmYZfEzFNeuX4f+PaaPtkul5
 w0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=F/dCW4v8WLTt9ErWAm/mwA0WZI03Ih/ZKlSgwSD72N4=;
 b=VXoEAwouYkR3cT+a75tXFmHezTTzKOrQXAAu0b6ZWjqacxGGm0img+5m6x2PWxOUGF
 jXCf3DthhnTSwb2QUh9cgvPlNGePjdFvrOTm2td6odTxYmLLCfcdhL/eYhHLtE6rLvCk
 Ny9H07gUx4RBhjz5SO0qB4y5HT4wePj0BeIixRpgkPBft4WsLRtCdCNcsxnLMJscrZnu
 fbvmz80zfwbSdVxKDDGKNQBq+YpUycZJsTB9BBNi9ftj0TOb31mBroc8FYn8170UDb+2
 CgaFsVfWMLnaY66sXzguupZ9ucQppSkUzBy0CJZD+2ptW9+SrQqg8Mz1l0oWus49BVwz
 QQRw==
X-Gm-Message-State: AOAM531XenDgfqrnszBRJs9WvXYQ3G5og52M0H/Bz9oqt63TUwMwLV93
 QU1RG0Qq+HFRbZqn/DdndaJFYQ==
X-Google-Smtp-Source: ABdhPJzG40h4fZUL5OHcBXwwcE+6pgHzz7gBUjtOz+GMdQlSfGd0xv1012exLZQA5gMOhTEtuYGweQ==
X-Received: by 2002:a05:6402:1544:: with SMTP id
 p4mr2614934edx.334.1593165762376; 
 Fri, 26 Jun 2020 03:02:42 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id f1sm20329336edn.66.2020.06.26.03.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 03:02:41 -0700 (PDT)
Date: Fri, 26 Jun 2020 12:02:41 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 3/6] block: add support for zone offline transition
Message-ID: <20200626100241.5dtagphfyxwybodl@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-4-javier@javigon.com>
 <b3429226-16ae-df3c-38aa-50e3a8716e71@lightnvm.io>
 <20200625194835.5hojuvdwtjxtso2l@MacBook-Pro.localdomain>
 <CY4PR04MB3751E7721E5D5E15065B0ED2E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626091113.GB26616@lst.de>
 <CY4PR04MB3751E3DF3A1BD1FC77E6C101E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626091758.GA27903@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626091758.GA27903@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_110244_822467_B020D00E 
X-CRM114-Status: GOOD (  21.96  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 26.06.2020 11:17, hch@lst.de wrote:
>On Fri, Jun 26, 2020 at 09:15:14AM +0000, Damien Le Moal wrote:
>> On 2020/06/26 18:11, hch@lst.de wrote:
>> > On Fri, Jun 26, 2020 at 01:14:30AM +0000, Damien Le Moal wrote:
>> >> As long as you keep ZNS namespace report itself as being "host-managed" like
>> >> ZBC/ZAC disks, we need the consistency and common interface. If you break that,
>> >> the meaning of the zoned model queue attribute disappears and an application or
>> >> in-kernel user cannot rely on this model anymore to know how the drive will behave.
>> >
>> > We just need a way to expose to applications that new feature are
>> > supported.  Just like we did with zone capacity support.  That is why
>> > we added the feature flags to uapi zone structure.
>> >
>> >> Think of a file system, or any other in-kernel user. If they have to change
>> >> their code based on the device type (NVMe vs SCSI), then the zoned block device
>> >> interface is broken. Right now, that is not the case, everything works equally
>> >> well on ZNS and SCSI, modulo the need by a user for conventional zones that ZNS
>> >> do not define. But that is still consistent with the host-managed model since
>> >> conventional zones are optional.
>> >
>> > That is why we have the feature flag.  That user should not know the
>> > underlying transport or spec.  But it can reliably discover "this thing
>> > support zone capacity" or "this thing supports offline zones" or even
>> > nasty thing like "this zone can time out when open" which are much
>> > harder to deal with.
>> >
>> >> For this particular patch, there is currently no in-kernel user, and it is not
>> >> clear how this will be useful to applications. At least please clarify this. And
>> >
>> > The main user is the ioctl.  And if you think about how offline zones are
>> > (suppose to) be used driving this from management tools in userspace
>> > actually totally make sense.  Unlike for example open/close all which
>> > just don't make sense as primitives to start with.
>>
>> OK. Adding a new BLKZONEOFFLINE ioctl is easy though and fits into the current
>> zone management plumbing well, I think. So the patch can be significantly
>> simplified (no need for the new zone management op function with flags).
>
>Yes, I'm all for reusing the existing plumbing and style as much as
>possible.

OK. Will use the current path on V2.

Thanks!
Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
