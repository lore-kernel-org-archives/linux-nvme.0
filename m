Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5679C3ABB2
	for <linux-nvme@archiver.kernel.org>; Fri,  2 May 2025 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FGKG+bqqtU1mFVGRnDFZ9YvbYaqYm4zslqMRs/wrJK4=; b=svhsZXzAwnmCsffEOQ866vy6Kt
	cVXvhO7fkXJNbJLx+Pd8CM5QfoLdpmW1YyEVMNsws+c6owEnsaBa+aOgK3elR+WCQQLrrjk4crCgI
	m9USUDE1OjDC6aE6f2/97ZRCYxyfpjVKyQecPKyfWfL2Lx3l4H+I8zuSSwGpy1gTZJJiJ2QEwTV3c
	xB097sjKkUTM5rzhmI/NMuU6C4SVVQw2n3ey/xhwzyu9VGirByF92tH/FVOP5v00bkEuoU46Tpy4Z
	kB6zlRCGzqDWkv6th3aEE5bQEzDl95saB+hw11huOzNv7TPGU4xIbvISLDrjV76JroHhbeLWLqNkP
	pSmjOMFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAu6Q-00000002e0w-2OP8;
	Fri, 02 May 2025 17:23:10 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAtYs-00000002ZHn-1qCX
	for linux-nvme@lists.infradead.org;
	Fri, 02 May 2025 16:48:31 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-af51b57ea41so286672a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 02 May 2025 09:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1746204509; x=1746809309; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FGKG+bqqtU1mFVGRnDFZ9YvbYaqYm4zslqMRs/wrJK4=;
        b=c0qA82h6GbD9f05WKYm+DIcKhmkv87r8SuiaZ90t3U3zkjmzY+8OrSI3/isGsdibzS
         jM/V9XaogiLNWlXfJe0TNRKo53pS7JeL4574V/mGZ//aG1wWpIvgUrojUiJD8hqE2wfv
         rScdeQKGchkpsGSKRDnRQBfG5MyZOyrOxsqRq+lIcjFOB1dqp9Sq27tKACd0En+WuYE2
         oq09XiC3hn0TXUnOpmKkQfNQ3XQuNWsIgum97T5MBZsdlviUqoKBmCClfN4h8mkyXX7v
         Ll7P5hlIJuXFDT+vnT3N1ur75VbILpEGZYQUClS3dsmkxK+VGEBL2z3ChybLXEF8bhpC
         dewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746204509; x=1746809309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FGKG+bqqtU1mFVGRnDFZ9YvbYaqYm4zslqMRs/wrJK4=;
        b=r+QEJ89CgvRw1hAsa5o2VkzjoA1u4M6vSIa69I4Jxu4uAkMNHxLsjHFWTOYtn1xCRh
         Ah0SKNnoCMs2DWh6cLajNdVflevOen9WRAAD5d+Yyn4sbojhZ5HMZwqZjKqToCqOKtlX
         z/iHhE2fYjHWzfFK08tK+K/dUv24Wg+7niYlFsYy9351CP3AopzobWPbYpd8zPXfq80L
         5tCrk2j0/Qh6l2foIzOquDHO7+TCBx32ygsUQ/01XBqjx31LmOD88x3j6e64O1NgnXV0
         jC5WMinAvKVkeWMRSenr0oY0wdCvr2czGIGt4/4YmcK7l7wlIQSLwuT4xwQhhAo6pStx
         JNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSm0k1S4/FTHDdnWzunODR4Y+AuOBZ4UtGNxBbTyh3jinuQS8TATe3bGfztxksCWG7U2XPTCBA9sqb@lists.infradead.org
X-Gm-Message-State: AOJu0YyQl25iMFQ7DihVZcVMpiiCAOW6f0uVF6L5VrHA/kzcvt9P0PEY
	I3zQhP4kFIPY/yV+kc7zJGHWh2TmN2fXFR1pJC08S87AO19Nz6qENdn/KliXGhm59l40tMizTrS
	OAQ9VjtTrYvsMKC0uDOOIXONQ06CKw+pWyvzFUw==
