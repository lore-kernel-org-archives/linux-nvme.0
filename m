Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1EAC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oYyGdlGAKRlwvNoItuyErTRndKrFvSDgY35o4T1kt30=; b=fcCzNgEjJS+5GZz2KbDylx1LFw
	wrg5iJmhRx9Sz4YII9DSXi7fYyrHdXJLxlNNiKGqdzRlhTi0Mce33uOIHFacprVd7FQnCXCbUIA/K
	nqmlPqJXYDJovoaTqAJQbKOo0FjoCMJ77idQVF58D4eTM5gesPvHbxIKDNj4kcIvhHLDrP4GHJbUq
	++hmS+c6+go4C01wFQrCqKb3PfQ8ZvaNtiuEMuhivcd4qyNZFyQ3UBMEyzgPlp86h5gPWlNjNf0Vy
	6D7DkhD7EDRpgSszMTD+Z+K0nVGNnvT5UowE9OC/jte7KkSLhJOGDnhG/2x7qhuhEgr0jIyckaAtK
	rCFv26LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzkIu-00E6lQ-2F;
	Thu, 18 May 2023 20:32:52 +0000
Received: from mail-pl1-f175.google.com ([209.85.214.175])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzkIr-00E6k9-36
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 20:32:51 +0000
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ae52ce3250so22468595ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 13:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684441966; x=1687033966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYyGdlGAKRlwvNoItuyErTRndKrFvSDgY35o4T1kt30=;
        b=clinhvgiJYHeIS1h6TYzLbYb4DiKI5bEUlnHxaamtBXC3IvhlFyJh0SKhNZKGSYDk7
         cYL7S3EkNWCOsp6S5SO0n/m5g8GFb0anU6GPR5IrIDadoqVSqhGQ0zoe6oCq4vg3r8Xy
         cexann3g20HXdFvYDAoaiZ+JkR2CeuIjwNVq+sXNsNrU0N953GxHkbVEMnngDajDk3yA
         ENHWSFXiMy59n+ofmw8nszo8uXJURXYyufFZ+v56/jaYKyNcdSan/IjO5pSpu0p8vbvw
         u++fpoTlr4iXgdUst1cZ5d0FuubTVtfEHlF5T5Ps0qcTo65yC0ZBwUVEb16NPNMkXK22
         TdYA==
X-Gm-Message-State: AC+VfDzGlY38T5sQMcubf98g1Fx1htO8kPbkRFzuSKEwEmi1I9RmgVRN
	YkbR3LShkZBc50P1fyXQNVU=
X-Google-Smtp-Source: ACHHUZ69PrvjoSkXqYLJuLkKk/77WJjdANyPz10rj7Z5joDlfB7/6hW2eONQS2Vs6BAyFWfYgAypSw==
X-Received: by 2002:a17:902:b496:b0:1ad:ea13:1918 with SMTP id y22-20020a170902b49600b001adea131918mr183398plr.69.1684441965786;
        Thu, 18 May 2023 13:32:45 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c20200b001ae5044c2aasm1874632pll.145.2023.05.18.13.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 13:32:45 -0700 (PDT)
Message-ID: <82c223c5-d6ba-d862-2d6e-31fbd3daa77d@acm.org>
Date: Thu, 18 May 2023 13:32:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet-rdma: Release connections synchronously
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230511150321.103172-1-bvanassche@acm.org>
 <f2909fb6-26e4-f99f-c55b-1dcec577bb44@grimberg.me>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f2909fb6-26e4-f99f-c55b-1dcec577bb44@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_133249_997577_C7917B3D 
X-CRM114-Status: GOOD (  16.44  )
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

On 5/17/23 00:42, Sagi Grimberg wrote:
> On 5/11/23 18:03, Bart Van Assche wrote:
>> @@ -1582,11 +1566,6 @@ static int nvmet_rdma_queue_connect(struct 
>> rdma_cm_id *cm_id,
>>           goto put_device;
>>       }
>> -    if (queue->host_qid == 0) {
>> -        /* Let inflight controller teardown complete */
>> -        flush_workqueue(nvmet_wq);
>> -    }
>> -
>>       ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
>>       if (ret) {
>>           /*
> 
> You could have simply removed this hunk alone to make lockdep quiet on
> this, without the need to rework the async queue removal.
> 
> The flush here was added to prevent a reset/connect/disconnect storm
> causing the target to run out of resources (which we have seen reports
> about in the distant past). What prevents it now?
> 
> And you both reworked the teardown, and still removed the flush, I don't
> get why both are needed.

Hi Sagi,

My understanding is that the above flush_workqueue() call waits for 
prior release_work to complete. If the release_work instance is removed, 
I don't think that the above flush_workqueue() call is still necessary.

This patch prevents that the target runs out of resources by releasing 
connections synchronously instead of asynchronously.

Does the above answer your questions?

Bart.

