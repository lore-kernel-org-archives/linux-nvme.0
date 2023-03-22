Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD04C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 12:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tITh4dChYxkdvElKxegNDMZLJ2gmBrwwzBXiwwFG7p8=; b=BDyTQePAkmNe8lM+h6FFaTd0R/
	oTfTx5TjftMw1KR4dkAC0uP9bGEZf8bIY/xG3DKRCRKKueoaILlRIBR9k/9g8CpHb+ldP54z8rc02
	s9rhmq+x5B1eKhuLE35CPdWRdEizO6wtWWLhjlqRxbYku8E69+vdXGpYtvpsWJsH697VY399Z7/Tk
	Xddn5/QtFYiVSbrMbE3Pgg2OcY/fl40DCmc59I4blEHhi3/LvtgCDLD2/B4ReHezJTacYlWsCRZ16
	ufudLGEob20dXF+4z9F7jta7JTHb60iYB7sh8UIm1WX7mX8BEvP9fmvIux+AnmjN4qDF3fQ+JkNB/
	bTuv7p2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pexWP-00FvJI-1W;
	Wed, 22 Mar 2023 12:24:53 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pexWM-00FvIG-0Q
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 12:24:51 +0000
Received: by mail-wm1-f49.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so6490890wmq.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 05:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487886; x=1682079886;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tITh4dChYxkdvElKxegNDMZLJ2gmBrwwzBXiwwFG7p8=;
        b=xW0C0ZuopemWXZAW4tczO9K62MYeZvodrRT5+RABgu+uYOrOB9vP0GjmcSwimVE3p4
         Mf0QwClwe2eXumJU8s/6mt1ZJJVsKzwcyyMKpi3gjNQBcipPogR6tvFZ1hFoKCyOxbcA
         +Bj6dtAHAEV5Fn3Z4VwBrOuagIbYazJWuO0fSlebT21uf6iaCIeUab1DWW+Yho4CPmpi
         VZF5Z50FZp+8vKUpq7c9zHAhfeA7Y6ECXBwkB3+fi0YzhsK7x3vJcTkg/57vHYLLQv/d
         CWVulUndlHea5bi98JZbVSoTG/8nf59rghYnOSXACoJYIycfi3wt7n8q9HfgQokDMXnJ
         Q26Q==
X-Gm-Message-State: AO0yUKW+prtWEtQn0MTGw+6ayCkhv9EOExLzKbWitA3djCMyWCXXhhMW
	xBfWyTmpyNh3hj3d5tDpZ5w=
X-Google-Smtp-Source: AK7set+NcyNnnfdwbnu9SnPtbrsgXCc3q7AWF32KXpsoHWY72qpFrbtwDCdKgMruqbMmN28Eu0+jdg==
X-Received: by 2002:a05:600c:46c4:b0:3eb:2e2a:be95 with SMTP id q4-20020a05600c46c400b003eb2e2abe95mr6029677wmo.2.1679487886031;
        Wed, 22 Mar 2023 05:24:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c05c500b003edf2ae2432sm9515845wmd.7.2023.03.22.05.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 05:24:45 -0700 (PDT)
Message-ID: <c7d0546b-0844-b1aa-7e35-0b304ebc59e9@grimberg.me>
Date: Wed, 22 Mar 2023 14:24:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 18/18] nvmet-tcp: peek icreq before starting TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-19-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-19-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_052450_163860_090E30E9 
X-CRM114-Status: GOOD (  23.19  )
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



On 3/21/23 14:43, Hannes Reinecke wrote:
> Incoming connection might be either 'normal' NVMe-TCP connections
> starting with icreq or TLS handshakes. To ensure that 'normal'
> connections can still be handled we need to peek the first packet
> and only start TLS handshake if it's not an icreq.

I think that for nvmet, we will want to strictly enforce tsas.sectype.
What are we gaining from allowing this?

And if you insist that we must, then this needs to be an explicit
setting to a permissive mode.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 60 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index a69647fb2c81..a328a303c2be 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1105,6 +1105,61 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
>   	return false;
>   }
>   
> +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
> +{
> +	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
> +	int len;
> +	struct kvec iov = {
> +		.iov_base = (u8 *)&queue->pdu + queue->offset,
> +		.iov_len = sizeof(struct nvme_tcp_hdr),
> +	};
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
> +	unsigned char ctype;
> +	struct cmsghdr *cmsg;
> +	struct msghdr msg = {
> +		.msg_control = cbuf,
> +		.msg_controllen = sizeof(cbuf),
> +		.msg_flags = MSG_PEEK,
> +	};
> +
> +	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> +			iov.iov_len, msg.msg_flags);
> +	if (unlikely(len < 0)) {
> +		pr_debug("queue %d peek error %d\n",
> +			 queue->idx, len);
> +		return len;
> +	}
> +
> +	cmsg = (struct cmsghdr *)cbuf;
> +	if (CMSG_OK(&msg, cmsg) &&
> +	    cmsg->cmsg_level == SOL_TLS &&
> +	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
> +		ctype = *((unsigned char *)CMSG_DATA(cmsg));
> +		if (ctype != TLS_RECORD_TYPE_DATA) {
> +			pr_err("queue %d unhandled TLS record %d\n",
> +				queue->idx, ctype);
> +			return -ENOTCONN;
> +		}
> +	}
> +
> +	if (len < sizeof(struct nvme_tcp_hdr)) {
> +		pr_debug("queue %d short read, %d bytes missing\n",
> +			 queue->idx, (int)iov.iov_len - len);
> +		return -EAGAIN;
> +	}
> +	pr_debug("queue %d hdr type %d hlen %d plen %d size %d\n",
> +		 queue->idx, hdr->type, hdr->hlen, hdr->plen,
> +		 (int)sizeof(struct nvme_tcp_icreq_pdu));
> +	if (hdr->type == nvme_tcp_icreq &&
> +	    hdr->hlen == sizeof(struct nvme_tcp_icreq_pdu) &&
> +	    hdr->plen == sizeof(struct nvme_tcp_icreq_pdu)) {
> +		pr_debug("queue %d icreq detected\n",
> +			 queue->idx);
> +		return len;
> +	}
> +	return 0;
> +}
> +
>   static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>   {
>   	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
> @@ -1879,8 +1934,9 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   
>   	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
>   		nvmet_tcp_save_tls_callbacks(queue);
> -		if (!nvmet_tcp_tls_handshake(queue))
> -			return;
> +		if (!nvmet_tcp_try_peek_pdu(queue))

Who guarantees that a payload already exist? Where is the peek resumes
when a payload already exist?

> +			if (!nvmet_tcp_tls_handshake(queue))
> +				return;
>   		nvmet_tcp_restore_tls_callbacks(queue);
>   
>   		/*

