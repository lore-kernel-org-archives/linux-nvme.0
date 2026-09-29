Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D465DCA5FB5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2026 06:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XhYOalr3R26HFLIa9ZlXnwM+/1lAsc8W8oOx84qhODs=; b=cIIqFK82Cevx3owMjoXHtGIUeD
	wh5zKocWrbgpB7SgsNFUm8mGC/QO+UM0EeV/4Es4w1lqsUCOKZKW9kOEyi5U4Zp7rwYvsPpoPgWEc
	QjAOAMGoVIMjAJ39ozsvNNi+QAaMkG95Sz083duyhVQi8EQWpF8aGjcN+JrUcxZkRCkSXlENDRA96
	NfWc7E7iqM1NxDJpC4sRmcwulkRYX4LH/K1IQNroU71JnwWwOudiyaOFhz3pUNB3czUQ5QYHRtCKB
	fRsZgNRtKatPmP3uPmA42VCWcDzft5h5y6WZFmD55j1vVbwSJ6rzonqIlxNIzcqA51LeN4c0xrF8g
	N4ahtf2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBnQq-000000055rp-21BY;
	Wed, 30 Sep 2026 06:04:44 +0000
Received: from smtp-17.smtpout.orange.fr ([80.12.242.17] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBaYJ-0000000422U-0mPw
	for linux-nvme@lists.infradead.org;
	Tue, 29 Sep 2026 16:19:37 +0000
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e] ([10.64.95.99])
	by smtp.orange.fr with ESMTP
	id Ba1ax0rGNJudtBa1ax6CAM; Tue, 29 Sep 2026 17:45:46 +0200
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id Ba1TxOXSTmvgMBa1UxXbFm; Tue, 29 Sep 2026 17:45:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1790696745;
	bh=XhYOalr3R26HFLIa9ZlXnwM+/1lAsc8W8oOx84qhODs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ZQ7yZe4f721D2FFc/wegR1sVUR+pLlDmZMoRecTHXd8wQBZoXNrn9rquk3Lpcs0TX
	 OSNh11BInBxuyDtPwU3/8eQWumoL0+clSja6jhRbqaFRFcvOvbfcLkBauwN8rGhSR8
	 3Pdsu1Wwjl8J+DuUJGbwh9M1FNXHY6uEqYBM28A1kEwewQ4iQpzYzwNwQ97WDUnzd4
	 3pLYpncoI1nWhMB+7txXYzc/xsZvtxAD9mqFBGkWhMxi1+sEmoalrJItslM/tYGPM1
	 TC8vHmVyOZk8Rx6B1bEjFYjnSLx+meQIGFU3m3ywEvrW5B+h/a+sZ6APgPPM0nbUxa
	 xaY94xit9qA5A==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 29 Sep 2026 17:45:45 +0200
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <5a35ad21-c9d4-4dab-a4f0-97baee6e2301@wanadoo.fr>
Date: Tue, 29 Sep 2026 17:45:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/13] nvme-pci: implement dma-buf backed requests
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: agk@redhat.com, akpm@linux-foundation.org, anuj20.g@samsung.com,
 axboe@kernel.dk, bmarzins@redhat.com, brauner@kernel.org,
 christian.koenig@amd.com, dm-devel@lists.linux.dev,
 dri-devel@lists.freedesktop.org, hch@lst.de, io-uring@vger.kernel.org,
 jack@suse.cz, joshi.k@samsung.com, kbusch@kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-nvme@lists.infradead.org,
 matthew.brost@intel.com, mpatocka@redhat.com, nj.shetty@samsung.com,
 phil.cayton@intel.com, sagi@grimberg.me, snitzer@kernel.org,
 sumit.semwal@linaro.org, tushar.gohad@intel.com, viro@zeniv.linux.org.uk,
 william.power@intel.com
References: <cover.1790602223.git.asml.silence@gmail.com>
 <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <e99dd5221c71cbf9aafb5737468d814cb83b9174.1790602223.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260929_091935_363683_74226228 
