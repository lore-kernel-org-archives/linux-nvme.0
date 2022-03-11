Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB9EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xrkMsT6XPANqLk5GgYC5BUODbPJFQSrD5uKd2h8hjI0=; b=oI/Yt2mzKAHGQXfYowVPxykT5W
	2EEHvv0hxSMkOBPqPyalveLVV3x234fkGTZ5ZsDhQ0PxsBHKbxNZbMatvkVGeduBi6blzfV0WcU/5
	mb0JpA9ZF+nSvIWkGq1tTyJaSRfOSreRey5QZyEGsgDNVlw9Cup8PcpTPpR0Ys1+ouu1oJTDKuLf5
	m+IWK4eCo7aNUhDEzGCLzAsbwoOLiXMFdAQWLueK0/V+u1qc3eQGFlM3OjXhW9zm3XxdkeOzTrBkb
	FLWmgRd4nqU/kHCVm6HzCafdXpv92p5x2NxYpzOSVo5JVNJ6Yq8E9mO1GQOnj1JRk7plwDCc7xXwO
	kNmN7BAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSmOy-000GrX-1p; Fri, 11 Mar 2022 21:02:20 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nSmOw-000GrH-B8; Fri, 11 Mar 2022 21:02:18 +0000
Date: Fri, 11 Mar 2022 13:02:18 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 linux-security-module@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
 kbusch@kernel.org, asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, pankydev8@gmail.com,
 javier@javigon.com, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Message-ID: <Yiu42rLif7FSwrjP@bombadil.infradead.org>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <YiuNZ7+KUjLtuYkr@bombadil.infradead.org>
 <CAHC9VhTnpO6LyaYWDTjJAy_ztGw+qqf-YS0W7S-djyZVnydVHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTnpO6LyaYWDTjJAy_ztGw+qqf-YS0W7S-djyZVnydVHg@mail.gmail.com>
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

On Fri, Mar 11, 2022 at 01:53:03PM -0500, Paul Moore wrote:
> On Fri, Mar 11, 2022 at 12:56 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Mar 08, 2022 at 08:50:53PM +0530, Kanchan Joshi wrote:
> > > diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> > > index 5c9cd9695519..1df270b47af5 100644
> > > --- a/drivers/nvme/host/ioctl.c
> > > +++ b/drivers/nvme/host/ioctl.c
> > > @@ -369,6 +469,33 @@ long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > >       return __nvme_ioctl(ns, cmd, (void __user *)arg);
> > >  }
> > >
> > > +static int nvme_ns_async_ioctl(struct nvme_ns *ns, struct io_uring_cmd *ioucmd)
> > > +{
> > > +     int ret;
> > > +
> > > +     BUILD_BUG_ON(sizeof(struct nvme_uring_cmd_pdu) > sizeof(ioucmd->pdu));
> > > +
> > > +     switch (ioucmd->cmd_op) {
> > > +     case NVME_IOCTL_IO64_CMD:
> > > +             ret = nvme_user_cmd64(ns->ctrl, ns, NULL, ioucmd);
> > > +             break;
> > > +     default:
> > > +             ret = -ENOTTY;
> > > +     }
> > > +
> > > +     if (ret >= 0)
> > > +             ret = -EIOCBQUEUED;
> > > +     return ret;
> > > +}
> >
> > And here I think we'll need something like this:
> 
> If we can promise that we will have a LSM hook for all of the
> file_operations::async_cmd implementations that are security relevant
> we could skip the LSM passthrough hook at the io_uring layer.

There is no way to ensure this unless perhaps we cake that into
the API somehow... Or have a registration system for setting the
respctive file ops / LSM.

> It
> would potentially make life easier in that we don't have to worry
> about putting the passthrough op in the right context, but risks
> missing a LSM hook control point (it will happen at some point and
> *boom* CVE).

Precicely my concern. So we either open code this and ask folks
to do this or I think we do a registration and require both ops
and the the LSM hook at registration.

I think this should be enough information to get Kanchan rolling
on the LSM side.

  Luis

