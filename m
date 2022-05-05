Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5581C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qpTpJs/4UCm/N9rePD3iNkMlzK6M1Zz5A6fn4ya6iZ8=; b=wMll6vom5wuiDvML4wRFqM1IHp
	aUwu1AUKHIXpz4++DeJdVQiCx8qipqNqdHFT0C/EiZ9ydkqRVjwtuWluNLOyf08YiLhM24LQXqXTI
	8ZIeAXxURrfdSBA9m87lFVooD7hLMJrVmcL9eMkkyH82OSVSkE72twL4YXjqehACc0r4Ghkynp+zL
	eHIypmVPgdF4B6qYWPvfLx1kb/QHFbriJAyDVnVa3DrU8nTzg9F2qg8bMHEQ0aZ8sLbtmrjDtzBTx
	JLOdugYx0KeTnSQ5dilaJM3ph1IWebN+WXcdZp1PpGU08rdHO4JuMhracECFdCEKjah9z8tgFP22V
	kbLdtASg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmcuG-00GUdT-Hy; Thu, 05 May 2022 14:56:40 +0000
Received: from out2.migadu.com ([2001:41d0:2:aacc::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmcuC-00GUZ1-9j
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 14:56:38 +0000
Message-ID: <67dd4b8f-2429-099c-c4ca-e8ff10da0647@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1651762589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpTpJs/4UCm/N9rePD3iNkMlzK6M1Zz5A6fn4ya6iZ8=;
 b=IHJShaktUmtr2rKCv/DV3WePNPLf+6bG6LXEYjn/XcGx1pcxdNF790jfJmIlaEqsRYqaKN
 KNdq4iibPmUlz4fIpY6kgLvQRqr7AoF01TIAjMbdYMnKs12ZZNhakMd6B0aCOX+VZx1KaT
 gBdtlCwe+Q7L/CTuWvXo+ShrsF9+kCg=
Date: Thu, 5 May 2022 08:56:26 -0600
MIME-Version: 1.0
Subject: Re: [PATCH] nvme: set dma alignment to 3
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20220504184325.1439476-1-kbusch@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <20220504184325.1439476-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_075637_425676_B60D059B 
X-CRM114-Status: GOOD (  17.95  )
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

Hey Keith
On 5/4/2022 12:43 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme specification only requires qword alignment for segment
> descriptors, and the driver already guarantees that. The spec has always
> allowed user data to be dword aligned, which is what the queue's
> attribute is for, so relax the alignment requirement to that value.
> 
> While we could allow byte alignment for some controllers when using
> SGLs, we still need to support PRP, and that only allows dword.
> 
> Fixes: 3b2a1ebceba3 ("nvme: set dma alignment to qword")
Just a small nitpick but the original commit uses 'qword' and yours uses '3'
Would it be more descriptive to use 'dword'?

> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index bea054565eed..0a6fb515a339 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1771,7 +1771,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>  		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
>  	}
>  	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
> -	blk_queue_dma_alignment(q, 7);
> +	blk_queue_dma_alignment(q, 3);
>  	blk_queue_write_cache(q, vwc, vwc);
>  }
>  

