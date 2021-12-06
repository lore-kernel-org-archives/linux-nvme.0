Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8ABC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Dec 2021 07:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=chmrmGnE9hkGaC0+CM5+OKTy7P4tk4m1kYI9Tg5TMFw=; b=MW6dVE0V18g4+q3Q2d7O5xPkWb
	zXEreFCbcxjUUMVUs8y+T3qd/t8b1b/bzesfQWgbayUS357KpnBLxE3lTAEJgRJxU7YickhlJhlph
	QcJl7r268YxPGNSRXaa5UQo8TgwBDfz++1yAG/m3JzRokplxjxYaqeQE+oWG1zkWXAx+rQipTe3yB
	LFRJcqU5zBEaxt5egkK6mcLqnuaI0uibwjOIFOe3z+xsQQUTwvItXy58RMxszHAk9MSRZtdAjKdjx
	VYQ4dWxAPZaxk0iUrj9/PCMOmBVoxQ4mjwG8BhX9Tr0LdESmUWnMSW1SDkPbWn+VGDCrw8EYZgvlC
	T18i3fzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mu8bw-002md7-BD; Mon, 06 Dec 2021 07:40:32 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mu8bu-002mcu-NE; Mon, 06 Dec 2021 07:40:30 +0000
Date: Sun, 5 Dec 2021 23:40:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
Message-ID: <Ya2+buqfKSFHWVvu@infradead.org>
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203214544.343460-5-axboe@kernel.dk>
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

On Fri, Dec 03, 2021 at 02:45:44PM -0700, Jens Axboe wrote:
> This enables the block layer to send us a full plug list of requests
> that need submitting. The block layer guarantees that they all belong
> to the same queue, but we do have to check the hardware queue mapping
> for each request.
> 
> If errors are encountered, leave them in the passed in list. Then the
> block layer will handle them individually.
> 
> This is good for about a 4% improvement in peak performance, taking us
> from 9.6M to 10M IOPS/core.

This looks pretty similar to my proposed cleanups (which is nice), but
back then you mentioned the cleaner version was much slower.  Do you
know what brought the speed back in this version?

