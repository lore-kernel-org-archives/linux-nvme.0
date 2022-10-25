Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2302BC04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 06:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jnjwrJaZ2F2azfd7qre0ipINPhjD8k11IAhbhIbkQIY=; b=wg8bFYdm7WoSg6SbXWi3tjLioI
	HVvPWalYpimjpkj3zFybHC7/LVwAMgEx2tD82IUYSyQRZUIro2UXGQJPSYf3lOlIPE84JeBlom0Db
	U2QD0KJ2xSeIZYcxcsGfNOz49ICxPR8PiD6rtQv8xjTXg7SEBFqEvAgEuE8zHq83clOFyVNgHHR6g
	fNqQCAHWjr00yzNvfQQXhbzubncDUZqBz41Da09LeX4UQFz6p0xCfBz09Qed7un2Byt2HM+h8aLSD
	DWz3fseIN43LjIfIJLqogGCjzsTnDWlHsMV/98vQVkcN2kKUg8bLnwchxEBezOy5enyXeiHyTNFat
	xDsAXFkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onDZa-00421p-Qm; Tue, 25 Oct 2022 06:38:02 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onDZX-00420n-OH
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 06:38:01 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92C951FD98;
	Tue, 25 Oct 2022 06:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666679876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnjwrJaZ2F2azfd7qre0ipINPhjD8k11IAhbhIbkQIY=;
	b=GG1qCXrDnJJHnksFUTWk8Z/o2u0mauly7Ajl9TQYZ1cfJXUCsfiuXO15FwUj1ZSgnvBVFT
	rCiSZc5ysaB/6RrQhTCaFNz0KsTy8YJ39UxR1vuty/4ZpkCsQqZZyrvmgY7KQgYr8a+ua8
	WYXVjvg9jBF/QhpUrIJjgJWqsjLra74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666679876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jnjwrJaZ2F2azfd7qre0ipINPhjD8k11IAhbhIbkQIY=;
	b=9qMMZT2d8+JbaLsl0NFq1O7VM14V/4aa1o2179Qaw/zBL0fSpHcwFI/RnDBv31tFV0kaQN
	kehvxpATtIRWA7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7780A134CA;
	Tue, 25 Oct 2022 06:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cKALHESEV2OrZQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Oct 2022 06:37:56 +0000
Message-ID: <04a26209-f5ad-3f97-62f5-a07ad0350733@suse.de>
Date: Tue, 25 Oct 2022 08:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20221024150334.29215-1-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221024150334.29215-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_233759_986587_0816EDFE 
X-CRM114-Status: GOOD (  24.40  )
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

On 10/24/22 17:03, Daniel Wagner wrote:
> Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
> large amounts of requests.
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> 
> IMO, this patch might still be a good idea to add. At least in my test
> setup where I only have one ethernet port it makes a big difference
> when accessing the system via ssh. When nvme-tcp is pushing a lot of
> data via the network, the ssh session is completely blocked by the
> storage traffic. With it, the ssh session stays responsive.
> 
> I suspect a proper storage setup would use more than one ethernet
> port.
> 
> Daniel
> 
> v1:
>    https://lore.kernel.org/linux-nvme/20220519062617.39715-4-hare@suse.de/
> 
>   drivers/nvme/host/tcp.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3e7b29d07c71..84a66ca208c8 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -308,12 +308,23 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
>   
>   static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>   {
> -	int ret;
> +	unsigned long deadline = jiffies + msecs_to_jiffies(1);
>   
>   	/* drain the send queue as much as we can... */
>   	do {
> -		ret = nvme_tcp_try_send(queue);
> -	} while (ret > 0);
> +		bool pending = false;
> +		int result;
> +
> +		result = nvme_tcp_try_send(queue);
> +		if (result > 0)
> +			pending = true;
> +		else if (unlikely(result < 0))
> +			return;
> +
> +		if (!pending)
> +			return;
> +
> +	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
>   }
>   
>   static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)

Looks like a good idea indeed.
One might want to make the deadline configurable, though.
Other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


