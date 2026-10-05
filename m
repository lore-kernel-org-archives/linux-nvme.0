Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB8ACA5FCE
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 09:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UfiwPw1cUvoeLTUb73jaDzbjG2F3VR4DyksQVw7sRrE=; b=zFWdoMTLGXZeNvg6KVaqaQNTL5
	JN62amREwnGs2hJfkKuOTOLmMnXwj+yRWNIuE6XNwKccJ9UENYuATzdOkEeYAfSvLmurL078gcekw
	FBw6+Vna220puhteyNtO60x7Oe5q16ektnzxmJgG9PUhb6z6yR7UAnL+uR+F1YF6N58PMh/Su9Se8
	BmeJigAaJsUeJA4sfzJ9klGwRcxiBHlH8xIkH1JXC5YRVbbU38SEz1SQKmI0GYhEHFh1vlOClTR7i
	Y6PJGDbOl27VM2uGqU1cPbTWwXme7MbIOOQgQ5lQ1S9sMlPy7rLlJyHSCghmgIeOzGXR37tVo/yK8
	4dJ4Cb2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeoi-0000000Fz7N-34nP;
	Mon, 05 Oct 2026 09:17:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDenh-0000000Fyzx-0Xn4
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 09:16:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9D82768BFE; Mon,  5 Oct 2026 11:15:54 +0200 (CEST)
Date: Mon, 5 Oct 2026 11:15:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
Message-ID: <20261005091554.GD10727@lst.de>
References: <cover.1790602223.git.asml.silence@gmail.com> <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_021601_324752_AF5BEB60 
X-CRM114-Status: GOOD (  13.27  )
X-Mailman-Approved-At: Mon, 05 Oct 2026 02:16:59 -0700
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

On Mon, Sep 28, 2026 at 02:32:22PM +0100, Pavel Begunkov wrote:
> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
> +		struct request *req)
> +{
> +	struct device *dev = nvme_dev->dev;
> +	enum dma_data_direction dma_dir;
> +	struct bio *bio = req->bio;
> +	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
> +
> +	dma_dir = rq_data_dir(req) == READ ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
> +	dma_sync_sgtable_for_cpu(dev, map->sgt, dma_dir);

This can use rq_dma_dir in the argument.  Same for the other DMA API
calls.

Btw, given how larger the dmabuf code is now, have you considered
splitting it into a new nvme-pci-dmabuf.c file?

