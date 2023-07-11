Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC66CEB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 07:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTvdUlVvZhc0hbKX1q8SVcLDSqn/rx2AGe/CA9ziUOM=; b=n7MafPkyc7tMrpQOKLg/ZgoZZz
	fOl/1e7JIoEOsSGw8OZbbj2/eorwx3BwSmv0yzBw64v0NUSsX6jwhbuNIC0WlZuQOt1Jtffs9qEkx
	vy7WteYMj/3tzD8LMeTOwnyLzglH1/lg5zO3Z90UV4cgVzkM8Mt+DNl09F2GmiOUdOKtVute02vSC
	4Uop/YJKf5RSi1wfvy8mkC8nDzkNyco3f6mkfessBspgVbCcrhyvPLOab4heB4T5+N6YSKQlrZ2dx
	nAd+tCfjpdnsEzo/mCjs4HhmVYu0jC4arrv+f3kBOqpE5XCFBu/PRfqkrjofxFs5O59jgdO4aX2e1
	rFX34otA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ80Q-00E0lM-36;
	Tue, 11 Jul 2023 07:41:54 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ80N-00E0kQ-2R
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 07:41:52 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3141a9f55ceso1250767f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 00:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689061308; x=1691653308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTvdUlVvZhc0hbKX1q8SVcLDSqn/rx2AGe/CA9ziUOM=;
        b=NwcJaRWdt92t6xkQc7ucxvlFN1qTMcoccwjsM5teLFNywIhyloMNV8HRtQtNdpoL0h
         OFNRQeyhMfe25hissfh0xqO+J+FocsM5LriUwG6JLGqiIgYLFBUk6VqP0jVd1VNepg0+
         CosVj1sboS6eT7/vB2yNu7zF9RxLsQXoH8TUFrYzEYH+W8pfjucCkOJXK0ZUMpU3XME8
         GdjP2KSv8/nZDAyLlhNyQr8Wk2Vwl2Cbi1UaAYg4RYZc+d3i3c+sSEyHIPWkZHB/ZdcM
         cZnW/Osy8P1iVUX9Sh9CZ7bdw2jb5uxCdXX7p8MbkEJUECf0FcUpE9+7F1+U31h0qjqe
         +ZCQ==
X-Gm-Message-State: ABy/qLbVCy5fO7YBsAQgizT8cXWdVRZlg7RG49JRCnnb7ZGX9IhDdZ+O
	q1/piAVkK0klGN0Kg4i1IxY=
X-Google-Smtp-Source: APBJJlHM5eVOBJQWvSG7gFz9IOPj4QQPMF74msWyFZusHDZvKMYWjlFMM/shLgPjS/tHOjykokGkCQ==
X-Received: by 2002:a5d:68c2:0:b0:313:ee56:a6f4 with SMTP id p2-20020a5d68c2000000b00313ee56a6f4mr13192900wrw.3.1689061308478;
        Tue, 11 Jul 2023 00:41:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 16-20020a05600c029000b003fc04d13242sm9191066wmk.0.2023.07.11.00.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:41:47 -0700 (PDT)
Message-ID: <c794c9d5-f665-3d5e-edee-7dc36ed69bad@grimberg.me>
Date: Tue, 11 Jul 2023 10:41:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/6] nvme: tcp: unquiesce queues after ctrl state is
 changed
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-4-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230710153555.1766438-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_004151_787414_763D7EDB 
X-CRM114-Status: GOOD (  21.98  )
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


> Unquiesce queues until controller state is changed successfully.
> 
> Prepare for moving start freeze into reconnect work for preventing new
> request from entering queue in LIVE state.
> 
> Before removing namespace, unquiescing queues is done unconditionally, so
> it is safe to do this way in case of state change failure.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/tcp.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index e414cfb3433f..e68bf21af348 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2109,10 +2109,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   	nvme_stop_keep_alive(ctrl);
>   	flush_work(&ctrl->async_event_work);
>   	nvme_tcp_teardown_io_queues(ctrl);
> -	/* unquiesce to fail fast pending requests */
> -	nvme_unquiesce_io_queues(ctrl);
>   	nvme_tcp_teardown_admin_queue(ctrl);
> -	nvme_unquiesce_admin_queue(ctrl);
>   	nvme_auth_stop(ctrl);

This is potentially a problem. It is possible that auth work is
running in the bg here, and without unquiescing the admin queue
the the auth_stop may take unnecessarily long until its I/O times
out.

I think it is fine to keep it as is...

>   
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
> @@ -2122,6 +2119,10 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   		return;
>   	}
>   
> +	/* unquiesce to fail fast pending requests */
> +	nvme_unquiesce_io_queues(ctrl);
> +	nvme_unquiesce_admin_queue(ctrl);
> +
>   	nvme_tcp_reconnect_or_remove(ctrl);
>   }
>   

