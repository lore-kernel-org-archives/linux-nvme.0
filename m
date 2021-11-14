Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4AEC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:28:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4A961027
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 10:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A4A961027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=usnN5Hiik11qFznqCYLBFZe3+7zscsCCngQY2DFoHHI=; b=UoQ+Q56cI5/kU2tjPW342PCVJj
	7eltXEZN8IYCFNk9HL3T1WlXAZRB1MHAGA/CVlRQp1x90nmMeRaECGmE/qCaRjf02Bg1aF1cioMKM
	VbpoPH/YrNboSmxMla0wMHYdQ/ugK2O1zfSL5upLAQTg7tx4A1T6ypIip3W6xhMX4Zk25q8yn6gpK
	sI2wDlGO7vbWWETBUVhxPf5LqG7Bn5+40+L9YQaBq5wn8X37VbTAjR8L8xRJ2bcUhLElWCvyjVbUd
	8jNgzmRUrAoyWIq+icBAe2lwuhmEaE2ajYx42eamKh7ybVoH1Ttixnas4UmB/9hLFMMBFD1HLVy5i
	Q9Omf1Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmCkm-00DWUY-GU; Sun, 14 Nov 2021 10:28:52 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmCki-00DWTt-SE
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 10:28:50 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 b184-20020a1c1bc1000000b0033140bf8dd5so10025899wmb.5
 for <linux-nvme@lists.infradead.org>; Sun, 14 Nov 2021 02:28:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=usnN5Hiik11qFznqCYLBFZe3+7zscsCCngQY2DFoHHI=;
 b=u+0SkQ3XDzFNQ41QurFmfwkC8WmyetNrZ0BBVPZF4f3o6kJj+iPAtPWGqJ17ScVoVD
 cKt2h+o9v80PvlOJTZmnNTE1jfTAE5wU+5F4jUsdgsiVEZYAnXp4tIYFJlzMWvCsJiSl
 xXrY/uO64p3MuveR+w65KJ5b1Lzawh7JoXHQIKCJcBEZ6x2RqhQp182KImjBCH2kyF0D
 wzj6vYt2CyZiZYUbha35MCq6N4RADimdeJ5rWAVTYC+NOykbUDv1D4uMDLhseOk9P8r8
 oYv1ahHFrap088VB2r4cu/t2oNgiUnGYNJ1Zyzmrk9hUOMXCMvSmwXEyVU8NbW7SqaNP
 KZbw==
X-Gm-Message-State: AOAM533RAgzIhaN6y9wAnpmuh29lKrnYMdp72vCzJ09GP1tsdocIzUyB
 soad2eRrHq5s8/ypchNRW11zwhSPmvk=
X-Google-Smtp-Source: ABdhPJxf450Pjg6MwyVFaHqKw07EsbnUJne4LebymmyA6mJUWIoYTfA2UY4lD9RuK+ByJdqA/FJE8A==
X-Received: by 2002:a05:600c:4fcc:: with SMTP id
 o12mr51716194wmq.110.1636885727682; 
 Sun, 14 Nov 2021 02:28:47 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id be3sm6388298wmb.1.2021.11.14.02.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Nov 2021 02:28:47 -0800 (PST)
Subject: Re: [PATCH 2/2] nvmet: fix a race condition between release_queue and
 io_work
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
 chaitanya.kulkarni@wdc.com, jmeneghi@redhat.com
References: <20211021084155.16109-1-mlombard@redhat.com>
 <20211021084155.16109-3-mlombard@redhat.com>
 <54e0464e-0d05-4611-10d9-7b706900af28@grimberg.me>
 <20211028075531.GA4904@raketa>
 <68b69eee-c08c-a449-7e18-96e67a3c0c9d@grimberg.me>
 <20211103113125.GA106365@raketa>
 <24a4036b-4f11-91f4-ee0e-80a43f689b09@grimberg.me>
 <20211112105430.GA192791@raketa>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ee5a0405-a8a5-0d8a-d3be-11fe1011c073@grimberg.me>
Date: Sun, 14 Nov 2021 12:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105430.GA192791@raketa>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_022848_949469_F7B4A67C 
X-CRM114-Status: GOOD (  31.54  )
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



On 11/12/21 12:54 PM, Maurizio Lombardi wrote:
> Hi Sagi,
> 
> On Thu, Nov 04, 2021 at 02:59:53PM +0200, Sagi Grimberg wrote:
>>
>> Right, after the call to cancel_work_sync we will know that io_work
>> is not running. Note that it can run as a result of a backend completion
>> but that is ok and we do want to let it run and return completion to the
>> host, but the socket should already be shut down for recv, so we cannot
>> get any other byte from the network.
> 
> 
> I did some tests and I found out that kernel_recvmsg() sometimes returns
> data even if the socket has been already shut down (maybe it's data it received
> before the call to kernel_sock_shutdown() and waiting in some internal buffer?).
> 
> So when nvmet_sq_destroy() triggered io_work, recvmsg() still returned data
> and the kernel crashed again despite the socket was closed.
> 
> Therefore, I think that after we shut down the socket we
> should let io_work run and requeue itself until it finishes its job
> and no more data is returned by recvmsg(),
> one way to achieve this is to repeatedly call flush_work() until it returns
> false.
> 
> Right now I am testing the patch below and it works perfectly.
> 
> Note that when the socket is closed recvmsg() might return 0,
> nvmet_tcp_try_recv_data() should return -EAGAIN
> in that case otherwise we end up in an infinite loop (io_work
> will countinously requeue itself).
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 2f03a94725ae..7b441071c6b9 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1139,8 +1139,10 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   	while (msg_data_left(&cmd->recv_msg)) {
>   		ret = sock_recvmsg(cmd->queue->sock, &cmd->recv_msg,
>   			cmd->recv_msg.msg_flags);
> -		if (ret <= 0)
> +		if (ret < 0)
>   			return ret;
> +		else if (ret == 0)
> +			return -EAGAIN;
>   
>   		cmd->pdu_recv += ret;
>   		cmd->rbytes_done += ret;
> @@ -1446,8 +1450,10 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
>   	list_del_init(&queue->queue_list);
>   	mutex_unlock(&nvmet_tcp_queue_mutex);
>   
> +	kernel_sock_shutdown(queue->sock, SHUT_RD);
> +
>   	nvmet_tcp_restore_socket_callbacks(queue);

I think you should shutdown the socket after you restore the socket
callbacks, and after that cancel_work_sync to deny a self-requeue.

> -	flush_work(&queue->io_work);
> +	while (flush_work(&queue->io_work));
>   
>   	nvmet_tcp_uninit_data_in_cmds(queue);
>   	nvmet_sq_destroy(&queue->nvme_sq);
> 

How about something like this:
--
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 6eb0b3153477..6425375faf5b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1436,7 +1436,9 @@ static void nvmet_tcp_release_queue_work(struct 
work_struct *w)
         mutex_unlock(&nvmet_tcp_queue_mutex);

         nvmet_tcp_restore_socket_callbacks(queue);
-       flush_work(&queue->io_work);
+       /* stop accepting incoming data */
+       kernel_sock_shutdown(queue->sock, SHUT_RD);
+       cancel_work_sync(&queue->io_work);

         nvmet_tcp_uninit_data_in_cmds(queue);
         nvmet_sq_destroy(&queue->nvme_sq);
--


