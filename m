Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB9FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YvVjMjD8TdSLd/OuNNLzMStyqlFHw/hyM/7ntihUFUg=; b=FLnoiZOYEfCrIwuTsvxbxZR+96
	h5YXL1eFpX5LGmIW8yPnA6R0VtpMioVYHqEv/GO6x35+opKVfzir3fwwop4RxQVUJ+OduaUy5+fl9
	ML+ZMQREtWXWdTysjX3rVZ7bjpUK2vOZRiGqcuBoIfea3nbN2JMGH+S1BNI1t5M9qMKPrvCqzOef7
	VZqSWumijQMm2T92nRmhqk6DAoeZScDPTWrWfqs/d6zNmudPuYr6CdBWXJbE1MhuJUOIK6UsKQC1m
	6MKfNGrJFtaAS+t2y7uz6SckCRPIZZ9+43LpQzRankZow06xlKH2vQdga1Jsfr/VnkzQoXBp7i5tS
	7Vo7BKWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH0F1-009XeQ-VA; Mon, 07 Feb 2022 09:23:23 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH0Es-009Xdi-LM
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 09:23:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BB5A81F37F;
 Mon,  7 Feb 2022 09:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644225792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YvVjMjD8TdSLd/OuNNLzMStyqlFHw/hyM/7ntihUFUg=;
 b=bF0PSB1A+Euo2H+rTwuwVFqlagyv9/r4IDrWF9Pa8pGpyuQH29zpMmg2q5P3GEFUcyGr+K
 quJ8/f05vtsitRBOo5uy+ghoepabe+Evs7R208Z0JWbofROkc8rGax0OSXrrZgV7+lHaFX
 x/rWB/DINLlLdNE0egoZeLvdr88IW4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644225792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YvVjMjD8TdSLd/OuNNLzMStyqlFHw/hyM/7ntihUFUg=;
 b=BCjaOnEFmI8Q+Pb2rYMGhoT1Y8caU6wUuqpE3OP7dUSyUiUoCjzoP923RpoI73cDxvKs+t
 hbRLI3mG0uYOkbAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB42F13B53;
 Mon,  7 Feb 2022 09:23:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jnxoKQDlAGLPGQAAMHmgww
 (envelope-from <hare@suse.de>); Mon, 07 Feb 2022 09:23:12 +0000
Message-ID: <c607c7b4-dba6-32fc-1b71-42bcdd2ef133@suse.de>
Date: Mon, 7 Feb 2022 10:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] nvme-tcp: fix bogus request completion when failing to
 send AER
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Anton Eidelman <anton@lightbitslabs.com>
References: <20220206224013.771411-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220206224013.771411-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_012314_871782_3BDB3A50 
X-CRM114-Status: GOOD (  19.19  )
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

On 2/6/22 23:40, Sagi Grimberg wrote:
> AER is not backed by a real request, hence we should not incorrectly
> assume that when failing to send a nvme command, it is a normal request
> but rather check if this is an aer and if so complete the aer (similar
> to the normal completion path).
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 01e24b5703db..1096a0b0a268 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -913,7 +913,15 @@ static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
>   
>   static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
>   {
> -	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_HOST_PATH_ERROR);
> +	if (nvme_tcp_async_req(req)) {
> +		union nvme_result res = {};
> +
> +		nvme_complete_async_event(&req->queue->ctrl->ctrl,
> +			NVME_SC_HOST_PATH_ERROR, &res);
> +	} else {
> +		nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
> +				NVME_SC_HOST_PATH_ERROR);
> +	}
>   }
>   
>   static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer

