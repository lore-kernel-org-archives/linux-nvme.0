Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE45C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 09:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v93eNXmzPwiXrwCHFiAuODfKt84UHq2qJ0/xhTRG8ZQ=; b=gt906vnr/6UKt7UFftu1oEaSCn
	LN9zPL91XAPjTKO3TRmxeayDBAoZQRQUN3aBD2kt9CXrZ1FgHgOUemwYcoZ3DLh6oIQVUTP8/9Miu
	dCydtnA4i9Z5fSfk0fkcbdaoG9h0rZbiJXe7U6MjttOO846yzOmFxGHa159Ftfzbs6ySe1OsyGSbJ
	SXH/KhSAbbvrv0M7QZ7upDqN3LLeco+uuBKrfv44OTO+1VyxLQBTjcm7hLz9MMpX1sKU0sLAzIi/k
	kldMIq3HQi+b2JnYFe6CCWGjYa/y0VRXB4p5rXdFj73NZ4RYVBuhBWS0TEjLgNM4J5vhPgUFZWh3M
	LmLTS2/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okiYn-004iaY-9j; Tue, 18 Oct 2022 09:06:53 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okiYe-004iSQ-U3
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 09:06:46 +0000
Received: by mail-wm1-f51.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so11772371wmb.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Oct 2022 02:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v93eNXmzPwiXrwCHFiAuODfKt84UHq2qJ0/xhTRG8ZQ=;
        b=L6WFq2zH3ZPGpc1mFe1rOHMO3Jk/njBWpamLdbmz1wTVis7jyDAI4HIn3CRiBJs21W
         IiJVlbPkfScWVVRapvrBByQjMNHa/gh8vp+3kE7D0SqyJUw4SQwwYGIgYY4z1UK0Tbw0
         boYqzL1LsjDbT+dyLz10KoHeXNp4g6FsDLB0xmgR85cZpcefXbhRtviiVIsbxKPN4MKi
         heIdD8UhNeT55JfIH24y5IoWaJBZq1X0fj0VZS/FRtYHddL04Ou/aHbZ6iWG3iOlT4Ug
         2ksrQ2b6ixepYaEzyhV7UhF2JNu9IGgVeBcnKd/v7yUtwSpoNCrV/o/dTYEB12bV+Ndp
         CieA==
X-Gm-Message-State: ACrzQf2MUa3XWp/RYk1W+nRRt0Stn8Q+P2mz/cH/vKu9zw15eYS4vpNA
	VyKJ9UP6DTYaM4k3aIKsqGc=
X-Google-Smtp-Source: AMsMyM49bWEGu0upxRjYoWsaRWbAgFxNRR9tL5Lg/JOCFd+pRckafbSt2Z/qcRrEAGF3Zb5Y+6xryg==
X-Received: by 2002:a05:600c:695:b0:3c6:b7f1:6f39 with SMTP id a21-20020a05600c069500b003c6b7f16f39mr1248821wmn.5.1666084003051;
        Tue, 18 Oct 2022 02:06:43 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d43d0000000b00228d67db06esm10646674wrr.21.2022.10.18.02.06.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 02:06:42 -0700 (PDT)
Message-ID: <3a466711-860a-667f-b78d-daa1eedb4edf@grimberg.me>
Date: Tue, 18 Oct 2022 12:06:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, ming.lei@redhat.com,
 axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017134244.GA24775@lst.de>
 <b0631151-4081-2fdb-fbb0-eab1db633200@grimberg.me>
 <20221018085557.GA28266@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221018085557.GA28266@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_020645_040611_103E9315 
X-CRM114-Status: GOOD (  21.80  )
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


>> The only question in my mind is regarding patch 2/2 with the subtle
>> ordering of nvme_set_queue_dying...
> 
> I think we need to sort that out as a pre-patch.  There is quite some
> history there was a fair amount of dead lock potential earlier, but
> I think I sorted quite a lot out there, including a new lock for setting
> the gendisk size, which is what the comment refers to.
> 
> Something like this:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c19..cb7623b5d2c8b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5105,21 +5105,21 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   
>   /*
>    * Prepare a queue for teardown.
> - *
> - * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
> - * the capacity to 0 after that to avoid blocking dispatchers that may be
> - * holding bd_butex.  This will end buffered writers dirtying pages that can't
> - * be synced.
>    */
>   static void nvme_set_queue_dying(struct nvme_ns *ns)
>   {
>   	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>   		return;
>   
> +	/*
> +	 * Mark the disk dead to prevent new opens, and set the capacity to 0
> +	 * to end buffered writers dirtying pages that can't be synced.
> +	 */
>   	blk_mark_disk_dead(ns->disk);
> -	nvme_start_ns_queue(ns);
> -
>   	set_capacity_and_notify(ns->disk, 0);
> +
> +	/* forcibly unquiesce queues to avoid blocking dispatch */
> +	nvme_start_ns_queue(ns);
>   }

If we no longer have this ordering requirement, then I don't see why
the unquiesce cannot move before or after nvme_set_queue_dying and apply
a tagset-wide quiesce/unquiesce...

