Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177C5C5ACB3
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 05:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=suJdzwb6QnV7u2jYqLrCsov3pdtkQknCiZqupKJR2v4=; b=1vKucKWIbriNRjyKSZgc+3L+Ee
	Nkgn+POPQHh/yXOt+9ZWsGuwnjayW0IOVj6v15b+ssf+21/P6avIscn5+lrNN1H9cCM5rGbzHvVon
	szkQAAb93rc6zlAtE1BUb4PsFKH6gKCIWDp65YD7o5ipsrir1iyxvurJk8ZCVIXlV+dtGiZ5q0rDM
	fD7HBoSeQanJ2LwpappqGXlG24Wk//gtQ/D4ryGWLrXB7rpx1DZvxkITUemKYaFp4vSpTfv75VHc9
	LDtLo8toWISzddjglIjJOt+bII05LVBeKvhroYRVkUhssqXCTfXGCnmC3orPaqAzKHjrS2meuWo++
	oDLoNNPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5IwI-00Fdmw-0U;
	Tue, 21 Nov 2023 05:04:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5IwF-00FdmN-0M
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 05:04:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F4F96732A; Tue, 21 Nov 2023 06:04:39 +0100 (CET)
Date: Tue, 21 Nov 2023 06:04:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/5] block: bio-integrity: directly map user buffers
Message-ID: <20231121050438.GB2865@lst.de>
References: <20231120224058.2750705-1-kbusch@meta.com> <20231120224058.2750705-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120224058.2750705-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_210443_293235_65699C7F 
X-CRM114-Status: GOOD (  15.14  )
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

On Mon, Nov 20, 2023 at 02:40:55PM -0800, Keith Busch wrote:
> +static void bio_integrity_unmap_user(struct bio_integrity_payload *bip)
> +{
> +	bool dirty = bio_data_dir(bip->bip_bio) == READ;
> +	struct bvec_iter iter;
> +	struct bio_vec bv;
> +
> +	if (bip->bip_flags & BIP_COPY_USER) {
> +		unsigned short nr_vecs = bip->bip_max_vcnt - 1;
> +		struct bio_vec *copy = bvec_virt(&bip->bip_vec[nr_vecs]);
> +		size_t bytes = bip->bip_iter.bi_size;
> +		void *buf = bvec_virt(bip->bip_vec);
> +
> +		if (dirty) {
> +			struct iov_iter iter;
> +
> +			iov_iter_bvec(&iter, ITER_DEST, copy, nr_vecs, bytes);
> +			WARN_ON_ONCE(copy_to_iter(buf, bytes, &iter) != bytes);
> +		}
> +
> +		memcpy(bip->bip_vec, copy, nr_vecs * sizeof(*copy));
> +		kfree(copy);
> +		kfree(buf);

Nit: but I'd probably just split the user copy version into a separate
helper for clarity.  Nice trick with the temporary iter, we could probably
use this for the data path too.

> +extern int bio_integrity_map_user(struct bio *, void __user *, ssize_t, u32);

Can you drop the pointless extern and just spell out the paratmeters?
I know this follows the existing style, but that style is pretty
horrible :)

