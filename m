Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4839C001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 12:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aq6u0pR9cfqUTnBYipi5Gew3ZlTO6F3copr5KtTjZ4I=; b=roTne1WougySyTjmiJ/uPILwgQ
	Xw4/dDawGKZdgx/N6LYPiOuHJY6wPsX5Ixv8nfJPJIKZpzZ0vvohVDZq0ZbL6d3lBr1EHTbhLv+MZ
	4U99csAbOSit6U1Wne0Ec+nUwyPdFDPmFz3mbroU9u2nYL07UljZEXBjPRFnQlGoHUPAGjEwFVTY5
	oEPWtUcejd7ZJ3PdXqL7kD8OiaBcruH740XDnZImm84Uda/TRjTU45jeWOiF2Hn8cP/zqTNCjAGEP
	8VnDRQDSZUZ2Pjqvp6voRj9tnCdF4amwPpQncR9XbZw//VV5m7wMOwk4STOc7TWOQWeMghCtjlVT7
	bih6N2XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQRcu-00FUUF-2L;
	Mon, 31 Jul 2023 12:03:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQRcs-00FUTH-03
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 12:03:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 02C4161083;
	Mon, 31 Jul 2023 12:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8375C433C8;
	Mon, 31 Jul 2023 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690805028;
	bh=RLse1hCJ1aWyaYPFqDGouatap+ZcliZQPPjVYQfi7e4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CXtpVhhMYGGsFAHL9amPJxarfGmQ0IR5+7tVreyga5SJbhp6t5j3otf6wObZ97Rv1
	 /PwDilekwOgH8Cv76Kj9PMVjzUqqZxHAz3qv6gvFz8g4T2MDWA2qYms4FkiPLZHAt/
	 VGNhx5vyegQ6p5UZJ2rQQ2oTa0EKWm8G2/ZX+Z1tnAbLwF982q1WxnbS3iHtAG7u8k
	 h39ovrra7zolfmr5966oJsYOy5PDRzRpxzJsFrp4U6ZsFqVTQBNghdbhSbBDA+qnMc
	 SwpTBr8dxJuKGyDXAXQZ/nXKbZ9yMo6MweBupCdq2OXb9u2URnaQ4DOURHywQrtmD0
	 wFfT5cGNnxOVA==
Message-ID: <e0f88870-73a8-05a3-024d-52cefcdef71d@kernel.org>
Date: Mon, 31 Jul 2023 21:03:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_050350_156601_C3481BC2 
X-CRM114-Status: GOOD (  25.72  )
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

On 7/31/23 20:46, Shin'ichiro Kawasaki wrote:
> BIOs for zone append operation can not be split by nature, since device
> returns the written sectors of the BIOs. Then the number of segments of
> the BIOs shall not be larger than max_segments limit of devices to avoid
> bio split due to the number of segments.
> 
> However, the nvme driver sets max_zone_append limit referring the limit
> obtained from ZNS devices, regardless of max_segments limit of the
> devices. This allows zone append BIOs to have large size, and also to
> have number of segments larger than the max_segments limit. This causes
> unexpected BIO split. It results in WARN in bio_split() followed by
> KASAN issues. The recent commit 16d7fd3cfa72 ("zonefs: use iomap for
> synchronous direct writes") triggered such BIO split. The commit
> modified BIO preparation for zone append operations in zonefs, then
> pages for the BIOs are set up not by bio_add_hw_page() but by
> bio_iov_add_page(). This prepared each BIO segment to have one page, and
> increased the number of segments. Hence the BIO split.
> 
> To avoid the unexpected BIO split, reflect the max_segments limit to the
> max_zone_append limit. In the worst case, the safe max_zone_append size
> is max_segments multiplied by PAGE_SIZE. Compare it with the
> max_zone_append size obtained from ZNS devices, and set the smaller
> value as the max_zone_append limit.
> 
> Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  drivers/nvme/host/zns.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index ec8557810c21..9ee77626c235 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -10,9 +10,11 @@
>  int nvme_revalidate_zones(struct nvme_ns *ns)
>  {
>  	struct request_queue *q = ns->queue;
> +	unsigned int max_sectors = queue_max_segments(q) << PAGE_SECTORS_SHIFT;
>  
>  	blk_queue_chunk_sectors(q, ns->zsze);
> -	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
> +	max_sectors = min(max_sectors, ns->ctrl->max_zone_append);
> +	blk_queue_max_zone_append_sectors(q, max_sectors);

You could combine these 2 lines:

	blk_queue_max_zone_append_sectors(q,
		min(max_sectors, ns->ctrl->max_zone_append));

>  
>  	return blk_revalidate_disk_zones(ns->disk, NULL);
>  }

Christoph,

I feel like a lot of the special casing for zone append bio add page can be
removed from the block layer. This issue was found with zonefs tests on real zns
devices because of this huge (and incorrect) zone append limit that zns has,
combined with the recent zonefs iomap write change which overlooked the fact
that bio add page is done by iomap before the bio op is set to zone append. That
resulted in the large BIO. This problem however does not happen with scsi or
null blk, kind-of proving that the regular bio add page is fine for zone append
as long as the issuer has the correct zone append limit. Thought ?

-- 
Damien Le Moal
Western Digital Research


