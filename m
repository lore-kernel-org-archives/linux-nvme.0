Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD02AC369CB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 02:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/H5CAwHQKAGhhgyjSbvaHcVayhHkcFdusJoJuYFxH8=; b=pj0TQ937djBJiogJMQC0KeIu9g
	FBCaQGrDGh75UUiNB180KSuAqzHI4zTpkSow5nlULO6nirSvrw0jf3NOM2Q6XnvrMy0/umDnSlmZA
	G+nuaWfftCU0J3VOW37XR10BBUlE0LxSueE6DnCt6HBvBLzfTi6b35FdzsVjjjHAAro/9gPaEnGP3
	Bx3qxOPMVV9xNRPS+Vy6y7eUt8IikuyfPATyZwxQ7sJZpybrwARxPdAB661EIwCoWJXUZ1FdnuqCU
	Fjq4/KoFnAbeLk6fI8hjaGcTXJvt56JGby+zUYL8O6cwlij3jhHLF/kSVDOzSqAm0vrjkwGaDtAkU
	eNElaVmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7mmy-0000000Cf64-4068;
	Thu, 24 Apr 2025 02:58:12 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7eQP-0000000BTAK-2GiX
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 18:02:23 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-6eeb7589db4so2217676d6.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 11:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745431340; x=1746036140; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v/H5CAwHQKAGhhgyjSbvaHcVayhHkcFdusJoJuYFxH8=;
        b=owCUDNbqqia6yjWAbHdi7QRO6Gvnmrlb/vyvX2k1000FdCb9gmwyo5ZTbo/3jBU3mg
         Cj9VPAcpnnRrtjkctwL2d3O423OAa2vFAP2kZNlxTke66TTRw9KV8x5j+KPl4AoWWaCS
         +C22gCSu9IieBaVhpUza1MUT21tvgEWfKVX6AZu7eynIGvt2g7wl52eHBYkeHRgozJO7
         eShkR7yYNBAEKJti0qrWM4FMz0ji9ab4Qq5RedsbtaOvcw9xB05DEuGXHYYHKHh5UdjE
         xDNt/W69QYKz3O2Wa9CayQQFmbrLaTcZ42TxO8BSiqlqoW+L8KoEpiDA+shUTWWvvHK6
         haJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745431340; x=1746036140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/H5CAwHQKAGhhgyjSbvaHcVayhHkcFdusJoJuYFxH8=;
        b=gx5SMjgN7s+V/oShUFpZe75tzeQZkH1CpLaxTKs1MBhrJwUIfo0cNdocB8gpxcna95
         zK9/Qa/iB7B79+a3TjRzNIrJYMI2G3uhatr0EsV4RScGaqDFC2WCoR0cod2719oMAbWL
         roFjfTbqoakZwrWRD3Nldm8rgVUEfcl/42dDH4weQdA/W5K3aza7FiVGrQrj7+qy93D7
         OufWf/1GOp9Do1/NKUbAMawz0D2M5NI2/0xnMyeplltmGQ2h60PZAF4BYnyiLLG53M69
         VO16qM3nQL/QIFC6BHGi6mQA6ozdPPDsxAML1NlTOegf6Q00vWHXtSr3ZpHKz23RX2dy
         tvdw==
X-Forwarded-Encrypted: i=1; AJvYcCUrIssiMp4V/waxRFM2Xd34feGE4StMnqwh5GEW1XqS10P9fSszO3SwAjA2DOsSPhYmv9NoUnEwMtg/@lists.infradead.org
X-Gm-Message-State: AOJu0YwfeHyFyT6NKoJRTBHR0Vc+Bbx5scNuE+PSwn5prO+qYX3NZcFm
	9vtT/THwWGc0vSISFwtqblRJHNQSfYqiqOJRLAip+oIVwINf82aeBzYOjGCe7h4=
X-Gm-Gg: ASbGncv6zyDR8cNDMPwAOSPIGvAnJMx4k2zz7AejZ/aJ0B1Mhvvq4LeZF7ZOOok2W1r
	xx0jm46tesoXPjXHr1N1XnVrVFd2EXT6eobzRPeWRHPeuOno1wTSUGoGpYxOBwLF5lkHcPl0IJQ
	L7R9aPcwKEUdYDzTE3OD83DFVdgL3doToqFgHoT52gKKbFh5DuqHYSW9WalYnOMJ8JgsnK7zOxW
	3gRwEBxRd6EZ1RFt2QU+v/mqgx7kBAks4ZG/CryQsFfYu2qewT1t6nEOrnqTuthMFnwI1MlCgos
	+R0U2ac78wqAHlOLKHy6Z5wc/XfN+j5emQBK0Aan1SSVmN9HdGsmo/xPBcy4iGG6eNFlzq+54FN
	UK1Z3mq5RzwlO48quSsc=
X-Google-Smtp-Source: AGHT+IHxXzsMEe6MN5UQygppndiI4ddaFnTKWUy8FtozhFzNSVoZsB8f3DMDl3MfRyMHEIrbMun+Mw==
X-Received: by 2002:a05:6214:19c8:b0:6ee:ba58:e099 with SMTP id 6a1803df08f44-6f2c454e522mr330593466d6.15.1745431340219;
        Wed, 23 Apr 2025 11:02:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c3ba3fsm73300796d6.125.2025.04.23.11.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 11:02:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7eQN-00000007LrM-0sGN;
	Wed, 23 Apr 2025 15:02:19 -0300
Date: Wed, 23 Apr 2025 15:02:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v9 16/24] vfio/mlx5: Rewrite create mkey flow to allow
 better code reuse
Message-ID: <20250423180219.GR1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <eefe5ad450fd434dff981963ec3c61df7b3734e1.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eefe5ad450fd434dff981963ec3c61df7b3734e1.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_110221_584194_C5CD1C54 
X-CRM114-Status: GOOD (  17.36  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 19:58:12 -0700
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

On Wed, Apr 23, 2025 at 11:13:07AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Change the creation of mkey to be performed in multiple steps:
> data allocation, DMA setup and actual call to HW to create that mkey.
> 
> In this new flow, the whole input to MKEY command is saved to eliminate
> the need to keep array of pointers for DMA addresses for receive list
> and in the future patches for send list too.
> 
> In addition to memory size reduce and elimination of unnecessary data
> movements to set MKEY input, the code is prepared for future reuse.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/vfio/pci/mlx5/cmd.c | 157 ++++++++++++++++++++----------------
>  drivers/vfio/pci/mlx5/cmd.h |   4 +-
>  2 files changed, 91 insertions(+), 70 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

