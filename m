Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51168C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FGsVUd4Tvft1mgackRQ5FZ0xdPjACeQFfBX1pwcwAyo=; b=rjlOKoIspufRXzG//HaSGt4cvd
	GeAXIpY4Jl3aXpCLE/5wVJFUz3zksCOPFsyTqeMqya/nTXTyQSrHgwZ6ND4bgMdeqMjl5zBngznzH
	Y/7LHIZRGsZr9w+iXWk/MkiNxX/beTKm4YhA1K9TDjUQqVHgNctGQ5+j1+ik0O4fRiIA3N0oZq1eG
	vv8u9bYoTK6x0lFIdcrsfIkBTZv20NaxcPV95zHqcmQ+ysMD2ONzdcEDUOuFYBk1SL/oSeQFeBj4j
	hVkSgE0SQqT7bnmhJIW+gfWkl1Wl2MrvNSO/I0IU558j+vyxRCpcICM5J5MtMV+0S+p9LUg9ecL3e
	HxNqcyvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKMI5-007Vc9-DY; Wed, 16 Feb 2022 15:32:25 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKMI2-007VbP-6s
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 15:32:23 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 013DB21114;
 Wed, 16 Feb 2022 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1645025541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGsVUd4Tvft1mgackRQ5FZ0xdPjACeQFfBX1pwcwAyo=;
 b=XLJqRF/L15YCRQPUQbZrAd2YzYWliOp9HpvS0VzI2nnQKGoGoXmeBX2EYntnp1Vawokns5
 RFrVImk4XKOmvhdb/62PziOZsVzux+XcOZ3CIAH6aqFvHeY1UaSeuRDSIPYg0jHahKFtpY
 Sv/mNKJd0xI9rDngPxuThD4dgrJLAxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1645025541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGsVUd4Tvft1mgackRQ5FZ0xdPjACeQFfBX1pwcwAyo=;
 b=yuIzoPz6ECxxM3mSnBr0X60Chtsjqvu1QQE+qZI05uTjsxpGoQrRKHkMMlCVGmdRAOCT4e
 iMJc2WbTQyaUalCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFE7D13B15;
 Wed, 16 Feb 2022 15:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ehlvNgQZDWKsMwAAMHmgww
 (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 15:32:20 +0000
Message-ID: <f7620445-6954-dd53-9481-8c3502840a78@suse.de>
Date: Wed, 16 Feb 2022 16:32:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: kbusch@kernel.org, markus.bloechl@ipetronik.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20220216150901.4166235-1-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220216150901.4166235-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_073222_422288_68C741DE 
X-CRM114-Status: GOOD (  13.40  )
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

On 2/16/22 16:09, Christoph Hellwig wrote:
> Various block drivers call blk_set_queue_dying to mark a disk as dead due
> to surprise removal events, but since commit 8e141f9eb803 that doesn't
> work given that the GD_DEAD flag needs to be set to stop I/O.
> 
> Replace the driver calls to blk_set_queue_dying with a new (and properly
> documented) blk_mark_disk_dead API, and fold blk_set_queue_dying into the
> only remaining caller.
> 
> Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> Reported-by: Markus Blöchl <markus.bloechl@ipetronik.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c                  | 18 +++++++++++++-----
>   drivers/block/mtip32xx/mtip32xx.c |  2 +-
>   drivers/block/rbd.c               |  2 +-
>   drivers/block/xen-blkfront.c      |  2 +-
>   drivers/md/dm.c                   |  2 +-
>   drivers/nvme/host/core.c          |  2 +-
>   drivers/nvme/host/multipath.c     |  2 +-
>   include/linux/blkdev.h            |  3 ++-
>   8 files changed, 21 insertions(+), 12 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

