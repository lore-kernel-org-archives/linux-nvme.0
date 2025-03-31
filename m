Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C16C3600B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 19:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dt32gY7PII308zLmCJyd2JbPBk7pRfyqNOcGW9IblNM=; b=EeAyyEgnY4+YFXbl/hiJcwurEB
	WeSBZzswlld14XJ2d9I1LCbj4ZotiW3+Lw1Z+mCHxs1lwHkC/ksQFhiRUYNu06ZvFiMBM2Yt8WEQc
	bnbzGSpSrmEgrG4tmpUzUfAxneQ9rspgmDZXLKFlvPYPL1aAg5iWAsE2bZqCJn/n4ybw1PED3AKHp
	d9wMiuTuBlaSh47lChVm4MCtyldANz2M2wltDrnv/mUAnbxX/E98zBC0XNoON3cijGlk5r3uXL2gv
	/TF2pMKs97/soLQkVQz7hVHqyUD6FYw+iggNoaqMv3WFMWxTCfifzf9XoM7Wo70fQAxggJwiYNzny
	o0mL79BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzKjQ-00000001E13-37E5;
	Mon, 31 Mar 2025 19:23:36 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzKX6-00000001CX0-3uVY
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 19:10:54 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso72454796d6.0
        for <linux-nvme@lists.infradead.org>; Mon, 31 Mar 2025 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743448251; x=1744053051; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt32gY7PII308zLmCJyd2JbPBk7pRfyqNOcGW9IblNM=;
        b=ctLG+IOz9W8XUVSgc6aeAi5zVAOIWiMPkdhFMuiS0INiaIRgyEU9F3pRQTe4E07AfJ
         a3SePlGzn4nir739a4+b9VqIzpyAUpjVNp1z9zSlkloWYdRqZ11XeKtRcZnK/gKDuiAd
         OSd7o9H5hEYGfi7f/pwbCs7xu+40Kn2HRYumBT6hzjRuwQUCdkP2thRTBhMGhlVVrJbb
         zMoDQSiRLhEok0/JmeCO25gybmff/zE+dWNYse9BQsuOm1pXeoE9FmPHzK/n279yhDPi
         1est1/SOp4NOoGNXbAC2ehO0pmPru4NWPSBM8G7Z7RQkqr+8lNaT7deIwyTFepmRBQLO
         pIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743448251; x=1744053051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dt32gY7PII308zLmCJyd2JbPBk7pRfyqNOcGW9IblNM=;
        b=fHTRVSws9j8VoBY2Wnae4rv5SoYNgzLKqRikf0bqw5Od34tJa7SQNv/NNaylGe5bAZ
         eJPINOj0OG8KjkbEG6V7ZeBKvW5Fi90102Ak0tHbzyggDu1XaF8o+o08dg+tlrxXbda+
         tp3WxYYZtBzAOnaSs+herM1fiT2LWGaBPWVE/bOHlN8AHKp++HYD+E9Zx9DDeaHkycZ8
         12oqPHisDp7N4CDtMmjJUaG2G6aX6E+/5wLuH81xdJMe++Rj4rQSslF4KgTX2l+8yo4e
         19+OxeUmmWVPHdGrZhq0035IZUukd0wCfsnXlfsHjOoJrF9Bte2BMjh1KljBR4S0IHmT
         7WXA==
X-Forwarded-Encrypted: i=1; AJvYcCX5MPAk39cwCAkM3PxKyxzC1LHRJQc/hUnYKe2cAsc/JBZab5FqcdMACb7pbZl/XcgjNu5jK+2aEUQb@lists.infradead.org
X-Gm-Message-State: AOJu0YwOj+uwgCgCQ/GoLxXlJeDHfD7HINadZdaedFJ97r7CcUXAmV7p
	jOQRnDH6pdBLQHElgwKU7SDzKD+dvWaZQDylwdzoYRy2g9yMfjflC64qhrWSqWw=
