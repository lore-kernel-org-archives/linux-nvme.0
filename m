Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C19AC46467
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jan 2023 09:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rrtrjn/9IMuh3EcHY6+lhXRH1IMlvNXhgY5+xxR60DM=; b=VodtS1xueDBghioelqqYcm4QTE
	foVKsCWPBcmvCJ8p7/5YK+gqG89eA64dJdK85pQQhuPk1OT5Gmo0//83YFSz9EHwMXUXAo8x+SsTa
	ucG1HMZXlTIjYfmezK5oR0YBrflwDU3YKBGKrhzMfG02Oma4v8yct5SqBpu+xwT4fXnWbZB6lao+t
	WmeDhBJzjjGU/nEM4WiG4rop1AU0lGPiqJH8oYsIw3vehKKkYGpWUijM+dVD4jDHS+2VHAZ0Itf89
	pmh4xYDvgI09uz2DCO4mI7LuHn0PMQBCC9M3ms2jppdTIycCk6yj+oR05CkaSopIzfh0vU45JE7lL
	FuiE+NIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCHIw-009yjT-F1; Mon, 02 Jan 2023 09:40:26 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCHID-009yPf-Hu
	for linux-nvme@lists.infradead.org; Mon, 02 Jan 2023 09:39:52 +0000
Received: by mail-wm1-f45.google.com with SMTP id ja17so20011411wmb.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Jan 2023 01:39:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rrtrjn/9IMuh3EcHY6+lhXRH1IMlvNXhgY5+xxR60DM=;
        b=hxTSHx4gVW3Q4yg8tFvWpfiLA3cu3aWcyJgfQ9Qw3vU8U3QilDhrPTJbyHVYi88AJG
         oxQoj37xl2Djjb7939oxaPFWNDxPsYaJWOYycFT7cueIKn/ZtpViW53Tc88ZHHhjS0XB
         pTT9arXsImWxCWQ8I9CqLI/J/mcy9MalNrdX7SBAQRW7jwmw7tewmNUt8AEOcwsdRs63
         2XovnPsDkumsM/DnJpjY+9TXEm3OJd0KpadbUJzY6PuMKafgIuehD+qKI6ge2hn7vn6e
         8Jc9XNdULF/axkyMkLBZ/nhpa7ouQswnK9zOnFch7tHmr2HSA2R82J7GWoIfumD6ygFT
         dzpQ==
X-Gm-Message-State: AFqh2kposkJ4tjqjW9B8D8vDg2L6dl/IaIohV+XTC02waCkaHACkdKb/
	BBMm8m/HmXDGL1k1MMk2Wi0=
X-Google-Smtp-Source: AMrXdXvk+uA99BBBocv+fO2IMCLptnuT3AfPldijFKb+/n6gLDPkHA65xAwhztZfnZzejQ9LPHdRHg==
X-Received: by 2002:a7b:cb86:0:b0:3d0:4af1:a36e with SMTP id m6-20020a7bcb86000000b003d04af1a36emr32288955wmi.26.1672652377686;
        Mon, 02 Jan 2023 01:39:37 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b003d9a86a13bfsm10315102wmo.28.2023.01.02.01.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 01:39:37 -0800 (PST)
Message-ID: <bffad1f9-f379-b5f4-8d37-304edd2ba38c@grimberg.me>
Date: Mon, 2 Jan 2023 11:39:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] nvme-pci: update sqsize when adjusting the queue
 depth
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>,
 Hugh Dickins <hughd@google.com>, linux-nvme@lists.infradead.org
References: <20221225103234.226794-1-hch@lst.de>
 <20221225103234.226794-3-hch@lst.de>
 <f0d3c027-d793-8266-7c69-30a85f884b23@grimberg.me>
 <20221228161050.GA849@lst.de>
 <c1f876cb-5004-c91e-398c-83fb007bb697@grimberg.me>
 <Y63BjxIJykWWTzOP@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y63BjxIJykWWTzOP@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230102_013941_954594_5FB442C2 
X-CRM114-Status: GOOD (  15.35  )
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


>>>> But if you want to patches 1+2 to be taken before 3+4, I'd make sqsize
>>>> to be a 0's based value of q_depth after we subtract one entry for queue
>>>> wraparound. So others would not get affected from patches 1+2. Then in
>>>> one batch make all assignments to sqsize 1's based like in patch 3 and
>>>> change nvme_alloc_io_tagset at the same time.
>>>
>>> 1 doe not make any difference in the 0s based vs not values,
>>> they just reduce the queue size by 1 intentionally.
>>
>> Not sure who is they here...
>>
>> Anyways, I guess we'll have to wait and see if someone happens to care
>> if his/hers effective queuing is reduced by 1 all of a sudden...
> 
> All nvme transports require the host driver leave one queue entry unused.
> The driver was not spec compliant prior to patches 1 and 2. I'm not sure
> if that "queue full" definition makes sense for fabrics lacking a shared
> ring, but the spec says we have to work that way.

fabrics already reserves one entry for a connect cmd, so effectively it
was reserving a slot already...

