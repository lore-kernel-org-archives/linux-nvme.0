Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A65C7618E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/bRiTgxkdFMkG+apAKytJGIlGPfvWygUknvUmPJKkf8=; b=WDj7iZXr+ovrHUpLuQ6Zm75NI8
	lJ+uIIy4Qt95KTh6jlSKTGCsTMWLGmon+fXLyyL5BxUFU7Z3OS3iXnBskoL69TNouxzmDQfVw+D0T
	STAyRNz20ZsJ+6xooIAzw1QV52UB+JDiMCSgOFiywLHTEDD7ryzXIxGA3BKM+plqmoxrEKhFdV3Y8
	yCnVNFOZVnEX138OaoUE/L2rb7TnBxHkUKFpZi66FU4ttAirUhaUjF2hrivR4q60aDghP2jeV9SaR
	rCEG57YqUDOUNQF/tcmxJSIlW4JWgsaNRkESDwUt8h1FLjuv54/PfdKkYNaeFdfVoiT37iOwf3L4M
	o/i3FV5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwfy-00GVPA-2r;
	Mon, 24 Apr 2023 13:56:18 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwfw-00GVNX-1l
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 13:56:18 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-760dff4b701so25947339f.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Apr 2023 06:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682344575; x=1684936575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bRiTgxkdFMkG+apAKytJGIlGPfvWygUknvUmPJKkf8=;
        b=WuE/cmr5jcSd1XJW5klJAX3Eartrg46Qx4ccxgp4EEI3LK6afKeLQNC8L/NOtTYsLe
         SFSNjCXBVzmy5bX+uJa88O41nqKrUZilRjDDM4GXYGcDfOkJIAPafR746gequ+Srsej2
         Bf4iMb4iL2byJgknc5CX1/o1WVvhtsY9dr9Yhshm6EpdftOhl70qMYvzeJCOyxtEdugr
         78ZfHxGYUu5jDs7yROMUQzw/DQ+e2fVnqU1XqBB8oKyWZGHMizCSancxqwJ33V0DvJ2J
         VSakywy6fd6bjkbb4SlnWCxoEVHsSQPJIobGcu4FOtsp3wcXI1jqzLffvA9q0WciRv+K
         juVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682344575; x=1684936575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bRiTgxkdFMkG+apAKytJGIlGPfvWygUknvUmPJKkf8=;
        b=BrsiR+nK22R5z+8RJdr6ZkMucuJB/YGHNeymwHQ9H45MurU2jaoVvaIqE8OXaMVzjc
         3d1p/0xGUHz8sVGt+TGz1DvQJYBPJueQyKzzrBEFkR1DByxBkFzygNOV8gvOIjHZ5BLY
         my/3y3zJWgOABcha184wbvp6Ge5mZNQA4WKDdbEtfM6XoclivltNC3Z3SWyf7BA16MvM
         yQx/QxQRtPqIcidvcv5CnCS545uIJ6Q//+RwJwStTvMKsRpydxe57vRi3jC0Bqmic+NN
         +IW0FWNPpbD4rElqq4qZ8519YJ8RZOlWbTpMVT+u/Mpak+nhCq+Vjhg/83ZQh2OQ43y7
         pvNg==
X-Gm-Message-State: AAQBX9cst16SbbC0x2ldkeG9kAlamuPX/CgUdwTatH6NbSdqHSyTiBOf
	xRRRJLsfPtBJyy6HOBmqJxBsrg==
X-Google-Smtp-Source: AKy350ZoXbNiq9mLvspvDyTiFezreLv7eyE6tsvOeO8uZM7GqMGu5hfnAifn7aPmKVQ9mS0+Ez3eww==
X-Received: by 2002:a92:a80f:0:b0:327:b69c:c202 with SMTP id o15-20020a92a80f000000b00327b69cc202mr5637150ilh.3.1682344575090;
        Mon, 24 Apr 2023 06:56:15 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a5-20020a056e02120500b0031595ea003asm3082442ilq.85.2023.04.24.06.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 06:56:14 -0700 (PDT)
Message-ID: <980a8241-407f-a3eb-a1b9-d5eb1ae0ecf5@kernel.dk>
Date: Mon, 24 Apr 2023 07:56:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
To: Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424130316.25805-1-mgurtovoy@nvidia.com>
 <ff1eb7b3-890a-7f12-94ad-6951bb1533ab@grimberg.me>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ff1eb7b3-890a-7f12-94ad-6951bb1533ab@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_065616_776689_030D5F1B 
X-CRM114-Status: GOOD (  12.57  )
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

On 4/24/23 7:38?AM, Sagi Grimberg wrote:
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> new file mode 100644
>> index 000000000000..8d2aabe2d290
>> --- /dev/null
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -0,0 +1,657 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> 
> Linux-OpenIB ?
> 
>> +/*
>> + * Sysfs interface for the NVMe core driver.
>> + *
>> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> 
> Not an expert in this matter, but does copy-pasting full hunk of code
> from one file to a new one qualify for copyrights claims?

IANAL, but that seems bogus for sure. Adding a copyright claim for just
moving code is nonsense.

-- 
Jens Axboe


