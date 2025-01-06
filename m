Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1CCE77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bQ6P69FJf7ylXQqOja4A97U45gCawPi/uZomYF+rIgc=; b=Nrd62kUXm8HWhFynqb9E7SUNlg
	eX1XqlLY3noDJo4jN1hx+SaiHoGVUUKiMuRXdWAz2JcbMqFFkLMqyoFobYw75eP1SeCOGWd+w1luT
	32OBxdgm6aKRhXQwPUd/SNaSBj+7lfBVdIeiZYK9VpRdjrdxC6w+3dKt8tqqt02ZQ+UzBZZkUkUcI
	TtYWsXG64zqEFATnf3UsP9yJsR0xo8YtaZGlTt0iA2Ik/7SIF0k+vOqB4Kgx9f07LM6t+reXnb546
	/mugvynBmY0iXfQybOIlbvXWcrUkcW2NUbj5T5yaFLHA61L2gswxig6d4cSJG609u3+MqihSqmdX3
	XYg/gTSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkae-00000000tuh-3dMZ;
	Mon, 06 Jan 2025 10:44:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkYq-00000000tiq-265S
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 10:42:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DF4BEA4145E;
	Mon,  6 Jan 2025 10:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58D2C4CEE0;
	Mon,  6 Jan 2025 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736160135;
	bh=euhWvUhz5CciYJh8Yuw2cExBVHc9+EtlTZ1pgZbX7Ho=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hUODWLJYC9lAQuwth5KQ9f/9n4JkccHviDS4BUW+GVnYUc95BTbiEfTLJTO2cSnhI
	 RoGLBLJs/jDMAKfkGSoG8fMvgAx1f+wf/EoLVq5jlCe5Aj3acYnWwRbQGefxm3Mk9y
	 Se7gjWn7ohH1ELKxO/yfEDpwedIExf6+QWU+QcTdeme4+2Syu5DERgr2CZJUWfbOaT
	 u1/Kl9WCgzP0ekKNfmY2vOBe+7Xpneq1f8fTkpfwoym9kbHfUXAwDhUN3RpSPjKDxE
	 Lq4zljlYQUJJRYaE589asV0Y2gFz7Ho5fL+S9ICfeYhrdshKYQIWtuuwVkio2eASNk
	 oPa63ka2qmKYg==
Message-ID: <c760f509-8902-429c-bf1b-526b1043c483@kernel.org>
Date: Mon, 6 Jan 2025 19:41:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] block: add a queue_limits_commit_update_frozen
 helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250106100645.850445-1-hch@lst.de>
 <20250106100645.850445-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250106100645.850445-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_024216_618565_37C5E920 
X-CRM114-Status: GOOD (  12.18  )
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

On 1/6/25 7:06 PM, Christoph Hellwig wrote:
> Add a helper that freezes the queue, updates the queue limits and
> unfreezes the queue and convert all open coded versions of that to the
> new helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

[...]

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 71a7ffeafb32..0a987f195630 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1105,9 +1105,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
>  		lim.features |= BLK_FEAT_WRITE_CACHE;
>  	else
>  		lim.features &= ~BLK_FEAT_WRITE_CACHE;
> -	blk_mq_freeze_queue(disk->queue);
>  	i = queue_limits_commit_update(disk->queue, &lim);

You need to change this line to use queue_limits_commit_update_frozen().

Other than that, looks good !

-- 
Damien Le Moal
Western Digital Research

