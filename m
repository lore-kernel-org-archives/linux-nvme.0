Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0263C001B0
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLg/Pzw8OnP8E1Kn7LhRYPEbzks7YCm0whxdNuxlWIg=; b=l/xSQ9glmmgY/xnk0F83iSks5N
	xkVcXBGaqOponhyCHMeCf+zQLtJ+/ul8HWUG70WZldr/JE5tORpzBayYcCXPhY45HATUoAWADI9KZ
	GiTwZl/ybtbwOZTVlg+3NzyvEXQ/Fq+/homT7QL4uird8nsgI8AcFVdv+5/UG4LxgIPf57iP2YEHE
	sFfGbRVZUhaF19AW1QAgsG8+/t5Q88G8i/MYUYJuO0lRl+mve0QUmOHh5TS7x7bcyGz/mp5J7d92E
	X687kasNMdL/EZ4F/UFHe2zkyzMp8y/8Sh9QngsQ6QoKCSWXgB56ZEZyf0SGjtZ4+V35HKgR8/KPT
	BrvXm0gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qThOc-004mDk-0u;
	Wed, 09 Aug 2023 11:30:34 +0000
Received: from mail-lj1-f178.google.com ([209.85.208.178])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qThOZ-004mCy-2E
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 11:30:33 +0000
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b9eaa7c83dso14432451fa.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 04:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691580629; x=1692185429;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLg/Pzw8OnP8E1Kn7LhRYPEbzks7YCm0whxdNuxlWIg=;
        b=KUHNfA+Zq7n6rEmlLuUKOHe1b13w//KLjH/+Zwfn3rUyfLSHUYMKB809YMwCGc6kbF
         +Zf0hsM/H3MY6xLUFTGD7W6Z+QUJkQA6BBzCc5Un5zHRPjV/aUbswiGjAZuMTEdzJk9J
         Wn470rvdS7ShSBVPD9mYazXGsq9RTPpeEPgxEAP9BSCN0ilYxnGgQu7P72Dh+tkcLlOn
         E0+N/Pvv8w8JynV1J/cdl6HwZxSdHwYKJBohwloVsP69g4T1RnXRYCgG/3tVcSEx5Ykk
         qMzO2bNpwoVrbvNAEsQFZ9l6cTajGx+QnlbxA9Tsvo0ZgF4E5xLaSxMEPZxG9sWWqyLG
         JvCQ==
X-Gm-Message-State: AOJu0YyJR1kx71p/FYJQktkqrtQPKau0FVPjTklwiAS56Vv+ReSFbO6v
	j93ofq2lR1okbeGI8JkwZDd78eUq6RU=
X-Google-Smtp-Source: AGHT+IFi6YpyK8eCUG1VUSO9kOWwhJV4APNY6C2rr41YlFna/Yykavg1xirE0nWqCE7aKhPOl0QSnw==
X-Received: by 2002:a17:906:5306:b0:993:f349:c989 with SMTP id h6-20020a170906530600b00993f349c989mr1497082ejo.7.1691580608931;
        Wed, 09 Aug 2023 04:30:08 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709064c9200b009875a6d28b0sm7872934eju.51.2023.08.09.04.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 04:30:08 -0700 (PDT)
Message-ID: <3b667ce4-e7c7-78a8-ccec-3cbe7620657f@grimberg.me>
Date: Wed, 9 Aug 2023 14:30:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/16] nvmet-tcp: control messages for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-17-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808165354.123499-17-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_043031_733173_037E094C 
X-CRM114-Status: GOOD (  26.51  )
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



