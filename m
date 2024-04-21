Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19C9C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 10:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GszQgQpzUTRi5dJxCQXi4tBvNXzSdoVKhpu21Kn30yM=; b=xwlC+hL1huELDS+Tb0vd7eid4c
	EReRbCthMfLmiTHK2esEw/cx6DLzWmjAUX79/K2Kom+XByau4I4Gy4IN5XVbaCLwCqAqe1KZRtjGR
	/RWSFu/hh1T1FMagjizQTiWRUkYi1P54aeX3lMOQHQRpg4W2+cWxwMWgKrif6UGpiLJe+mQqcWKA8
	iqduzdcqm8V57eBzQhD8BIbjG9VzdNVPd/onp8cUqQlPzL0/dQIIcUOL62QNzGuIMcDDQXsxMMxjr
	eRhJRf0YTpfBjbnnro8sCvS33aajWB2buNtZ5fWHEdmJn9cqll0x/rY89SSMCkDafqrYATM1NpUIk
	Iyj6jUJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryUTt-0000000AJ4e-1Ygh;
	Sun, 21 Apr 2024 10:31:33 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryUTp-0000000AJ45-49tH
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 10:31:31 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-346a5dea2f4so801463f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 03:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713695488; x=1714300288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GszQgQpzUTRi5dJxCQXi4tBvNXzSdoVKhpu21Kn30yM=;
        b=O3lnWDpcoM0dhrmV6bJQekkBh905/NparhaV30bVH/2q9kbgGMvr3EdPi4f0q/Iq1U
         9KYBynPTtSnIFCtBLO4u1cxP2AT9PZxtCLjMOEwXtRt1Z9GfdQFYwbcWRkkc86FPgrT3
         zbwDf17EXvMezqA71wgQhTgrjNIs+nhg5bTLPhBAtDfUM05DDO2XyuvtilSXCx/G96Aw
         G/p2AW5x9ApMuQu8eeaBYYgoTX3IqreFlpQous05aG/5BdhNamUudaPyxbeHhuXKTvhB
         ohZQIwVnV/XyRfiA5lORA/P/Dz6LHCjC8RIA4o9dP/RUi2uITl8O83u0XkdvgY8z8fJ4
         8Osg==
X-Forwarded-Encrypted: i=1; AJvYcCWlgVHbKLkwskYe469RGM1CYYCzgpiNUX4tBF6FY4qoWeHognCtl/SekK+CIHqlg4OpsVtJu0DOjQpxiTHnEtl9Kqz+64K3yT5EMFQofvA=
X-Gm-Message-State: AOJu0YyAV8auEsHnU5K2Ovq9rc5neDSv6vwf2bVj/qDccafWKfM8Qhy2
	in/xE2cS6LBaKZRgrbxMZOoerKHCjtwiRwJ8EB/BEgWZUhlyjbBj
X-Google-Smtp-Source: AGHT+IHHsQNnARBtgBiA47qYmYz+T9oXZgOmuinv8K61cf/j6tm3LWYbhboL1FrG6iEexKpWPv51sQ==
X-Received: by 2002:a05:600c:3b09:b0:418:ef65:4b11 with SMTP id m9-20020a05600c3b0900b00418ef654b11mr5410497wms.2.1713695487651;
        Sun, 21 Apr 2024 03:31:27 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id fl14-20020a05600c0b8e00b0041a25e1e2fcsm1998202wmb.20.2024.04.21.03.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 03:31:27 -0700 (PDT)
Message-ID: <ede49e66-7a0a-472d-a44c-0c60763ddce0@grimberg.me>
Date: Sun, 21 Apr 2024 13:31:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] kmemleak observed with blktests nvme/tcp
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Yi Zhang <yi.zhang@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CAHj4cs8xbBXm1_SKpNpeB5_bbD28YwhorikQ-OYRtt9-Mf+vsQ@mail.gmail.com>
 <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <923a9363-f51b-4fa1-8a0b-003ff46845a2@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_033130_071177_8C0983FE 
X-CRM114-Status: GOOD (  11.65  )
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



On 16/04/2024 6:19, Chaitanya Kulkarni wrote:
> +linux-nvme list for awareness ...
>
> -ck
>
>
> On 4/6/24 17:38, Yi Zhang wrote:
>> Hello
>>
>> I found the kmemleak issue after blktests nvme/tcp tests on the latest
>> linux-block/for-next, please help check it and let me know if you need
>> any info/testing for it, thanks.
> it will help others to specify which testcase you are using ...
>
>> # dmesg | grep kmemleak
>> [ 2580.572467] kmemleak: 92 new suspected memory leaks (see
>> /sys/kernel/debug/kmemleak)
>>
>> # cat kmemleak.log
>> unreferenced object 0xffff8885a1abe740 (size 32):
>>     comm "kworker/40:1H", pid 799, jiffies 4296062986
>>     hex dump (first 32 bytes):
>>       c2 4a 4a 04 00 ea ff ff 00 00 00 00 00 10 00 00  .JJ.............
>>       00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>     backtrace (crc 6328eade):
>>       [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
>>       [<ffffffffa86a9b1f>] sgl_alloc_order+0x7f/0x360
>>       [<ffffffffc261f6c5>] lo_read_simple+0x1d5/0x5b0 [loop]
>>       [<ffffffffc26287ef>] 0xffffffffc26287ef
>>       [<ffffffffc262a2c4>] 0xffffffffc262a2c4
>>       [<ffffffffc262a881>] 0xffffffffc262a881
>>       [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
>>       [<ffffffffa76b0813>] worker_thread+0x583/0xd20
>>       [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
>>       [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
>>       [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30
>> unreferenced object 0xffff88a8b03647c0 (size 16):
>>     comm "kworker/40:1H", pid 799, jiffies 4296062986
>>     hex dump (first 16 bytes):
>>       c0 4a 4a 04 00 ea ff ff 00 10 00 00 00 00 00 00  .JJ.............
>>     backtrace (crc 860ce62b):
>>       [<ffffffffa7f2657c>] __kmalloc+0x37c/0x480
>>       [<ffffffffc261f805>] lo_read_simple+0x315/0x5b0 [loop]
>>       [<ffffffffc26287ef>] 0xffffffffc26287ef
>>       [<ffffffffc262a2c4>] 0xffffffffc262a2c4
>>       [<ffffffffc262a881>] 0xffffffffc262a881
>>       [<ffffffffa76adf3c>] process_one_work+0x89c/0x19f0
>>       [<ffffffffa76b0813>] worker_thread+0x583/0xd20
>>       [<ffffffffa76ce2a3>] kthread+0x2f3/0x3e0
>>       [<ffffffffa74a804d>] ret_from_fork+0x2d/0x70
>>       [<ffffffffa7406e4a>] ret_from_fork_asm+0x1a/0x30

kmemleak suggest that the leakage is coming from lo_read_simple() Is 
this a regression that can be bisected?

