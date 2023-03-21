Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150F7C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0IRz85pGwGG2Tpe80ITqJFBqaaHFvPiEer+idqSdXEg=; b=topsQ7SraWVm5GRIHK1rEdpSIU
	2cy2FM9DJ3kVUaqFVaFpbqYyXS3UZJ3bFsDXrsqk6RuFwwO2dXv2g7J7yHjkUEmTDqOv7MZyczKkm
	1V07KkG3McuS0u3PYboiSGn0baq4ZPbn3HhRo5kluDhzW4JTi9wgqkVfT4H2/igEheCNQSshE4/h7
	v2wZvM34fL90HJFNQSgL0oHTq2rmXsFOesf1wYVVq3Qd0jrVJJwR+zxvkcoh9iV8G5TwRlChzKS9F
	ZSlJoQsrxziek2wgfSFVMBV44LuCQLEVObEzbT9/tEJ5aimIFMIZ4/nxR6v3HotT6Jwy4rrW9ofRE
	d4Se2jTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pecPw-00Cbgq-2g;
	Tue, 21 Mar 2023 13:52:48 +0000
Received: from mail-ed1-f52.google.com ([209.85.208.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pecPq-00Cbea-17
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:52:47 +0000
Received: by mail-ed1-f52.google.com with SMTP id b20so27018273edd.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 06:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679406758; x=1681998758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0IRz85pGwGG2Tpe80ITqJFBqaaHFvPiEer+idqSdXEg=;
        b=WiG5WLKkc8sefRtIum1fvCVwRNWsdiD0fb5otcfSePGyIbuc0Z44IAO17pm2Rnq9Wo
         1Iy4REkxT4Gm8T+eFW/a10UF/xtueFIOekZ/EtmPdSEjebGTqVbMKGznGejIIubVdeBk
         QbOKenZqZBZjPSUZlkIscvLTQN6NL1JDmz5Js4Elu8IckF8oEUHSeeyfMp9Hyq7WbRw4
         qicP81KP3nJ/BI1QRiqnKNIr+UNg+/OORS7H+FWCfScCNmytFRxzhcp1eNxrP+Qccqgq
         Gbp8uJoLkSiJJ8gmJtA40oKhEnnxm6zMdbzs2vJZUCt1H1ey9eDfLAMe6apKtmVTSf4y
         CURw==
X-Gm-Message-State: AO0yUKVtMc1IDfEZftpPEAVvSMsXFt9v5tTghhwO8FXVIiSpS2SN3vyD
	xdxpZqNKKkcpsQ4EM2IpI5k=
X-Google-Smtp-Source: AK7set9uwlFDZoIM064z2OjGPdMCazQ47m4fae1RS/ho02MIVaJpz5r3OZHQHX8HJvkDxD/8Bri2eQ==
X-Received: by 2002:a17:906:dd:b0:92f:27c2:13a3 with SMTP id 29-20020a17090600dd00b0092f27c213a3mr2378739eji.3.1679406758283;
        Tue, 21 Mar 2023 06:52:38 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id fi9-20020a170906da0900b00931faf03db0sm5553460ejb.27.2023.03.21.06.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:52:37 -0700 (PDT)
Message-ID: <7944e142-3eb7-68cf-65c4-edaa4e05f135@grimberg.me>
Date: Tue, 21 Mar 2023 15:52:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/18] nvme/tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-8-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_065242_380710_10C0D94F 
X-CRM114-Status: GOOD (  21.64  )
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
> When using the TLS upcall we need to allocate a socket file such
> that the userspace daemon is able to use the socket.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0512eb289dcf..0438d42f4179 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -115,6 +115,7 @@ enum nvme_tcp_recv_state {
>   struct nvme_tcp_ctrl;
>   struct nvme_tcp_queue {
>   	struct socket		*sock;
> +	struct file		*sock_file;
>   	struct work_struct	io_work;
>   	int			io_cpu;
>   
> @@ -1330,7 +1331,12 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>   	}
>   
>   	noreclaim_flag = memalloc_noreclaim_save();
> -	sock_release(queue->sock);
> +	if (queue->sock_file) {
> +		fput(queue->sock_file);
> +		queue->sock_file = NULL;
> +		/* ->sock will be released by fput() */
> +	} else
> +		sock_release(queue->sock);
>   	memalloc_noreclaim_restore(noreclaim_flag);
>   
>   	kfree(queue->pdu);
> @@ -1526,6 +1532,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>   		goto err_destroy_mutex;
>   	}
>   
> +	queue->sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
> +	if (IS_ERR(queue->sock_file)) {
> +		ret = PTR_ERR(queue->sock_file);
> +		queue->sock_file = NULL;
> +		goto err_sock;
> +	}

If a sock_file is always allocated, and fail the connection if
unsuccessful, why do you check on its existence when freeing the queue?

>   	nvme_tcp_reclassify_socket(queue->sock);
>   
>   	/* Single syn retry */
> @@ -1647,7 +1659,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvme_tcp_free_crypto(queue);
>   err_sock:
> -	sock_release(queue->sock);
> +	if (queue->sock_file) {
> +		fput(queue->sock_file);
> +		queue->sock_file = NULL;
> +		/* ->sock will be released by fput() */
> +	} else
> +		sock_release(queue->sock);
>   	queue->sock = NULL;
>   err_destroy_mutex:
>   	mutex_destroy(&queue->send_mutex);

