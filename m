Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199E7C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 05:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2a/Y/9RxUg+RQvi15qObMdwkcPWgNkuVkFYsEACDhk=; b=HyxO8rH72+ROuc3Bx8rbEPyev2
	eQsd4ykCs6mj4r7zLUsyeGijyVWNHkYhGkKFKIDy3sygZFFljCx9UhOZLrpTkgD2m7+YipUSltpB6
	cUhMg2q7/Nl1kUHKvJiKoxEmDfgINdFoIXHHHns/O+MIszxWVQHeIf+reB0LzOzyaFW8DgRTCQTH4
	MURBQju4aiZBv1eOKRQd3iJHRRl4cw+r7pQoIzbsquzO01L9y1ekH7XMraWzD40DM2O4WGBN2KYQh
	tT5jjbHK/A4keyhmkOxItRZ49lG7yDD71hY7C27OMHLbhRrk9KVTma9TUjdQoDKIgXoTNsbYkmLDK
	5kifE4Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTGVH-002E2w-Fl; Sun, 13 Mar 2022 05:10:51 +0000
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTGVE-002E22-Ha
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 05:10:50 +0000
Received: by mail-lf1-x12b.google.com with SMTP id n19so21692350lfh.8
 for <linux-nvme@lists.infradead.org>; Sat, 12 Mar 2022 21:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/2a/Y/9RxUg+RQvi15qObMdwkcPWgNkuVkFYsEACDhk=;
 b=dGMG4CGvo7ZEusw/Ld484ohSc3fYw9xqgxsiNBnbP8RjQymD23frQDRtA4TW3JRFVz
 jyAX5CFAD+gbxRCxqPKxnI0UAy07HAt1Y2vEaYJwOB5vjA3P4ANAdITS01kxTKXz8O2D
 +sSzFavIAAfwkUgBVvkMttK1YxbvW+aNqAj+6/2zqODavQLvBpF618r1pqPQcVPiHKqi
 RIH32k+3xmJ/nEgrsm7XoAGIn0j2XfYCxTMYQ5Dx+oqIfQJwENAOnkszZe1FHWBjeUR3
 JqVzOIVmSfHNscDmoynYYFTViaH43dYTwpWhDE1vVrSoNYbMx5rYUTbi9qjH/u9GzdZ9
 kMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/2a/Y/9RxUg+RQvi15qObMdwkcPWgNkuVkFYsEACDhk=;
 b=NOhW1wQVN/0ROQ2GjbYTNnZ13LOfWzNJs/X2I+QXnj6Vur56k0oPvz5PytGvpKFqvy
 NSlz1EkLtCyZqw3EjpIHgGrfnTkhXkceryuaFu22Q/dBVzTd7/cqdtHI5ZVlcxOnnirl
 ldhb9kWixXHZYys997/6wIEqhWtM2p0JpLSe1XzMFt2y1Udcz1taSGQWUn60KrLMarnJ
 t3PwCkXsU2iHVHW/j7hHXeu+LUQDX/WIW7vxxT0hvQ5pk28jJF5d7BX/fM0fj6M1V3Dm
 n3VmlZdkBdzJDLj+4v5oeBLda/FQeTAhJXeS01EyRybMjwI7d8Pi9RduvLuBJloxUp/A
 qOyA==
X-Gm-Message-State: AOAM531r7v7XQCKQglvH+Fx9cZkJTlcB8ZgRoGWcB/I0kWRjYtTe+ixv
 mq2kLALtdlODW2bhBgIrZZd53XFgefXLQ6ok+uw=
X-Google-Smtp-Source: ABdhPJyU6aJ5LvlLIm1T0ym3uRSz5wd5N0P5WXOILbF4l1t4ugCeri+GG6bQDZpgXFpiYUZyRYDJV79MInjH6/VIu7A=
X-Received: by 2002:a05:6512:3f99:b0:447:7fc0:8d3 with SMTP id
 x25-20020a0565123f9900b004477fc008d3mr10460588lfa.671.1647148245909; Sat, 12
 Mar 2022 21:10:45 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220308152651epcas5p1ebd2dc7fa01db43dd587c228a3695696@epcas5p1.samsung.com>
 <20220308152105.309618-1-joshi.k@samsung.com> <20220310082926.GA26614@lst.de>
 <CA+1E3rJ17F0Rz5UKUnW-LPkWDfPHXG5aeq-ocgNxHfGrxYtAuw@mail.gmail.com>
 <Yit8LFAMK3t0nY/q@bombadil.infradead.org>
In-Reply-To: <Yit8LFAMK3t0nY/q@bombadil.infradead.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Sun, 13 Mar 2022 10:40:20 +0530
Message-ID: <CA+1E3rKgGgOQonGpjjwdAFc2FAXH5UkGKNXh0RqrBo9_=H6VSQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] io_uring passthru over nvme
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
 Jens Axboe <axboe@kernel.dk>, 
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220312_211048_611530_8A1AA36E 
X-CRM114-Status: GOOD (  17.59  )
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

On Fri, Mar 11, 2022 at 10:13 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Mar 10, 2022 at 03:35:02PM +0530, Kanchan Joshi wrote:
> > On Thu, Mar 10, 2022 at 1:59 PM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > What branch is this against?
> > Sorry I missed that in the cover.
> > Two options -
> > (a) https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-big-sqe
> > first patch ("128 byte sqe support") is already there.
> > (b) for-next (linux-block), series will fit on top of commit 9e9d83faa
> > ("io_uring: Remove unneeded test in io_run_task_work_sig")
> >
> > > Do you have a git tree available?
> > Not at the moment.
> >
> > @Jens: Please see if it is possible to move patches to your
> > io_uring-big-sqe branch (and maybe rename that to big-sqe-pt.v1).
>
> Since Jens might be busy, I've put up a tree with all this stuff:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20220311-io-uring-cmd
>
> It is based on option (b) mentioned above, I took linux-block for-next
> and reset the tree to commit "io_uring: Remove unneeded test in
> io_run_task_work_sig" before applying the series.

Thanks for putting this up.

-- 
Joshi

