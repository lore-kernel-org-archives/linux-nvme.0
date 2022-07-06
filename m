Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF6CCA473
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XvMk995wzgnDDJsq9K/qXkIeP50uy/sMjQBxeoI5vHk=; b=EpxZfFAo7QR49CzcFTd/AQcv+a
	+s6ylst99HVzQQoHf7n1SqpymH+RMDEEtw3xXzEQuPlLDVnDoOEwSCesxgeTEipnvM6XjQFe32iOZ
	5/MYjxIm4KHh8t/wees+a+e1CAXVUhxlaawt7kdQ11Ae3KOJuf2at+n1Z66YQy92hIuxf/wAN8oYY
	Bk7cnZef/mv5N9RGHZI9zKCX/DZKVBgbZuqtx6+EPaQxu31GMZqjCzRygj85FUB2EqbJiLjRGqRzk
	WXOjD4zGx1fxpsGtSz8oPKTsAxFhTu0CxLNbIDGwMmOS6IhYQYN4cm28gy4P8vPSODu8Nbog+cadn
	xw/2VU3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o96zL-00B27R-Ln; Wed, 06 Jul 2022 15:30:51 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o96zI-00B263-Q1
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 15:30:50 +0000
Received: by mail-wr1-f49.google.com with SMTP id a5so7897317wrx.12
        for <linux-nvme@lists.infradead.org>; Wed, 06 Jul 2022 08:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XvMk995wzgnDDJsq9K/qXkIeP50uy/sMjQBxeoI5vHk=;
        b=2IKea4aOQoMrG+Ys3bV1aHpKTowk2Y2HQ3DqDxnw2flXB8ZHyGekE3knRkMetaKJHa
         w8ylP1SC3LlnLg33VX/TuUbMDUFxyvCSPXlymSGUOLhD5/PLohBu8ivTulUYwK3unoy5
         kirhSx/2PjUj94Fqkpr7m/meHTl1yMYlety4DCY0e4MqKJtff/vYCoEJHsg8oh6LNmHN
         I3QXaVUdcp0HWPilfr3BqGhxKs5CR3hwwWQLDleokKxL3Y34kWayWqKZmSAP2/ZyxI0P
         BUXsdqRuPm4baw+AmIfXP+QxrtCtU1DRSL8svUdImhCf9s78qkBCruEcHq4Mnh6FMP5v
         e5dA==
X-Gm-Message-State: AJIora/jEHC0Uw1P2Uw1XufYtgzAyCWq9Tukcs547lmtPBMfk5RLPfAZ
	mPnJdvjYz9IxQPm4teG5+Hk=
X-Google-Smtp-Source: AGRyM1vcVnSxSH3WsC7XW58OYK6cjX6DhrmMF3Sf0/0iIGolBMboRP/Fm0D47hTciu30fK/aNaVDgw==
X-Received: by 2002:adf:ffc1:0:b0:21d:66a1:c3ee with SMTP id x1-20020adfffc1000000b0021d66a1c3eemr17797653wrs.364.1657121445291;
        Wed, 06 Jul 2022 08:30:45 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b0021d7ae38ca2sm2733195wrp.55.2022.07.06.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 08:30:44 -0700 (PDT)
Message-ID: <0a8099e6-6e28-da1f-7b4b-0ea04fa8f9d6@grimberg.me>
Date: Wed, 6 Jul 2022 18:30:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] nvme/rdma: nvme connect failed after offline one cpu
 on host side
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
References: <CAHj4cs9+F5F-v_2m=MYd8B=dXVgTBrtGikTTzfBU8_cX8fb0=g@mail.gmail.com>
 <CAHj4cs_RUuiOw4pzSD+fv70p6izVMZ8z7mc+E0Kv0Rh8zriWCQ@mail.gmail.com>
 <2c42c70a-8eb4-a095-1d2b-139614ebd903@grimberg.me> <YsOKnb7MWLCeJxBE@T590>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YsOKnb7MWLCeJxBE@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_083048_896616_A2947792 
X-CRM114-Status: GOOD (  15.69  )
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


>>> update the subject to better describe the issue:
>>>
>>> So I tried this issue on one nvme/rdma environment, and it was also
>>> reproducible, here are the steps:
>>>
>>> # echo 0 >/sys/devices/system/cpu/cpu0/online
>>> # dmesg | tail -10
>>> [  781.577235] smpboot: CPU 0 is now offline
>>> # nvme connect -t rdma -a 172.31.45.202 -s 4420 -n testnqn
>>> Failed to write to /dev/nvme-fabrics: Invalid cross-device link
>>> no controller found: failed to write to nvme-fabrics device
>>>
>>> # dmesg
>>> [  781.577235] smpboot: CPU 0 is now offline
>>> [  799.471627] nvme nvme0: creating 39 I/O queues.
>>> [  801.053782] nvme nvme0: mapped 39/0/0 default/read/poll queues.
>>> [  801.064149] nvme nvme0: Connect command failed, error wo/DNR bit: -16402
>>> [  801.073059] nvme nvme0: failed to connect queue: 1 ret=-18
>>
>> This is because of blk_mq_alloc_request_hctx() and was raised before.
>>
>> IIRC there was reluctance to make it allocate a request for an hctx even
>> if its associated mapped cpu is offline.
>>
>> The latest attempt was from Ming:
>> [PATCH V7 0/3] blk-mq: fix blk_mq_alloc_request_hctx
>>
>> Don't know where that went tho...
> 
> The attempt relies on that the queue for connecting io queue uses
> non-admined irq, unfortunately that can't be true for all drivers,
> so that way can't go.

The only consumer is nvme-fabrics, so others don't matter.
Maybe we need a different interface that allows this relaxation.

> So far, I'd suggest to fix nvme_*_connect_io_queues() to ignore failed
> io queue, then the nvme host still can be setup with less io queues.

What happens when the CPU comes back? Not sure we can simply ignore it.

> Otherwise nvme_*_connect_io_queues() could fail easily, especially for
> 1:1 mapping.

