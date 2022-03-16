Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA64C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bI4ZhjQL8dIuJvz21TfUD5JbGeAx7Qdq2Uugzf6XgB0=; b=PpAqJnFJKFwv5PlhoK6nOYDILA
	7bwVmOz2FgrDd0vB355YrjP3zawZ6wlI5+NIUCzABTFGoXq3qEUhaC6MBeHLrMRvixDlJAl+eyBW+
	gkXGZCNSkZsSg8Jymhk7kQHpOMcKtzzGdzvhZKmy+Rnwr9XVFNA/UQlq9TeEsI8UByvB0drnhWcAb
	4yKMTQI6aGvozbneVKzm4xNltyhHZSk0x0DKUr8jdXOtDC9WiFbfcvR2mQx77Tzjf/TZil537xlm/
	OLIuXkojJYcPoGcwRfUH667QkQhejKRgdBMhs8Xt3yx174IZgxJOHFQYqqIAcMXfOwKhimXqRSgDF
	gs5mwv6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUUzL-00DKu8-LQ; Wed, 16 Mar 2022 14:50:59 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUUzJ-00DKsv-87
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 14:50:58 +0000
Received: by mail-wr1-f48.google.com with SMTP id r10so3348088wrp.3
 for <linux-nvme@lists.infradead.org>; Wed, 16 Mar 2022 07:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bI4ZhjQL8dIuJvz21TfUD5JbGeAx7Qdq2Uugzf6XgB0=;
 b=IO/FWfRFhf6EIaA+8muyymmgovrpKgKtRkS9tIafiQ0n/T9S3gAW9Ax6ctKdmIoc6k
 lkozpFNFfo0O+Kqi6FSdW7Mwj7zt2/SM7Y58aWDrAEpvAjEA1KdAP0HCSXfq6aary6Mo
 eCToKYoXDv+yR3/r2HO4M4XRbOLqmVig9kWMl2HiqpN//jEbn46qQkihoTlOPKsAQ3oq
 YgbZnaX0vlbT4KJGME6yQDJy8f6GcnsXNn6OtEPdWvPKHFOtbi2SqYjTh2BNv36+EocQ
 wQRYaP94RPmD+lm5gCaj68M7aG5b+bhwDBkHlwKtl1Av5kfokiHc76LqLkPUyTkL7CW7
 5ZXA==
X-Gm-Message-State: AOAM533B73klXsDqwMP0UhSt0MBs9hLda51q6srXRZ3hcLhkATC2yihD
 0z+laa9OqUxXbR4t75vJi8A=
X-Google-Smtp-Source: ABdhPJzrRH5zBsn9fYkNcZjd08EnDBOCdVlS4Q3hFeb7W2Pq1bG2CpbUzWEW5D36WNgcL+UcKvbCng==
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr271610wrz.690.1647442255234; 
 Wed, 16 Mar 2022 07:50:55 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r4-20020a05600c35c400b00389f368cf1esm513959wmq.40.2022.03.16.07.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Mar 2022 07:50:54 -0700 (PDT)
Message-ID: <28b53100-9930-92d4-ba3b-f9c5e8773808@grimberg.me>
Date: Wed, 16 Mar 2022 16:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Pavel Begunkov <asml.silence@gmail.com>,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 Pankaj Raghav <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152702epcas5p1eb1880e024ac8b9531c85a82f31a4e78@epcas5p1.samsung.com>
 <20220308152105.309618-6-joshi.k@samsung.com>
 <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
 <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
 <8f45a761-5ecb-5911-1064-9625a285c93d@grimberg.me>
 <20220316092153.GA4885@test-zns>
 <11f9e933-cfc8-2e3b-c815-c49a4b7db4ec@grimberg.me>
 <CA+1E3r+_DEw5ABPbLzSp9Gvg6L8XU-2HBoLK7kuXucLjr=+Ezw@mail.gmail.com>
 <3ed01280-5487-7206-a326-0cd110118b65@grimberg.me>
 <666deb0e-fa10-8a39-c1aa-cf3908b3795c@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <666deb0e-fa10-8a39-c1aa-cf3908b3795c@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_075057_326295_A00CA9D0 
X-CRM114-Status: GOOD (  17.72  )
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


>> [...]
>>
>>> Got it, thanks. Passthrough (sync or async) just returns the failure
>>> to user-space if that fails.
>>> No attempt to retry/requeue as the block path does.
>>
>> I know, and that was my original question, no one cares that this
>> interface completely lacks this capability? Maybe it is fine, but
>> it is not a trivial assumption given that this is designed to be more
>> than an interface to send admin/vs commands to the controller...
> 
> Most people don't really care about or use multipath, so it's not a
> primary goal.

This statement is generally correct. However what application would be 
interested in speaking raw nvme to a device and gaining performance that
is even higher than the block layer (which is great to begin with)?

First thing that comes to mind is a high-end storage array, where
dual-ported drives are considered to be the standard. I could argue the
same for a high-end oracle appliance or something like that... Although
in a lot of cases, each nvme port will connect to a different host...

What are the use-cases that need this interface that are the target
here? Don't remember seeing this come up in the cover-letter or previous
iterations...

> For passthrough, most of request types should hit the
> exact target, I would suggest that if someone cares about multipath for
> specific commands, that they be flagged as such.
What do you mean by "they be flagged as such"?

