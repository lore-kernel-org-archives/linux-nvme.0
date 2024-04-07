Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78590CD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ipVAIesNeJekKaAm4RMBK3twZ+whoFrrb2ReteU7v8k=; b=jtSCAcpGTnwOcuFHyiCJU4d9OQ
	TOoHowxGfdoBNVjDLiA4nOMvXewdLoPy2Ccshgb52putSBrHpyAVIc72Sp81917uOJQ/vB1oIEVtd
	fDZQJi9+ZzWgVzTEECDGhBo97ESSO6t6gbj573/xOqzJpsk2v+ba3pTfBVdeWn/bKb46wb3diougH
	F1k5z6KLPKPmOgv3hWZ8V9vLc84qEd2us5KUnii8NXBjM5tNsjad7gtokuZAJMyzwDiAGjlK+qbeb
	K23Wn8ubXKs9FRqZ2/MwmGRRkenY94BA7Go3VFqzIE4gOk2Qdz/t2SArfLjlTwkenar/1AjAxqmhL
	J0DKbEMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rta04-0000000DXfN-0MjC;
	Sun, 07 Apr 2024 21:24:28 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rta00-0000000DXdq-0YVM
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:24:26 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-345606e8ac0so280089f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712525059; x=1713129859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipVAIesNeJekKaAm4RMBK3twZ+whoFrrb2ReteU7v8k=;
        b=MjVIYbNG45VBSkW1Px+sJX4lywJnmDMIoS2w7Ki6YHj2dWxLNJAsnhT9DodzA4vQ8U
         oV731ZDZ08F/hMUR4AWAP2EP+EZx7b8oc6PdgDYuNRudUvv+kvWIt05RQnT0EJMyLPss
         uj+XeYBiqib48Ip/mkMybd2z486hzUwFOnknxbKHevHftWSKyklTHMSWAXBSfsoxaq25
         AL/bdu9uN2yv8ppEwMV2mJkOH8TSrXfeMs7/Fx1u/3V1mbvPoQFmTD1ptzjn4fSd+ngb
         HPxnY/e+4iHQ8rLVjrN4TTzc3+GiIrClPYLXy/T4ClAMz2ccdUPAAu4QJ19kiYLR7/RX
         H2jg==
X-Forwarded-Encrypted: i=1; AJvYcCWmmvPsi+iBP9zkdisjFZaSN5jZbFsGk/cPqSDxb66ehaI6ov/7+KsUC6Z+KWCe0D5YmDY6ynS6qYuYFgdqTE5ZOrww/3gpOZU5UXZmTrk=
X-Gm-Message-State: AOJu0YxpcwP/+ODTZ7Dh15zCeJV7RTQcSh+bdI1EkHOe4tEg8A8nUuQa
	6UgLXPP6gty6gBRcIZmmsG+FwrMdgmpi3iZajZlXz0z/No8fEAZv
X-Google-Smtp-Source: AGHT+IHdR4OCMcSkWBDvN/TLGD2m2PkC9ELe+p3Jrvtw+p+WKC0YmHONYq2ljgWNvKAMKFraNxmEsw==
X-Received: by 2002:a05:600c:3b08:b0:414:b440:4c66 with SMTP id m8-20020a05600c3b0800b00414b4404c66mr5757153wms.3.1712525058451;
        Sun, 07 Apr 2024 14:24:18 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id jg1-20020a05600ca00100b00414688af147sm14222864wmb.20.2024.04.07.14.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:24:18 -0700 (PDT)
Message-ID: <ea0d9634-d220-4e0e-9aef-567941c39dcd@grimberg.me>
Date: Mon, 8 Apr 2024 00:24:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/17] nvme-tcp: do not quiesce admin queue in
 nvme_tcp_teardown_io_queues()
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-10-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-10-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_142424_303997_E9347476 
X-CRM114-Status: GOOD (  15.83  )
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



On 18/03/2024 17:03, Hannes Reinecke wrote:
> nvme_tcp_teardown_io_queues() is for I/O queues; the admin queue
> should be left untouched here.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7018dc0dd026..66675b2dc197 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2173,7 +2173,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   {
>   	if (ctrl->queue_count <= 1)
>   		return;
> -	nvme_quiesce_admin_queue(ctrl);
>   	nvme_quiesce_io_queues(ctrl);
>   	nvme_sync_io_queues(ctrl);
>   	nvme_tcp_stop_io_queues(ctrl);

1. can you explain why is this needed?
2. I have some vague recollection of this being added to address
something, but git blame leads to a patch that looks completely unrelated:
d4d61470ae48 ("nvme-tcp: serialize controller teardown sequences")

So I do not really object this (primarily because I cannot figure out why
this exists there in the first place).

