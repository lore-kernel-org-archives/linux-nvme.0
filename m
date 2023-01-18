Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B86C38159
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jan 2023 05:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LbwTQmx2HsxXXvXJiKJ1tKkosP2fjNQXyxHmfyZMxuY=; b=yOupCl6VqZhPHIl/iIINpmhg1K
	ttkW3VxSj49lUS0T/7jgahiedHIbbiPVXs9WG+9J6vFB6wAQW/Js9kCwx6BUBHEHt1H2Yipr0jLcT
	axrWSOi4H7Yc+8oIKYBzKSm8nWl7/kIkU3sOd1LPmtvGPnwt95bnL8H69MmNIBlojsNZ6BoaPOaAx
	KaGZbing8c6KyfE76Tg1Gc9/Nlkmc0SbzP6zHAYxAm2UiVDjfRVTdLji2pXmStzdO4cgrYHFn+KER
	pr3SUbcXZVVU7vRgjxzvYUt4N43lV+4WJ6o6lg6alEW86DR1vqeXvtFV0J7WDhL/e59mgCFPqIPP1
	7XxaStBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI14T-00GzL5-Gh; Wed, 18 Jan 2023 05:33:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pI14Q-00GzKV-Ob
	for linux-nvme@lists.infradead.org; Wed, 18 Jan 2023 05:33:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F29F167373; Wed, 18 Jan 2023 06:33:06 +0100 (CET)
Date: Wed, 18 Jan 2023 06:33:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme-pci: fix timeout request state check
Message-ID: <20230118053306.GA24817@lst.de>
References: <20230118052244.741505-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118052244.741505-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_213310_959821_B7E210D5 
X-CRM114-Status: GOOD (  14.62  )
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

On Tue, Jan 17, 2023 at 09:22:44PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Polling the completion can progress the request state to IDLE, either
> inline with the completion, or through softirq. Either way, the state
> may not be COMPLETED, so don't check for that. We only care if the state
> isn't STARTED.
> 
> This is fixing an issue where the driver aborts an IO that we just
> completed. Seeing the "aborting" message instead of "polled" is very
> misleading as to where the timeout problem resides.

Hmm.  Using a started helper for something that by definition is started
doesn't really make much sense.  I guess the problem here is that
blk_mq_end_request_batch sets the state to MQ_RQ_IDLE afte calling
blk_complete_request?  Maybe we just need an explicit check for
MQ_RQ_IDLE here as started seems like the wrong implication here.

