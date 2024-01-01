Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB129C47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WzKPur3jcdDSfibt1RFCNQMNY6sjJlJHaOdOKnaIKRw=; b=OW52LXBFSfZGIr+3uu11+kPJmF
	BCYyCV3t0+edQA0UeqoPQbRFCmvFt3KZ9wec0+Un34lDWdSlQC+UpwC+u4OlbCwFCz0Banx6T3An2
	Or1XgC8TV+oxPHWboTY/q3gNmpxFb6h/Cg02T1kdv89YtC+Q05d2uz+mBmKrs2Inuv9Xzq7HoERjC
	wIn91E88LBWUkAqvpKNWkVqMWlJARM+p/wFNT8BQt/EjX1qTIXiJ/9YBj67gt3oixcSsKuhu8Bt8O
	WPlcVXKgOGZHeLC0fPiWcd7wYCKDXVm83oriOLMy5bf/eKQskVxewoVXqluUZX5vlg2Ho8xChDWm3
	9GoqPUyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEUA-005oSr-0n;
	Mon, 01 Jan 2024 09:21:26 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEU3-005oSN-2s
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:21:21 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d3da82e29so18029335e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704100877; x=1704705677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WzKPur3jcdDSfibt1RFCNQMNY6sjJlJHaOdOKnaIKRw=;
        b=W0tluG4yg/Gqbw2G12sYHWIqTj03QYlC7E7trROy/rYexGy457HmyqrHyFNqiwb6ze
         0NHlcyjqTC0ZbJ6nzeABSS8Dhg2WjkJiK8GC5lOZu4H3o2vzcqf7ghemnoR1SRUdSyhP
         K+9eLdT6tul8Wg+5jRRHwhno7rq+BjRLTGmpOq8XWl6DWwFu6kdHMWpm4OPWcqnzdY40
         G96qC98jyP5YY39vpuJNE2MLckhgfenBltNyDalH5a5ToqDExXpzc3l2p36YwdR6zA//
         Ly4tWqQc4wJR/lUCsuR3F/Z1JPBfacxN9CyQekqdokD+ku6IUPRr/a3sZPlDAgSkcwf+
         qBnQ==
X-Gm-Message-State: AOJu0YxIKZ9BnEUpjSp5BVVwpXJAPwxyPpDo1xBgshKp8HKpB1oK35/e
	3FdLULcsEoLEx2WeAA+XOtQ=
X-Google-Smtp-Source: AGHT+IHoxt50xHLLhabtp/eLMiaIvglTi76KYx8AAu/RJiOmjoKsxmcrMOCqZpoc9bk0/9DOEoXxCQ==
X-Received: by 2002:a05:600c:1ca8:b0:40b:2708:2a52 with SMTP id k40-20020a05600c1ca800b0040b27082a52mr19513584wms.1.1704100876914;
        Mon, 01 Jan 2024 01:21:16 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe307000000b0033674734a58sm10035586wrj.79.2024.01.01.01.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:21:16 -0800 (PST)
Message-ID: <e2001f25-ee04-4f34-823c-7647ab58da13@grimberg.me>
Date: Mon, 1 Jan 2024 11:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: Add two-pass shutdown support
Content-Language: en-US
To: Jeremy Allison <jra@samba.org>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 linux-nvme@lists.infradead.org
References: <20231221172257.2234320-1-jallison@ciq.com>
 <20231221172257.2234320-5-jallison@ciq.com>
 <694ac9af-ac3b-41a0-a50d-abb89503d453@grimberg.me>
 <ZYt1o/n8qymZC65g@jeremy-HP-Z840-Workstation>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZYt1o/n8qymZC65g@jeremy-HP-Z840-Workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_012119_955214_33756FA8 
X-CRM114-Status: GOOD (  15.29  )
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



On 12/27/23 02:53, Jeremy Allison wrote:
> On Mon, Dec 25, 2023 at 11:58:04AM +0200, Sagi Grimberg wrote:
>> On 12/21/23 19:22, Jeremy Allison wrote:
>>>  EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>>> +int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
>>> +{
>>> +    ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>>> +    ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>>
>> Why is ctrl_config being set again?
> 
> Good catch. There's no need for that. I'll fix
> in the next iteration, thanks !
> 
>>> +EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);
>>
>> Why export the symbol?
> 
> nvme_wait_for_shutdown_cmpl() calls nvme_wait_ready(),
> which is a static function defined in drivers/nvme/host/core.c.
> 
> The only way to inline the functionality of nvme_wait_for_shutdown_cmpl()
> into nvme_shutdown_wait() is to export nvme_wait_ready() instead.
> 
> If you're OK with that I can remove the intermediate
> function nvme_wait_for_shutdown_cmpl() (and indeed as
> you've pointed out there's no need to set ctrl->ctrl_config
> again).

I think it is small enough to make it static inline in nvme.h

