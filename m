Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE10C369D8
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Apr 2025 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9/cTmOe+FIMZIw2i44VJudB3jzVcGXPAOGoPOd5HwBY=; b=Pz6vL4IsEpPq7TlikBxRPVIGHm
	ehYiLvF+VUyQHa6VMBRRXUJE6jTEoHA3uq6DeyBNafF91ZIZRrnWMXpkDcUnoZ0GcgPgQXw+UfVu1
	ljxMbvDpbd6wxAUy+xf/3mHkte+WfrcE3w4vciAcAOyFcKp2jaJ4dbmEfFsNDAE3YdEh2JZ81QAym
	zUzzeksd1K5qAhAcYDr0K2w8qoGP7JTwKW9WZhshCVsDVlWYM1CWx3Q5XtPHF1QLkkKKufZZg7SQn
	PcHJGyi51WbL86IWC8+7XjTZKKSYrF21k0yi9JmsO1fBaiihGUwGF65a0/jBNygRFGRzmJX0UcUf6
	qMj2UOJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6u7P-00000004h92-3DHx;
	Mon, 21 Apr 2025 16:35:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6u5r-00000004gZz-2Buk
	for linux-nvme@lists.infradead.org;
	Mon, 21 Apr 2025 16:34:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E8D6560008;
	Mon, 21 Apr 2025 16:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F71C4CEE4;
	Mon, 21 Apr 2025 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745253242;
	bh=ii11Zr+Updew/MOUDrq24J55rAYYFktZ0u9SMNEKDb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeJ/fptOWN3ZzdCtkjX88KJ3DRrra2qBbWUPxjrmqqFZ//JvENlW8AWYdHH4QRHNd
	 ANiVXWqymXWcIjWXo1REZ7Re6F2t2cYNbMKPhM/Rq21x9K1MyMD9fJQiTXX9CSNg4M
	 eWIhUWMZExrMytcHKiC/fF5IfJzInn/FgSQj/H6WLM8TD/Esh4F4lSlW5IBFSKxcJM
	 4+AQcDh2sCtOtAveocLY9ljxg+w59z/yclzhVr8gARJD7/Ncrk2XjyA33ttHyp9y6Q
	 zYVwQ5bFBxtA73MUgxwuH1qkvVR2vban7XC6xpRL2+O4FAG3VwagVc1UFRs0EmFMs+
	 k5b+4SaaQjB9Q==
Date: Mon, 21 Apr 2025 10:33:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme/pci: make PRP list DMA pools per-NUMA-node
Message-ID: <aAZzd-9YjBP4IyNK@kbusch-mbp.dhcp.thefacebook.com>
References: <20250421161725.1610286-1-csander@purestorage.com>
 <20250421161725.1610286-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421161725.1610286-3-csander@purestorage.com>
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

On Mon, Apr 21, 2025 at 10:17:25AM -0600, Caleb Sander Mateos wrote:
> +static void nvme_release_prp_pools(struct nvme_dev *dev)
> +{
> +	struct nvme_prp_dma_pools *pools_end = dev->prp_pools + nr_node_ids;
> +	struct nvme_prp_dma_pools *prp_pools;
> +
> +	for (prp_pools = dev->prp_pools; prp_pools < pools_end; prp_pools++) {
> +		if (!prp_pools->small)
> +			continue;
> +
> +		dma_pool_destroy(prp_pools->large);
> +		dma_pool_destroy(prp_pools->small);
> +	}
> +}

A minor difference in style, I think indexing looks cleaner than
incrementing pointers: 

static void nvme_release_prp_pools(struct nvme_dev *dev)
{
	int i;

	for (i = 0; i < nr_node_ids; i++) {
		dma_pool_destroy(dev->prp_pools[i].small);
		dma_pool_destroy(dev->prp_pools[i].large);
	}
}

Note, dma_pool_destroy() already checks for NULL, so no need to check
before calling it.

