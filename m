Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9D8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TE8n2qHv14fuB3CwoM4G4MqgZMfIJ3HjzCk+Yfyt5N8=; b=SZt0c2qvuypF7cZyVJyjP9xw8E
	AWSh8jf4j9KKHN8ZECkeNcC77okWN8budZr2HZzSzzeOwXpcdIZ2hzCtmNt+rxPNDRit+5AuAX1Aw
	B/4P1rrszhCbF/aDmEyzcQHW/PPX0mggOcOO4x29HKqmFrNeoh9RMfAVOQPihMSlkMg6J+qrWm0FU
	JMJDuh8YdRueM8W+GWtWvHPWNW+oqWBalIBVlbTYSksZGOjdoUgJHmt1byyG3VSyY+TzooW8SKHP7
	Pv64jmiMfXQTFUNn0E3R6wcv/UnbiTZGyRXUkXE1WVpZ2mBeQtEdDujns7bTdBsMYpoYSwyu9IcMt
	hpCu8S+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKisy-00BIJT-A4; Thu, 17 Feb 2022 15:40:00 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKisv-00BIGj-GG
 for linux-nvme@lists.infradead.org; Thu, 17 Feb 2022 15:39:59 +0000
Received: by mail-pf1-x434.google.com with SMTP id p8so1415033pfh.8
 for <linux-nvme@lists.infradead.org>; Thu, 17 Feb 2022 07:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TE8n2qHv14fuB3CwoM4G4MqgZMfIJ3HjzCk+Yfyt5N8=;
 b=qMt5VtEERrppHzkcA843sKlSXVkDWwJVCc8xr8+WeAWWtHU+r71qgQBRYbX1ux5DHL
 NTb7U6GXDPSHTmip7AfIy5Ko8VL/n2wYZkfTF+oblRqdZyRfvEJN8zeIrsT+U1xUpvfJ
 riVOgdNN8btUUwTA2klq9U/ssBcB0UxtckmqrZ9tEwGNj1BJ21gr/PO2oSD17bvd5xTR
 WaPxX9eN4glrpIkVpONkOkPCdwiqP9MsrN3kghCci+eV1jQZ8IyRz1YxvinGdbLTKvYS
 g0yJtFpgUiwqm4F4jDITroCd2gmObqxz7e5DqX7MyAaS2lksK8rHnhn45TfDiH1mcbj+
 z0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TE8n2qHv14fuB3CwoM4G4MqgZMfIJ3HjzCk+Yfyt5N8=;
 b=W3ADsA3vFzZDsrrvbwqcnEklENXHrByuPmddsGmTbdtfKR6+bJzgSgv04oDwS5Gj5x
 L4n2WENqXnFOstB+THioYOiYv422GZFBpZDSJ5nVMPqmZ30bn+rEThyg4vtb7cbfOtHl
 o8KbyA7aaX6gmqtunLMdKo6PtZRF0X/3aqjXAISYIvmm5JAEPS3CS7nnToEQ2CDgA38W
 oym9wqddxsS0V36tmUUXWYPS9yYwTx6G5SKD3GbPqsEQfdORx8Q951FIBu+OigWqoohe
 Ha3cyEUK1I+XkpmfgIjdd1jTY68i1K4j8FZztkgtiXuAFb+qI6NE1p08uqWkVcGYvwlY
 uNcg==
X-Gm-Message-State: AOAM531MuSYLaSaM8VvOOyED4Q7bdsZYt38fLMXk6eNY1WWclM5M+DRw
 tjhg1B2TegYttV0BNu5H3b2HGDqjB3EB9Vasq7k=
