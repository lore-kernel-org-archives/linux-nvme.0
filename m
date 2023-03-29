Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B88C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YpBMM16H4VxKR5S0BgjpnB4EOSPEUEXtpuHJU6u+kKM=; b=DHOL22lSTuJO1kxgw3nlgyBC/7
	snthm/SZF7TwNDgZ9addd2c6he0sacuIAKPKUVQm0O7beIv0TAxMxPXhtcVNE2jH0ob2xy2nvatdc
	/0IoZfe/eJoA+heApDtDmdbLkuNn/blbh1Mf0mDlqUR7GUzAFOXMZzowN+PtOBw1Rmf7E6hUU52X8
	jnCC6MFmh0A/lCNQzoHyCs3gfyW7tWu1btqUEt1FAgRk7DpjkoRXmzq7LL/feSE17L9MB8QBShyIh
	GRl4A/V4f/wUHGOvh6j82yevOTvnxSKN9uufgFF/AMU726flnC802rXVCwg+ywnDhm+7eLBGlicC6
	n6WWfxvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phYAr-000v3i-0p;
	Wed, 29 Mar 2023 15:57:21 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phYAo-000v2F-0q
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:57:19 +0000
Received: by mail-wm1-f51.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so10025324wms.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 08:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105437; x=1682697437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpBMM16H4VxKR5S0BgjpnB4EOSPEUEXtpuHJU6u+kKM=;
        b=xIJPilwhiji+/WEOICaecmVw24lCwxMdCVqcKepBane8TufIbSs81oO3KVYHU/HKrq
         iC+/Y8GF+nmO7ZsjZO2fTkOCAZYUf6RLKwLG27z6gKk780NOcoCi1FI1eSkiJ2L5J8XV
         YRi4tbJ9I35mmhe0eWrDYkqDYTqoSWacPduKsAeAhzBLl9ZHJPZo9RaAZESpz4kALmzF
         ulW4lAw7pspwKgcT8ft0BOFQ50uhU8AD1jW5kjq++aKu+jt32zATKgMqSWZoPLxaD/Yt
         tYzcQCc915SwO5MQ2YDDxPdYw0BcTXBWi361eLB0WR+7bydM1nuhvxvQ6w7Q4RMWqxOv
         /K3g==
X-Gm-Message-State: AAQBX9dmvtIjYcRrXb3AVNsmhP3vvZPZrzHeD1tpBt/WNRcaqF/c1GLp
	fEdr3pEYMgwZaXYsI6PuHi4=
X-Google-Smtp-Source: AKy350YnTkuRhy6rZpyGthXVArnJI+1sVROHYPaPXbSSN7o5crWNv2FU6iBYKx+Ie2REEoIG0y+eSQ==
X-Received: by 2002:a05:600c:3c91:b0:3f0:330b:d3d4 with SMTP id bg17-20020a05600c3c9100b003f0330bd3d4mr346969wmb.4.1680105436796;
        Wed, 29 Mar 2023 08:57:16 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bcbd3000000b003ef684c5e32sm2594516wmi.48.2023.03.29.08.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:57:16 -0700 (PDT)
Message-ID: <54748ec5-2734-0000-1405-3d7e6d898a54@grimberg.me>
Date: Wed, 29 Mar 2023 18:57:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/18] nvme/tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_085718_297293_634E6CE8 
X-CRM114-Status: GOOD (  19.46  )
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

> When using the TLS upcall we need to allocate a socket file such
> that the userspace daemon is able to use the socket.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 42c0598c31f2..fddf785aba74 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -115,6 +115,7 @@ enum nvme_tcp_recv_state {
>   struct nvme_tcp_ctrl;
>   struct nvme_tcp_queue {
>   	struct socket		*sock;
> +	struct file		*sock_file;

I think that sock->file is storing the file, no need to store it as
well.

>   	struct work_struct	io_work;
>   	int			io_cpu;
>   
> @@ -1330,7 +1331,10 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>   	}
>   
>   	noreclaim_flag = memalloc_noreclaim_save();
> -	sock_release(queue->sock);
> +	/* ->sock will be released by fput() */
> +	fput(queue->sock_file);
> +	queue->sock_file = NULL;
> +	queue->sock = NULL;

Is the queue->sock = NULL here required because we allocate a sock_file?

