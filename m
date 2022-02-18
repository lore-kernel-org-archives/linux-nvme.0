Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA3CC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Feb 2022 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KSli5rCrJB0W3FEtPi/UFqHqSyfkR/GxEvw8Vsf0wq0=; b=D1rwSb49x9WErDskJoaTa0IVs+
	mTMwbE85p9yAYrk7TAcLt2CwWbnw2UB6li7rSjNFrZIIoVZl0twBRLBlSXY9EuZypPivQ6FIVhGhq
	V/HKW01vLb6CQve3JP2O2cJE1Z1ZrKoVBSrhMCsiLTQYYq9nVYlwm66VsJ/LdZSZlSagi/QNPfZXo
	xjy+J+WExYwVFYctTyOJxZ+hS9vqdK5MWYD3DywXePOy1bzdmGrk7sxeBZXeWLQ9Oolt+ut+Am+dw
	zvaUtmWiV14n+S3s+rQlkEv5KVVaBQEp50Hc6Jckk+9vXOI6sJFmWLQ1yO4zpWLWFiKPfDei34TdB
	jR+fVZgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nL7GZ-00FQ5c-3T; Fri, 18 Feb 2022 17:41:59 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nL7GT-00FQ4M-5K
 for linux-nvme@lists.infradead.org; Fri, 18 Feb 2022 17:41:54 +0000
Received: by mail-pj1-x1034.google.com with SMTP id
 q11-20020a17090a304b00b001b94d25eaecso9170227pjl.4
 for <linux-nvme@lists.infradead.org>; Fri, 18 Feb 2022 09:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KSli5rCrJB0W3FEtPi/UFqHqSyfkR/GxEvw8Vsf0wq0=;
 b=KIFNCgz5A3jkvjPREYY404JrN5BdDM7HCekAcSiFxZ9BZq+0X5ARFpw0Ae9G4RKvFD
 ZlbXBXjVATg72xZh0JWKmI9RJizkhYNxJwKrQgC++IqYMx9vYdaX8ID1rT16hY4aM9G8
 KtIvM3F+89hPvzaT7nv/ZbBswkpFEmp5rE5mvYO4IzWleJv4cYE4tAlo7WGIHmv2FY0l
 fgFjVQ0x1WWNEREZnMufZ3Ku4rzKSRFytC6mN0ktm2IKVuW364SGP/09CYQmGsNTOCu0
 SSxuHdlEOkFyiOx9T/edLiRPOkaFC15T1g2AL4s/MtZAk8GdMp/U65AHk12myhbpFGkQ
 r+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KSli5rCrJB0W3FEtPi/UFqHqSyfkR/GxEvw8Vsf0wq0=;
 b=C0PYLgq+CxQAMI/NYcecS9SEXtSAQD2F4EiKWMpbEESF/ELhGNRa7RjDZpHWsMcc1I
 CY12TpgP0OI4KmRh9qkO72tJAbUENvKJN78qY2WVBTvAylfiCb+W7n8cbeE5h3k53dbH
 eBRLOMzGYc9WQh2V+49YZLPrZIZr/5ixedhBRPZAwFq5xjyRcA2Cm1vO3YMJsKSTI5XU
 JaqAoeJJt6LIhOLu09IBjRQX6H97NxBB74vVmBOb25Zha3q8BtZGBR1W2UUlRduk7rrp
 vYMUuHjHo0765NiyOjwdPGC0/ZRHS4xD9cMHNux5mI7dcR0A6VNssA5vEBTCcS0AOhyO
 X0zQ==
X-Gm-Message-State: AOAM532UyBdQYEvmEiJ0ZfTmZqGdq4OWgTx6SMDk0bBeydcxARgoGmd4
 gQDDnm0T/Kvl5OxME9nC4vuZ31ykpjirAfB7/mg=
