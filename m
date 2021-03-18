Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC86EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:45:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 346CD64EC4
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346CD64EC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OZW+zq0WD4oTcr9MUo7Cj2BArXVIzSrqa99sCHqvmJ0=; b=I4lWJ7dYFlDZMu0rWskyLqJee
	H93nAdwPnvMnYwHkMeqE4pvSumBqjppIuHN1vfJkNTOUhvb2i9pc+gmWyzim5mAw8vbewy7cM6VJk
	g9cLBXVmvOQ+AaXAGSkFhSSRY6H4J4+L1F6BSAYNgBoad6eHeyCOUmYLwTWJtVOocPfpRmz0Qls8E
	HyAxLY5ebmv/t8zmBPzd7+ww2OB0e4IGeVNtCnwBTE+Om7g2KhbCPah5AH0n5MUVPuzvGAu+ngEhp
	i7QQtbL8N6a+PWQFHUaRi2KZzLPkhqdCaj5UBe1QNwo5EkqiXFTrgjQ/SIJPlRdR/swW2M+LZk2yp
	hU+0jqcsQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlTD-004Y6J-QD; Thu, 18 Mar 2021 05:45:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlT4-004Y55-Ap
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 05:45:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A87CA68CEC; Thu, 18 Mar 2021 06:45:07 +0100 (CET)
Date: Thu, 18 Mar 2021 06:45:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, hch@lst.de,
 kbusch@kernel.org, linux-nvme@lists.infradead.org, metze@samba.org
Subject: Re: [PATCH 6/8] block: add example ioctl
Message-ID: <20210318054506.GE28063@lst.de>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210317221027.366780-7-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_054510_646497_28301295 
X-CRM114-Status: GOOD (  13.28  )
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

On Wed, Mar 17, 2021 at 04:10:25PM -0600, Jens Axboe wrote:
> +static int blkdev_uring_ioctl(struct block_device *bdev,
> +			      struct io_uring_cmd *cmd)
> +{
> +	struct block_uring_cmd *bcmd = (struct block_uring_cmd *) &cmd->pdu;
> +
> +	switch (bcmd->ioctl_cmd) {
> +	case BLKBSZGET:
> +		return block_size(bdev);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
>  static int blkdev_uring_cmd(struct io_uring_cmd *cmd,
>  			    enum io_uring_cmd_flags flags)
>  {
>  	struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
>  
> +	switch (cmd->op) {
> +	case BLOCK_URING_OP_IOCTL:
> +		return blkdev_uring_ioctl(bdev, cmd);

I don't think the two level dispatch here makes any sense.  Then again
I don't think this code makes sense either except as an example..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
