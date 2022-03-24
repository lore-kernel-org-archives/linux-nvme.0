Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84204C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 10:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z+tOhomyyHuPVoCuADsMsVAjnchfBPFbDYj/vr6ULFk=; b=UlPIPt+Gy5yN3LAB68l3SWQc8c
	Ezs+dLn56NOWjg+udXTXvmwoBsSpZfow61aO6C+hYV9Y6ryPPeoRwOcwBpE3kqh7To5CJb0jFuwmd
	gehyZD8IxIruZiTzMyOP2D2gFTXJIIM+r/iM9df+9uPIel3W0YmJTKHJ0yKYG9Ls/2Ky7Bq01RbWL
	/6zcXe+qcf5GO4Ht2wVbCaR2oylfWZrPg81MHdBK0FSL1wwc0IWJ4KKvhSWcY75qPblZMavZNkJiw
	oU7AFmJqZXN7RoA3/gq0ZWeuIvqkRu2Ar/agiQsdVLb3IgxeKEpA1L+FfhvxR3RRSgC4A89z6LmnS
	qTUqpoHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXKva-00GFv3-71; Thu, 24 Mar 2022 10:42:50 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXKvX-00GFuE-Np
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 10:42:48 +0000
Received: by mail-ej1-f46.google.com with SMTP id d10so8245167eje.10
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 03:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Z+tOhomyyHuPVoCuADsMsVAjnchfBPFbDYj/vr6ULFk=;
 b=jOLJyV6wLhZ9x+q/N6AehPavLx4aHHYtfouBS51NOLgVAQdiLNeWAVGrj7ZKax6uWv
 hFfAcNYG+4XxhT4xao26JpSfHtszt9VbihoJtGqr701c3HQ+C6C69WAcmOwdqFo82lyd
 1026n2rx2XUFutiEwckrn/M4FvVSNzRTJiR1Th9JOEC7D3eIvBzRH6jJOukhJHn2d5Mg
 sB0wAASUTaXycbWZMiyVQuAx1tDQsTpcdgtX4K18blrTEOf7E8ItLTjbXyzfAG5VnDzm
 1wfhJBe3grLDsRokL2R2mngBIHjVdYsww/QXUnS1+tgHJ2I/cNtLue0zOSfuYWXyIlBK
 bR/g==
X-Gm-Message-State: AOAM531oPEvcemd2tsTc2P+O6XI2XzZH22wPlMIQRJlFHwlVnvY6SfBV
 4nixxnmFcd/2SMUPk9o4A3g=
X-Google-Smtp-Source: ABdhPJwIdokZm/Y/j1GkNTRNcR1YxV/an65AItscWscYJKvj1/Qq6h7xM55DmHKiD8wf1owr5GZbZg==
X-Received: by 2002:a17:906:6547:b0:6bd:e2ad:8c82 with SMTP id
 u7-20020a170906654700b006bde2ad8c82mr4794402ejn.693.1648118565765; 
 Thu, 24 Mar 2022 03:42:45 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 l2-20020a1709060cc200b006d3d91e88c7sm959117ejh.214.2022.03.24.03.42.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 03:42:44 -0700 (PDT)
Message-ID: <88827a86-1304-e699-ec11-2718e280f9ad@grimberg.me>
Date: Thu, 24 Mar 2022 12:42:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 05/17] nvme: wire-up support for async-passthru on
 char-device.
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshiiitr@gmail.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav
 <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <20220308152105.309618-6-joshi.k@samsung.com>
 <7a123895-1102-4b36-2d6e-1e00e978d03d@grimberg.me>
 <CA+1E3rK8wnABptQLQrEo8XRdsbua9t_88e3ZP-Ass3CnxHv+oA@mail.gmail.com>
 <8f45a761-5ecb-5911-1064-9625a285c93d@grimberg.me>
 <20220316092153.GA4885@test-zns>
 <11f9e933-cfc8-2e3b-c815-c49a4b7db4ec@grimberg.me>
 <CA+1E3r+_DEw5ABPbLzSp9Gvg6L8XU-2HBoLK7kuXucLjr=+Ezw@mail.gmail.com>
 <3ed01280-5487-7206-a326-0cd110118b65@grimberg.me>
 <666deb0e-fa10-8a39-c1aa-cf3908b3795c@kernel.dk>
 <28b53100-9930-92d4-ba3b-f9c5e8773808@grimberg.me>
 <20220324062053.GA12519@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220324062053.GA12519@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_034247_809335_8454AA47 
X-CRM114-Status: GOOD (  15.23  )
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


>>>> I know, and that was my original question, no one cares that this
>>>> interface completely lacks this capability? Maybe it is fine, but
>>>> it is not a trivial assumption given that this is designed to be more
>>>> than an interface to send admin/vs commands to the controller...
>>>
>>> Most people don't really care about or use multipath, so it's not a
>>> primary goal.
>>
>> This statement is generally correct. However what application would be
>> interested in speaking raw nvme to a device and gaining performance that
>> is even higher than the block layer (which is great to begin with)?
> 
> If passthrough is faster than the block I/O path we're doing someting
> wrong.  At best it should be the same performance.

That is not what the changelog says.

> That being said multipathing is an integral part of the nvme driver
> architecture, and the /dev/ngX devices.  If we want to support uring
> async commands on /dev/ngX it will have to support multipath.

Couldn't agree more...