X-Google-Smtp-Source: ABdhPJzMHCKthZOO2Ql1mmgaOUdLWEnOAXoAJjDZ2Ed1STB6HaeTHcYgODUuzLKdUsC1c5XVubuD3v/f1pkkVeNuHqc=
X-Received: by 2002:a17:902:cf0e:b0:14f:8a60:475c with SMTP id
 i14-20020a170902cf0e00b0014f8a60475cmr221751plg.146.1645206110764; Fri, 18
 Feb 2022 09:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142228epcas5p2978d92d38f2015148d5f72913d6dbc3e@epcas5p2.samsung.com>
 <20211220141734.12206-2-joshi.k@samsung.com>
 <Yg2vP7lo3hGLGakx@bombadil.infradead.org>
 <CA+1E3rLpKp0h2x7CoFPXwsYOc4ZYg_sqQQ+ed8cJhq77ESOAjg@mail.gmail.com>
 <b11ede2b-b737-f99a-7b31-20d6b4eccb42@kernel.dk>
 <Yg6MVe2Qpy92CsNF@bombadil.infradead.org>
In-Reply-To: <Yg6MVe2Qpy92CsNF@bombadil.infradead.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Fri, 18 Feb 2022 23:11:25 +0530
Message-ID: <CA+1E3r+41WZRR_AOodvQnVbRo3+fG=sLT4LJpSjgd2SsJCNuow@mail.gmail.com>
Subject: Re: [RFC 01/13] io_uring: add infra for uring_cmd completion in
 submitter-task
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
 io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220218_094153_250910_25DE0918 
X-CRM114-Status: GOOD (  28.11  )
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

On Thu, Feb 17, 2022 at 11:26 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Feb 17, 2022 at 08:50:59AM -0700, Jens Axboe wrote:
> > On 2/17/22 8:39 AM, Kanchan Joshi wrote:
> > > On Thu, Feb 17, 2022 at 7:43 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >>
> > >> On Mon, Dec 20, 2021 at 07:47:22PM +0530, Kanchan Joshi wrote:
> > >>> Completion of a uring_cmd ioctl may involve referencing certain
> > >>> ioctl-specific fields, requiring original submitter context.
> > >>> Export an API that driver can use for this purpose.
> > >>> The API facilitates reusing task-work infra of io_uring, while driver
> > >>> gets to implement cmd-specific handling in a callback.
> > >>>
> > >>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > >>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > >>> ---
> > >>>  fs/io_uring.c            | 16 ++++++++++++++++
> > >>>  include/linux/io_uring.h |  8 ++++++++
> > >>>  2 files changed, 24 insertions(+)
> > >>>
> > >>> diff --git a/fs/io_uring.c b/fs/io_uring.c
> > >>> index e96ed3d0385e..246f1085404d 100644
> > >>> --- a/fs/io_uring.c
> > >>> +++ b/fs/io_uring.c
> > >>> @@ -2450,6 +2450,22 @@ static void io_req_task_submit(struct io_kiocb *req, bool *locked)
> > >>>               io_req_complete_failed(req, -EFAULT);
> > >>>  }
> > >>>
> > >>> +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
> > >>> +{
> > >>> +     req->uring_cmd.driver_cb(&req->uring_cmd);
> > >>
> > >> If the callback memory area is gone, boom.
> > >
> > > Why will the memory area be gone?
> > > Module removal is protected because try_module_get is done anyway when
> > > the namespace was opened.
> >
> > And the req isn't going away before it's completed.
>
> Groovy, it would be nice to add a little /* comment */ to just remind
> the reader?
>
> > >>> +{
> > >>> +     struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> > >>> +
> > >>> +     req->uring_cmd.driver_cb = driver_cb;
> > >>> +     req->io_task_work.func = io_uring_cmd_work;
> > >>> +     io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOLL));
> > >>
> > >> This can schedules, and so the callback may go fishing in the meantime.
> > >
> > > io_req_task_work_add is safe to be called in atomic context. FWIW,
> > > io_uring uses this for regular (i.e. direct block) io completion too.
> >
> > Correct, it doesn't schedule and is safe from irq context as long as the
> > task is pinned (which it is, via the req itself).
>
> Great, a kdoc explaining the routine and that it can be called from
> atomic context and the rationale would be very useful to users. And ..
> so the callback *must* be safe in atomic context too or can it sleep?

Callback will be invoked in task/process context. Allowing much more
to do than we can in atomic context, including sleep if necessary.

