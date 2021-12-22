Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39496C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Dec 2021 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wxvMlF+l51oDklf4EWdV5hXzMGWV02iTMeiu5UDuE14=; b=BRRJz/OtfIlxosqTgLLMWRu0S6
	L0Vl3UHEsZAcCLJGDCLb7uZmYd7ca4eQhLrTAq8C2RE/h8FvIDgD5xe2ZwOX02dRlHGI917eEWjLH
	xRj2kjl59qX9fWKbPYxZNXOhY8s1UOyebPPNFsAYdECCnfSDUHHu1ne9fX48pxPdbB6wmGj26tsEN
	7JddjbqQGmfWTFsR2kjxGxVrfS/OGIvd28L2t7xraRoTh32RtUyVh9jxMiqVtxFZmnFnh+vSeOf6w
	mTKsSjkqLdUKf7XNb/SV56rYRpk1/2enjiPgz4/qgNVTE0m8NBtByRtSgoAoxy1ByKn7bP1f3vRCP
	V/spFWfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n01xX-00AaXM-Er; Wed, 22 Dec 2021 13:47:11 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n01xQ-00AaWK-Mn
 for linux-nvme@lists.infradead.org; Wed, 22 Dec 2021 13:47:06 +0000
Received: by mail-wm1-x32e.google.com with SMTP id e5so1225309wmq.1
 for <linux-nvme@lists.infradead.org>; Wed, 22 Dec 2021 05:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wxvMlF+l51oDklf4EWdV5hXzMGWV02iTMeiu5UDuE14=;
 b=EqwnjVMY7HMk9vmwXPlECKQbKBxQ1TmHzuOg9dZYm38j3qn958X3+M1Lsm73knrJN8
 gPqRxOj/t/X0hnbQrQzvxwDlOtOIzRn0NsHQF2cOMikt6I1aybrCWrJRNUc91wW/Ruer
 R0q17uz4oBfLyWR3W9I95XBcT0sHWigqYiMC+GPmCVawoSUXJdA7OxboIlEeR1eDkxkt
 AuXbjq8h3m4jsheXsDmFu5j5B0Hf1WGZl5L5R5e9xRQ4SFAWKgHTKw+eq29tyN+31iqK
 BjpSCDJoTc5rCPfgMtSAe9oOfiokMXuNKCCxINdNM1QAYxFepXoZogVo7koypWnJNx0D
 jykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wxvMlF+l51oDklf4EWdV5hXzMGWV02iTMeiu5UDuE14=;
 b=nyYjkX2YoiH8LC8YZ2NuT0bGgUAxFzTHVC4NZzbNus7ocWMLq9+NxNIYaK94j7n8ts
 bhWWgFYBjBmZrWOLbiBPGzel0gIlrhasmVkyvudBfJjnFRiI/VneLc3DVXo+7atIrHaZ
 Tbbspzymlbsj7A5Ri2zHDhbLYJLE7gqd4YtOQNgzZ7+CKBdWr3it21iCaYRC8nDS4B3e
 jJgSLRIIhxP2UYwU+uvNdigPLJcNQYY8C/UF66N6BxTDxOIlsKO/reFwUgxt9xwhBz2E
 +9olyh6ZnVTIeH/2g76IpOQ6/QbKWuTjORZEMAjN6T53Bs0oG+jdpZ3Ld7k27Lr/j7ds
 1Jhg==
X-Gm-Message-State: AOAM532YDC+8nk5bpJ25rzuPj/tHu8qwKNggZbnuNUg6vXcAZONYG5Jm
 hpTA4q2xL2fss53x8WMS29CZwwwKGjh7FseIRGw=
X-Google-Smtp-Source: ABdhPJxkxIwRoqvckjEUCYcJLdJLYPj3QuiYAWIBmMn64kvOBURss2n9lxMGdsbdDXeake/d5KlX0U843vkNazgqp0c=
X-Received: by 2002:a1c:f213:: with SMTP id s19mr1042698wmc.0.1640180821187;
 Wed, 22 Dec 2021 05:47:01 -0800 (PST)
MIME-Version: 1.0
References: <2da62822fd56414d9893b89e160ed05c@kioxia.com>
In-Reply-To: <2da62822fd56414d9893b89e160ed05c@kioxia.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 22 Dec 2021 19:16:35 +0530
Message-ID: <CA+1E3r+kmGcAsN-1F4W02+qrF7MJ1fqbRWnOfNAqNAapg=E4qw@mail.gmail.com>
Subject: Re: [RFC 02/13] nvme: wire-up support for async-passthru on
To: Clay Mayers <Clay.Mayers@kioxia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, 
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "javier@javigon.com" <javier@javigon.com>, 
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "pankydev8@gmail.com" <pankydev8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_054704_775319_747A3630 
X-CRM114-Status: GOOD (  22.53  )
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

On Wed, Dec 22, 2021 at 2:46 AM Clay Mayers <Clay.Mayers@kioxia.com> wrote:
>
> Message-ID: <20211220141734.12206-3-joshi.k@samsung.com>
>
> On 12/20/21 19:47:23 +0530, Kanchan Joshi wrote:
> > Introduce handlers for fops->async_cmd(), implementing async passthru on
> > char device (including the multipath one).
> > The handlers supports NVME_IOCTL_IO64_CMD.
> >
> I commented on these two issues below in more detail at
> https://github.com/joshkan/nvme-uring-pt/issues

That is on general/existing nvme ioctl (and not specific to this
series). You might want to open up a discussion in the nvme mailing
list.

> > +static void nvme_setup_uring_cmd_data(struct request *rq,
> > +             struct io_uring_cmd *ioucmd, void *meta,
> > +             void __user *meta_buffer, u32 meta_len, bool write) {
> > +     struct nvme_uring_cmd *cmd = nvme_uring_cmd(ioucmd);
> > +
> > +     /* to free bio on completion, as req->bio will be null at that time */
> > +     cmd->bio = rq->bio;
> > +     /* meta update is required only for read requests */
> > +     if (meta && !write) {
> > +             cmd->meta = meta;
> > +             cmd->meta_buffer = meta_buffer;
> > +             cmd->meta_len = meta_len;
> > +     } else {
> > +             cmd->meta = NULL;
> I believe that not saving meta in cmd->meta will leak it when it's a write.

Indeed. Will fix that up.

> But nvme_pt_task_cb also needs to change to copy to user when
> cmd->meta_buffer is set instead of cmd->meta.
>
> > +
> > +int nvme_ns_chr_async_cmd(struct io_uring_cmd *ioucmd,
> > +             enum io_uring_cmd_flags flags)
> > +{
> > +     struct nvme_ns *ns = container_of(file_inode(ioucmd->file)->i_cdev,
> > +                     struct nvme_ns, cdev);
> > +
> > +     return nvme_ns_async_ioctl(ns, ioucmd); }
> > +
> The uring cmd flags are not being passed to nvme_ns_async_ioctl - what if
> IO_URING_F_NONBLOCK Is set?  When it is, I think the nvme_alloc_request()
> call in nvme_submit_user_cmd() needs to pass in BLK_MQ_REQ_NOWAIT as
> the flags parameter or move to another thread.  Our proto-type does the former
> requiring user mode to retry on -EWOULDBLOCK and -EBUSY.

Right, this part is not handled. Need to get that sorted in the next
version. Thanks.



-- 
Joshi

