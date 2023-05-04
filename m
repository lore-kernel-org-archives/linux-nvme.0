Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F92BC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bRSKiMRNzAS8SYsNJtO1x0Je7I8zvfMap7XakQOJ9KM=; b=af4nn/pekFmaTg+AZmjsYGZRy9
	4h2weD5m5NEqjB50VCxALvHKyhiOGmIL2nA7Cl4oKQnSnjT+X1HDlTkXTGfmNOSi/u23A32Ao00vp
	/JVghrhB4D5AQY5fxKfZT9mZgQIH3sMZ93CulWSI4Z4/oyXtVk3aNlE3efw93YsR/xv6VGs/uglQc
	1rh/PwKK3j/3LoYxia5WFNvKY12VooF2+PyIXKE1WHBXdBGU+cIFI8S5bv9VC3ecpVg3PG3MrbHvI
	xy9QbiQVwscTfCdrveGkPMwB3ijrq965OwVz8tPLzorkpJC88vxlIIHZkbQRL5yH6GWDpj3gpqAsE
	4DnMjtEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pudBG-008TYM-1p;
	Thu, 04 May 2023 17:55:50 +0000
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pudBD-008TUi-2S
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 17:55:49 +0000
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-32ea67ffec0so77035ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683222943; x=1685814943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRSKiMRNzAS8SYsNJtO1x0Je7I8zvfMap7XakQOJ9KM=;
        b=I5tzf75lA60MDRwyUhlOPX9dYMnWIOPIXMhDevTbdmNhLwsgB/pTnE4VQEf6hdMg+a
         QS78de/oAe4v6Pn9xGtaVj3rARlRsrnltV7SIqWs3AwnKKkvdObPun5JTRo4B3kAOW9v
         ttHdKV6M7qXD1SJfsT3Q+oX1D79rG3w+jNa0Rt54l7LeJHrGEmBZnofZyShOsrqRzY71
         NFmUJuri1jJ8Xqbs3tM5lcQ/m9FV3RNTzr9UZKXNxQ6szOCVSyyF5dE8WMkMZDP6+n7v
         XmEgNJElTY5iadU0W0cwruIjGWSIH5NaOMUYMdlakKsRfPTsNmVz30qyP3jW9uYlh7NO
         QT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683222943; x=1685814943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bRSKiMRNzAS8SYsNJtO1x0Je7I8zvfMap7XakQOJ9KM=;
        b=OBrmHDgSn/KJ8wYI3gWBpnyqsagIxQRsU9eCuEwQ8tkFQN1kRZSFZKc8yzvVG4Tm6C
         bvB+rQqJxMtLFCv9H9cRDcVKvPpFZyFY6Vg/Ui6SYrToe1FnkeYXV6clMMpA2fY+gjCP
         5SrCUxLcWkE4kL5qVEMZZ2A+R50MotpR2lT+LU/mC8sBqhLHiY2jBD8AaMONQf67zaTv
         9Gnx3UqeyYp8Rk6S+bDQhlamObKRFReKpYcRe0vZOu+mi0QkSiJrXeIoVWz1vm+cJWmU
         gegQBS0ysvsQOQPH5X/MT0g9Zke58Fo683Cn/yscwYBaYELwCOvAaP+LwyjqOixphNko
         9TIQ==
X-Gm-Message-State: AC+VfDwSTtYkrPiRAaZfXIkbg+cH+448D+Lb1aW6qZ16kaE7Cgfl3gLN
	rXlW+ko2KsUI44jXDcnGOvKGBpXqnTPjaDAzGY0=
X-Google-Smtp-Source: ACHHUZ4CwxguDAnm5mofESc7Ze4qxx1tbr1Q32K2GggqnGP6Rqj5PcO3ovGjM3QdQX4e5v6SnA6n/Q==
X-Received: by 2002:a05:6e02:20e6:b0:331:1267:31f9 with SMTP id q6-20020a056e0220e600b00331126731f9mr6568960ilv.0.1683222942925;
        Thu, 04 May 2023 10:55:42 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 10-20020a92c64a000000b0032afe23820bsm3272ill.17.2023.05.04.10.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:55:42 -0700 (PDT)
Message-ID: <79be970b-16d7-bfb4-ddc1-6705a06e4e34@kernel.dk>
Date: Thu, 4 May 2023 11:55:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: dynamically allocate nvmet_ns->nguid
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20230502053051.14621-1-kch@nvidia.com>
 <b9688be8-fd92-99df-7083-c8a695e77377@kernel.dk>
 <4174843d-18f8-572d-8fff-ab6d9bf42946@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4174843d-18f8-572d-8fff-ab6d9bf42946@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_105547_795808_F3F85773 
X-CRM114-Status: GOOD (  16.56  )
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

On 5/3/23 4:39?PM, Chaitanya Kulkarni wrote:
> On 5/3/23 08:45, Jens Axboe wrote:
>> On 5/1/23 11:30?PM, Chaitanya Kulkarni wrote:
>>> The nvmet_ns struct is critical to I/O operations in each backend bdev
>>> and file, but its static nguid array is not accessed in the fast path.
>>> This means that pulling all the memory for the array on each access
>>> is inefficient.
>>>
>>> This patch dynamically allocates the nvmet_ns->nguid array, reducing the
>>> size of the nvmet_ns struct. This optimization should reduce unnecessary
>>> memory access in the fast path that is required for the array vs pointer.
>>> For allocation of nguid with kzalloc() use same policy GFP_KERNEL that is
>>> used to allocate nvmet_ns struct iself.
>> Replacing 16 bytes of embedded memory with 8 bytes and then alloc+free
>> seems like a poor tradeoff.
>>
>> Why not just arrange it a bit more sanely, and also push the config
>> stuff out-of-line as that would not be used in the fast path. The below
>> 30 second job takes it from 456 -> 440 bytes for me, and has a better
>> layout imho.
>>   
> Intentionally I didn't touch reordering since I've asked Christoph J
> look into it so my patch only optimizing the nguid allocation.
> Just looked into his series your patch is missing from that.
> 
> Moving configfs out of the way and combining bool together is
> much better layout ...

But I think you missed my point, which is that replacing 16 bytes with 8
bytes, and then adding an alloc+free on top for the latter, doesn't make
a lot of sense. And some saner reordering gets you a bigger win, without
needing to resort to any of that.

-- 
Jens Axboe


