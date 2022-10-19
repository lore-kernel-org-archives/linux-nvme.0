Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC75EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LofcaUSMIaNx2cRds1XrysPOZVMwRolaIDakuz6r9bk=; b=wRJribJCZYB7Y3fXB52yd9B2Tm
	tdN/bjeNfo51d7X/A1k2sjMRNcIv1j+PNlncDLoeqbDpDQGsrD7CH/Nn6RiQ7iAVbePyOQ2fejRxu
	Ek7McAibAyzOh6VmvWkWlRHbtiCkwniqUt7QXSpxYkaolPCDU3BZev1UQwqO78uSxp/GuB7bEfGkz
	Xq+z/77XdgGzDRr1IN3hpdtMMGmZFEE9sCHfgVBgUtRguorhXK+hSJXxnRHyRF3BHMOxbkpOn1HMf
	W+JXiy+JT5xtMsXgP9rxfSixW+hhnhSXAnA4jaLkbYVmHEMecAUIzCvTTdi1egxj8guPz5/gB1na4
	N+ZYRv3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3XR-00GC0G-F7; Wed, 19 Oct 2022 07:30:53 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3XO-00GByP-EV
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 07:30:52 +0000
Received: by mail-wm1-f54.google.com with SMTP id t4so12310770wmj.5
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 00:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LofcaUSMIaNx2cRds1XrysPOZVMwRolaIDakuz6r9bk=;
        b=v1uRtCmiP1GnhBwzAjUZthzO6emEhtRMMtzuVjR0y9OyCKenhDTMME3avbRYqzqgBO
         mml5fsymJ18k/Iz25pqOrjhrkjYegr6Y+olGvcebO7WZfBm8dkPBfFvLZxBdkD95zBfZ
         c/IWoA9exTlRyILLGvMazsd+ezzQLZN9nWHEQIDJMPpv6hLH6KRyjqKoLKHYK1kCTh5Q
         bkLrRJ8KO3Y1tMLvSfdkBuqIwFATT8/OHHie9YiFQfQFclRItX6N6rEQ4rIqsEnWl0P4
         M/lgkR0MJjAJk10dnIf5+MlrVL2vT4VE3AsIZ2d3HQyD8eZx2RAKUm7Z1MowO3sWGuH0
         HeVA==
X-Gm-Message-State: ACrzQf0UIcpGHJbIVX1GodPlNEU8ecBKz5rYYE94K/eZ2x7bJVYOvGOL
	RsHX/osQTxalP/3a9nbiJ30=
X-Google-Smtp-Source: AMsMyM6ehhFFVp3zLUaCyDL+dBLZlA6v9cYEx07QrvR3VhdpTVhOCIDTYKIKQ5Byxj+J0Oqc1N71XQ==
X-Received: by 2002:a05:600c:1509:b0:3c6:809a:b5a1 with SMTP id b9-20020a05600c150900b003c6809ab5a1mr26112789wmg.71.1666164646481;
        Wed, 19 Oct 2022 00:30:46 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b0022afcc11f65sm12887605wru.47.2022.10.19.00.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 00:30:46 -0700 (PDT)
Message-ID: <974a750a-4d18-f559-0247-3d3aa62e620e@grimberg.me>
Date: Wed, 19 Oct 2022 10:30:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1>
 <20221017153105.GA32509@lst.de>
 <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1>
 <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590>
 <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me>
 <20221019072535.GA11402@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221019072535.GA11402@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_003050_519907_7317EEA4 
X-CRM114-Status: GOOD (  13.50  )
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


>> nvme-tcp will opportunistically try a network send directly from
>> .queue_rq(), but always with MSG_DONTWAIT, so that is not a problem.
>>
>> nbd though can block in .queue_rq() with blocking network sends, however
>> afaict nbd allocates a tagset per nbd_device, and also a request_queue
>> per device, so its effectively the same if the srcu is in the tagset or
>> in the request_queue.
> 
> Yes, the only multiple request_queue per tag_set cases right now
> are nvme-tcp and mmc.  There have been patches from iSCSI, but they
> seem to be stuck.

iscsi defers network sends to a workqueue anyways, and no scsi lld sets
BLK_MQ_F_BLOCKING.

