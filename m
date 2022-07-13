Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FB8CCA479
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n8eCyagKJD1192UPqzMB5meP50tseHK9E50B0X3PFRQ=; b=HeJrWKTxkrDEwDHkXgz81pSlfg
	f4bNwQLZIozMESkHCOZYzUrthcqFO4VFudbxStg2gQPl9M8gRYWl2Yaf18Sspz4KHJWEYzHvWUKN3
	Dv+AQpP6SInkVupbckp+K76KGRMo3Nx9fOGdlTBf6NRCM9BhQiQ9GQvFyGHU/022kJFQbQSx8BbTS
	LJzcXQLSj2EgNdSG2tGbL/UJOf1r7XP/YTMyeCjgCzUsMK8vU7n9Kui3HAYz6KSYXY4SWSWpE5qwY
	RJXOXCgyIRUuGCXMHsv6qdjtlQFzOqTJhCGMZPcH6ZKJtkx15bXbrKCJc6mOCipADRQ773ElHoQVR
	3OFG2ivA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbIJ-003RAs-4q; Wed, 13 Jul 2022 12:16:43 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBbIG-003R9e-HH
	for linux-nvme@lists.infradead.org; Wed, 13 Jul 2022 12:16:42 +0000
Received: by mail-wm1-f47.google.com with SMTP id c131-20020a1c3589000000b003a2cc290135so1107619wma.2
        for <linux-nvme@lists.infradead.org>; Wed, 13 Jul 2022 05:16:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n8eCyagKJD1192UPqzMB5meP50tseHK9E50B0X3PFRQ=;
        b=OVp4AYIztTHhYFFeF+r17SiG8UshihrzSQHYA1itu8bIAeLIYmlohhXFxf+r3T48Ti
         BDvJcVWnhCF624QFUK5Y99l4UwLUjlKiTXszXoAlXmKq32sj7fJuZwYhE+adaKP7Gyfh
         l0c7yU+S40SQ6EKTBuVft2YbK6+JRkU+iiUn6AE93NfAdWZggBQcDxpank62blx1SMik
         EXmD4x8QYTxAB/V9n4ab2OOInDSLnyUOYoB3K2Vyur+XT7JXTVFmCw/JSrYchzZMK7kh
         bgapsrZU08vJcR5aHSh44K34kcUmUegH5lamW4sI2Chg+oapT+fw6Td4FWx8KdHzV+W7
         qLBg==
X-Gm-Message-State: AJIora9ivBw1g8ERMAO1VzTLPPp20tGJouUZGS8PQJ03zdvddvOg2Kd4
	koS03N1qqsR785STF0YTe3U=
X-Google-Smtp-Source: AGRyM1t6s7YUfAjYHssbxL+0aWhZ1r/560DGbYAjEbsPRdwzdBPLYGVoGLXh+VfJcYUYUWP8wxYpVQ==
X-Received: by 2002:a05:600c:1c18:b0:3a2:e193:2bda with SMTP id j24-20020a05600c1c1800b003a2e1932bdamr3256228wms.2.1657714599185;
        Wed, 13 Jul 2022 05:16:39 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q6-20020a1cf306000000b003a2e92edeccsm1986453wmq.46.2022.07.13.05.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 05:16:38 -0700 (PDT)
Message-ID: <156ed583-5150-d823-437a-de5b9ffcda99@grimberg.me>
Date: Wed, 13 Jul 2022 15:16:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, axboe@kernel.dk,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, asml.silence@gmail.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com, gost.dev@samsung.com
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com>
 <20220711110155.649153-5-joshi.k@samsung.com> <20220712065250.GA6574@lst.de>
 <436c8875-5a99-4328-80ac-6a5aef7f16f4@grimberg.me>
 <20220713053633.GA13135@lst.de>
 <24f0a3e6-aa53-8c69-71b7-d66289a63eae@grimberg.me>
 <20220713101235.GA27815@lst.de>
 <772b461a-bc43-c229-906d-0e280091e17f@grimberg.me>
 <20220713112845.GA780@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220713112845.GA780@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_051640_615485_C272AB51 
X-CRM114-Status: GOOD (  19.95  )
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


>> I view uring passthru somewhat as a different thing than sending SG_IO
>> ioctls to dm-mpath. But it can be argued otherwise.
>>
>> BTW, the only consumer of it that I'm aware of commented that he
>> expects dm-mpath to retry SG_IO when dm-mpath retry for SG_IO submission
>> was attempted (https://www.spinics.net/lists/dm-devel/msg46924.html).
> 
> Yeah.  But the point is that if we have a path failure, the kernel
> will pick a new path next time anyway, both in dm-mpath and nvme-mpath.

If such a path is available at all.

>> I still think that there is a problem with the existing semantics for
>> passthru requests over mpath device nodes.
>>
>> Again, I think it will actually be cleaner not to expose passthru
>> devices for mpath at all if we are not going to support retry/failover.
> 
> I think they are very useful here.  Users of passthrough interface
> need to be able to retry anyway, even on non-multipath setups.  And
> a dumb retry will do the right thing.

I think you are painting a simple picture while this is not the case
necessarily. It is not a dumb retry, because the user needs to determine
if an available path for this particular namespace exists or wait for
one if it doesn't want to do a submit/fail constant loop.

A passthru interface does not mean that the user by definition needs to
understand multipathing, ana/ctrl/ns states/mappings, etc. The user may
just want to be able issue vendor-specific commands to the device.

If the user needs to understand multipathing by definition, he/she has
zero use of a mpath passthru device if it doesn't retry IMO.

