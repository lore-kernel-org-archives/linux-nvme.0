Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28AF3EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 03:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ho022umTByB5mVW79Pjp5lYa8B6fZjBj7xiHtb7KyiU=; b=weSUMuWGEuzEjdIDI9JuSqmi7j
	4dQtH7q0lWj85us5CThQlJlSylW7v+CL2oN8ZuTc6bZCJFktRwVx6oJ5YXHBlyPN5xRc0J/sEOgr8
	oj46cIeO+MdJbrC1FEk5+oDUfwPfcxsTlAZiqd1WxpIT61Qo2htpU6ctJpr5VUSV8kQVsd9biLz0z
	RgO54U3FPLtBjSibjdFsM5LcZGwhEWpwA0StWSQQ9dM+zOb6qtLFtGDUdtOT08y7C+Pi+ecvXeBne
	pytKN8kK6KvBjqNXjjfYyxzGO+0CfErEQAqTIAQDiwn6wiAqHe+AkUSuBSz5B7GYpkU9euMFCMBVJ
	nTLpYtcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIhzC-00AKQa-2O;
	Mon, 10 Jul 2023 03:54:54 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIhzA-00AKPu-2s
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 03:54:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 349E760B88;
	Mon, 10 Jul 2023 03:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E295EC433C8;
	Mon, 10 Jul 2023 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688961291;
	bh=nU3ffBEWaeGa+g/w+fIOFK5rD8bAOgNBOmWPTbZKkbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Tuox4OAYXoDk3DJe8/PPH2kLdCIdDw9UJBVIkUmPm8vJ6V0KNQ+C0MUgDu92k5r9A
	 3PjnViuB7KH+pN2UgggViKsOEZIGIgpIn08pKaZay01NL6B3NG7aI4OmHtoWahzOHj
	 EuaEIMEH53hlVxQeLfsPioQGSkejSOt4VUqcS+IbUgH3QDAV7deoxw9Vu7OOkfCOru
	 f08RnuVy6lW/+rTFe1qTN7b7//oTm3HCKB8nftAyAC4E5ptXNQJI2cgEJy0KQ+b9kg
	 6hZN2yG2UaWJSx8nsDPoiVuWS0j+Fzeq9fk724PVLlBXRE6byP/23qediot7Od4Q+o
	 YFFz+s0paxEew==
Message-ID: <ea6e5b23-e793-a883-5722-51f2f589f847@kernel.org>
Date: Mon, 10 Jul 2023 12:54:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] nvme: update discard limits in nvme_config_discard
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230707094616.108430-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_205452_969636_9E73C5E2 
X-CRM114-Status: GOOD (  19.36  )
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

On 7/7/23 18:46, Christoph Hellwig wrote:
> nvme_config_discard currently skips updating the discard limits if they
> were set before because blk_queue_max_discard_sectors used to update the
> configurable max_discard_sectors limit unconditionally.  Now that this
> has been fixed we can update the discard limits even if they were set
> to deal with the case of a reset changing the limits after e.g. a
> firmware update.
> 
> Fixes: 3831761eb859 ("nvme: only reconfigure discard if necessary")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Look OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/nvme/host/core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 47d7ba2827ff29..2d6c1f4ad7f5c8 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1734,10 +1734,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
>  
>  	queue->limits.discard_granularity = size;
>  
> -	/* If discard is already enabled, don't reset queue limits */
> -	if (queue->limits.max_discard_sectors)
> -		return;
> -
>  	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
>  	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
>  

-- 
Damien Le Moal
Western Digital Research


