Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ECEC369D5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=; b=GvHKIbtQWn4ba0+97cLadTKGFw
	qHH4r8Jo0vl3h0Tj288adsEDaG34vkHjRKb41PjJn1IxJ7ev8qfDY3/0beyNwRHDdp7a0WmOQGJ/Q
	lyf+eDvFSYEPFzWVhSRlxwm+Db5mBn4PFlsy5X5miW3peQS8v1zsILSPGh8vB0OaBBv/JsndSOOZI
	RyI2+4+BmDjpRr4yrmeTd2MOIeFKg8yh0hySegYQXqCZIkwTuqA0ZIDKjeWgHozeIXPBsr8SMg61i
	+GBHSEcnIjk4mVeZwm0CSvjREi/ntaUdANeIWA4vfxwGwSeG4d8/JR8EzlEPokh7zTorkC/YaCkDr
	ZBZsTz0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ezf-0000000BbWZ-0KBu;
	Wed, 23 Apr 2025 18:38:47 +0000
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7dhU-0000000BEZn-0dKr
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 17:15:57 +0000
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-7c58974ed57so4742885a.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745428555; x=1746033355; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=D/13aUzjSg2NJ0PjoPLt1Tg/MWpuO8P45dh+nnXFbgug5JI1osThm0DNuHl5Fdsvc2
         EUkWTgLL1cnA4I1tBC2tyWOsqnPiEnrNEfcj1yhh/R0zVcZfwhQ0e16v5aCfxyS+7N2e
         hfgJK2JCj1Z2Jq0ycJvNC9g0i362uuXfQCAiES7Apr8DeZNmRef13XrwjZEFpoT4wpuE
         imPEEGE7Y47RV1D11hvTRaBYraN5/lcaMC16eFVYLTUhSFfntgLSZewNhBRh3R4x+9N0
         Wngr2WkgknMf5ii7uRpMsSGpg+5PKlP4+/nFHAE/TGXoxkXtwnGTgUaaTxuuUzdl5LTB
         vfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428555; x=1746033355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5HpTnu16aeUYpErbp5yUwht+j3Mgf+r7FFUrUseQ0w=;
        b=WpGDuPgskP7hhFZjacZDjYk0ZvbL7/emyxwL0NWHb5kcp69Bffesz1fBq9lUBCZZfM
         up2BXh1VqbbiZZb6qB08/2KrSYG2hA3IJJS8StiR10+hrE1CClzKF13Q2Uwsk6Xd2y6+
         0HGsrx4UCqqVM6IW9aUdMfhOhr+5DIyvtNBI2tjemSw1YcsW/y+hjJXpDyz3CTr89EEJ
         e5tD9tCsR84H1lVBPSQTMoJAN15ea9LLBS51Noa1mWFDktHobdGksh6yKdGV/f5CFZaa
         e6ZHp92rdQ3UyP+wdUcmfVPTJoH51MFoXxWDaiC/uwoNGQZZFiKAFdnREdpabbJoQnsw
         3cKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdzUxWY7+JXhxSYKlkKeofeBjjNN/gOKCV/2KwhSK0S6MGcGKP16zdubQZhrBLZa3LVmdxqtOvfJQ/@lists.infradead.org
X-Gm-Message-State: AOJu0YzNkwqyYiGee7Ef+ujwq3xje+i4Z36pKg3XRBpHvr3TkVih3kW1
	6eVidJjawvEZHZxFtLotMQ9Hvvm0P42ufa0LHzL5pIIJotmStrkzo2dMYy/rUng=
X-Gm-Gg: ASbGncsvFOnuMrt109RevHgjtborxcYrwZ/sMfG2iH0R6A/w7D6nzSpvxX5EbZrgHyn
	CZoEWuJq/5kb8kiwvNFa7jywxQAAShxRlUxhfKAzf+aJm+qIBWTL/Rb9cm3/JN1nqm+yEVkSH/E
	HqTGIFJbCJvdkbkaVM2WMj+XBlsPwLiJesGRbSKjAt+K4Fwv8HGUTslcJtcpLf4V6r1ftT+dSLV
	JkKCByXd53KwGEAr7z3s7p3CUzZIsSIR3Ge9zMcnKCbd6Sx64i90bqnbZXCXMXif5Fu1oiKiAlJ
	0XjMu0QGMhKgcyldYAYBseaKc1Issdb8xivFWjG6i9UlYihYakVrd1PaID7jG++c1kCXp1SqRi4
	dHv8B9JdjC67+IAd8b3w=
X-Google-Smtp-Source: AGHT+IHusnUQ6QwwVsDnvg+0qYOM6lcQLPltCEX7WmRgNJP3vwJodfip7PxZnn5pgy7BG5cQ6pnE/Q==
X-Received: by 2002:a05:620a:4456:b0:7c7:a5e1:f204 with SMTP id af79cd13be357-7c955e14768mr54555485a.56.1745428554903;
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b4e93asm705867885a.70.2025.04.23.10.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:15:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dhR-00000007LQy-3kud;
	Wed, 23 Apr 2025 14:15:53 -0300
Date: Wed, 23 Apr 2025 14:15:53 -0300
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
Subject: Re: [PATCH v9 04/24] iommu: add kernel-doc for iommu_unmap_fast
Message-ID: <20250423171553.GK1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9becc0989ed0a6770e4e320580d1152b716acd0d.1745394536.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_101556_190535_69A3320A 
X-CRM114-Status: GOOD (  12.75  )
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

On Wed, Apr 23, 2025 at 11:12:55AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Add kernel-doc section for iommu_unmap_fast to document existing
> limitation of underlying functions which can't split individual ranges.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Will Deacon <will@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

