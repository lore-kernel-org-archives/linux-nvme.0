Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C5EEB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 03:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tnPogoUBmylca9+nqGu8egi66pV6zHdkHjOkqzj67LM=; b=gPsDvlJtPDNySYhl4UN6iqxAgA
	FhfNdRTUZ391O/RDDMboBakOEYNm3U4DFWkbicnO+72qVamYFlNT35xLytqVHH511DYso2CW1SNMj
	sLcbeK/XIeJ8RlTnNG2Qg2qXAyLbq2H+rjtoJRxKen/zuw1LwEtLvwODb75SCNB2GDSeQ4yoqNEDd
	We1HQaT3pd/Jmr6Qgt2muaMnlt5G53KANqG7Ghkn7tFOiYNtVgoMHI65JNHTCV3PwDjZcZz4Sx5Id
	MA4FrJ26qsu3CkEnF5go0VdMdKgz00Mzhr5PfJ5o/vOk4ig7cvXPrVAsRqLeuETiXbm71Npi1o3D7
	GgG9RX1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIhy5-00AKC4-0i;
	Mon, 10 Jul 2023 03:53:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIhy2-00AKBE-1R
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 03:53:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0C23460472;
	Mon, 10 Jul 2023 03:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA3CC433C8;
	Mon, 10 Jul 2023 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688961219;
	bh=c83HHLEuw3oaOnGz4RSWtJJZgGWARDVC09RNf9XCtKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X34Peei8KLsaksJEoJKslFZqLG3AIMBGn2mhcA1QXrzKXDA6EcWygZffwscnOqFOY
	 u3RQa7aOSgF6LKpjafRPdMAeEpvREEUyOK4WyQjeNBb/O/9Eh/6yEnAc7NhW4AT+EJ
	 NRtt3uREuoR25BVn6/dXclBui+pGNLv+CMgsVDaoxlL+mZJXe3F9Khd6XL5j1SNmSO
	 fcdsW6VqPmxJlmR7Yd2VdQDltsfdC2Tn0umqazIQP93dN4bzTnex+wbXe2GFuDrulK
	 WRHCnYHWPli2wkWZzYINqqOvqIA2PQ5r+XPRFck1G22PWQk+en1oY2f9UKxeESNFeG
	 vVU1E1IOUEDqQ==
Message-ID: <40107b82-3091-a19a-4740-d1a9e8d7229c@kernel.org>
Date: Mon, 10 Jul 2023 12:53:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230707094616.108430-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230709_205342_525297_F9376606 
X-CRM114-Status: GOOD (  19.42  )
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
> max_discard_sectors is split into a hardware and a tunable value, but
> blk_queue_max_discard_sectors sets both unconditionally, thus dropping
> any user stored value on a rescan.  Fix blk_queue_max_discard_sectors to
> only set max_discard_sectors if it either wasn't set, or the new hardware
> limit is smaller than the previous user limit.
> 
> Fixes: 0034af036554 ("block: make /sys/block/<dev>/queue/discard_max_bytes writeable")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Look OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


> ---
>  block/blk-settings.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 0046b447268f91..978d2e1fd67a51 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -179,7 +179,9 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  		unsigned int max_discard_sectors)
>  {
>  	q->limits.max_hw_discard_sectors = max_discard_sectors;
> -	q->limits.max_discard_sectors = max_discard_sectors;
> +	if (!q->limits.max_discard_sectors ||
> +	     q->limits.max_discard_sectors > max_discard_sectors)
> +		q->limits.max_discard_sectors = max_discard_sectors;
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  

-- 
Damien Le Moal
Western Digital Research


