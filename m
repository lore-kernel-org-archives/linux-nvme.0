Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F038FC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:32:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971E960EE9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 01:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 971E960EE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YknGA/91WpOTwzE96GQFNRVxNifhNn6HSUSS25vIzYY=; b=0JPkbJ9vl0C8bFtb8SGo0KjIWl
	hH/bgFJdB8f8KObJrTuPGOxw479IF9I5g+1TjU1BV3v/DwYA95R3qSTIDUVK59ZupXIxi9u/9Q60h
	W7PmLHzu++U1QYET/zPNpyLhKhjDrbyIOTk51HKMe74Hb/hbbJl6/ghpNi2fRCsp4GMMYAfikLx/u
	vp38On/VQPdB0JxjN7w220sOlsKvfPdZCIMcIgWD8aPrjcUOA+6nLvuwakHRiYV7KTl9vTnE7c55S
	NS+Cq12H1U2AXWg3IhsQ4Xuk9DHeKNI+/CJKPQXO7RKMj6UDHfmxREFpUrnr0WLm9FbsX46GLg3Wb
	lAE4OQnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDd6g-005As5-BU; Wed, 11 Aug 2021 01:32:34 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDd6d-005ArX-Fd
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 01:32:32 +0000
Received: by mail-pj1-f43.google.com with SMTP id bo18so974834pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 18:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hg28dbppp+DeO8XFA2BkM8GSss92cdT5BCAqKNFT/y8=;
 b=WLYhZ5RJbXkqTB/jSj2Q+VADaI2k3WIbTlleIHBSNh9BsBy4I73Fj83gjZ2eytmOav
 /BnEWASQDuCINMi9xc1QX/v34z3QotJjVCM/BFIoR6cgJogL3EHU4m88fQn3naxT3lee
 3k8jEk65Hx/gxiq4AB7JhtOTK4x2+24XbQDuMn9ICzXV/WYBxBGFpejRpDBTbvcSiXC5
 xP3gsHvSoBrpD5EQts+muK7Fx3eM1hJCz8tuf0z4ckTKf6EBK6fpKG1+iKCPG6IgedCW
 zX3A4DA6O/3UoIHAUFtZkthCu8Gp9pWto3MffiugGc34w59KLZMl3Hc0roU4NGUb6rug
 Rtpg==
X-Gm-Message-State: AOAM532wZeClZY792wEr+akWK1oLtd4avegWIslWXAzvTaw8zaBXu5Bn
 f99aXwpLiPldXnjzHaydKWEtk11tTUU=
X-Google-Smtp-Source: ABdhPJwZRJON6Ms2HTIcQak3UABp5bKxE23gRD90thVvcoH03bbdBjdz6lVt3KoSDVPmfx1IFHcAHw==
X-Received: by 2002:a17:90a:1108:: with SMTP id
 d8mr7946181pja.190.1628645549714; 
 Tue, 10 Aug 2021 18:32:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:61e5:4b9f:b48a:e987?
 ([2601:647:4802:9070:61e5:4b9f:b48a:e987])
 by smtp.gmail.com with ESMTPSA id s31sm30108988pgm.27.2021.08.10.18.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 18:32:29 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: don't do scan work if io queue count is zero
To: Keith Busch <kbusch@kernel.org>, Ruozhu Li <liruozhu@huawei.com>
Cc: linux-nvme@lists.infradead.org
References: <20210803090630.14425-1-liruozhu@huawei.com>
 <20210803090630.14425-3-liruozhu@huawei.com>
 <20210803155512.GA2294634@dhcp-10-100-145-180.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f3a9a4fc-56cc-a2ae-25d7-1a9f2b358b41@grimberg.me>
Date: Tue, 10 Aug 2021 18:32:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803155512.GA2294634@dhcp-10-100-145-180.wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_183231_578669_FC1BD953 
X-CRM114-Status: GOOD (  19.18  )
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


> On Tue, Aug 03, 2021 at 05:06:30PM +0800, Ruozhu Li wrote:
>> kernel panic when try to rescan ns when io queue count is zero.Because
>> kernel BUG_ON when hctx_idx is greater than ctrl->queue_count.
>> --
>> nvme_rdma_init_hctx+0x58/0x60 [nvme_rdma]
>> blk_mq_realloc_hw_ctxs+0x140/0x4c0
>> blk_mq_init_allocated_queue+0x130/0x410
>> blk_mq_init_queue+0x40/0x88
>> nvme_validate_ns+0xb8/0x740
>> nvme_scan_work+0x29c/0x460
>> process_one_work+0x1f8/0x490
>> worker_thread+0x50/0x4b8
>> kthread+0x134/0x138
>> ret_from_fork+0x10/0x18
>> --
>> Defence it by not allowing rescan ns when io queue count is zero.
>>
>> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
>> ---
>>   drivers/nvme/host/core.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index dfd9dec0c1f6..d9f837eb3e26 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -141,7 +141,8 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
>>   	/*
>>   	 * Only new queue scan work when admin and IO queues are both alive
>>   	 */
>> -	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
>> +	if (ctrl->state == NVME_CTRL_LIVE &&
>> +	    ctrl->tagset && ctrl->queue_count > 1)
> 
> Why is the transport driver leaving an unusable tagset allocated when
> there are no IO queues to support it? I think it should free the tagset
> in that case. At least that's what pci does.

We can't release the tagset as that will fail I/O (which is probably
fine for mpath) but for non-mpath we want I/O to block.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
