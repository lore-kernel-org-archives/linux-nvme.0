Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A39C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 07:51:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC83060E76
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 07:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC83060E76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GJ6yCbA1sHBuXn3mO7609AxlvL/0gl1n6C1K0uhyuig=; b=rrLai6l1WWjcNZ
	4UjGBZZnEOqeQsLCAhPfLdZuTkY0brZWZ77iNNpkwSUPmtLHzJO5uiR1iK2s3KTVaCjl8rqQOROt8
	+heN61OtNxJ5HRYHxXNb/ia144PIsKp/oOCGsPEFE+RUBv3kfHl0M3N/wK5DD48MZFS1gK8YBbXBw
	bAzM5HZRJFCMtdvqDO914FxK3UAVQZLVwUUYqgIryucoWeqPKHf7/Zw/wLxVbo4/k/Y+CPhVwSlwL
	fRfTKV/IpWcOk7IDxHuZQgZh/FGSbMRs7JhoM/lQgLOZ4547Ebdsk0xMV8jgOlnBsf34HnlT02k2m
	e0uHpug2d66pJrG8d4Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNVsj-002n88-CM; Tue, 07 Sep 2021 07:51:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNVsg-002n73-6n
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 07:50:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B256D67373; Tue,  7 Sep 2021 09:50:55 +0200 (CEST)
Date: Tue, 7 Sep 2021 09:50:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, hare@suse.de
Subject: Re: [RFC PATCH 6/6] nvme: enable passthrough with fixed-buffer
Message-ID: <20210907075055.GE29874@lst.de>
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125937epcas5p15667b460e28d87bd40400f69005aafe3@epcas5p1.samsung.com>
 <20210805125539.66958-7-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805125539.66958-7-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_005058_473314_4478ADB8 
X-CRM114-Status: GOOD (  12.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +/*
> + * Unlike blk_rq_map_user () this is only for fixed-buffer async passthrough.
> + * And hopefully faster as well.
> + */

This belongs into io_uring.c.  And that hopeful comment needs to be
validated and removed.

> +int nvme_rq_map_user_fixedb(struct request_queue *q, struct request *rq,
> +		     void __user *ubuf, unsigned long len, gfp_t gfp_mask,
> +		     struct io_uring_cmd *ioucmd)
> +{
> +	struct iov_iter iter;
> +	size_t iter_count, nr_segs;
> +	struct bio *bio;
> +	int ret;
> +
> +	/*
> +	 * Talk to io_uring to obtain BVEC iterator for the buffer.
> +	 * And use that iterator to form bio/request.
> +	 */
> +	ret = io_uring_cmd_import_fixed(ubuf, len, rq_data_dir(rq), &iter,
> +			ioucmd);

io_uring_cmd_import_fixed takes a non-__user pointer, so this will cause
a sparse warning.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
