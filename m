Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994BCC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 17:03:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1C623A54
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 17:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1C623A54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W2HiWTjcNyF+YqwPdxF9POoIWYcf8kDvlpAckmWE3kM=; b=e/HcBokwfMdOwecCh9FQ9ZDkn
	onFOgY/02ockVx22bAuKXjgFlKZnbjqSfmc1aOB+VwqPv8TvL61ivmLVcf/9KmHfX65MLCHisIs6m
	9CbXvvma2RA0SOmPsdA7wCPPQ/07AeSAHE/by2ulQHQsklNTxUQ+QVbakf9ak33WcpxHyvPIHfMgC
	HbvYgOE9MPJrEq0+OyPTwSZds7Nalk0yziaTKonlTr1YumwL8Ea8aCUF4XIP3WE9EQW13XNeVj51H
	rTD+gOPWTPNstW20bVHkLehrqAZqkgM9PIy2tLj8pRn5mj0q5PE6sLHFl1Xb3h70+Fchr4+FOUVFr
	KMp05L8jA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2dMk-00080J-13; Thu, 21 Jan 2021 17:03:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2dMh-000803-Or
 for linux-nvme@merlin.infradead.org; Thu, 21 Jan 2021 17:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QzyNyEp1YsTE5vSV+3cDru2rTzeX2CsFjS3xBz6a990=; b=m/sCpkjOMCVgP4VoWYhFT+pNFA
 XsN5cp/1QMUAEvRGYKVrcCWtT0K0Qc1rUYrY8tnWtvRBGAzYQF1aJcWF3PjXrGGN5DB6crvK52Uhq
 VmNi8hTrqhlV+i2i9NAfj+R5YQr9uVin10+P+GGGvl4s+Wro8U/2/QQy8nAXo/5hPnH9AZL+NWlnM
 toPoiBaqrmygPeFA0pi51swSnxTXmB2rXAaBa2z16O2JBwXvSZdc+MGy9skDIY3SNinDpyuqYtJ3N
 cyelbC61FxOX5f44I6+AYEzvIq/k8mhEfUgaLp9Knoar2TChae7OQQlHwtAFdMat/0mm5SWvcQ2ZF
 9pImn9Kw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1l2dMH-00HI8V-2u; Thu, 21 Jan 2021 17:03:07 +0000
Date: Thu, 21 Jan 2021 17:02:57 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: Re: [PATCH 1/2] block: remove unnecessary argument from
 blk_execute_rq_nowait
Message-ID: <20210121170257.GA4120717@infradead.org>
References: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
 <20210121142905.13089-2-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210121142905.13089-2-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: axboe@kernel.dk, linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, target-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 21, 2021 at 03:29:04PM +0100, Guoqing Jiang wrote:
> The 'q' is not used since commit a1ce35fa4985 ("block: remove dead
> elevator code"), also update the comment of the function.

And more importantly it never really was needed to start with given
that we can triviall derive it from struct request.

> -extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
> +extern void blk_execute_rq_nowait(struct gendisk *,
>  				  struct request *, int, rq_end_io_fn *);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