On 8/8/23 19:53, Hannes Reinecke wrote:
> kTLS requires control messages for recvmsg() to relay any out-of-band
> TLS messages (eg TLS alerts) to the caller.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/tcp.c | 83 +++++++++++++++++++++++++++++++++------
>   1 file changed, 72 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 75e4cb4c2f29..e1aea52e58da 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -14,6 +14,7 @@
>   #include <net/sock.h>
>   #include <net/tcp.h>
>   #include <net/tls.h>
> +#include <net/tls_prot.h>
>   #include <net/handshake.h>
>   #include <linux/inet.h>
>   #include <linux/llist.h>
> @@ -70,6 +71,9 @@ device_param_cb(idle_poll_period_usecs, &set_param_ops,
>   MODULE_PARM_DESC(idle_poll_period_usecs,
>   		"nvmet tcp io_work poll till idle time period in usecs: Default 0");
>   
> +#define nvmet_queue_is_tls(queue) \
> +    ((queue)->port->nport->disc_addr.tsas.tcp.sectype == NVMF_TCP_SECTYPE_TLS13)

That is some steep dereferencing... I'd say just cache a flag
in the queue itself, or in the port.

> +
>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
>   /*
>    * TLS handshake timeout
> @@ -118,6 +122,7 @@ struct nvmet_tcp_cmd {
>   	u32				pdu_len;
>   	u32				pdu_recv;
>   	int				sg_idx;
> +	char				recv_cbuf[CMSG_LEN(sizeof(char))];
>   	struct msghdr			recv_msg;
>   	struct bio_vec			*iov;
>   	u32				flags;
> @@ -1116,20 +1121,59 @@ static inline bool nvmet_tcp_pdu_valid(u8 type)
>   	return false;
>   }
>   
> +static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
> +		struct msghdr *msg, char *cbuf)
> +{
> +	struct cmsghdr *cmsg = (struct cmsghdr *)cbuf;
> +	u8 ctype, level, description;
> +	int ret = 0;
> +
> +	if (!nvmet_queue_is_tls(queue))
> +		return 0;
> +
> +	ctype = tls_get_record_type(queue->sock->sk, cmsg);
> +	switch (ctype) {
> +	case 0:
> +		break;
> +	case TLS_RECORD_TYPE_DATA:
> +		break;
> +	case TLS_RECORD_TYPE_ALERT:
> +		tls_alert_recv(queue->sock->sk, msg, &level, &description);
> +		pr_err("TLS Alert level %u desc %u\n", level, description);
> +		ret = (level == TLS_ALERT_LEVEL_FATAL) ?
> +			-ENOTCONN : -EAGAIN;
> +		break;
> +	default:
> +		/* discard this record type */
> +		pr_err("TLS record %d unhandled\n", ctype);
> +		ret = -EAGAIN;
> +		break;
> +	}
> +	return ret;
> +}
> +
>   static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
>   {
>   	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
> -	int len;
> +	int len, ret;
>   	struct kvec iov;
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>   
>   recv:
>   	iov.iov_base = (void *)&queue->pdu + queue->offset;
>   	iov.iov_len = queue->left;
> +	if (nvmet_queue_is_tls(queue)) {
> +		msg.msg_control = cbuf;
> +		msg.msg_controllen = sizeof(cbuf);
> +	}
>   	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>   			iov.iov_len, msg.msg_flags);
>   	if (unlikely(len < 0))
>   		return len;
> +	ret = nvmet_tcp_tls_record_ok(queue, &msg, cbuf);
> +	if (ret < 0)
> +		return ret;
>   
>   	queue->offset += len;
>   	queue->left -= len;
> @@ -1182,16 +1226,21 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
>   static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   {
>   	struct nvmet_tcp_cmd  *cmd = queue->cmd;
> -	int ret;
> +	int len, ret;
>   
>   	while (msg_data_left(&cmd->recv_msg)) {
> -		ret = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
> +		len = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>   			cmd->recv_msg.msg_flags);
> -		if (ret <= 0)
> +		if (len <= 0)
> +			return len;
> +		ret = nvmet_tcp_tls_record_ok(cmd->queue,
> +					      &cmd->recv_msg,
> +					      cmd->recv_cbuf);

I think it will be better to condition on tls on the
call sites, so it will be clearer that we are checking
the tls record only for tls queues.

