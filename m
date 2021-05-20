Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99184C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 22:44:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C5D36101B
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 22:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5D36101B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMSCSvWjIU/xF55Z+Uon87AcfvSkiPMrspZMheaR6+Q=; b=EErleIVGosHzSUQwxe/hsIZfvA
	wMjJC+kjuTZdv4nyAhsYofJfBJHEKp5rGrxCxoofkx/VpyNkweB/OKyvkhn9ywCI8RKY/MjHmc0fV
	QpzStXnk4lARdjNxdhb2qRT/zSvvgTDyFLqiz+TYqm5Vc4ydDyDigue6R/dVFNd0uQXTc01PrG3VN
	JHZs7gmviEs6yA+Tlp9n7mu3+u7Grt+kBVilt+rELC3myM9lIj7hSjOl9OiS4HZK3LrfJIq59ay7t
	eBh13whCFtobHM/UlhbKW/zfwgH/KWeMj/nq1x35LPChuwsCrSt28SLryCQTeNfTPu3Lm6HJGY3JM
	Zn6jVEDQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljrP0-002wjK-03; Thu, 20 May 2021 22:44:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljrOw-002wiu-7W
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 22:44:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=XKePK6bU9zB8lkyfeItnApdHtEU+NdmiAionGlQioQ8=; b=Hz417soV7/WKiQlIon601Miyvx
 rGg4tbtoJyATO6E6yBdi4g+KPzfNTXQnPk745uaCtrE4Ufl8izlzLwuq1WXrNFR4Ab68CiNOj96cH
 z3WPexyMgULkgXa9H5hlaYgReNKILGY7Xx7bmTB0YAHQtLI8E5eM5AFvJaylfbtyE8UgUvYUi2GLs
 KBrjRiNKEB/Pm6v20wVMfVArPFRHwmX+XM8FuETD7sbczIb8AzUo5iXgpGzZ1vW7a9asGgVrflFXu
 JUlgao7qwzaOTjQ2uoXD0JLYtu8agoHVCa6a8HnCIT4rRIv7m/+DpZCcK9zISFxmfGBUDGpO9BbP+
 roTI66Mg==;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljrOt-00GhGn-Mq
 for linux-nvme@lists.infradead.org; Thu, 20 May 2021 22:44:21 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 z137-20020a1c7e8f0000b02901774f2a7dc4so5878823wmc.0
 for <linux-nvme@lists.infradead.org>; Thu, 20 May 2021 15:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XKePK6bU9zB8lkyfeItnApdHtEU+NdmiAionGlQioQ8=;
 b=m/elzwYg6dYCuRb48WJ5kFcg7nbYQPYwUmm5tCi/7V3DXDBW99qmhwHDZCDlJG/jcz
 4QZSC5I5xgTdP3nFSmS7Y2XVY71p9WOJPLctShfBt7dNL05eB23a7Zkq/BZ7MBFpuruf
 yYG1yOQDJMpw2xN0vBhWzrK6C/JmRgQuY9M1w2MDjjd3b7hjs3IQQYjFGf/zFbAonxM2
 zexqDqVNkGExeH0TEHFnuf+bcFrOkCLJt1pIhCKy4Y+RmRFQNm9K+121dEDS8hdwopy/
 lZlD4f++K5DEAR7uJ1gLJz8e6wWC9FSqf+EtLavd+BAeBay123ZOQX8yI56nH1xkeexI
 MiIg==
X-Gm-Message-State: AOAM5308zWwCijFDAA2qA0WV4jOq6JDxdQzVHGtvSuZTXI+iwebcdq6+
 TA9bZ32y1s9aJ492kFXyjLCU8FCc6/Y=
X-Google-Smtp-Source: ABdhPJzs1B6smKonfUKJDoDH+oFZV5SZgL363gSWtx9JL9qL22dZYT4LMS4PllI9gAwSsJV/V8c11w==
X-Received: by 2002:a1c:5544:: with SMTP id j65mr5911819wmb.174.1621550658122; 
 Thu, 20 May 2021 15:44:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:1349:5b78:fe05:c9c1?
 ([2601:647:4802:9070:1349:5b78:fe05:c9c1])
 by smtp.gmail.com with ESMTPSA id f13sm5050672wrt.86.2021.05.20.15.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 May 2021 15:44:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet-tcp: fix connect error when setting
 param_inline_data_size to zero.
To: Hou Pu <houpu.main@gmail.com>, hch@lst.de, chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, larrystevenwise@gmail.com,
 maxg@mellanox.com, elad.grupi@dell.com
References: <20210520113046.27821-1-houpu.main@gmail.com>
 <20210520113046.27821-3-houpu.main@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <417493d4-a78f-ea89-8536-0b391ef95f08@grimberg.me>
Date: Thu, 20 May 2021 15:44:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520113046.27821-3-houpu.main@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_154419_781278_E2556A6F 
X-CRM114-Status: GOOD (  27.88  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> When setting inline_data_size to zero, connect failed. This could be
> reproduced with following steps.
> 
> Controller side:
> mkdir /sys/kernel/config/nvmet/ports/1
> cd /sys/kernel/config/nvmet/ports/1
> echo 0.0.0.0 > addr_traddr
> echo 4421 > addr_trsvcid
> echo ipv4 > addr_adrfam
> echo tcp > addr_trtype
> echo 0 > param_inline_data_size
> ln -s /sys/kernel/config/nvmet/subsystems/mysub /sys/kernel/config/nvmet/ports/1/subsystems/mysub
> 
> Host side:
> [  325.145323][  T203] nvme nvme1: Connect command failed, error wo/DNR bit: 22
> [  325.159481][  T203] nvme nvme1: failed to connect queue: 0 ret=16406
> Failed to write to /dev/nvme-fabrics: Input/output error
> 
> Kernel log from controller side is:
> [  114.567411][   T56] nvmet_tcp: queue 0: failed to map data
> [  114.568093][   T56] nvmet_tcp: unexpected pdu type 201
> 
> When admin-connect command comes with 1024 inline data size, in nvmet_tcp_map_data(),
> this size is compared with cmd->req.port->inline_data_size (which is 0),
> thus the command is responded with an error code. But admin-connect command
> is always allowed to use no more than 8192 bytes according to the nvme over
> fabrics specification.
> 
> The host side decides the inline data size when allocating the queue
> according the queue number, the size of queue 0 is 8k and others is ioccsz*16.
> The target side should do like this.
> 
> Fixes: 0d5ee2b2ab4f ("nvmet-rdma: support max(16KB, PAGE_SIZE) inline data")
> Signed-off-by: Hou Pu <houpu.main@gmail.com>
> ---
>   drivers/nvme/target/tcp.c | 24 +++++++++++++++++++++---
>   1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index d8aceef83284..83985ab8c3aa 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -167,6 +167,24 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops;
>   static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
>   static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
>   
> +static inline int nvmet_tcp_inline_data_size(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct nvmet_tcp_queue *queue = cmd->queue;
> +	struct nvme_command *nvme_cmd = cmd->req.cmd;
> +	int inline_data_size = NVME_TCP_ADMIN_CCSZ;
> +	u16 qid = 0;
> +
> +	if (likely(queue->nvme_sq.ctrl)) {
> +		/* The connect admin/io queue has been executed. */
> +		qid = queue->nvme_sq.qid;
> +		if (qid)
> +			inline_data_size = cmd->req.port->inline_data_size;
> +	} else if (nvme_cmd->connect.qid)
> +		inline_data_size = cmd->req.port->inline_data_size;

How can a connection to an I/O queue arrive without having the ctrl
reference installed? Is this for the failure case?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
