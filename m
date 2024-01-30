Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5020DC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mrjxm1y3m1JVU+6ojmOaPg+TfDTTP0S4T+2ibjKaxvM=; b=vypBWdlX6P5U4kP19Pqc6Bc56N
	9YSKUr7SHLozf5gvLoHx5FIUnVE2oOGvmohQ3LB6q2y2ox29/OYN9Bnf4JSyFyr8vo90QCWxKpcSc
	OqAGf54Xk4r88JBYFNM8Fn4sXEGA9U5dbKSpGi2X7E893R6k6Bx5dPawK6v+FwMpGi+IkRlUlDr8D
	HN0qDDNsI8QmKQ3nyuvoBqPErMDMip18+1T6S3fGhT561g3pKjcd+3ZyggYwql+WhT+RX/uJp7f3R
	0FWwp7BC5S+0jW5BVsVEeu5/nXCdrStnSHK5b4jeRaKJYgY1rgW8htaGxQQm7z8hKtCE6Y/lLCCcZ
	Wm7tdyKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUjo2-0000000FmeT-09rh;
	Tue, 30 Jan 2024 08:49:22 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUjnz-0000000Fmcr-35ej
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 08:49:20 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ad9ec3ec2so379240f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 00:49:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604557; x=1707209357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mrjxm1y3m1JVU+6ojmOaPg+TfDTTP0S4T+2ibjKaxvM=;
        b=fjm8GNlspWT66l2nRPslusx/dhsPje0xFZY4fCb4QacwYQ3+IWfH+AMo96cASBW1jK
         D/SYTYnImPRtnaRFfPraasf3sSNO7QmAVVwJ3R/yhnSGcHYouFJvOqbmkOqdxnx/uqi0
         09fkOP7L4CrwWxyH4Iy2O/vgQFlfEhlQIb3eBX/1MyTWlELt6jmkSQvzpWgIWUAMAHQi
         izWjeka9lVbHxCfy3clv3isIzhZsu5u5dPJR3IwiNpxBJCKUF9vr5jw1zBwCgET5lgqn
         4UJkvXxm9z2HQkV2ut7fO9epptmTZVzQxUYFh8uVgUnWxPSFLleb+jcr8C3X9/ME9Sw3
         KM1A==
X-Gm-Message-State: AOJu0Yy4VHtrzjBeHAqYAWrChdE4tVASKwwq8PzLYFF4lo/w7HKHBDz5
	WhsXDdWg+0ydTeoJAg62mR4Wof1rPKR73nWWzmcXgLTIVoykDvyAWGkz8bPY
X-Google-Smtp-Source: AGHT+IHoaBZVMv3GJOgnUEJXzXWNpwSP7pQrntgoRBK212sp3DPxa8z8KC+jrTip9cKsNMeUtmiLJw==
X-Received: by 2002:adf:cc0c:0:b0:337:9a1e:1d03 with SMTP id x12-20020adfcc0c000000b003379a1e1d03mr6010444wrh.5.1706604556928;
        Tue, 30 Jan 2024 00:49:16 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b00337d980a68asm7776971wrv.106.2024.01.30.00.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:49:16 -0800 (PST)
Message-ID: <f8c1ca31-119b-4837-ba3a-1913a8239158@grimberg.me>
Date: Tue, 30 Jan 2024 10:49:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/1] nvmet: support reservation feature
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240118125057.56200-1-kanie@linux.alibaba.com>
 <20240118125057.56200-2-kanie@linux.alibaba.com>
 <d201893b-e2c8-4265-a634-472459f6bda6@grimberg.me>
 <dacdc03e-6905-4009-af34-149520de1dc3@linux.alibaba.com>
 <592f9221-5b02-4c59-9e40-908355a19943@grimberg.me>
 <1768bd2f-f442-4981-81ba-b952dacc4fbb@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1768bd2f-f442-4981-81ba-b952dacc4fbb@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_004919_793854_C8C40847 
X-CRM114-Status: GOOD (  10.22  )
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


>> Can you please explain where are the write side and read side critical
>> sections for the registrant_list and where exactly a dereference occurs
>> that is synchronized via rcu and is _not_ protected with a mutex?
>>
> 1. write:
> 
>      1) executing register、acquire、release commands.
> 
>      2）disabling namespace in nvmet_pr_exit_ns().
> 
> When doing above, I will use mutex pr_lock to protect holder and
> 
> registrant_list both, because there are multi writers.
> 
> I use rcu_dereference_protected to get holder if locked pr_lock.
> 
> 
> 2. read:
> 
>      1) executing report command, nvmet_execute_pr_report().
> 
>      2) checking admin and IO command access, nvmet_pr_check_cmd_access().
> 
> When doing above, I use rcu_read_lock to read holder and registrant_list
> 
> lightly.

Right, I ignored the REG_ONLY and ALL_REGS cases... It makes better 
sense now.

