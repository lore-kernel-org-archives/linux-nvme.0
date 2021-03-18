Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3216C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:44:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42D4264F06
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 05:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D4264F06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9V06lLqmHXzf8BRCLBpwOtWKtpGn6AAaGugo+zfNwgs=; b=iN5Fgd6IfE4SwzbEJsTr3tizz
	topWSX0bxLe2/Efevb5dQm88iLVhH+MYIcg1P8hUK6HdcMfMNJ+F/vnlw3fjVyv3TFpc6vcstO9LM
	cBZ8zaUxSuQP5i9LAiMfB+6LyeJs/pQpt0N0xScwc0r1aPYHlx+8RhlMSDfhg2YgEt7YBcy6g/ngE
	j+DzdIa5walgvsa5cbQD5CZDTrHyXFx/a+kXDHAgOTMlIUWDcVrsoezZOOFbEMoqmGXBRyRJAFvMw
	pzqcHVt5ZNtnvzNXGMWE0PxOOqKmmgRo7lRjexLH3XMPoZLfMO9j72+qAMA56npYA6OIzEXfJTYq3
	jgUTxLwmw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlSB-004Xt6-E2; Thu, 18 Mar 2021 05:44:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlS4-004Xrt-Fc
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 05:44:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 89D8868C8C; Thu, 18 Mar 2021 06:44:07 +0100 (CET)
Date: Thu, 18 Mar 2021 06:44:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, hch@lst.de,
 kbusch@kernel.org, linux-nvme@lists.infradead.org, metze@samba.org
Subject: Re: [PATCH 5/8] block: wire up support for
 file_operations->uring_cmd()
Message-ID: <20210318054407.GD28063@lst.de>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210317221027.366780-6-axboe@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_054408_784636_265B0698 
X-CRM114-Status: GOOD (  11.31  )
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

> +int blk_uring_cmd(struct block_device *bdev, struct io_uring_cmd *cmd,
> +		  enum io_uring_cmd_flags issue_flags)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +
> +	if (!q->mq_ops || !q->mq_ops->uring_cmd)
> +		return -EOPNOTSUPP;
> +
> +	return q->mq_ops->uring_cmd(q, cmd, issue_flags);
> +}

This has absilutely not business in blk-mq.  It is a plain
block_device_operation that has nothing to do with requests or
blk-mq.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
