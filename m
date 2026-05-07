Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71677CD3442
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 09:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EcZwFh2QZ44n0xgSUmMbcy6iZL2QmvBbYa+KTyDF4zs=; b=IaG1OoBZYITqOT0b75u2i3eOVG
	FBz7aSMuidawA/8YEAoqjdXiewB7dd7Wvxx5gMGWTLvtT3hjBU4lbOvcLtFoc85aSOpNa7D4Rf3MZ
	A5SMjC61nnvPFVWTN6c8zY3jQGi45kmUP2zuAfw5ChvQ7ojjB6ieDRWUyHv1qFHGpx9FBTd9gMt93
	kdFAoBUxtKOOlFHAqguk6nT6P81wEV1LA+7l3TRxfsF5tSUkr6G+4XTRlSn3YuQhPUZyg+dr6ZVmu
	dPBb//0Wos0oZNnvXS0hxQt3xZ9ZcnJMkg6KuHRYiiy3puhO2lNLmX9+QIHfQyHNYO0brcWxLWms4
	b+CphMPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKvNn-00000003Osi-30xf;
	Thu, 07 May 2026 09:51:03 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKvNl-00000003Ora-1GPn
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 09:51:02 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-43fe3e22e33so398277f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 May 2026 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778147459; x=1778752259; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcZwFh2QZ44n0xgSUmMbcy6iZL2QmvBbYa+KTyDF4zs=;
        b=RN0qvTAFTfM/uSm/0R4MIb1oHsIOhdaiV0+TkjP7jz3mFY2UCfZNLIr2EUEiRYcQK+
         kI3nFLByuJ6YIjf+tyHP82f0YoQ8ysvV6WrElhU3TIkkyqSrmZk3JyPJbRkKLLy85lHu
         S5DE8CQVDYcLw9aHmpxTOqqcTdc0GLe5rUwoV/GwRDg7UJv48BnpbRDxvet07PYtnLcH
         sYSAfaWHn5n+Mm0zFQwUqmYEriadiLQv5gBwjnR5KBZbySk0woPd/BQtAkSSHJ0karlr
         HlMchirp1p2ApEFFhLRh2zTZ1GJIuDU07i1gYPtwR/Jl35g46wEw3d0dBE71k2ju1iVI
         6jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147459; x=1778752259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcZwFh2QZ44n0xgSUmMbcy6iZL2QmvBbYa+KTyDF4zs=;
        b=k0hFDe1FsAtI+W7s4kB3bHQyrrR4/nJZST6CklNpPGnC7xg6LyPPFvU8QDX+A83x8s
         jxsDlCkZjeFRWLswnpKxuEsJanNtaoLO4sIxbMGHAey/H6qCBI5dWO23nhCzOFThllf2
         5O7ifxNLtKMafWtFTRhLSwfcHKu/kmFyCM4IT0kxoelJ+5wEcr5nl8QPaETs6URteqw8
         XYkciMv37OGF4Lz2JmJFsYjhu/Q7cvbBaeBSD/iOsGMHjLWpCuSGijcQlvAGk6zvpGUi
         Hjw036VEI9nNWkl71s0ToHNXsijEcpZTrYjsZZtnO6BMz2KgTVU6cN81N74uyEgHuKoP
         VOHg==
X-Forwarded-Encrypted: i=1; AFNElJ+iI5GJDimH5FR43DAOAHXu6j2O7pM3TBopE/Y/Bi7fBRbunKnil4ve/7p3x3uamQxLcNcBIvmyIphK@lists.infradead.org
X-Gm-Message-State: AOJu0YyjXfCqow7gHRHLYrzj46PUC7H/XEg2VSeFPZpKHRt2k7vG4w4Y
	OKL1SnbUPX9s7veUq+VEEAsRxjsX5lbpXUwm19WWeQp4EE09rsPQMj+f
