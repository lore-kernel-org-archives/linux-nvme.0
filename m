Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E733C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 16:40:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBA6660187
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 16:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA6660187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Grg1CuCQcpMj2ScLDZ2ss84ycii0v90e+RoEt1rwRVE=; b=cLHYxcAqxp+BXKjdt90QVniin
	iG6yVzwjbV7SDj4FSVUCks0ueS2ZINPLdtjZThjCAQQ+UP+CUEDoDESKKzPSHw+tJRs918kGaOGYT
	TUUYudYcnvGXrr3iVz8kw9rpvlJGW2RxPVa/wKsrM+F/SsuX/BXdony8UxJpV0TsNoFNgQ/+ouWy2
	DMqdQh/1QHqmsvHlFsQ+bUFJtfYXrod8lb9airJfDqmsWQoPiOCGLY8BfOTQ3TsKPbJJoOIrzXwaj
	X2SMBJK1VpTaHizUEDcwjKpWoVZnlJTpmwuUQgoqbKbtvp+Ad0T76R2UAkKjqFQOS//Q5w1v0ho5V
	yY0HnAfvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4nrp-0004yX-2s; Wed, 27 Jan 2021 16:40:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4nrm-0004y0-3V
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 16:40:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2C0EE68B02; Wed, 27 Jan 2021 17:40:21 +0100 (CET)
Date: Wed, 27 Jan 2021 17:40:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v4 1/5] blk-mq: introduce blk_mq_set_request_complete
Message-ID: <20210127164020.GA23417@lst.de>
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-2-lengchao@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210126081539.13320-2-lengchao@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_114026_281153_92EE738C 
X-CRM114-Status: UNSURE (   6.73  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +static inline void blk_mq_set_request_complete(struct request *rq)
> +{
> +	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> +}

This function needs a detailed comment explaining the use case.
Otherwise we'll get lots of driver abuses.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
