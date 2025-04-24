Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819E9C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 17:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q7ZGm3rblj2kgAcpsN0EQih8yO5JOg9TsIGPUfiFTgs=; b=r78pJHYAJgRUMepEVhUL8ILX7u
	a29r3wOMgIeDv4UyslQ/pTfAX3g6fSFA6yZKpT20ui0qMB433hAgWjreV7ms9LEhn1FfGKQmlwMPg
	91uyDMO1BBRfSsqwqu0DvbifyEhhYj6jclmkwOSsd3RCpM20MhHGvCo5DtsSesrbS5eUPh8gIlNHK
	JXQHuAF7GV8HfmHR1YhGVvSzffuWcPEDQln4FAslEXGXt8U7xe/2NNwIeIV/yVP673E7GyS687au7
	8nwVrgly3JT2413nYwV86c3/W5iUEFo4u6A2Q0ryOqrlBxJW+7BleHJwSq//2nbxMPVf+BxJGtCte
	Lj+skokw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u80HI-0000000EsoQ-2cdb;
	Thu, 24 Apr 2025 17:22:24 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ymU-0000000EX9D-1mU0
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 15:46:31 +0000
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-3087a70557bso214988a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 24 Apr 2025 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745509589; x=1746114389; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7ZGm3rblj2kgAcpsN0EQih8yO5JOg9TsIGPUfiFTgs=;
        b=d9gTGnigFpIFV6Jt+erXG9c+IeL3F9z2NG9egLTrSoX6ErZM+bDbVkhsedMCI/ZF6U
         6lAw7EX4gzv5oEuPzc116JH+WUqIlexTQHUocRbSNUccFT2Gx5Z7XxTABU5GjCTm/KHG
         93/GJbDKn8mNQJf/mCF4xG1dvxZWlcBtfZYMRWIaX2ZxpjYTXuTOWFIeLQ1TJZRv5Irm
         /zJPiqrMTKeMLKqCpqKGmvme54sq8otyxLdnvFgdGgneYUEOYXIkg3QZ4w73h0IbWV94
         ppPiCDzGIZpdPkvxwgx8ExTe3r6M7XHK8e1+5nKzFtI9Q576US10i1Mhcz56KlkQByz1
         FWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509589; x=1746114389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7ZGm3rblj2kgAcpsN0EQih8yO5JOg9TsIGPUfiFTgs=;
        b=Deh0ub2wb7EwlnYYpkQrbm51rX4vpyRSZj5mGSXPLY16WdptEmYsRGruyl9iwED72I
         XKY22SOfu4QzELACzqUYFGnt0S3m/Ff09kYvDi4Z75jCgfsUYT55kDzWBGHBDqsISvE/
         52u/AdJWS/RkG8yUuf8s9nc9zKDM0rP8H/hUNxTpOp1DKqScJQ67b+80rHELt8wyD0ku
         LvlbGEuTOGsOUpGn2Kwos8OM5IS6V1DEIeefoHw8uvF5WSzESrkymppTKsITvFj1/wln
         yOj9ryxoJZv3H6SB3UZx2F5C0x9gXjGhu7vK1tGjJOcAuvJTfAJYwpdYjNpKDVcuA5g3
         5Jaw==
X-Forwarded-Encrypted: i=1; AJvYcCWGPm4j/thgvlMSEVnF29PbV8Wzg3DCKu8GImmIOk4fP0y7AlKu6UKkKpeuwNdpaPv2xeyyuLYu1o46@lists.infradead.org
X-Gm-Message-State: AOJu0Yw9h3DFD/v7XN6kt/8wfyRZgrI1zSv7SvCkjbE4+wX1TJrw7G3S
	/CZ21/huKaZEJlPy8R83HkHxfg07LNLNR1r4EAB0bGiUFtVXW+aaZWufeMuX4H1QJkJg1kazb8K
	lb+UmTsuylafkC9/oXTrQWV+1b1vwMR9QTc0dvg==
X-Gm-Gg: ASbGncukjuXkTnwxjsM/xEPS9wiTKjfVXOrqXjhqjP4+GPzMzOyOd6eIU84BzJt/caM
	iOoq9zVpaByUiB+nMFvioAJr+GK1k2TMj84nwh0h+8oJ4RvuvALZSFH2ZreRgKMYcjQTXeC2QBx
	CU6BOoLmXhaWkLqXxCHmbi
X-Google-Smtp-Source: AGHT+IHNf2GMNeqL16Klsm77Qm5cAQu6Mvza6m/E48PAkzIQkLWGytFSKzo4VUqKfp8jikfzSzd9uZhcyM0JdWSseY0=
X-Received: by 2002:a17:90b:3906:b0:2ff:5759:549a with SMTP id
 98e67ed59e1d1-309ed24cc88mr1987895a91.1.1745509589025; Thu, 24 Apr 2025
 08:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250422220952.2111584-1-csander@purestorage.com>
 <20250422220952.2111584-4-csander@purestorage.com> <20250424141249.GA18970@lst.de>
 <aApbYhyeYcCifoYI@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <aApbYhyeYcCifoYI@kbusch-mbp.dhcp.thefacebook.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 24 Apr 2025 08:46:16 -0700
X-Gm-Features: ATxdqUHCi4C_REHlKrLnX5wREYYxsmbvpIQODsvqs0AotMM04vU2aN13a--TT-4
Message-ID: <CADUfDZqA0v-i1=TSkW6HkUNdN-_954Kq0hJS4H4cgbPb5o9EgA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] nvme/pci: make PRP list DMA pools per-NUMA-node
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Andrew Morton <akpm@linux-foundation.org>, Kanchan Joshi <joshi.k@samsung.com>, 
	linux-nvme@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_084630_500741_EE27AA10 
X-CRM114-Status: GOOD (  22.96  )
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

On Thu, Apr 24, 2025 at 8:40=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, Apr 24, 2025 at 04:12:49PM +0200, Christoph Hellwig wrote:
> > On Tue, Apr 22, 2025 at 04:09:52PM -0600, Caleb Sander Mateos wrote:
> > > NVMe commands with more than 4 KB of data allocate PRP list pages fro=
m
> > > the per-nvme_device dma_pool prp_page_pool or prp_small_pool.
> >
> > That's not actually true.  We can transfer all of the MDTS without a
> > single pool allocation when using SGLs.
>
> Let's just change it to say discontiguous data, then.
>
> Though even wtih PRP's, you could transfer up to 8k without allocating a
> list, if its address is 4k aligned.

Right, it depends on the alignment of the data pages. Christoph is
correct that commands using SGLs don't need to allocate PRP list
pages, however not all NVMe controllers support SGLs for data
transfers.

>
> > > Each call
> > > to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlo=
ck.
> > > These device-global spinlocks are a significant source of contention
> > > when many CPUs are submitting to the same NVMe devices. On a workload
> > > issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA no=
des
> > > to 23 NVMe devices, we observed 2.4% of CPU time spent in
> > > _raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.
> > >
> > > Ideally, the dma_pools would be per-hctx to minimize
> > > contention. But that could impose considerable resource costs in a
> > > system with many NVMe devices and CPUs.
> >
> > Should we try to simply do a slab allocation first and only allocate
> > from the dmapool when that fails?  That should give you all the
> > scalability from the slab allocator without very little downsides.
>
> The dmapool allocates dma coherent memory, and it's mapped for the
> remainder of lifetime of the pool. Allocating slab memory and dma
> mapping per-io would be pretty costly in comparison, I think.

I'm not very familiar with the DMA subsystem, but this was my impression to=
o.

Thanks,
Caleb

