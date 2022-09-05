Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F40ECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VIsL7N5ljNMOCja38haH4bXMMncVeQZG5cQVF+WVtYU=; b=whuhDEBin6NThm+RIrEpBZ4L2+
	rcqKWeqTAvCnkeQAiW2MxqEzS5Q6ydSm17ReqXDJ+3RxZc7tOc2n5CeYF8WcPGrjfrNRz8f38ktnJ
	XacpmZZUBLqfSwPGl65+0KrMNDa1FziuMbV1wPAi2TAFlhbg/bbtRLDN0bi1L61DSbeoTMkcS3NJV
	yqra32m9pE5cDxyfAa9EwF5GrWegi+4d8EOZPLOkkO5YlKqPaNreI4oeowHO+eaWG0SZKYHlzh717
	xk7zH1qC7+2nzzrxibb6R9uiQKDBSbr9n38PHKFV9xGb118p5kZYFboZoqVS34mVbyOTkXjM+UWKN
	LF397KgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVEHR-006C6G-Km; Mon, 05 Sep 2022 15:44:57 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9iz-000grT-0R
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 10:53:06 +0000
Received: by mail-wr1-f44.google.com with SMTP id n17so10828924wrm.4
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 03:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VIsL7N5ljNMOCja38haH4bXMMncVeQZG5cQVF+WVtYU=;
        b=nyW4VRHU11HJPc9/jFyjMKZVj1NFL2LJOdN88AiAKs6uNhgKTc9TVHqJHRbO9FLURf
         tUvicLH6VtMnUp/vFenmblh3cfX7Lal5fRbDpjZNzXm7gI0jkKRJfEFjdXt+d3kTO/V4
         4+RBowsiagkb+R321AD4iNI6KkzOprRktysUDpbHRMOTKM8VyMgWZ5Y4AjzE9eimyDjI
         Xk1pZGlpCAM0hEthiAqEKbvDkqjwoFCg3X2kdrXn5CbvfgGQjGcCzXREkFnCT3ARfxqC
         kVI9jF9JgwO94PhFRfUo95vzEvIIPzyfWUqpXp8wwCOuoKk3Ud3pV5Q2N5/zsY5Hofrb
         8luQ==
X-Gm-Message-State: ACgBeo0UhQGlBz60IRmCqeB/7KTPwnNmmzfd7RYb0wIk233JB/3jg4JG
	nZG0m14r0f7uTobDRTIl1T42a1h9Q18=
X-Google-Smtp-Source: AA6agR5coXz/uEHT+pFH0glZiMkDPT1IYUPDQ8cYTqNVa1RzL6jXPDXROWxmghZ2lKhNDF0ssXHunQ==
X-Received: by 2002:a5d:5d89:0:b0:226:e5ca:4bc2 with SMTP id ci9-20020a5d5d89000000b00226e5ca4bc2mr16624196wrb.310.1662375182230;
        Mon, 05 Sep 2022 03:53:02 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5942000000b00226f39d1a3esm8601100wri.73.2022.09.05.03.53.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:53:01 -0700 (PDT)
Message-ID: <9803c44c-e7dd-ba06-2195-9287f8890884@grimberg.me>
Date: Mon, 5 Sep 2022 13:53:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: crash at nvme_tcp_init_iter with header digest enabled
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20220819075117.rzvbecyvh2wuwokj@carbon.lan>
 <9a0bc2f1-b1d0-a34d-2e9f-926da3fc2ab4@grimberg.me>
 <2913fc75-49a6-346e-136c-31b87d6487fc@grimberg.me>
 <20220905102612.xur4ul2bhade6ccv@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220905102612.xur4ul2bhade6ccv@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_035305_094020_B6D5B05B 
X-CRM114-Status: GOOD (  11.49  )
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


>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index e82dcfcda29b..3e3ebde4eff5 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1229,7 +1229,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>>>                   else if (unlikely(result < 0))
>>>                           return;
>>>
>>> -               if (!pending)
>>> +               if (!pending || !queue->rd_enabled)
>>>                           return;
>>>
>>>           } while (!time_after(jiffies, deadline)); /* quota is exhausted */
>>> -- 
>>
>> Daniel, any input here?
> 
> I haven't heard anything from our customer yet. Let me ping them again.

Most likely it should address the issue, but the proposed patch is a fix
regardless.

Will send it as a proper patch, would love to get your reviewed-by, and
when you hear from your customer, you can add Tested-by tag.

