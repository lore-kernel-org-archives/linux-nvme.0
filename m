Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E58AC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:59:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416F465079
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416F465079
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SP7oDaHLGHDKefnw8V1EfkqeQXqCVkhj2L3DPcxgdow=; b=g5fUTQ9bCIWftNHPeQy4sGLUk
	ApL3usIOzfTHNNq90B2Drrgv3JkQzPj52Am50EhFsgtFptor2+6rUfDgXTd8RCt8eWA+IDeyJYO28
	4dQGwMb47yiRvwJZx6WGPjzY/nXN5kL4uycUYJYHb0zQRTpEdT3t6Pqu0Josb915kf2pIMfbz4e4+
	vQ/7GevOBrbIBx6UEF1IbpV/16yt+XGADFT2J+eIigO+aHG6hs0AZDlVtCJcjY1ROL4zkWaR9yun/
	TD0G6jlMJsePmFyv7B9d+/YYq4pNLmtk5hb2dzLqNB3GW0l6bkk051HcjSa8UzWP65KQESdavcIKV
	beZu/iFew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIHXF-00GTWP-45; Fri, 05 Mar 2021 20:58:57 +0000
Received: from mail-oi1-f182.google.com ([209.85.167.182])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIHWz-00GTSA-5d
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 20:58:45 +0000
Received: by mail-oi1-f182.google.com with SMTP id z126so3977286oiz.6
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 12:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n/JXPbkENtG4m2r7B2ya8geWAQxEZg0gSnffsoHuBdQ=;
 b=mmSfRZJ0JlRhu0Z9nwrIg3Zr4FlnBahUjxTdN2H3pDxHoKKQ8nZnkuSkShDAaRThBy
 1RtL5+eu/eBYQVKljc5lOQglaLIchuyFeJQmtvvXEjP5HMQQW0ilhpBqqGTZnEG/e86r
 Tr7u8SE4K8iKNDZbRK/zLjwRdTm3S1uKQhu+6NrGAaToXmkdR6pwezNa6lFoNk18YetY
 7CLsaSLNsuMzK1JCuHXgGn3Cy6Fs4SwlNYp7Xujd9YiSYb8OTTFIU2OYv4wlMVvVO2xd
 BzhkdPCzXs9ZV6Qqqcuf6BRUDL2meHbHB6pirMMVMdPDKeH/5JwGlMZzkUoAyAnPuXOy
 Tslw==
X-Gm-Message-State: AOAM531/ZH2eH10NZo8YSuTGaHJpIiyMPkSR3IOA4nHNKo6Ab3NY6W4y
 MKQywfJslk8qJqUGN8L5MMo=
X-Google-Smtp-Source: ABdhPJx4Z/OJzxTW7tZccyxtpWJJu1zMNpAL7peKE4K1hxtOUveu8h4+2pI7xrzxKGEA7rB3b75izA==
X-Received: by 2002:aca:130e:: with SMTP id e14mr8723435oii.169.1614977919371; 
 Fri, 05 Mar 2021 12:58:39 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id i6sm303727oto.47.2021.03.05.12.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 12:58:38 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
References: <20210304005543.8005-1-lengchao@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
Date: Fri, 5 Mar 2021 12:58:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210304005543.8005-1-lengchao@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_205842_343009_DF5A92BC 
X-CRM114-Status: GOOD (  24.52  )
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


> A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
> over rdma(roce) reconnection, the reason is use the queue which is not
> alloced.
> 
> If queue is not live, should not allow queue request.

Can you describe exactly the scenario here? What is the state
here? LIVE? or DELETING?

> 
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   drivers/nvme/host/fabrics.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 733010d2eafd..2479744fc349 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -189,7 +189,7 @@ static inline bool nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   {
>   	if (likely(ctrl->state == NVME_CTRL_LIVE ||
>   		   ctrl->state == NVME_CTRL_DELETING))
> -		return true;
> +		return queue_live;
>   	return __nvmf_check_ready(ctrl, rq, queue_live);
>   }

There were some issues in the past that made us allow submitting
requests in DELETING state and introducing DELETING_NOIO. See
patch ecca390e8056 ("nvme: fix deadlock in disconnect during scan_work 
and/or ana_work")

The driver should be able to accept I/O in DELETING because the core
changes the state to DELETING_NOIO _before_ it calls ->delete_ctrl so I
don't understand how you get to this if the queue is not allocated...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
