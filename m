Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2A8D2503B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 06:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wgkrQL7V6uLOZS8mdy+TrpbtMGz7Utgzsw3FwuNEzIc=; b=p3MzJ8E9J4hTkFmglwbDngyUZM
	LQTJyFkx7iL3oJFaJecDNsSb5SaIIGn1hNgYzl8Mc2Hg8vPQetyAMyUHhoU9V7Dv30t4dtHmvaV4G
	ODFniqI3naPK8nCXuy91puhfGIYBPMPSusfTJ7jJqGfO175wtsZLSTfkgaJ0BCsOiarH7MOwsHKZ5
	ZhXRO+K/MmVNLSicAbHprFaGy2saXc3jOwPJWJ7UxGvnClbmiEuFENnWstLDa1au4zAYOdv6blbwS
	hLzQbTN3iRYqcqGG+mRB1ZwDMF1ugZijnupIKgAuLkaQOqNFsHYeYOESzr6evbJS0OTcUQP9XC0Lz
	CrXmLr3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfBmk-00000004q4s-32r0;
	Mon, 12 Jan 2026 06:52:18 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfBmj-00000004q4l-2mDI
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 06:52:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7AD0B60165;
	Mon, 12 Jan 2026 06:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4343EC116D0;
	Mon, 12 Jan 2026 06:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768200736;
	bh=Zr0/lIFCXZjMmjAnh+1bVGpbL0AEOTdDpzHKMbRqAzM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rS7OMSY8x9K2q1tuVXNxghbmBMXcA1zOjJvN41WCIisRpmMa/3X05/rqZvyMRfxH9
	 WO555HJTDdZCx0tIUAn7GeCdD32G1T3NDj+58bIIFH2FNIIZWgSg7OFb0i3xNChkg8
	 TtDP51UolZAu0PJWj8Pk5X0K/zoOH9PGoH0XfoInMsxskNgo1GPoIIjN1ZE+KQuE3N
	 gUBIVpwbiP0GxhlZpxpHxhR3NO+oIxgjt0jmj15eY3Jk16wYn0JgYI473TjK2h1kZO
	 DZaVHgDNtHnbi4W7pSrGxD14lXtFQHNEsbC5iuMpet67n1hhcbh7FbwSyeo1LIqnrm
	 L+/Y87StvU1hQ==
Message-ID: <954593de-bfcc-467f-9279-bb6e87fb6df3@kernel.org>
Date: Mon, 12 Jan 2026 07:52:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme/host: fixup some typos
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20260111233901.2439097-3-wilfred.opensource@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260111233901.2439097-3-wilfred.opensource@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 1/12/26 00:39, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Fix up some minor typos in the nvme host driver and a comment
> style to conform to the standard kernel style.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> V3:
>         - Fixup the comment to standarn kernel style
>         - Drop french style spacing removal.
> ---
>  drivers/nvme/host/tcp.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 69cb04406b47..92749f6d0f96 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -25,7 +25,8 @@
>  
>  struct nvme_tcp_queue;
>  
> -/* Define the socket priority to use for connections were it is desirable
> +/*
> + * Define the socket priority to use for connections where it is desirable
>   * that the NIC consider performing optimized packet processing or filtering.
>   * A non-zero value being sufficient to indicate general consideration of any
>   * possible optimization.  Making it a module param allows for alternative
> @@ -926,7 +927,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>  			req->curr_bio = req->curr_bio->bi_next;
>  
>  			/*
> -			 * If we don`t have any bios it means that controller
> +			 * If we don't have any bios it means that controller

Since you are correcting things, please do correct the grammar too:
...that the controller... :)

Personally, I prefer a more formal style, so I would also change "don't" into
"do not".

>  			 * sent more data than we requested, hence error
>  			 */
>  			if (!req->curr_bio) {


-- 
Damien Le Moal
Western Digital Research

