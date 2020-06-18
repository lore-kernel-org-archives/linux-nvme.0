Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C09C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D9120739
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="e+KeyYYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D9120739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IZID1Nhv7l0caFhJYd7kPcJub6o/OgpLGBn5hkzwZH4=; b=e+KeyYYt1M4F/V
	rXYzvbiPIib4HhLYWN0NppJfO7/QDNykKxOacZghdxi3RVQiVECxvLkXYikWYUoaClO2rv/NrLLgf
	rJ6VPCvABJyTTGD11uR+YXODsurzuI/OAPsb2P9XrFgdD5l/IRcS9vrmOa31myXvcFtdEnwFgf4Ut
	ZTdI3DA4eQbEnl75eTaTz30vyvGudqu6vpBkaTO9ezvzgDPPg/Idc+9/VSsLp1NxBRh8sp9YA7pqU
	DXI6ndjzDMCmU0B1H//S+rLekQuF3Btp2Or67aVn1J3n06vcqTxoB13J5o0+r6bOLBtf4+0qQNdtw
	JuwczaQi/3fEvBouK08g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlvFy-0006Zg-KZ; Thu, 18 Jun 2020 14:11:06 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jlvFw-0006ZL-0j; Thu, 18 Jun 2020 14:11:04 +0000
Date: Thu, 18 Jun 2020 07:11:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: blk_mq_complete_request overhaul
Message-ID: <20200618141103.GA16866@infradead.org>
References: <20200611064452.12353-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-1-hch@lst.de>
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
Cc: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Any comments?

(and yes, I misspelled the nvme list address, but the interested
parties should be on linux-block anyway)

On Thu, Jun 11, 2020 at 08:44:40AM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> Peters recent inquiry made me dust off various bits of unfinished work
> around blk_mq_complete_request and massage it into a coherent series.
> 
> This does three different things all touching the same area:
> 
>  - merge the softirq based single queue completion into the main
>    blk-mq completion mechanism, as there is a lot of duplicate logic
>    between the two
>  - move the error injection that just fails to complete requests out into
>    the drivers.  The fact that blk_mq_complete_request just wouldn't
>    complete when called from the error handle has been causing all kinds
>    of pain
>  - optimize the fast path by allowing drivers to avoid the indirect call
>    with a little more work for polled or per-CPU IRQ completions.  With
>    this a polled block device I/O only has two indirect calls let, one for
>    the file operation that ends up in the block device code, and another
>    one for disptching to the nvme driver
---end quoted text---

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