X-Gm-Gg: ASbGncv7fROjYmGzSK0tkp50w+N0G0WZL8KfDSP415EQpxEaHdynZJNWvj2rsoLzbQZ
	hAFhEhLTDMpUVF6+hG3zITkNXlGPH9wE/zWAIgXG5NJPIkJ+qIbtU4vpGpX7nU52T+LvpltNWgk
	h9fXFtWp1xcSAMnzEvrgLxwyk1uRHG7Xvp1sLoK09V/qdtUYtO38JLaemWd6GZPTtn1rTHnHNdt
	IRimhBzSPaYF2Is2xNv+ghwasgWh+CcHnVcuFdHTRYFxTOaTs+Rm+gVQKUq+w7IAvrQcOc9E5Hq
	Qo41EelhGwGLlzqWI6AT7yNt77maFuFK/mmdHk9aMJsc02EQyP0fyhFdBU4YmLxupJcFB8dhm+y
	ys2farl+gT0657fvEkSgqH+A=
X-Google-Smtp-Source: AGHT+IEZHkY9cceG9Xv7rEu7PB72dn7pTp6BwVJLHoJ1MHilW0TdQewa+AGCIOjjtFFGEUJX/PJSGA==
X-Received: by 2002:a05:6214:19cd:b0:6df:99f7:a616 with SMTP id 6a1803df08f44-6eed5f4e587mr150303596d6.2.1743448250916;
        Mon, 31 Mar 2025 12:10:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9797136sm49986056d6.103.2025.03.31.12.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 12:10:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzKX3-00000001EjT-33eb;
	Mon, 31 Mar 2025 16:10:49 -0300
Date: Mon, 31 Mar 2025 16:10:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 00/17] Provide a new two step DMA mapping API
Message-ID: <20250331191049.GB186258@ziepe.ca>
References: <20250220124827.GR53094@unreal>
 <CGME20250228195423eucas1p221736d964e9aeb1b055d3ee93a4d2648@eucas1p2.samsung.com>
 <1166a5f5-23cc-4cce-ba40-5e10ad2606de@arm.com>
 <d408b1c7-eabf-4a1e-861c-b2ddf8bf9f0e@samsung.com>
 <20250312193249.GI1322339@unreal>
 <adb63b87-d8f2-4ae6-90c4-125bde41dc29@samsung.com>
 <20250319175840.GG10600@ziepe.ca>
 <1034b694-2b25-4649-a004-19e601061b90@samsung.com>
 <20250322004130.GS126678@ziepe.ca>
 <c916a21e-2d95-476d-9895-4d91873fc5d5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c916a21e-2d95-476d-9895-4d91873fc5d5@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_121053_096608_60D31AF1 
X-CRM114-Status: GOOD (  18.16  )
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

On Fri, Mar 28, 2025 at 03:18:39PM +0100, Marek Szyprowski wrote:

> What kind of a fix is needed to dma_map_resource()/dma_unmap_resource() 
> API to make it usable with P2P DMA? It looks that this API is closest to 
> the mentioned dma_map_phys() and has little clients, so potentially 
> changing the function signature should be quite easy.

I looked at this once, actually it was one of my first ideas to get
the VFIO DMABUF side going. I gave up on it pretty fast because of how
hard it would be to actually use..

Something like this:

dma_addr_t dma_map_p2p(struct device *dma_dev, struct device *mmio_dev,
		       phys_addr_t phys_addr, u8 *unmap_flags, size_t size,
		       enum dma_data_direction dir, unsigned long attrs);
void dma_unmap_p2p(struct device *dev, dma_addr_t addr, u8 *unmap_flags,
		   size_t size, enum dma_data_direction dir,
		   unsigned long attrs);

Where 'unmap_flags' would have to be carried by the caller between map
and unmap. mmio_dev is part of the P2P metadata that dma_map_sg gets
out of the struct page via the pgmap.

unmap_flags is the big challenge, there is not an easy data structure
to put that u8 as a per-call array into in the DMABUF space. It could
maybe work not bad for VFIO, but the DRM DMABUF drivers would be a
PITA to store and this wouldn't be some trivial conversion I could do
to all drivers in a few hours.

But, the big killer is that such an API would not be suitable for
performance path, so even DMABUF might not want to use it.

If we start to fix the performance things then we end up back to this
series's API design where you have the notion of DMA transaction. The
more of the micro optimizations that this series has the closer the
APIs will be..

So, IDK, we could make some small painfull progress for VFIO with the
above, but replacing scatterlist would be off the table, we'd have to
continue to live with the DMABUF scatterlist abuse, and there is no
advancement toward a performance struct-page-less DMA API.

Jason

