Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604EBC4320E
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:47:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1825A61056
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 14:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1825A61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SkVmzcYuSbB42bxdHvsZrOxQPNWjGhIVTsCnCgi0wYQ=; b=UtfcHcCW7oiO4Rk+3IGi5hALmH
	uQiK+P3j6ke9jY/ISyj7VtxfgbH78FWhycQ10cGGf7pBl21x/V5qCpzBnKwtsVlLuR70wiI90PrA4
	JOLgXVAGkbCG2ntzD8xUTK4lx93f/nS8eTn6XPj5p6Tdkd0SYModYtJnzdYoIwJ/Zb/CiZeyYt+pQ
	IIVdKpwGDBj1m2glQlBa/ZbX3qVGUbWdUwUylwqnCSYziS0p00Lw3kfq/GlIUnAjVl5/XUqz4IK6o
	cmMKZod2h/OuCG9X7qYvIc7r5iw9JqMDSOvTnTx+bBXWk+6UygY1FJ5hJBoxANBf3QqWxWu9N4paO
	rYYtuirA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLRWQ-006Hl7-Ru; Wed, 01 Sep 2021 14:47:26 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLRWG-006Hjw-Sn
 for linux-nvme@lists.infradead.org; Wed, 01 Sep 2021 14:47:18 +0000
Received: by mail-wm1-f41.google.com with SMTP id e26so2090589wmk.2
 for <linux-nvme@lists.infradead.org>; Wed, 01 Sep 2021 07:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cO9WV7kMd+UCwErRi8QICTFJxvpLvyFGb5rsDdVRM38=;
 b=suSh8WNKiZYwwmCwlr1FSytaW9SdbuFs4VsZqiQ4+m98cB+df02TZjUVbHpM+gHP3b
 sAqL6g+yUzc9OwuUN5tGPeZpFKkFvygCwhI9A0A4XU3R4YWGiK7Qx4DeQdry0DJTjKm/
 rGV0AkFQW338XS3vtT1dvfOwYz8fjPniWXEyIxTQHgN5Mo4mtyQMD9REO8iE7MQKIC/F
 GPGZJx83bj4EkvjjxM6D9SDygcT5tfopaFYUsnSeBnPiJ0G7KduJuhesnVdATPLj5SDt
 kMyjrTQbVcVx5IDvYPsboSRaTKL33aA05KN9swCJwPsoEFNjDjSkd3c1xG4BG5z9t1K9
 SCgg==
X-Gm-Message-State: AOAM530Y1pCXx9RV805efy5t8wL1Zfy30u4I0S3Jw7+6m3/KWXdPGMkt
 3ujm+vpaGroA2c6LrAEwF23y852dAlw=
X-Google-Smtp-Source: ABdhPJxoSt6G0oC8hDbSXbbcuJ4A0lmvMJNKxHhqO92FikJRQZ7JQTX6IftOd1H1xClpc7q5FmSu3Q==
X-Received: by 2002:a05:600c:3213:: with SMTP id
 r19mr9988807wmp.11.1630507633601; 
 Wed, 01 Sep 2021 07:47:13 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id p13sm21650028wro.8.2021.09.01.07.47.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Sep 2021 07:47:13 -0700 (PDT)
Subject: Re: nvme-tcp crashes the system when overloading the backend device.
To: Mark Ruijter <mruijter@primelogic.nl>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1A17C9D4-327C-45D6-B7BB-D69AEB169BBD@primelogic.nl>
 <11cd3514-570a-8bf1-55f7-cda6cacc7124@grimberg.me>
 <2E0B97E4-8182-4EF5-8D90-DA4998C58295@primelogic.nl>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <06beadce-b135-f1ac-094a-8262ea37fe86@grimberg.me>
Date: Wed, 1 Sep 2021 17:47:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2E0B97E4-8182-4EF5-8D90-DA4998C58295@primelogic.nl>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210901_074716_983634_1D53E78B 
X-CRM114-Status: GOOD (  25.08  )
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


> Hi Sagi,
> 
> I can reproduce this problem with any recent kernel.
> At least all these kernels I tested suffer from the problem: 5.10.40, 5.10.57, 5.14-rc4 as well as SuSE SLES15-SP2 with kernel 5.3.18-24.37-default.
> On the initiator I use Ubuntu 20.04 LTS with kernel 5.10.0-1019.

Thanks.

>>> Is it possible to check if the R5 device has inflight commands? if not
> there is some race condition or misaccounting that prevents an orderly
> shutdown of the queues.
> 
> I will double check; however, I don't think that the underlying device is the problem.
> The exact same test passes with the nvmet-rdma target.
> It only fails with the nvmet-tcp target driver.

OK, that is useful information.

> 
> At far as I can tell I exhaust the budget in nvmet_tcp_io_work and requeue:
> 
> 1293         } while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
> 1294
> 1295         /*
> 1296          * Requeue the worker if idle deadline period is in progress or any
> 1297          * ops activity was recorded during the do-while loop above.
> 1298          */
> 1299         if (nvmet_tcp_check_queue_deadline(queue, ops) || pending)
> 1300                 queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
> 
> I added pr_info statements in the code to determine what is going on:
> 2021-09-01T07:15:26.944067-06:00 gold kernel: [ 5502.786914] nvmet_tcp: MARK exhausted budget: ret = 0, ops = 71
> 2021-09-01T07:15:26.944070-06:00 gold kernel: [ 5502.787455] nvmet: ctrl 49 keep-alive timer (15 seconds) expired!
> 2021-09-01T07:15:26.944072-06:00 gold kernel: [ 5502.787461] nvmet: ctrl 49 fatal error occurred!
> 
> Shortly after the routine nvmet_fatal_error_handler gets triggered:
> static void nvmet_fatal_error_handler(struct work_struct *work)
> {
>          struct nvmet_ctrl *ctrl =
>                          container_of(work, struct nvmet_ctrl, fatal_err_work);
> 
>          pr_err("ctrl %d fatal error occurred!\n", ctrl->cntlid);
>          ctrl->ops->delete_ctrl(ctrl);
> }
> 
> Some of nvme_tcp_wq workers now keep running and the number of workers keeps increasing.
> root      3686  3.3  0.0      0     0 ?        I<   07:31   0:29 [kworker/11:0H-nvmet_tcp_wq]
> root      3689 12.0  0.0      0     0 ?        I<   07:31   1:43 [kworker/25:0H-nvmet_tcp_wq]
> root      3695 12.0  0.0      0     0 ?        I<   07:31   1:43 [kworker/55:3H-nvmet_tcp_wq]
> root      3699  5.0  0.0      0     0 ?        I<   07:31   0:43 [kworker/38:1H-nvmet_tcp_wq]
> root      3704 11.5  0.0      0     0 ?        I<   07:31   1:39 [kworker/21:0H-nvmet_tcp_wq]
> root      3708 12.1  0.0      0     0 ?        I<   07:31   1:44 [kworker/31:0H-nvmet_tcp_wq]
> 
> "nvmetcli clear" will no longer return after this and when you keep the initiators running the system eventually crashes.
> 

OK, so maybe some information can help. When you reproduce this for the 
first time I would dump all the threads in the system to dmesg.

So if you can do the following:
1. reproduce the hang
2. nvmetcli clear
3. echo t > /proc/sysrq-trigger

And share the dmesg output with us?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
