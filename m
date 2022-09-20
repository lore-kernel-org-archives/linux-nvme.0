Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1ACC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 12:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYII2cr2LDNGOtjEY7cbCL0IS5FnGHixjIFZ4ppEPnM=; b=wH1XKom8TgPcnr0OVIWHZBz58W
	SJP9iH7tkk3bUVxbsR7xwzHdgjZpdTxln1UBh8QxMPsnMvgB7uFOguUe7rxf3PjWRup8FGX+1kNFD
	Isg+7E9xrbNLwD8XBxF9woWBdNm2JzDqF2aJIHJ61cHjIsok7OKBzK07c5Jj1pE4rQI7meDdfy45m
	y+Tya1ZuCfetjiaz3IsHayj9zc7W4hNnVrpTAGOOvKUkl2C2ODovt6ugE67VTiyCp+G/oAqeA3l3J
	faW7ZaBvqZThR8r1/7j6Hj4kS0PGq7ygojjb3yTA80zAjN7SKYRYKHhUIRrkxqAHr2rI8zDePX0LP
	Hp3khzGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oabxY-003Yz9-EY; Tue, 20 Sep 2022 12:02:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oabxU-003Yvt-4P
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 12:02:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 213FE68AA6; Tue, 20 Sep 2022 14:02:27 +0200 (CEST)
Date: Tue, 20 Sep 2022 14:02:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v7 3/5] nvme: refactor nvme_alloc_user_request
Message-ID: <20220920120226.GB2809@lst.de>
References: <20220909102136.3020-1-joshi.k@samsung.com> <CGME20220909103143epcas5p2eda60190cd23b79fb8f48596af3e1524@epcas5p2.samsung.com> <20220909102136.3020-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909102136.3020-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_050236_365065_A6801F0F 
X-CRM114-Status: GOOD (  26.36  )
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

On Fri, Sep 09, 2022 at 03:51:34PM +0530, Kanchan Joshi wrote:
> Separate this out to two functions with reduced number of arguments.
> _
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/ioctl.c | 116 ++++++++++++++++++++++----------------
>  1 file changed, 66 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 548aca8b5b9f..cb2fa4db50dd 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -65,18 +65,10 @@ static int nvme_finish_user_metadata(struct request *req, void __user *ubuf,
>  }
>  
>  static struct request *nvme_alloc_user_request(struct request_queue *q,
> +		struct nvme_command *cmd, unsigned timeout,
>  		blk_opf_t rq_flags, blk_mq_req_flags_t blk_flags)

I think we can also drop the timeout flag here, which seems like it
can be handled cleaner in the callers.
to set it can just do that.

> +static int nvme_map_user_request(struct request *req, void __user *ubuffer,
> +		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
> +		u32 meta_seed, void **metap, bool vec)
> +{
> +	struct request_queue *q = req->q;
> +	struct nvme_ns *ns = q->queuedata;
> +	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
> +	struct bio *bio = NULL;
> +	void *meta = NULL;
> +	int ret;
> +
> +	if (!ubuffer || !bufflen)
> +		return 0;

I'd leave these in the callers and not call the helper if there is
no data to transfer.

> +
> +	if (!vec)
> +		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
> +			GFP_KERNEL);
> +	else {
> +		struct iovec fast_iov[UIO_FASTIOV];
> +		struct iovec *iov = fast_iov;
> +		struct iov_iter iter;
> +
> +		ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
> +				UIO_FASTIOV, &iov, &iter);
> +		if (ret < 0)
>  			goto out;
> +		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
> +		kfree(iov);

To me some of this almost screams like lifting the vectored vs
not to the block layer into a separate helper.

> +	}
> +	bio = req->bio;
> +	if (ret)
> +		goto out_unmap;

This seems incorrect, we don't need to unmap if blk_rq_map_user*
failed.

> +	if (bdev)
> +		bio_set_dev(bio, bdev);

I think we can actually drop this now - bi_bdev should only be used
by the non-passthrough path these days.

> +	if (bdev && meta_buffer && meta_len) {
> +		meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
> +				meta_seed, req_op(req) == REQ_OP_DRV_OUT);
> +		if (IS_ERR(meta)) {
> +			ret = PTR_ERR(meta);
> +			goto out_unmap;
>  		}
> +		req->cmd_flags |= REQ_INTEGRITY;
> +		*metap = meta;

And if we pass the request to nvme_add_user_metadata, that can set
REQ_INTEGRITY.  And we don't need this second helper at all.

