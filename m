Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A72C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 09:32:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C34C64F41
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 09:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C34C64F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BygwJodBTOGUdfiCWqRuBADyAES/p0g35e9tiIPfi34=; b=bKj03FjIxJPPqBSqHnvkKwE2/
	6W4+zQq2kYoacv2YsD1+3fm4TLZQjChQqgtRmy0NJUYU1jyIcqMIIB/uUj1oHp8SArJ7NAKPAMM9a
	sGpTBpMwqIxtKjWDQgGD3zVB5tGBTv0LMrybKeXgoex2zC9lFb9UzkRIRqCMsyjHV9TKo0A9Qvl5U
	zpQpibmU0s6u/joUvL/XWceXXFCxrdK9zb+1lTvCjtYF4j7D3eog3cwESeUmBgpKsN5yl4pOgwvh0
	seOgzbYO46I2qMdioPjT99Oi9lpAxJox9wLtCVohUMlkmD5thozOHa/lfPU92/yPYqF+c+8LBL6Ly
	27hFJEURg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMSXI-002r3e-TR; Wed, 17 Mar 2021 09:32:17 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMSXE-002r24-Ss
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 09:32:15 +0000
Received: by mail-wr1-x431.google.com with SMTP id x13so1061812wrs.9
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 02:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ckMFHbIAza0oRVDWFt01YA8LQDAieZmNLJNBqCZJrhs=;
 b=ReRH1LzoQsFbkj5XeL0BikRfqrBJxUxZ7ZfMzq0pmfQJNbCI88nn0qjyjyHWz+FlDH
 +o2mEMy87p8E+GptXa5pkKxYa+OcE+MT1vzEiArcmcaiFNLltEjV4PXVWfioAorPZskp
 5VlFdC3GKgFTyQr5Q6+N3T+X4WBxYxj28sqcHQQq3KkNBhh6a5Tqs2S2ykS7KV5i/7B2
 +VALfPsXfPDozi//B8cBhjhSncjqLE9LvV2FDjYRX6stkmr3hegbOOP3DQtl9BN5eSXH
 Z844XxtOGlFrEUV31jnQuigeN9ETuRfyL/+WC4DKw2XbqxiOMOydLBIIt/s1pTIO/GOt
 dDdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ckMFHbIAza0oRVDWFt01YA8LQDAieZmNLJNBqCZJrhs=;
 b=qGqA706rZMmtgWvm3RMSt0Ijjbdlp4azJ7x8xJmhMQ3XCraW0BxrKLhwVXcVAETfMt
 L3j6E4mWyMKBW/xfAJD6xsTuQnIjWvEmv3Db18oLmUMO+WkuvshAF38N65yvwV/UMQqa
 3a1dyYv0rMlRy6Wy5SClgVk5OWqcXiFuAf6ppBosnvwqrvQWuKSzmJDFS/DzUEG4VhiL
 1YDctX/3s0pK/tlOZwTAdToqnzEdTzAcurwZNaMIBTHJWPGCwcwApN72ISeaTg93DCPo
 wx30YAyQMKaB+kTF/8Rt8Ure7x+9ep8FCLGLr/QSI/ArFftUGhiEJRHa546tq6OCGdTW
 ehLw==
X-Gm-Message-State: AOAM532bhCTWiJJ0vEiuSwQQxt3YhwTwV+hbVIyGI2SiPzTcaWIeXmxf
 w8ALJ99HpS4fRrL0D3c43gzSxjFGIeHKBGsAIsk=
X-Google-Smtp-Source: ABdhPJxOSK+7YazsLKF0GZI9RunQyJekGktJ84bICE4RIs8SHdn1QWin0P8W0AKObSyMIogKK8bucnlug1KnoeHvhIk=
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr3312761wrw.355.1615973531697; 
 Wed, 17 Mar 2021 02:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210316140229epcas5p23d68a4c9694bbf7759b5901115a4309b@epcas5p2.samsung.com>
 <20210316140126.24900-1-joshi.k@samsung.com>
 <b5476c77-813a-6416-d317-38e8537b83cb@kernel.dk>
In-Reply-To: <b5476c77-813a-6416-d317-38e8537b83cb@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 17 Mar 2021 15:01:47 +0530
Message-ID: <CA+1E3rLOOaggA0p5wr5ndTWx42zjebCeEm5XzfOq7QcH6oP=wA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20210317_093213_090035_61E05561 
X-CRM114-Status: GOOD (  15.34  )
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

On Tue, Mar 16, 2021 at 9:31 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/16/21 8:01 AM, Kanchan Joshi wrote:
> > This series adds async passthrough capability for nvme block-dev over
> > iouring_cmd. The patches are on top of Jens uring-cmd branch:
> > https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-fops.v3
> >
> > Application is expected to allocate passthrough command structure, set
> > it up traditionally, and pass its address via "block_uring_cmd->addr".
> > On completion, CQE is posted with completion-status after any ioctl
> > specific buffer/field update.
>
> Do you have a test app? I'd be curious to try and add support for this
> to t/io_uring from fio just to run some perf numbers.

Yes Jens. Need to do a couple of things to make it public, will post it today.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
