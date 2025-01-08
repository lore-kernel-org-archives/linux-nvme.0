Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB17E7719A
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xx85ikLru9614KyosuJXWUYJm6VJE4LKz0axhKxd7Nw=; b=o5PViZqR1u+7w+QF7iOD4NQxBl
	adkq57hAMw1hohiPXSjh4lMt3p8lOOl+8AD5Qew7xVPFC7uLwjd4SW4RLFRy+mesHoVAzs7ubFgg5
	D21fvRVsGNiIemC3MUmZEqzg0zwpTZuI5kQ+SezyaBcLVodB8Xv/bHR3D9zl8VU2FVAibm7TcvheK
	cUfZXbplTFsSNZkczCDtM7ZwKhBoiVWNn0qVrgKPBryOYuYBTyArq19C19H2qpXt6ovbvgtDTwF8g
	NearWEN/dk70aeZr1rtUXgRzHcobV8cV6pIfHD6SIWQEpv6fEo4XdvmxUQ10baaksf0k9fiyZ2YrA
	dDhIsvZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTE9-00000007yIs-0L1j;
	Wed, 08 Jan 2025 10:23:53 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVT91-00000007x1b-3zC0
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:18:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2176BA40C4C;
	Wed,  8 Jan 2025 10:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1355BC4CEDF;
	Wed,  8 Jan 2025 10:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736331514;
	bh=Iy5y7jGbSKm6Vq5JK20bohcBwxpWKQDfh6OOx83t328=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QD+QE/TkcsrwKbypzGxkRH74jesRHo7N/TVTwwaRTX1BK6YV31BvoNwrqbEIMyTzc
	 YsqaLoUBB2CpZLNgCwoSkbjThGxFUFAywHWZh8rrQU0gZqu5xJQWngS0f66RNzIhCs
	 yr1VQp13GpGvrn86SDRDkZwNzzlr934q084+hllsSS+JINHAi57szQ6f2jfdci1Frx
	 jRyceuVuRl3A1d0D9YAt2ZcuTmEuIBQAD1JM4yHFDdjdWJ/cxMK5gyqMk+QNR4H1NZ
	 xeHP+U8QT1AjU/Q3WNvlgg6YwbygxMvHD0pS/pqCZDyl7YRaZukI1yrI6Jq8kL0370
	 34iL3Hf21PPMw==
Message-ID: <d5010a1b-f458-4f1e-b7ab-e0f8210b9af7@kernel.org>
Date: Wed, 8 Jan 2025 19:17:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250108092520.1325324-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_021836_063278_36FE4C33 
X-CRM114-Status: GOOD (  12.41  )
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

On 1/8/25 6:25 PM, Christoph Hellwig wrote:
> When __blk_mq_update_nr_hw_queues changes the number of tag sets, it
> might have to disable poll queues.  Currently it does so by adjusting
> the BLK_FEAT_POLL, which is a bit against the intent of features that
> describe hardware / driver capabilities, but more importantly causes
> nasty lock order problems with the broadly held freeze when updating the
> number of hardware queues and the limits lock.  Fix this by leaving
> BLK_FEAT_POLL alone, and instead check for the number of poll queues in
> the bio submission and poll handlers.  While this adds extra work to the
> fast path, the variables are in cache lines used by these operations
> anyway, so it should be cheap enough.
> 
> Fixes: 8023e144f9d6 ("block: move the poll flag to queue_limits")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

