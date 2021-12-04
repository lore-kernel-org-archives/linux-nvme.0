Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE76C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Dec 2021 10:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P96On9OMfnkRrgapNYQYmocdc+Y51XQaGwmtKp+8CkU=; b=RWnBptoT96tZFfE3McPgbEHXVB
	o8iu3Aun4abSKpwGazdfRkB7Z3P+WD9cF7CmQBUSIq+2lzJuGRNcfXz/yvkDNrgf0eXELqugs5DNg
	hIbbVt9sSTtwhmZSA+wTJIJaY2w7+XcMOLkUCvyvLDNK15A3iYzlOcFIpYHERhqQ0+yO2BOa9khN9
	270jHPWqbH2kX5hjAFSEfg6MMhFtNMuJ5IGeg6vSxB4AG8yNuPIlJ4DXXtZLHOx02GXRDpLMdsbyC
	n8lHZLFucGEVOjxHYaYNStVdx58KOtGi1+z2z3pKRow8Wt6aYqwznLPjvWaOfBEYedEJnfTUy3z/C
	wkbo9gzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mtSWo-000DUA-0w; Sat, 04 Dec 2021 10:44:26 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mtSWl-000DSx-8t
 for linux-nvme@lists.infradead.org; Sat, 04 Dec 2021 10:44:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 092CA1FD37;
 Sat,  4 Dec 2021 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638614662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P96On9OMfnkRrgapNYQYmocdc+Y51XQaGwmtKp+8CkU=;
 b=hVN3hHuydmY+OXhs8cbk5fe8s5DssS4U0xM+aPgZ46fH+pFoBEQzM1owUUT/eHi3klbWdL
 2o1np/TUsWgbvukdaynHsp9F6pPUbmcsgNIOIZ4dI5HkDp5EajDW7RHWC4tN2a7f/xmnYo
 Fl3liaDYeRFUdyu/iRt84cJKCQfl4Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638614662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P96On9OMfnkRrgapNYQYmocdc+Y51XQaGwmtKp+8CkU=;
 b=oEeBYa17Uusnh4it7+2P++/G703wUMCHyFFBnF0LJHB+O4AABdYaQpd/YJAQfJvVjfzOOg
 2FbT62KSgRqIOiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC2E813BF8;
 Sat,  4 Dec 2021 10:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Bq4NNIVGq2HaagAAMHmgww
 (envelope-from <hare@suse.de>); Sat, 04 Dec 2021 10:44:21 +0000
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20211203214544.343460-1-axboe@kernel.dk>
 <20211203214544.343460-3-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <2fc88a4a-31a4-538e-5380-5e0cb3b8b042@suse.de>
Date: Sat, 4 Dec 2021 11:44:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211203214544.343460-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211204_024423_483062_540C8E38 
X-CRM114-Status: GOOD (  18.58  )
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

On 12/3/21 10:45 PM, Jens Axboe wrote:
> We'll need it for batched submit as well.
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/nvme/host/pci.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8637538f3fd5..09ea21f75439 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -500,6 +500,15 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
>   	nvmeq->last_sq_tail = nvmeq->sq_tail;
>   }
>   
> +static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
> +				    struct nvme_command *cmd)
> +{
> +	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes), cmd,
> +		sizeof(*cmd));
> +	if (++nvmeq->sq_tail == nvmeq->q_depth)
> +		nvmeq->sq_tail = 0;
> +}
> +
>   /**
>    * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
>    * @nvmeq: The queue to use
> @@ -510,10 +519,7 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
>   			    bool write_sq)
>   {
>   	spin_lock(&nvmeq->sq_lock);
> -	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
> -	       cmd, sizeof(*cmd));
> -	if (++nvmeq->sq_tail == nvmeq->q_depth)
> -		nvmeq->sq_tail = 0;
> +	nvme_sq_copy_cmd(nvmeq, cmd);
>   	nvme_write_sq_db(nvmeq, write_sq);
>   	spin_unlock(&nvmeq->sq_lock);
>   }
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

