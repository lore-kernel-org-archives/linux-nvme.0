Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AFFC6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gDA/Ghf/TX7kr3KZzREqnH8Bircr4mFG0VwOERlPICE=; b=HljfCj65iDqvQcDL0G8xzYmsO0
	b+BvvkNoi7FwldXRXD+qkZ5ksnIH3dxI05/G6n5kJsxiGFAxRl0wJNXxLqZtxLZPceu8yK4OaU68L
	St3fv+GEtfUvI9drKDFhJ9BiS2UPdbcX3Oj1c4tMGGD1xXhvFhm1B0RQQ0nHG/iK8ucqn3aQVAQeD
	Ej4rtpv3A/VxJDOWEcDLYUxcg5PaIfy0RS23BLPdCDe2ZcDK5Ss94d59+yAb39pmv1yXxDXN+d+VG
	AOCamNAXH64FalEcmB2vjnZ8U2KeAmgDhWt7h/jvPO/Xp2CvTCVgG1SP8WbGzniiC55xSFKOK0xGY
	ks4LOgjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pexOL-00FtnL-2O;
	Wed, 22 Mar 2023 12:16:33 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pexOI-00FtmG-2I
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 12:16:32 +0000
Received: by mail-wm1-f45.google.com with SMTP id m35so11371813wms.4
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 05:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDA/Ghf/TX7kr3KZzREqnH8Bircr4mFG0VwOERlPICE=;
        b=iMDuGUZojqUomVoQpxjFH3TMpy5LPWI3o7ICokDCftPKBUO07RHEOSAsqf8kGhGl+N
         IH16Buy3x8VIz7KWI0jTUFG75G2kZOsVJdr6eZs7UI0jFd0U6rb0z72ZtP3olCy7EA3m
         iNlXREE8CD2Y9U0h6ni2zeNLwmbq87zlb4Vp82OODMMU7M30g6J6YoS+XtIL3FdP8Wbu
         sNUCfQw3jgzG9DtKlKzOOMiowdx9CJE235h7HOUIf0/pmj+wLMvNtdaYCBaYTvJje32r
         jLN84EiDFK9jw/fIf+rBxXlShWKLVIMSWnD0zFpeSXnK2dLfbO62/Lqhb1MUEYxKrZd1
         UyOw==
X-Gm-Message-State: AO0yUKWtyccYRTo0fQy59AtQFu9tTDLUQY4kdRM5mwuVBZYASTi3OXRA
	N5gTkO1KaG+bMY2t2VmR0yQ=
X-Google-Smtp-Source: AK7set9JFEl8C4+BBWHBNrx4c2J7+8cL7EC8MFu/tyO4Em1JcZLYJTjtlV1qrQFu+pNNEOtZXUnAXw==
X-Received: by 2002:a05:600c:45c3:b0:3eb:f5a2:2d49 with SMTP id s3-20020a05600c45c300b003ebf5a22d49mr5805931wmo.0.1679487389027;
        Wed, 22 Mar 2023 05:16:29 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b003eddc6aa5fasm11156521wmq.39.2023.03.22.05.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 05:16:28 -0700 (PDT)
Message-ID: <c85a6dc1-07b1-daab-2bfd-70cc31309741@grimberg.me>
Date: Wed, 22 Mar 2023 14:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 16/18] nvmet-tcp: rework sendpage for kTLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-17-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-17-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_051630_751428_3A836A1A 
X-CRM114-Status: GOOD (  18.13  )
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


> kTLS ->sendpage() doesn't support the MSG_EOR flag, and it's
> questionable whether it makes sense for kTLS as one has to copy
> data anyway.
> So use sock_no_sendpage() for kTLS.

Same comments as the host side.
1. separate MSG_EOR from kernel_sendpage
2. keep kernel_sendpage unless unsupported properly.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 56 ++++++++++++++++++++++++++++-----------
>   1 file changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 6e88e98a2c59..9b69cac84508 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -570,9 +570,14 @@ static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
>   	int left = sizeof(*cmd->data_pdu) - cmd->offset + hdgst;
>   	int ret;
>   
> -	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->data_pdu),
> -			offset_in_page(cmd->data_pdu) + cmd->offset,
> -			left, MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> +	if (cmd->queue->tls_psk)
> +		ret = sock_no_sendpage(cmd->queue->sock, virt_to_page(cmd->data_pdu),
> +				      offset_in_page(cmd->data_pdu) + cmd->offset,
> +				      left, MSG_DONTWAIT | MSG_MORE);
> +	else
> +		ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->data_pdu),
> +				      offset_in_page(cmd->data_pdu) + cmd->offset,
> +				      left, MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
>   	if (ret <= 0)
>   		return ret;
>   
> @@ -600,10 +605,17 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>   		if ((!last_in_batch && cmd->queue->send_list_len) ||
>   		    cmd->wbytes_done + left < cmd->req.transfer_len ||
>   		    queue->data_digest || !queue->nvme_sq.sqhd_disabled)
> -			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> -
> -		ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
> -					left, flags);
> +			flags |= MSG_MORE;
> +
> +		if (queue->tls_psk)
> +			ret = sock_no_sendpage(cmd->queue->sock, page, cmd->offset,
> +					       left, flags);
> +		else {
> +			if (flags & MSG_MORE)
> +				flags |= MSG_SENDPAGE_NOTLAST;
> +			ret = kernel_sendpage(cmd->queue->sock, page, cmd->offset,
> +					      left, flags);
> +		}
>   		if (ret <= 0)
>   			return ret;
>   
> @@ -645,12 +657,19 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
>   	int ret;
>   
>   	if (!last_in_batch && cmd->queue->send_list_len)
> -		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> -	else
> +		flags |= MSG_MORE;
> +	else if (!cmd->queue->tls_psk)
>   		flags |= MSG_EOR;
>   
> -	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->rsp_pdu),
> -		offset_in_page(cmd->rsp_pdu) + cmd->offset, left, flags);
> +	if (cmd->queue->tls_psk)
> +		ret = sock_no_sendpage(cmd->queue->sock, virt_to_page(cmd->rsp_pdu),
> +			offset_in_page(cmd->rsp_pdu) + cmd->offset, left, flags);
> +	else {
> +		if (flags & MSG_MORE)
> +			flags |= MSG_SENDPAGE_NOTLAST;
> +		ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->rsp_pdu),
> +			offset_in_page(cmd->rsp_pdu) + cmd->offset, left, flags);
> +	}
>   	if (ret <= 0)
>   		return ret;
>   	cmd->offset += ret;
> @@ -673,12 +692,19 @@ static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>   	int ret;
>   
>   	if (!last_in_batch && cmd->queue->send_list_len)
> -		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> -	else
> +		flags |= MSG_MORE;
> +	else if (!cmd->queue->tls_psk)
>   		flags |= MSG_EOR;
>   
> -	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->r2t_pdu),
> -		offset_in_page(cmd->r2t_pdu) + cmd->offset, left, flags);
> +	if (cmd->queue->tls_psk)
> +		ret = sock_no_sendpage(cmd->queue->sock, virt_to_page(cmd->r2t_pdu),
> +			offset_in_page(cmd->r2t_pdu) + cmd->offset, left, flags);
> +	else {
> +		if (flags & MSG_MORE)
> +			flags |= MSG_SENDPAGE_NOTLAST;
> +		ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->r2t_pdu),
> +			offset_in_page(cmd->r2t_pdu) + cmd->offset, left, flags);
> +	}
>   	if (ret <= 0)
>   		return ret;
>   	cmd->offset += ret;

