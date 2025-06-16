Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D615C71135
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 08:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jWWSjqc9uc1wuUoj/H5HIiiKBiAXExC7f094h1c6gLY=; b=RsilRB3UXKa4A1
	pSv6TrFOkPqARP1NI/Ebm3/yzpnwaPVHZhmv7bG1pIcJB4OqiE0JK3nYBhvB6y0XodPpaD//PV840
	iwb5JBfoCrw2t9Wx4l4fy053+AU+qqkJ99+9L2Zw5aCyncTLCW2pMVlfDIlzCHpssnASuMSk8haQA
	JPg5ITgY7Hl9HY1DxoiCvY1k4QlPG3kruEiGVNmnflGytvOxXfkapPv/yTNCHSOSYjeUXfHKYMTdt
	xWAK5HoKS2E3OAZjpT9ZzZidghhTAZAp4XD1wbg8ENeW9Yf0PqiVWJA2uFPL9EUmL/Uvy2znqlBcn
	QynENd+vqJKqErcp9uQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR4sO-00000003kA4-27Pf;
	Mon, 16 Jun 2025 08:07:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR4bI-00000003heR-0oHD
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 07:49:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F129B5C584A;
	Mon, 16 Jun 2025 07:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF61C4CEEA;
	Mon, 16 Jun 2025 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750060191;
	bh=Cz3lDHFGJJSCBLHfEjRzh8NozUVsGBREjmVm7AlWgfQ=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Sgi6QPQqndZXcORblP7IP7+rNuZyWjLXtq2bx8op6hhJIxjguGdlkzWEK2llVQDDr
	 u7iGf2lsdfKC9nsfwi1eNWxt9ggCo+NzoPCkT0JkxOuO6kvH5XQxEVEY0RovkfkEgV
	 HMbB7j+VpJ0sI3nMCD5f2kfV0mGNpMl3xr/7nyGt8HEIQWQXzXzLFUwWBYBv5opdNa
	 0b9/YYpKsDhSgNd15CH7GLpVBLp/3mmNOgHRJsTCjiZ38V9IqZLGqCzrKcpYb1I0gW
	 QhEZZrI+/k8Wlb/5lzi6wXoJQWkkNVD2e3ANonU5qGjUCDzMmO8NQ8Ur4BUbPkpX4b
	 ODo0n4R2OpsHw==
Message-ID: <871b014b-e308-4f20-9701-5581beee91ed@kernel.org>
Date: Mon, 16 Jun 2025 09:49:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250610050713.2046316-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_004952_382956_30E276CD 
X-CRM114-Status: GOOD (  11.39  )
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
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/06/2025 07.06, Christoph Hellwig wrote:
> @@ -46,13 +45,11 @@
>  #define NVME_MAX_NR_DESCRIPTORS	5
>  
>  /*
> - * For data SGLs we support a single descriptors worth of SGL entries, but for
> - * now we also limit it to avoid an allocation larger than PAGE_SIZE for the
> - * scatterlist.
> + * For data SGLs we support a single descriptors worth of SGL entries.
> + * For PRPs, segments don't matter at all.
>   */
>  #define NVME_MAX_SEGS \
> -	min(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc), \
> -	    (PAGE_SIZE / sizeof(struct scatterlist)))
> +	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))

IIRC, I've seen in the commit history going from PAGE_SIZE to CC.MPS for
different cases in the driver. PRPs requires contiguous regions to be CC.MPS,
i.e use NVME_CTRL_PAGE_SIZE for PRP lists and entries. But I think that is not a
limit for SGLs. Can we use PAGE_SIZE here?

