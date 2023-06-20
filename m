Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5285CEB64D8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 10:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yCDS4aJu5R+WDDnO8dMRPmrAcYwY3DQAbMpWRhnvmME=; b=0tMnRrnG6KUGZHPSrL/o06wxEP
	D1ZTPuUjDJVLXkX8QH5kP7Ae14L1Klpo438dPUiYOlo/ksMHW4YGo+MjiahM4yfltDH+hfyGl2Xuv
	E9zKRZJRoCfHaK83+WrI/GAgf6Wdnyi/+wvY72EV54xmw5c6a3w3GtfAQvVF906dgf6dGSnGKrLRT
	MtWZnf6FUWe5AEt2MVBoLgBYYtEn4td4qIcxEraRXbz1ElhOqaeUvJ6sZoGJbyhruuFUc/BI6JGvk
	bpKM1P150r2B4yCNk8nSEeo2lFqnS9l76g/R4Ps4NmoeZMAO0rf/YaQvZ2xXwszFx0v7j3uh85OUs
	4/992Ikw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBYB6-00AngR-0V;
	Tue, 20 Jun 2023 10:01:36 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBYB1-00AnfR-2M
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 10:01:34 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-3f9b38e4e29so3912455e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 03:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255289; x=1689847289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCDS4aJu5R+WDDnO8dMRPmrAcYwY3DQAbMpWRhnvmME=;
        b=De1ViuYNTu34knh0AQqb7hOKNgm5uLfG7O0NBIrJgii1BSSCU6MzvOmuL8xsVzDBW0
         Pivf9Ld9Kg+dvzoWiRb9IeeT5aRm8xhzai+/Rm01GrCsxMOcfy6BOZzq8f9nqHf9l42N
         67wCYZoNspBBCrpxI376Gv/74A/lFL+doTEdX1uvUimffI3z2hd04a4Ww/FQxikH7YH3
         6wnQy5y1wWV4mgJoUWu1SkqjGZC019jA7bZ+kxZNqw77+QU+mrjevmOjHiXTxbgKtBeq
         xnIFEv/VNscsEVd/Ecd8TtV6TdJM4ZNT9OFXPv4J0ixh70TyjUBsK6SSkW/VhmQj9qip
         91Kw==
X-Gm-Message-State: AC+VfDwyTmDVkHv2lJO1dMxPJmqUgHOBMqghCjoYWLbdjclI1qgAZmKi
	TDyeTsy7hLPczE63LNeE2Uc=
X-Google-Smtp-Source: ACHHUZ55gLulHOB1ptW2A/aNbYvJALXz2obyFE+D30kJH7lwmsApJSoYxRyG5/tLoL4o70WY3rsI5Q==
X-Received: by 2002:a05:600c:6349:b0:3f9:b3f9:fac4 with SMTP id du9-20020a05600c634900b003f9b3f9fac4mr3135429wmb.1.1687255288940;
        Tue, 20 Jun 2023 03:01:28 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c00d700b003f78fd2cf5esm1900672wmm.40.2023.06.20.03.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 03:01:28 -0700 (PDT)
Message-ID: <b4b47027-119c-bde1-f91a-4fd0cec9edcc@grimberg.me>
Date: Tue, 20 Jun 2023 13:01:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
 linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
 <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
 <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com> <20230616054800.GA28499@lst.de>
 <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com> <20230620054141.GA12626@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620054141.GA12626@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_030131_779222_C7EF02D0 
X-CRM114-Status: GOOD (  12.12  )
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


>>>> GD_DEAD is only set if the device is really dead, then all pending IO
>>>> will be failed.
>>>
>>> del_gendisk also sets GD_DEAD early on.
>>
>> No.
>>
>> The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
>> bio_queue_enter().
> 
> IFF we know we can't do I/O by the time del_gendisk is called, we
> need to call mark_disk_dead first and not paper over the problem.
> 
> An API that force unfreezes is just broken and will leaves us with
> freezecount mismatches.

I absolutely agree here.