X-Gm-Gg: ASbGncva0DoZNeeSUb0H51g4c8xtVcPhKnLUdCqvy84IrW7yI8r6Q0MvuUGhIUZPmoJ
	R6lJBUYb6uKZ/zp6FkNbY70beYRhRaRyeygiVDbufDTZTJrdRuCYQxOLJVrCIihSeRV+SbNg885
	zHXOgeKsfzFMuM1GXHwjDl
X-Google-Smtp-Source: AGHT+IEELL9u72c1Fg2kejI58mub1eHMZr6Gpc7Bc6hBIFC204l0EKzL5sGiaFODbZX/MTt3DAVSgDpVZmluKrqjuK4=
X-Received: by 2002:a17:90b:38c3:b0:305:5f31:6c63 with SMTP id
 98e67ed59e1d1-30a4e6f7e74mr2199297a91.6.1746204509624; Fri, 02 May 2025
 09:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250426020636.34355-1-csander@purestorage.com>
In-Reply-To: <20250426020636.34355-1-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 2 May 2025 09:48:17 -0700
X-Gm-Features: ATxdqUHt_RY6WlfG-cFs204ON7jneR73r_rcAj43sEs6pcYPHQ6F77sRjndgWok
Message-ID: <CADUfDZr=OWv-bt+rzNQZ7zii9JyNxmkYCJxXCiCNsoHhT5UcYw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] nvme/pci: PRP list DMA pool partitioning
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250502_094830_514586_159FAC01 
X-CRM114-Status: GOOD (  21.78  )
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

Hi all,
It seems like there is consensus on this series and all patches have
multiple reviews. Would it be possible to queue it up for 6.16? The
NVMe tree seems like it would make sense, though maybe the dmapool
patch needs to go through the mm tree?

Thanks,
Caleb

On Fri, Apr 25, 2025 at 7:07=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> NVMe commands with over 8 KB of discontiguous data allocate PRP list
> pages from the per-nvme_device dma_pool prp_page_pool or prp_small_pool.
> Each call to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool
> spinlock. These device-global spinlocks are a significant source of
> contention when many CPUs are submitting to the same NVMe devices. On a
> workload issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2
> NUMA nodes to 23 NVMe devices, we observed 2.4% of CPU time spent in
> _raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.
>
> Ideally, the dma_pools would be per-hctx to minimize contention. But
> that could impose considerable resource costs in a system with many NVMe
> devices and CPUs.
>
> As a compromise, allocate per-NUMA-node PRP list DMA pools. Map each
> nvme_queue to the set of DMA pools corresponding to its device and its
> hctx's NUMA node. This reduces the _raw_spin_lock_irqsave overhead by
> about half, to 1.2%. Preventing the sharing of PRP list pages across
> NUMA nodes also makes them cheaper to initialize.
>
> Allocating the dmapool structs on the desired NUMA node further reduces
> the time spent in dma_pool_alloc from 0.87% to 0.50%.
>
> Caleb Sander Mateos (2):
>   nvme/pci: factor out nvme_init_hctx() helper
>   nvme/pci: make PRP list DMA pools per-NUMA-node
>
> Keith Busch (1):
>   dmapool: add NUMA affinity support
>
>  drivers/nvme/host/pci.c | 171 +++++++++++++++++++++++-----------------
>  include/linux/dmapool.h |  17 +++-
>  mm/dmapool.c            |  16 ++--
>  3 files changed, 121 insertions(+), 83 deletions(-)
>
> v6:
> - Clarify description of when PRP list pages are allocated (Christoph)
> - Add Reviewed-by tags
>
> v5:
> - Allocate dmapool structs on desired NUMA node (Keith)
> - Add Reviewed-by tags
>
> v4:
> - Drop the numa_node < nr_node_ids check (Kanchan)
> - Add Reviewed-by tags
>
> v3: simplify nvme_release_prp_pools() (Keith)
>
> v2:
> - Initialize admin nvme_queue's nvme_prp_dma_pools (Kanchan)
> - Shrink nvme_dev's prp_pools array from MAX_NUMNODES to nr_node_ids (Kan=
chan)
>
> --
> 2.45.2
>

