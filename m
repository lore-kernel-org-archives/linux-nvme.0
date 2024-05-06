Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614CCC10F16
	for <linux-nvme@archiver.kernel.org>; Mon,  6 May 2024 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qdtDDeytcxiqc75VPsvZlZLywIeDSbnrxWnckzXAQjg=; b=oV6B/ahDjwc37Yr/lKc2p8827l
	E8B+tm3C6QDUptKjDgB/gyDf9B+DfmVvyzr1XjsRZxw2bgr/T1YJAfwNHSlmys5+vxoDRJh0yTDIb
	X0LkDaDnhSvor8+RYnzCugwoNoxawg+YVcNh2/RXh6+k/VPKgYMzQro3WowPD6Gur9C4W06TU2gni
	XQQFtIqpA41Px9znY8gKEZBBf8IneroPv0rv4Nq48F9gvptA8bC3QHygp61psw548hZtT+5LUASid
	/otsKjAjwNPv67ZzIdnJvkKADFujSadnRUP4yKOUwEyKKN66Y/OyygGMiml1FZAFUo4UtQ6fKDn09
	HoGuKOtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3t6w-00000006ViS-3jE8;
	Mon, 06 May 2024 07:50:10 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3t6t-00000006Vfo-2YbG
	for linux-nvme@lists.infradead.org;
	Mon, 06 May 2024 07:50:09 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41ecf80482bso912725e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 06 May 2024 00:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714981804; x=1715586604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdtDDeytcxiqc75VPsvZlZLywIeDSbnrxWnckzXAQjg=;
        b=rhmT3z/O5oBTwB/8NRtNZgIY0o4ESBat03gsBtT+KSyUJMp07o7+k1G3hAEs6MoMZt
         TJQtw5kkuYVfcNTtcVvucWROTmtLFxvVF/ny20x1EvKfKL0E+feru9jMzePc/ZeS91Sl
         4rNU7bZZWel6EdHWZfuuXNGeOfhRNWZVI2lLLmfzCEZxwNi6Haw3ouH4QvJ81wXVNUfa
         BScv2lHZkLahWC5tOOaMwUc35wSr1R9mtoEPy9ZWMRz3xEaVXFt8rB2l0xWZc6T8ClkY
         fI7obVm1z6oXLa5A5BBjBGhMfyWun+g3DEZrgpfzRq8Ek2EomH/FOD0e5x4RCLsYedj9
         fg1A==
X-Gm-Message-State: AOJu0Yx+B8oE2/BIkHbVYIkRTsPHyXSfg0Eh5KF2l7dX7eGB73cPoW48
	gFgrYQxS58rkIsYCjcomN6Wun2DUEGwxc4TrJzW/+9Kz1A7Sv/4a
X-Google-Smtp-Source: AGHT+IHmd4as+bzNAqQfSbD9nyh+VaY6EB3eYdS9b9Pe5M7nsoeKhuy/F5YUaUCAlM0Ovy6UTCym9A==
X-Received: by 2002:a05:600c:4fd1:b0:418:1303:c3d1 with SMTP id o17-20020a05600c4fd100b004181303c3d1mr7427777wmq.3.1714981804013;
        Mon, 06 May 2024 00:50:04 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0041bb11ff5a7sm18905771wmq.8.2024.05.06.00.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 00:50:03 -0700 (PDT)
Message-ID: <d15da519-2c81-42bb-8f60-89da4650f7a9@grimberg.me>
Date: Mon, 6 May 2024 10:50:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: make nvmet_wq unbound
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20240505103951.52413-1-sagi@grimberg.me>
 <20240506053308.GA5030@lst.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240506053308.GA5030@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240506_005007_687719_7C7D1C18 
X-CRM114-Status: GOOD (  15.39  )
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



On 06/05/2024 8:33, Christoph Hellwig wrote:
> On Sun, May 05, 2024 at 01:39:51PM +0300, Sagi Grimberg wrote:
>> From: Sagi Grimberg <sagi.grimberg@vastdata.com>
>>
>> When deleting many controllers one-by-one, it takes a very
>> long time as these work elements may serialize as they are
>> scheduled on the executing cpu instead of spreading. In general
>> nvmet_wq can definitely be used for long standing work elements
>> so its better to make it unbound regardless.
> This looks sensible, thanks.
>
>> While we are at it, expose it via sysfs to allow cpumask
>> control of this workqueue if a user wants to modify it.
> This on the other looks very questionable to me.  It needs a way better
> justification and should be split into a separate patch if we really
> need it.

It doesn't have any better justification. I never really saw any other 
justification
to add WQ_SYSFS to a (usually unbound) workqueue, than simply have 
visibility
or ability to control it.

What makes you think this is not harmless and useful?




