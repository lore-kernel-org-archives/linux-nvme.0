Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B45AC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=makDagrHRlU7vaXpIkbBqsJmR2imX/hQ0vT1IyZGbe8=; b=V5QWkEJzTrOiBMBlUGXwk1Ym1K
	xNQunC3n/kpmFbPaMBZvrD2zP+lmWSsk0COZ3sEVbXy0UsL0X+CSUuP5gEGaoLTdJ4UKiSQegW4uB
	IeuOIshepIGpXQl+LKwsjKvpl14g0anqC+nyTPwF1AK5027TM4bcaypMWjoHl1QtxWOYMdi6EDLei
	+mhsZo0qTrshc5hqYJ7OJEO1H8GBFe+3qW1Fc5HGJ4E/WsBMW2rw7Sy/R7BvPq+e6dfadV18hQXBQ
	2GylCYwqemBlQeiUFE6au8Y5qONaBGFLmBiS32GqFimxHLYdDRVkDnOZyKdJXxqsApxjoH1V1qqTx
	VGvZdH4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDS8H-002WIo-9W; Fri, 28 Jan 2022 14:21:45 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDS8E-002WFO-G5
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 14:21:43 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id k4so5932823qvt.6
 for <linux-nvme@lists.infradead.org>; Fri, 28 Jan 2022 06:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=makDagrHRlU7vaXpIkbBqsJmR2imX/hQ0vT1IyZGbe8=;
 b=hagW1D3vrAXgmIdAaPuyb0ZYpBBI5GPj5cGf4t4VMPl2Hby0LDAfvZWMHlJD4RNPqz
 udQ6uMwMCSFght7z8OXaOlANPe89fBH+JadGzhs2iy3sYKIgrM8DNT9kykuob784vNJb
 /Y/FgIYpTCK+z7cKXzoYjO1GyqMmNfC0h5hNyGY73VQ5CoPXpXPP9nyVMuQ4vWD+VQga
 0hYXfzvwCLnChzgjp4NqFihb4T9f8dI0raxoWaXnXY+5G5GDrUXCHtUcKwBORYZObA9Y
 YPaqcPq/4bzPj+zORYsBg7/S7b+i2mhRoE+TwNrxyzVcDs3wf6ttmJBlILKVUF4beVAI
 0u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=makDagrHRlU7vaXpIkbBqsJmR2imX/hQ0vT1IyZGbe8=;
 b=mtPvNrzizroh6BUfUvF9DURwnL4sMUBYVE1QoxbYnFlyxG8He+8M4wLgsWuZJtBccd
 lro2gbQXiFSJnnFC4HXfxXWHIv+fQrXpAgAfaOtuJ1mW4fmBrctJxSM8doILUbAJi32/
 z78RbfdaOs2cUDvCDGs14W+//VlFh6aOpeB6Sr+Y1wuCp2DbW2P1MKQIjAVLqc3iGoEf
 P4IJVlbVVN+g9MeU4f0OqZEQJo3zhd7xg4cA+vu+kJ5FBxearhXBu7Og4fqY1ZGvbmwo
 hKBmrZZLOfTf1ZznfAnrYuWw7nldh5dF3TXAgxQJRyb9CgWce6mzIQzvoY8si+72Opjz
 DDgA==
X-Gm-Message-State: AOAM5327UXN+wGCkUmQ2TwZJELCoKyyOa1cHJysRlTYfEJuEZa6pPm2W
 GIeNEuCkV4mKPRzT6vFQhaHarg==
X-Google-Smtp-Source: ABdhPJw4cx6/r5UFZ4KcHMvTw88cPD84uAemPNZJJIK7lCC9YLt9fXRF4PueHdJDgL+a1AuPlHcoPg==
X-Received: by 2002:a05:6214:519a:: with SMTP id
 kl26mr7027757qvb.68.1643379700472; 
 Fri, 28 Jan 2022 06:21:40 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id o4sm3070925qtw.53.2022.01.28.06.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jan 2022 06:21:39 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1nDS8A-007UXM-Bu; Fri, 28 Jan 2022 10:21:38 -0400
Date: Fri, 28 Jan 2022 10:21:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Alex Sierra <alex.sierra@amd.com>
Subject: Re: [PATCH v5 02/24] mm: remove extra ZONE_DEVICE struct page refcount
Message-ID: <20220128142138.GU8034@ziepe.ca>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128002614.6136-3-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_062142_561729_55F87CD1 
X-CRM114-Status: GOOD (  17.61  )
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

On Thu, Jan 27, 2022 at 05:25:52PM -0700, Logan Gunthorpe wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> ZONE_DEVICE struct pages have an extra reference count that complicates the
> code for put_page() and several places in the kernel that need to check the
> reference count to see that a page is not being used (gup, compaction,
> migration, etc.). Clean up the code so the reference count doesn't need to
> be treated specially for ZONE_DEVICE.
> 
> [logang: dropped no longer used section from mm.h including
>  page_is_devmap_managed, rebased on v5.17-rc1 (possibly poorly)]
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c     |  2 +-
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
>  fs/dax.c                               |  4 +-
>  include/linux/dax.h                    |  2 +-
>  include/linux/memremap.h               |  7 +--
>  include/linux/mm.h                     | 44 ----------------
>  lib/test_hmm.c                         |  2 +-
>  mm/internal.h                          |  8 +++
>  mm/memcontrol.c                        |  6 +--
>  mm/memremap.c                          | 70 +++++++-------------------
>  mm/migrate.c                           |  5 --
>  mm/page_alloc.c                        |  3 ++
>  mm/swap.c                              | 45 ++---------------
>  13 files changed, 46 insertions(+), 154 deletions(-)

This patch still can't be applied until the FSDAX issues are solved,
right? See my remarks the last time it was posted..

Jason

