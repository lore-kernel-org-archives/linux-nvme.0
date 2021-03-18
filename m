Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B67C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 07:48:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D10464E33
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 07:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D10464E33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RXSg2RX+vGMaeOKSXcS7kEBu5ZxfE46wVfpTliNAZ3o=; b=QesYBad6dgyTw9xKg8LNGW/Y+
	UhCx8eFQcWLE4YJddodEpLboS3bhRgjQcl7mLw91GeI55reykLBXRwWD1Tv9u2xYTJW4XCdUdbZ/z
	uqDvGSWFgAhLz7pb3GU1syDFXH+MshCkZm3b9LPUMxEL/5dY1/Z6jLKLNhbSfZiXiToMNryajaEvy
	/lxlOdhG8cwwTdjY4OcpoR4nUUY/Q0FY9SlpOXjyyCC4NchqJIfkExV4VdwYr3Pza45On7nResSXL
	NTbkWHNGmOnA6J18pkoMB7+MxXXV9yNzOKxty7CuvoYO8WqhetNcTYeQsrT/guFh+p+kwnkYkCBXT
	hBBLAmKPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMnOO-004hMS-H2; Thu, 18 Mar 2021 07:48:28 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMnOG-004hLN-N1
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 07:48:22 +0000
Received: by mail-wm1-x32d.google.com with SMTP id
 z6-20020a1c4c060000b029010f13694ba2so2712629wmf.5
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 00:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TG7YlWDsVFQll45rVCenXqdxqCRGUryVl0R9Q9CGIEE=;
 b=tS4qDC4ZQ5pPfJwDVXyCedaUhR1HKjXliuwPA0dgHMkQLPhlwuS05d0cuzyF6HWIzn
 i8DdBxUH9KhTLpoy4ytcBKlpwDK980x7Y7gVLNRiI6sOwsG0tFhOQbu7Jx78byt8MbJq
 zL4I2G7tUSWglNejAZ4WHP0k76AMuxlODA8o6AALsBByodxG/jNxMsxohpp0WafR2u5W
 4/eYyKuboT9Uj3x4yiXO/BVWbxIMB2vxvQuTsax5q07XHS5H8ufa0fytEFdw8+i3nivi
 5BK2dUj9ia6dRm+5XTpSxwoZO0c5+q/OD/IgYrY76KZeaHSrtLrU7r0hVLNPef9SVQu6
 uhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TG7YlWDsVFQll45rVCenXqdxqCRGUryVl0R9Q9CGIEE=;
 b=LpLW0XpGha3QQi2zYgD8YNWIVH7mSFX8UggcpL6D6Vvku9GRzdbXtpA/blT1ubFkit
 Pa80HEUX+9RDxcA52imjLnrl1zqWBZKp/ofgICkmwR0BpEeqiLbM17e6UoOh+UxWtVIF
 ylfSzUJxYKtSyVMn1prGOxdGvgXgeYNBZkNLzG6/PYWwBS5KOKeAZo+yTaBl4yJZoPXy
 XCCAcCuJF/jYjkFjRhQ6xJvxJH2GoSFAzEE+vED5jDLmmCBMthxbPB4Joev62FmetRkJ
 3hqvSG4WdnnRvKMvTD4uG2F2qxdx8eYdKSq1InLaWjtQk1gVaLRLh4+mqBUoDngRqTBG
 2plw==
X-Gm-Message-State: AOAM532Ta9UnAN5N/UlWHIM1sND4H1tAgjQBBkZ1hRxf0OV9lwXQl/D6
 0oaRG7MhgLl5fT8enD0qqLfaT9Y2aqk++nl788s=
X-Google-Smtp-Source: ABdhPJzfXm9JgoR6BcOdccwdmN0b1PPTp0RUszAvhDYTkb4OcnL/bD1xb+yTieB+Uugq6/qgpIs6q9S9Nba9ta5I31Y=
X-Received: by 2002:a05:600c:4fc2:: with SMTP id
 o2mr2220575wmq.25.1616053699300; 
 Thu, 18 Mar 2021 00:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210316140229epcas5p23d68a4c9694bbf7759b5901115a4309b@epcas5p2.samsung.com>
 <20210316140126.24900-1-joshi.k@samsung.com>
 <b5476c77-813a-6416-d317-38e8537b83cb@kernel.dk>
 <CA+1E3rLOOaggA0p5wr5ndTWx42zjebCeEm5XzfOq7QcH6oP=wA@mail.gmail.com>
 <63a127c2-e2ed-ad5f-a6d3-8d56e3e95380@kernel.dk>
In-Reply-To: <63a127c2-e2ed-ad5f-a6d3-8d56e3e95380@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 18 Mar 2021 13:17:52 +0530
Message-ID: <CA+1E3r+_rNmDBgL2cabxboG4GDaRx=XRt=SiNPt3hnvOuTYd5A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] Async nvme passthrough over io_uring
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, 
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, 
 Selvakumar S <selvakuma.s1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_074820_933257_716628C7 
X-CRM114-Status: GOOD (  22.56  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 18, 2021 at 7:28 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/17/21 3:31 AM, Kanchan Joshi wrote:
> > On Tue, Mar 16, 2021 at 9:31 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 3/16/21 8:01 AM, Kanchan Joshi wrote:
> >>> This series adds async passthrough capability for nvme block-dev over
> >>> iouring_cmd. The patches are on top of Jens uring-cmd branch:
> >>> https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v3
> >>>
> >>> Application is expected to allocate passthrough command structure, set
> >>> it up traditionally, and pass its address via "block_uring_cmd->addr".
> >>> On completion, CQE is posted with completion-status after any ioctl
> >>> specific buffer/field update.
> >>
> >> Do you have a test app? I'd be curious to try and add support for this
> >> to t/io_uring from fio just to run some perf numbers.
> >
> > Yes Jens. Need to do a couple of things to make it public, will post it today.

Please see if this is accessible to you -
https://github.com/joshkan/fio/commit/6c18653bc87015213a18c23d56518d4daf21b191

I run it on nvme device with the extra option "-uring_cmd=1". And pit
passthru read/write against regular uring read/write.
While write perf looks fine, I notice higher-qd reads going tad-bit
low which is puzzling.
But I need to test more to see if this is about my test-env (including
the added test-code) itself.

It will be great if you could, at some point in future, have a look at
this test or spin off what you already had in mind.

> Sounds good! I commented on 1/3, I think it can be simplified and
> cleaned up quite a bit, which is great. Then let's base it on top of v4
> that I posted, let me know if you run into any issues with that.

Yes, will move to V4,  thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