X-CRM114-Status: GOOD (  20.89  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 23:04:42 -0700
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

Le 28/09/2026 à 15:32, Pavel Begunkov a écrit :
> Enable BIO_DMABUF_MAP backed requests. On registration we map the
> dma-buf and store it as a prp list, which is then used to initialise
> requests. All attached contexts are stored in a new list dmabuf_ctxs,
> and additions/removals are synchronised with dmabuf_lock.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Hi,

a few nitpick below, should it help.

> ---
>   drivers/nvme/host/core.c |  12 ++
>   drivers/nvme/host/nvme.h |   2 +
>   drivers/nvme/host/pci.c  | 308 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 322 insertions(+)
> 

[...]

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a953c0697f99..e58bdd9a4098 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -27,6 +27,8 @@
>   #include <linux/io-64-nonatomic-lo-hi.h>
>   #include <linux/io-64-nonatomic-hi-lo.h>
>   #include <linux/sed-opal.h>
> +#include <linux/dma-buf-io.h>
> +#include <linux/dma-resv.h>

Move up, to keep better alphabetical order ?

>   
>   #include "trace.h"
>   #include "nvme.h"
> @@ -318,6 +320,8 @@ struct nvme_dev {
>   	bool hmb;
>   	struct sg_table *hmb_sgt;
>   	mempool_t *dmavec_mempool;
> +	struct list_head dmabuf_ctxs;
> +	struct mutex dmabuf_lock;
>   
>   	/* shadow doorbell buffer support: */
>   	__le32 *dbbuf_dbs;
> @@ -397,6 +401,13 @@ struct nvme_queue {
>   	struct completion delete_done;
>   };
>   
> +struct nvme_dmabuf_map {
> +	struct dma_buf_io_map base;
> +	struct sg_table *sgt;
> +	unsigned nr_entries;
> +	dma_addr_t dma_list[];

Add __counted_by(nr_entries) and update nvme_dma_buf_io_map() so that 
nr_entries is set at the right time ?

> +};
> +
>   /* bits for iod->flags */
>   enum nvme_iod_flags {
>   	/* this command has been aborted by the timeout handler */

...

> +static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx *ctx)
> +{
> +	unsigned nr_entries = ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE;
> +	struct nvme_dma_buf_io_ctx *nvme_ctx = ctx->dev_priv;
> +	struct dma_buf_attachment *attach = nvme_ctx->attach;
> +	unsigned long tmp, i = 0;
> +	struct nvme_dmabuf_map *map;
> +	struct scatterlist *sg;
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +	map = kvmalloc_flex(*map, dma_list, nr_entries);
> +	if (!map)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sgt = dma_buf_map_attachment(attach, ctx->dir);
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		sgt = NULL;
> +		goto err;
> +	}
> +
> +	for_each_sgtable_dma_sg(sgt, sg, tmp) {
> +		dma_addr_t dma_addr = sg_dma_address(sg);
> +		unsigned long sg_len = sg_dma_len(sg);
> +
> +		if ((sg_len % NVME_CTRL_PAGE_SIZE) ||
> +		    (dma_addr % NVME_CTRL_PAGE_SIZE)) {
> +			ret = -EINVAL;
> +			goto err;
> +		}
> +		while (sg_len) {
> +			map->dma_list[i++] = dma_addr;
> +			dma_addr += NVME_CTRL_PAGE_SIZE;
> +			sg_len -= NVME_CTRL_PAGE_SIZE;
> +		}
> +	}
> +
> +	ret = dma_buf_io_init_map(ctx, &map->base, sgt);
> +	if (ret)
> +		goto err;
> +	map->nr_entries = nr_entries;
> +	map->sgt = sgt;
> +	return &map->base;
> +err:
> +	if (sgt)
> +		dma_buf_unmap_attachment(attach, sgt, ctx->dir);
> +	kfree(map);

kvfree()?

> +	return ERR_PTR(ret);
> +}
...

CJ

