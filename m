Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B56C5475B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c5ZIjtn84+RGrKPpS181y3wEWWbDN+8mLamK+w2N/o4=; b=xNeSkORcWilZWjnKSad/eg306A
	loVBgaboshVUG0PMTsf/skekbuDUKV3majR8+ypeshLwo9Q1WHeiRwx2DqSJC6EODBWNA5tVII4Um
	qcguoups96910PSr7+05u11mXSey8cDlLmMzwIwKBK6gBDy6ey8zTXg0Vrjwhy1WK37hHq5QMNnj8
	04fYQxSgbh/bhwYns8u7T9a+1XBtQ2tLEs9sED1ZTUiuJ/jifks5HwqtzN8B9kvYCEzu2el64ek3n
	POTSgR2mLNk34btzS4OU6daHOeEX9sxLY5sbo8u1ES0MejR13CgzC/2CiR5bjJV3NnbAQk9cTB8s/
	A7Hx6tAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhtn7-00000000umL-2EN8;
	Wed, 06 Mar 2024 16:06:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhX5I-0000000ELN8-1PFW
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 15:52:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1B95DCE1877;
	Tue,  5 Mar 2024 15:52:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB4CC433C7;
	Tue,  5 Mar 2024 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709653921;
	bh=pSqyVUiOhZxz9FIInEYMAmoXZWKPhnt0IQNLfQGtXOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBoFlOhlhaEkFpkwIhtzKscT84AMxoyIqH1ke1DoX3oTGvoYraBWWNLX9PB1wDsDX
	 8/jrkloUt7VxJU24ln5/zi811lztKw0pkpRiqC5TgWE3Z3l2yBlrPTsMwI7n+JTnPL
	 cIBn53riFq9sACKU+PDs51snnPNJif2TZriANWE8lPNacPlZ3ZEjjBSL+Ajm8tvqj0
	 Xh39F7UKx8jqNW9DJE3CBRQ781zgONKaHkjALazRttLlPWK1iLUFRVRnO9bb0lDH+E
	 AJgD1u7Xsepu7WvnlIDZLfAruLkrmiYG+GBGJiaH7MHjj517QXOLR7xfuwktrP6dWh
	 5IQc8QXtatQIw==
Date: Tue, 5 Mar 2024 08:51:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 16/16] nvme-pci: use blk_rq_dma_map() for NVMe SGL
Message-ID: <Zec_nAQn1Ft_ZTHH@kbusch-mbp.dhcp.thefacebook.com>
References: <cover.1709635535.git.leon@kernel.org>
 <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016fc02cbfa9be3c156a6f74df38def1e09c08f1.1709635535.git.leon@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_075204_737363_1ABB27C6 
X-CRM114-Status: GOOD (  11.18  )
X-Mailman-Approved-At: Wed, 06 Mar 2024 08:06:47 -0800
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

On Tue, Mar 05, 2024 at 01:18:47PM +0200, Leon Romanovsky wrote:
> @@ -236,7 +236,9 @@ struct nvme_iod {
>  	unsigned int dma_len;	/* length of single DMA segment mapping */
>  	dma_addr_t first_dma;
>  	dma_addr_t meta_dma;
> -	struct sg_table sgt;
> +	struct dma_iova_attrs iova;
> +	dma_addr_t dma_link_address[128];
> +	u16 nr_dma_link_address;
>  	union nvme_descriptor list[NVME_MAX_NR_ALLOCATIONS];
>  };

That's quite a lot of space to add to the iod. We preallocate one for
every request, and there could be millions of them. 

