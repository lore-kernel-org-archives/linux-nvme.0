Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA37BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 07:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b6Jq+WqltgHYDIE8h1uOgHbz6klPpXh5o/pVBvCWD3U=; b=UdKziSRaL0N/O9xL9rOYezWyOB
	CV1NyZjO6tflGX/+YwyfjFAYBuE6PUf1b5+vmj+WNpbYuLGPzD5BbWglLSrF5jHuSXZ71m/L2j+n8
	hAC6KlZizccWs/otqtSQ1fDHQkzyok9sqf4cizVcNtbpjBjUKPz6ruzaXVF/pLpPEgkTHzQ50Y1ey
	HlGtaxgLb4v7cJl0Yn72KKc8fsFjv+LxLPxOr1v+GLWKO3ReIH+MPfDv7wEIa9EsPtH+ah3iHdKiw
	zjx9yePD7Eodl3AI7ulWYEt65K6E9WGB9BC+OL0q+D4mt/0pV5ZIIM3enzLHcNcPVYdTHF/M8VtE8
	nZG0NAlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfkr-00BjOb-Hh; Wed, 09 Nov 2022 07:44:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfkl-00Bj0B-6M
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 07:44:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A68B41F6E6;
	Wed,  9 Nov 2022 07:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667979845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6Jq+WqltgHYDIE8h1uOgHbz6klPpXh5o/pVBvCWD3U=;
	b=WdtWevEs+6A4nTUwMoyTgYe4CDf2cvfjfL6WsYsQHKcNMqzUl80Sc0T8Zm/bpH33yf2qTQ
	CGqA1nLjjmZbxs8n9t6gwNJlAbJcYmwAYcAsgPVpZaPdh+eiFOHgx1Ag+VGVjULD7dL5Rp
	hbFjuhRGxcOGQ8EvhqdaE90QRgchbxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667979845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6Jq+WqltgHYDIE8h1uOgHbz6klPpXh5o/pVBvCWD3U=;
	b=T+9oFbCQego/QtjkKpdefCnhzLB5MxA4q3fDBsXHRedAWmiT34e/I+3Z0QaMh7okIf6SE5
	B3nDQ7YQ8rAm8/DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E873139F1;
	Wed,  9 Nov 2022 07:44:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Bsp6F0Vaa2NXOwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 07:44:05 +0000
Message-ID: <098502b9-0021-1d17-7fe0-aef101bbb745@suse.de>
Date: Wed, 9 Nov 2022 08:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 14/16] nvme-auth: have dhchap_auth_work wait for queues
 auth to complete
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
 <20221109034420.1000086-15-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-15-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_234407_403385_0579E829 
X-CRM114-Status: GOOD (  21.00  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> It triggered the queue authentication work elements in parallel, but
> the ctrl authentication work itself completes when all of them
> completes. Hence wait for queues auth completions.
> 
> This also makes nvme_auth_stop simply a sync cancel of ctrl
> dhchap_auth_work.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 0159179c2455..e88d6254f2f5 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -924,6 +924,12 @@ static void nvme_dhchap_auth_work(struct work_struct *work)
>   	 * Failure is a soft-state; credentials remain valid until
>   	 * the controller terminates the connection.
>   	 */
> +	for (q = 1; q < ctrl->queue_count; q++) {
> +		ret = nvme_auth_wait(ctrl, q);
> +		if (ret)
> +			dev_warn(ctrl->device,
> +				 "qid %d: authentication failed\n", q);
> +	}
>   }
>   
Don't we need to clear the dhchap context here?

>   int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
> @@ -974,12 +980,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
>   
>   void nvme_auth_stop(struct nvme_ctrl *ctrl)
>   {
> -	struct nvme_dhchap_queue_context *chap;
> -	int i;
> -
>   	cancel_work_sync(&ctrl->dhchap_auth_work);
> -	nvme_foreach_dhchap(i, chap, ctrl)
> -		cancel_work_sync(&chap->auth_work);
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_stop);
>   
Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