X-Google-Smtp-Source: ABdhPJzPHsLcfwtzgYqMUfCU52gOXoVikjFPcVCnRLCbbJ9C8FYtQSZ8LnF5dDCB8RmVXuGNHrzFCDcOFwUhqIC04Qk=
X-Received: by 2002:a05:6a00:a8b:b0:4cd:6030:4df3 with SMTP id
 b11-20020a056a000a8b00b004cd60304df3mr3442934pfl.40.1645112395768; Thu, 17
 Feb 2022 07:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142228epcas5p2978d92d38f2015148d5f72913d6dbc3e@epcas5p2.samsung.com>
 <20211220141734.12206-2-joshi.k@samsung.com>
 <Yg2vP7lo3hGLGakx@bombadil.infradead.org>
In-Reply-To: <Yg2vP7lo3hGLGakx@bombadil.infradead.org>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 17 Feb 2022 21:09:30 +0530
Message-ID: <CA+1E3rLpKp0h2x7CoFPXwsYOc4ZYg_sqQQ+ed8cJhq77ESOAjg@mail.gmail.com>
Subject: Re: [RFC 01/13] io_uring: add infra for uring_cmd completion in
 submitter-task
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Pankaj Raghav <pankydev8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220217_073957_582965_4422183F 
X-CRM114-Status: GOOD (  27.15  )
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

On Thu, Feb 17, 2022 at 7:43 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Dec 20, 2021 at 07:47:22PM +0530, Kanchan Joshi wrote:
> > Completion of a uring_cmd ioctl may involve referencing certain
> > ioctl-specific fields, requiring original submitter context.
> > Export an API that driver can use for this purpose.
> > The API facilitates reusing task-work infra of io_uring, while driver
> > gets to implement cmd-specific handling in a callback.
> >
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > ---
> >  fs/io_uring.c            | 16 ++++++++++++++++
> >  include/linux/io_uring.h |  8 ++++++++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/fs/io_uring.c b/fs/io_uring.c
> > index e96ed3d0385e..246f1085404d 100644
> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -2450,6 +2450,22 @@ static void io_req_task_submit(struct io_kiocb *req, bool *locked)
> >               io_req_complete_failed(req, -EFAULT);
> >  }
> >
> > +static void io_uring_cmd_work(struct io_kiocb *req, bool *locked)
> > +{
> > +     req->uring_cmd.driver_cb(&req->uring_cmd);
>
> If the callback memory area is gone, boom.

Why will the memory area be gone?
Module removal is protected because try_module_get is done anyway when
the namespace was opened.

> > +}
> > +
> > +void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
> > +                     void (*driver_cb)(struct io_uring_cmd *))
>
> Adding kdoc style comment for this would be nice. Please document
> the context that is allowed.

Sure, for all kdoc style comments. Will add that in the next version.

> > +{
> > +     struct io_kiocb *req = container_of(ioucmd, struct io_kiocb, uring_cmd);
> > +
> > +     req->uring_cmd.driver_cb = driver_cb;
> > +     req->io_task_work.func = io_uring_cmd_work;
> > +     io_req_task_work_add(req, !!(req->ctx->flags & IORING_SETUP_SQPOLL));
>
> This can schedules, and so the callback may go fishing in the meantime.

io_req_task_work_add is safe to be called in atomic context.
FWIW, io_uring uses this for regular (i.e. direct block) io completion too.

> > +}
> > +EXPORT_SYMBOL_GPL(io_uring_cmd_complete_in_task);
> > +
> >  static void io_req_task_queue_fail(struct io_kiocb *req, int ret)
> >  {
> >       req->result = ret;
> > diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
> > index 64e788b39a86..f4b4990a3b62 100644
> > --- a/include/linux/io_uring.h
> > +++ b/include/linux/io_uring.h
> > @@ -14,11 +14,15 @@ struct io_uring_cmd {
> >       __u16           op;
> >       __u16           unused;
> >       __u32           len;
> > +     /* used if driver requires update in task context*/
>
> By using kdoc above youcan remove this comment.
>
> > +     void (*driver_cb)(struct io_uring_cmd *cmd);
>
> So we'd need a struct module here I think if we're going to
> defer this into memory which can be removed.
>
Same as the previous module-removal comment.Do we really need that?

Thanks,
--

