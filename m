Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A77C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 13:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sfTw+SLtHXSBNt/ICgJ7KD4injoyAqk1UZBT2+QbwlU=; b=F9bw9QkTAPe9UxlnC5Uf6FvtvY
	G/50H/wrR5vnk1yMoYvQ1s10vUs/A4Jirc1FGMH8gfrIS2mwj0NnIn9nuWpfComDace+Tf7/QMEGB
	WAe5zq5AYvO/MDZ3EuoBuPStEDaBaAM5Rl/x7xstLb9/2tQnc6IH6YfT3V6aGRDYwMR+p3ZWiL+oK
	WHgz4c+1MQeoqGI8SmtR076j2N2cHYiVA89o7AM+tGquRBWY3hLRBY1lKdmI07Qa4/MCt7UiABSzC
	6/gcDObGH6YAaO7Q+1UHF/buDDabYJtLnVV8OuV5cYuy6ovBNd20zFCz7zgNlCuH3h/ECoRdPg9R8
	T8TuRQBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlNL-00Bu81-Ll; Wed, 10 Aug 2022 13:03:55 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlNI-00Bu7D-DL
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 13:03:53 +0000
Received: by mail-wr1-f45.google.com with SMTP id z16so17614925wrh.12
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 06:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=sfTw+SLtHXSBNt/ICgJ7KD4injoyAqk1UZBT2+QbwlU=;
        b=TyMWDsNLJe2BGfWqCV+2+/ZpyZvXS+wVfEwmIBsElZ21rqein2sSDr5HpiGJ6T6GWr
         cYx4JFTN/bisQaXf2g9XNGCKQ7PyrJzzRM62qdKz1ehkt7friOALoqFb9Dn/On3L0mp1
         M7sP0T4PnpLXvkY/W5h92VGy6SIMt/w+pRkZPGR6mv5+hikpzIxwPh97ZHbQgwfF1oIt
         HQBVTbZk4ayLiiIm+kIaOIsKBYq5LVeyB5conhQw9XlmZU0VUrrlZimdWETxkPARMZux
         8jPN7sDArhtxa4ecbh0tblE7QVXF/3vAQaBEdKRrr7/qZZSLQmfJazr4+DtqvfCMuF8B
         BvrQ==
X-Gm-Message-State: ACgBeo0HJNvtUbp/WkLExkht7lL5eqiFrl6EbW10mmRPdSjqB2FH0RYs
	r0Sz9esE/EIXaV1VWnZN1bwd2p0sIbU=
X-Google-Smtp-Source: AA6agR7Lx87A8vf4NA15qRodyozRVF4ZZB/kXyPY90bxKGx4d487tRIob+i9jgHL8r45MdeAYclABQ==
X-Received: by 2002:a5d:47c2:0:b0:220:681f:6fb4 with SMTP id o2-20020a5d47c2000000b00220681f6fb4mr18058628wrc.599.1660136630296;
        Wed, 10 Aug 2022 06:03:50 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d464e000000b0021e30e9e44asm16281260wrs.53.2022.08.10.06.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 06:03:49 -0700 (PDT)
Message-ID: <9feb87bd-baf2-a9ca-f4ca-8af6b8b00d95@grimberg.me>
Date: Wed, 10 Aug 2022 16:03:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-host tcp: check if the queue is allocated before
 stopping it
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org
References: <20220801080900.391575-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220801080900.391575-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_060352_495004_A9FA0B07 
X-CRM114-Status: GOOD (  10.88  )
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


> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ac74dce3e95b..ab9bb5c98c78 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1619,6 +1619,9 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>   
> +	if (!test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
> +		return;
> +
>   	mutex_lock(&queue->queue_lock);
>   	if (test_and_clear_bit(NVME_TCP_Q_LIVE, &queue->flags))
>   		__nvme_tcp_stop_queue(queue);

This looks correct to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

