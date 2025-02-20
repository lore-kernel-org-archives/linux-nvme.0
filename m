Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7201C021B1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 10:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QIjwu3RYYavwx7GxHSYx3vMs9gSZthvf41B/8METdPg=; b=axf6Lnq56b2MS2X0lKhCUJ6/es
	pbBUw7MaFY0z6kW4swgDUG7sc9rSkwBXLYnScgK9JhdO1bO4TKXko6WwJ1oWlSdc3oLZlOYuysk3l
	9CqRorYHsVFBvD3dL7w8pJ8VP+EJK0LEIxC7Ag13CnC8SIs0sHvVaP5cjtPUqn28Epy0LLNGXF/He
	4Dyxxy/jz9QWcFFhRmTtdi/wJIZTVltluluh6OyckHmHSPBl9aHSfr8Eb6eGBWflRCNLJbs6LSCZ9
	JyAbpOC//xvUing3/L1hyuQDSBWEFQax2EO910gALYqkjnL1MGdxbNFtn3QXX/B63aiIKigFuknXF
	BJFF1jDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl41B-00000000LeM-1m1R;
	Thu, 20 Feb 2025 10:42:57 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl419-00000000LcD-0krC
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 10:42:56 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38f2f783e4dso667013f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 02:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048173; x=1740652973;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIjwu3RYYavwx7GxHSYx3vMs9gSZthvf41B/8METdPg=;
        b=tuT3c5flZKp342t2/FixEO4vt32kzTyKGphDxH/smULotl3O0mZo+SLIgjOB7NuGNJ
         JHJwjNtRJL3hsfe7WJ16imi4xsBa6XyRXlBbvSQYHV0vntfipWU/+MIlqQi0Ncvd9y5v
         b6aZpxd5Aom9wiYONVAHKf+OkCjPCWJdEy4PJl1d0pE7fRnPGSXK61bLCe03lWohCzsy
         f6PNuSAJZfcCLzXKdTLJGTva9U9J8WJ4qKcqD6Hi5T1QsY38+ae6iWKoztUgSJJhOi5r
         WuvA4hSCz2p2lxYUE2VGzOoQMkdwJ6hGEvfdJLh22Y5TgvOGHLP+LQIhpL3oB0k205wz
         Dx/w==
X-Gm-Message-State: AOJu0YyZqCVFqJp859m8/f0HdGnzj4jTfsdJEaTkCsFjo+QpcoCvJdh2
	GK7nW4CiGa3lQliydj9wsyw97RPeDG0QRaAYuHhYAucWBqAMxVXr
X-Gm-Gg: ASbGncuVcPXnxC4hvf29VYsVDSdPWCEHSRgvR85kBn47r8eWHnsZiioooRalCGa9Dt2
	jlhtCZH0eFyyrgc/X3aBvhK9vkua2D+8Ktt5ObjYt5hhKkC0W5tVStrtopIzJVixwVQukW8yzEq
	OVDFIQywhrsPJaHTXp1hqHzRSro6c1kDaJrEyv3TGk9g77XRUSo06J3o5eHgKI9IpBKHzqW2x5K
	JpF+ecTZlv8hzQ+CHNnyHKdhaxapN2rpYezi5kd9bixmLUZDQP5bzp/FzQ9FFRJXitLY/7r12i+
	jdlJwCaSJfKLCkaFJyca6BWmcWkbkjSmT25JhR4pb2JCiYRubmI=
X-Google-Smtp-Source: AGHT+IGna+K4Hn+0IZDEALuChWhz5PrRd1TExpzSUvz416/K++e1s9YIZq2BgOvXa5so75LLaNcaow==
X-Received: by 2002:a05:6000:1a54:b0:38f:4e50:8b0b with SMTP id ffacd0b85a97d-38f58796ab6mr5607169f8f.31.1740048173094;
        Thu, 20 Feb 2025 02:42:53 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b439dsm20077978f8f.8.2025.02.20.02.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:42:52 -0800 (PST)
Message-ID: <500bba3d-d549-40ed-8457-c2e138b6534b@grimberg.me>
Date: Thu, 20 Feb 2025 12:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet-tcp: Enforce update ordering between queue->cmd
 and rcv_state
To: Meir Elisha <meir.elisha@volumez.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
References: <20250219155809.3077375-1-meir.elisha@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250219155809.3077375-1-meir.elisha@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_024255_222457_001788DC 
X-CRM114-Status: GOOD (  23.59  )
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




On 19/02/2025 17:58, Meir Elisha wrote:
> The order in which queue->cmd and rcv_state are updated is crucial.
> If these assignments are reordered by the compiler, the worker might not
> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
> the correct reordering, set rcv_state using smp_store_release().
>
> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>

I think we need a fixes tag, and also rephrase the patch title to 
describe it is
fixing a bug rather than what it is doing.

Something like:
"nvmet-tcp: Fix a possible sporadic response drops in weakly ordered 
architectures"

> ---
> Changes from v2:
> 	- Read queue_state and queue_cmd locally and use load barrier
> 	- Remove unnecessary barrier in nvmet_tcp_handle_h2c_data_pdu
>
> Changes from v1:
> 	- Change comments to c-style
>
>   drivers/nvme/target/tcp.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 7c51c2a8c109..20fc1a27b720 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -572,9 +572,15 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>   		container_of(req, struct nvmet_tcp_cmd, req);
>   	struct nvmet_tcp_queue	*queue = cmd->queue;
>   	struct nvme_sgl_desc *sgl;
> +	enum nvmet_tcp_queue_state queue_state = READ_ONCE(queue->state);
> +	/*
> +	 * Use an acquire load to ensure that any updates to queue->state are visible
> +	 * before loading queue->cmd.
> +	 */
> +	struct nvmet_tcp_cmd *queue_cmd = smp_load_acquire(&queue->cmd);

Nit, lets move this above the sgl.

>   	u32 len;
>   
> -	if (unlikely(cmd == queue->cmd)) {
> +	if (unlikely(cmd == queue_cmd)) {
>   		sgl = &cmd->req.cmd->common.dptr.sgl;
>   		len = le32_to_cpu(sgl->length);
>   
> @@ -583,7 +589,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>   		 * Avoid using helpers, this might happen before
>   		 * nvmet_req_init is completed.
>   		 */
> -		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
> +		if (queue_state == NVMET_TCP_RECV_PDU &&
>   		    len && len <= cmd->req.port->inline_data_size &&
>   		    nvme_is_write(cmd->req.cmd))
>   			return;
> @@ -847,8 +853,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
>   {
>   	queue->offset = 0;
>   	queue->left = sizeof(struct nvme_tcp_hdr);
> -	queue->cmd = NULL;
> -	queue->rcv_state = NVMET_TCP_RECV_PDU;
> +	WRITE_ONCE(queue->cmd, NULL);
> +	/* Ensure rcv_state is visible only after queue->cmd is set */
> +	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
>   }
>   
>   static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)


