Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98141C761A6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 12:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JCfDzNMQ70beC5O5GClciZ2nIdUEqxJFrG39irVbzl0=; b=C7hpPyqIcQmwfHm2q4HtVioep2
	UJhiKd6fJ/KJiCyslTCIvWKAUxF/fP0eONClWRL44VLgbSSldP1tvxyqK77HwnJM2gSJd+OBhM7lk
	KGlBplCR71sWd4Sf7WhXufDaACXweW7w3yEH04fGDDb73sugkJgVe0p0YSG6kM0RfS5EZ5QEAOGlP
	Ls5ZQIXMLFJLFpDa3vGfB2/TxKVlKv9Vde8Vvo3tIFERUn+KkRAcN+VjX46LzONCSI1oYo7l8kC58
	XCGQFj5BqKYapWot7uoU8KxNgFkfpVqGzF3lu/JJJDRsK8rtRmzJu03rDmGdNbg577gcui4GK7GSQ
	+pH8KT7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJg6-00FLtC-2z;
	Mon, 03 Apr 2023 12:52:54 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjJg4-00FLqi-1a
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 12:52:53 +0000
Received: by mail-wm1-f47.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so19435481wmq.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Apr 2023 05:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680526370; x=1683118370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCfDzNMQ70beC5O5GClciZ2nIdUEqxJFrG39irVbzl0=;
        b=cTgEexQfkO3uZtdYMPzISF8USKEydoreolLE9kPrcRr8i6kgpOLPTQPvaWrYn4Z3wX
         1OFt5T20iaNn0ztrjjqLlMNeZISh+EdHEiO+93X17lMwYbWuDXqtnfwycQextI3gaNqJ
         x6hxUbuKrScrPvQWm4ZyBqi2uHx1CDAMdiZmOwifWcJ+fZQ6QsotNmfyAyKvqi1+Q/MG
         Wv4oDm92gV8eC1I8nzHHS3/YnRpPS19ObVjQHlKbTEKbnqhZAprYFa830u3ftQe21la2
         3xXKQOXFOeZOVG+L/evCxBzG1NIGNQSisEQuJ5Amtg8sPi2uWwoupONfq01QS/KqXgLe
         mOWA==
X-Gm-Message-State: AAQBX9cfb+i95+yzI0SAIpR7NwwGKst3smsLPPdMdDpbkseTIyjodL07
	7FNVmuZdFPIaRRNVHS6cbBk=
X-Google-Smtp-Source: AKy350b3rviohzUfIO7MFp6Cb4Db5lTTVsqX3JSu5+Yi3U4f6Xie/lw51323655120usIZa88tUvMQ==
X-Received: by 2002:a05:600c:1550:b0:3ed:d2ae:9adb with SMTP id f16-20020a05600c155000b003edd2ae9adbmr11760689wmg.0.1680526369871;
        Mon, 03 Apr 2023 05:52:49 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bca52000000b003ee44b2effasm11977487wml.12.2023.04.03.05.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 05:52:49 -0700 (PDT)
Message-ID: <6b964823-0a49-b2b5-dba5-4ee054d036a7@grimberg.me>
Date: Mon, 3 Apr 2023 15:52:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 16/18] nvmet-tcp: rework sendpage for kTLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-17-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-17-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_055252_530157_7EF8A2E3 
X-CRM114-Status: GOOD (  15.53  )
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

> kTLS ->sendpage() doesn't support the MSG_EOR flag, so blank
> it out if kTLS is enabled.

I'd prefer we don't do this, but lets wait for the verdict from
Jakub.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index ebec882120fd..5daf16138471 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -650,7 +650,7 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
>   
>   	if (!last_in_batch && cmd->queue->send_list_len)
>   		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> -	else
> +	else if (!cmd->queue->tls_psk)
>   		flags |= MSG_EOR;
>   
>   	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->rsp_pdu),
> @@ -678,7 +678,7 @@ static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>   
>   	if (!last_in_batch && cmd->queue->send_list_len)
>   		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> -	else
> +	else if (!cmd->queue->tls_psk)
>   		flags |= MSG_EOR;
>   
>   	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->r2t_pdu),
> @@ -708,7 +708,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
>   
>   	if (!last_in_batch && cmd->queue->send_list_len)
>   		msg.msg_flags |= MSG_MORE;
> -	else
> +	else if (!cmd->queue->tls_psk)
>   		msg.msg_flags |= MSG_EOR;
>   
>   	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);