X-Gm-Gg: AeBDiev1Qn5UTDBezFchUgTJOQ/n96EkHuxQOXbMBObuARlkB0w84UIcWPTNPHHBOdC
	hanzUPQNkk4iMpJKIh1qKtIJsldgjVzLA7K6maTPzhCK+NkC+A2sjzK0hQMMjDRrrd1M82PBfip
	nJwQJoTqIyM6kgpeXZf9beho9Nzv9xnTUnJAXsfEc34FqQCks3hm78q32YWmhQ91l2IksAtjWjB
	9h9ClH0pAV2GIK5H46+mVkCzM5NojxjyBcHvsxKzg2XWeCRvG+kzl+40p606CPexwRJfVy6UZry
	xqHeUv7BtnIQBzNfvdnhM35tJL/TXBdPqSGkwr9P0/CMk2KR6gnc5+TwCjtlg+Q8eOuFiO8PSTy
	EDfNDNVLFzOJO6Urp1ZPwCk3IiJV/go+jjFqM8PD19/O+MajVpTsNXZ+OSBOzD5HY/8N+hzvTiU
	8P0VNkBprM4PrtqDn+gCsAbYdmYdHsIqM5efFawCXk5Y8Dd+DXUJj5imZMYgoIVQ==
X-Received: by 2002:a05:6000:2207:b0:43d:7dc2:b655 with SMTP id ffacd0b85a97d-4515ad767c3mr12533550f8f.15.1778147458336;
        Thu, 07 May 2026 02:50:58 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48c04sm19976392f8f.15.2026.05.07.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:50:57 -0700 (PDT)
Date: Thu, 7 May 2026 17:50:43 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
Message-ID: <afxgc4hizusnAA26@fedora>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <afi7c-VUJWOLlC1m@fedora>
 <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_025101_380041_CD7D9019 
X-CRM114-Status: GOOD (  39.74  )
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

On Wed, May 06, 2026 at 10:02:11AM +0100, Pavel Begunkov wrote:
> Hey Ming,
> 
> On 5/4/26 16:29, Ming Lei wrote:
> > On Wed, Apr 29, 2026 at 04:25:46PM +0100, Pavel Begunkov wrote:
> > > The patch set allows to register a dmabuf to an io_uring instance for
> > > a specified file and use it with io_uring read / write requests. The
> > > infrastructure is not tied to io_uring and there could be more users
> > > in the future. A similar idea was attempted some years ago by Keith [1],
> > > from where I borrowed a good number of changes, and later was brough up
> > > by Tushar and Vishal from Intel.
> > > 
> > > It's an opt-in feature for files, and they need to implement a new
> > > file operation to use it. Only NVMe block devices are supported in this
> > > series. The user API is built on top of io_uring's "registered buffers",
> > > where a dmabuf is registered in a special way, but after it can be used
> > > as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
> > > requests. It's created via a new file operation and the resulted map is
> > > then passed through the I/O stack in a new iterator type. There is some
> > > additional infrastructure to bind it all, which also counts requests
> > > using a dmabuf map and managing lifetimes, which is used to implement
> > > map invalidation.
> > > 
> > > It was tested for GPU <-> NVMe transfers. Also, as it maintains a
> > > long-term dma mapping, it helps with the IOMMU cost. The numbers
> > > below are for udmabuf reads previously run by Anuj for different
> > > IOMMU modes:
> > 
> > Plain registered buffer is long-live too, which raises question: does this
> > framework need to take it into account from beginning?
> 
> Not sure I follow, mind expanding on what should be accounted?
> Are you suggesting that we might want to use normal registered
> buffers in a similar way? I.e. giving the driver an ability to
> pre-register them?

Yeah, normal registered buffer is long-live too, which is exactly
what the driver cares for the long-term dma mapping motivation.

> 
> > BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
> > which can maintain long-term vfio dma mapping over registered user-place aligned buffer.
> 
> Interesting, just too a glance, and it looks like what David Wei
> was thinking to add to fuse, but IIUC he gave up exactly because the
> client will need to cooperate and that could be troublesome.

Here the cooperation is minimized, maybe one shmem/hugetlb path, or memfd,
and it is one optimization and opt-in, and fallback to normal path
if application doesn't cooperate.

> 
> Should we try to push everything under the same interface instead of
> keeping a ublk specific one? Again to the point that it requires

If generic interface can be figured out, it shouldn't be a big deal for
ublk to switch to it, and the usage is simple actually.

So far, ublk supports both FS and nvme block device.

And cooperation can't be avoided for this usage no matter if generic or
driver specific implementation is taken, for both fuse & ublk.

> a cooperative client, but if it's something more generic, the user
> might just try to use it as a general optimisation. In the same way
> it'll be helpful to fuse, and as a bonus you wouldn't need tree look
> ups (but mandates clients using registered buffers as a downside).

Yeah, but tree lookup is fast enough in case of huge page for typical
application, and it is simple in concept.


Thanks,
Ming

