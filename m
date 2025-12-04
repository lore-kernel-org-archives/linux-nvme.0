Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE76D1F9B1
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 11:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPr0hvEES4qg8auZHNPhlav8VYvcjZHHtnyCgzRk7/Q=; b=rkQUtXNTn/hoOzFNP5XC79U1sh
	sJVfqTH7nYRL6eFtsSo2fOFxoLWh/MTXpHR5r5R96ZmF2CbWeCJxfNCLJ1UzADPCuVhDlbVowOi+a
	8545kZSIE/eDoqaeFryT2eTrIAHulsYOyKQhzs/JetOjB0KQwgVS6gCkx5JycXnFi6zULAT8KRlfs
	IRLCkF7G03SKolQtvG0ErnfLpdQXz2R/2CUq3VS4oxHfiCQgnyp8h1spC0RHztqkUm6Khlpz4yMJ3
	defdYw6hwumBWe3NBng3Ty8v/3VVCscdb1PgQ1Yd1Y9Xz4LKMxzNYRViCvGIChvW0+M6k/O7JFxQy
	dTVSV+9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR749-00000007t1F-166A;
	Thu, 04 Dec 2025 11:00:05 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vR746-00000007t0z-3wxL;
	Thu, 04 Dec 2025 11:00:02 +0000
Date: Thu, 4 Dec 2025 03:00:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 06/11] nvme-pci: add support for dmabuf reggistration
Message-ID: <aTFpsl3o7IoJ_xPg@infradead.org>
References: <cover.1763725387.git.asml.silence@gmail.com>
 <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc25f46d2116436d73140cd8e8554576de2caca.1763725388.git.asml.silence@gmail.com>
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

Splitting this trivial stub from the substantial parts in the next patch
feels odd.  Please merge them.

(and better commit logs and comments really would be useful for others
to understand what you've done).

> +const struct dma_buf_attach_ops nvme_dmabuf_importer_ops = {
> +	.move_notify = nvme_dmabuf_move_notify,
> +	.allow_peer2peer = true,
> +};

Tab-align the =, please.

> +static int nvme_init_dma_token(struct request_queue *q,
> +				struct blk_mq_dma_token *token)
> +{
> +	struct dma_buf_attachment *attach;
> +	struct nvme_ns *ns = q->queuedata;
> +	struct nvme_dev *dev = to_nvme_dev(ns->ctrl);
> +	struct dma_buf *dmabuf = token->dmabuf;
> +
> +	if (dmabuf->size % NVME_CTRL_PAGE_SIZE)
> +		return -EINVAL;

Why do you care about alignment to the controller page size?

> +	for_each_sgtable_dma_sg(sgt, sg, tmp) {
> +		dma_addr_t dma = sg_dma_address(sg);
> +		unsigned long sg_len = sg_dma_len(sg);
> +
> +		while (sg_len) {
> +			dma_list[i++] = dma;
> +			dma += NVME_CTRL_PAGE_SIZE;
> +			sg_len -= NVME_CTRL_PAGE_SIZE;
> +		}
> +	}

Why does this build controller pages sized chunks?


