Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97588C369DE
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=; b=uKUEgmV2IEBVbY5iDwizeU6xF4
	QJVfhjcC19M/Yn9xjDwgDdV0wi5z65gicpKDB76Q+u0byTUZQrH7T+v7P8dxhc9iJ6DBodpx45oYo
	BE87LHH2275l1MV4DeAE9puKir+gtRuQfkNei6HZXJg0AoUR7Qm/t3NjF7uC+VrBQNXjwhOXjocpu
	8ep5LiCZcUpdWMofIb4LvSiobZa6tSYCr9fFFZerSoHeUj1+2LcD1hbwiHFTBaEEyM2VYN6Hpyvu4
	lcuMvF81Gg2MegF9PupEUKc4kA3tzEYgGtokCz785cO4bltPATWutuT/ObNOSjlTV9SvwhGa0K0wr
	V5ZoWZGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ezf-0000000BbXV-3VU9;
	Wed, 23 Apr 2025 18:38:47 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7dis-0000000BF06-2ZD5
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:17:23 +0000
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4766631a6a4so837451cf.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428641; x=1746033441; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=jZl9PT0g/HlSfwE+YMAatzROU+37fgdgezNvCLwG9eW7VX86CczdFNAHMm1r8nSDIo
         d7VoZsyUY4+Z9w0YiE4NI6WpjLv9ESbL7tdwFPpcemMlneKQ8C601Eqk4CxBjZgnzpao
         QVHLg6thdW+T9Rzfp/ZSblTcFC2Qb0kbjZIJlOYKfT/8XZS00me1qQaQ6RVm9NnXZPvw
         nEmY823l+6rDaGPhduN0vDpgDv9jaegO9PcQMFRIPO1gIg1NOqlVVeB7pVtqbQ2VNsL7
         cZBfYF+xmyjwbeWd0ET098328+M6/rgJff9V80q5UtW0qblsBnPgUceGHIrYtH8mm9ct
         aoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428641; x=1746033441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFsItIzcNoABKT1tTnR+L3KluEl/QW6UiWkd3yuS4gc=;
        b=KCw+1c1X347aFsQ4TFBbhYaWafx822yfGgqvP7883+RaGv3uU8HI8sI3zmPA9X2y24
         OUugWwUK/xX4eETO2Rp4HyewT17MpBvmhehkyKXrGZAlnm7/RYbqDxxPv2d24iinkM6G
         LATT2rxqLm9sXC6/oJQRb6SHvv1Er9Lihy+ygjsW5AsOQKbSXheH5Xj0HeYg4WXOyOmH
         aXVIkMQLDMRezwmJ2cmgU9r9BgsPM3RfhepNtnaetu8Jl2U/fu6YWhRHpZWMWxwW7ZRF
         alqECeKIPIRdqQt+lPbHFHOnXp0wRVlSbbefIgkAhVwl5kydctAxve5k5mtri8u3Lgx8
         IkGw==
X-Forwarded-Encrypted: i=1; AJvYcCUsfWueNJncaTN/4sW5T4JMxDFp9fKiwka2JMQeRjPR39nb7ufLUJspnm661cNG4lUVqa9LnJhektzV@lists.infradead.org
X-Gm-Message-State: AOJu0YwsFKM1pIZn3QN71JY8/F3IE+quKABoOoDPilRtnZSJ/tjKIb9O
	ej4DVs0JjRc19TG6TtotYRSsomEHIMDyqE18v4ZQ2jPZOffWbim5NddknUwom5Q=
X-Gm-Gg: ASbGncsvf6ZJmxdYCJEEjc81McS3Qi8EjhIltzvTv5Mx+KwF5DCobgzl7EVbQhEqs0l
	poIVWq6PvVpESiFBLwVmwrjbCJVDwBoQhsbBXQpC/vyDLeuFZetIDNFmMpoL0tVEqXw1uyoB4a8
	MUrS2ptreG5RAYzZAwy4FZGwfZeNTOqrtGD0nJYj2xzRQayhR2OpVZpSEsC0UORuahYYNCs4Y5z
	VIMiHC9PthCxUo/MxicvK9Bsnp3XexuVeZV1HUZhnZ1Wjoo2V4IzpgJlav/e3CBC0f6gjCrKcJU
	+ymaWdhkesXI9zYJGv7MJJ6THO3k8LVNYN+wVg1NzfM6kUCdxUJAKAXCcFrWXz/i9nvRsZ6GfRg
	4D/gf9fYcm3A7tK76WAc=
X-Google-Smtp-Source: AGHT+IFtKlYmuMPWfMKQK8kh2VV5wwxeBA4j6ePEQHIEvAPMlC2NtpfOcLZrcYI7RZQRiXVuJwSHAw==
X-Received: by 2002:ac8:7f51:0:b0:476:838c:b0ce with SMTP id d75a77b69052e-47e7607d5ddmr844071cf.13.1745428641397;
        Wed, 23 Apr 2025 10:17:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f29sm70808611cf.71.2025.04.23.10.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:17:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7diq-00000007LSZ-1iS9;
	Wed, 23 Apr 2025 14:17:20 -0300
Date: Wed, 23 Apr 2025 14:17:20 -0300
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
Subject: Re: [PATCH v9 10/24] mm/hmm: let users to tag specific PFN with DMA
 mapped bit
Message-ID: <20250423171720.GL1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7c1e06269eee12ff8912fe0da4b7692081fcde.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_101722_650024_AD6E2F7F 
X-CRM114-Status: GOOD (  12.89  )
X-Mailman-Approved-At: Wed, 23 Apr 2025 11:34:49 -0700
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

On Wed, Apr 23, 2025 at 11:13:01AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Introduce new sticky flag (HMM_PFN_DMA_MAPPED), which isn't overwritten
> by HMM range fault. Such flag allows users to tag specific PFNs with
> information if this specific PFN was already DMA mapped.
> 
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  include/linux/hmm.h | 17 +++++++++++++++
>  mm/hmm.c            | 51 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 49 insertions(+), 19 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This would be part of the RDMA bits

Jason

