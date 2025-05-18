Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDADC3ABD8
	for <linux-nvme@archiver.kernel.org>; Sun, 18 May 2025 10:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Kt44Ao0x7UVYjrQkQm7U+HhMGBG8WB6X2pYVMdlUO8=; b=qmc6KifsLw8ykSrWcR0C4Knx41
	HZf3s3ElR34HkOJphd+tGFMKB0zxtN6YuvnIykTffngRkGzF3JERIlh9zu0fWkbmpM6PaelvRr8wy
	tL/AzrMOuO7spLY4Hkqv0PArFovI5LnEUjty+a0Ajsk8PEi3rZG4y9O/iPD2xIvSqes+jgcRg8iwQ
	1NnqncHJ06TiI0IpSV8I8Jnz/BE5f8VgFeSvXawKRxH0dcHpsCOOHliaSd1ytW72dGi5E3sPzIlEJ
	t8x5fbyNzixi6xZAnNRHHqJz0uraYtcVgYAKwCdLap2JUfp/9JsOLZd3K+C14d0z14A+ZuxwY7lmC
	qSpnXtRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGaq4-00000006yzo-1OI4;
	Sun, 18 May 2025 10:01:48 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGaq2-00000006yzQ-11g3
	for linux-nvme@lists.infradead.org;
	Sun, 18 May 2025 10:01:47 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso34379315e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 18 May 2025 03:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747562504; x=1748167304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kt44Ao0x7UVYjrQkQm7U+HhMGBG8WB6X2pYVMdlUO8=;
        b=QM2mEA09MpYX3KQ9xiMKwnwNPbM/hyvMVW3Aad77VikH04C0N/Ao6a7GmLC/kD9WeW
         jKDJrxkUyebfqfMqPyCRJs/fwOMmvwaGUwPumoFUJ5dFOaK45yhTGLKmeQHEMjYhU2bY
         o8MNjG9GJ/WNL9S884tdjoESP+6mA3WJFK4F7JjyNWEkUs86N+rmtwvghCHhUTtBEdGx
         EwG5lnXTqSKmrNc5wTlRM8Fa0AAvE6c8cCX5pGRElWqkSqrpZonFlqeRsTtoNgBQ9Kjs
         yShdymn57i+1fmzI/ZBC+DQtwwLXNOskTZkCIWc9gdVtpX6lzHFJHp4/wHwh0g3MX/Bv
         R9Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWBIuOUAoWtebI2D0iLrWSbRaV0NjvmSn6H4FfZn3WaY5Q/LcUq1REyiYnQidJZX5rG2feNHMVcM+Bh@lists.infradead.org
X-Gm-Message-State: AOJu0YwHyfWgu53fVbKNn8OZlR1dbKGsow44gmQwFTvGr/3z4/F0nl6u
	Z4iDV8o1PrvWITGEx4qQmvR7FNn013UnAMIxtlvzNuhgbLuU6D7peh97gushZA==
X-Gm-Gg: ASbGncu9+oqbPflaydIyeS0mP+BzoneyPrjySk5vSZ7WFd7HI8IwmjTEZftuhdGztEz
	deXr/lxolJyRCVn3Ch0Z+cjc5WgkPWyzR+q1jy1F8d3YTptnFU/Tx9zjpZ4Giox+WDEIc01YJ3K
	LgwYy9M0DeLaGJv7NGYX7uC8ZfZlsfAwEEsycOPzVF6FCaPsCCYEvgQg6LqPFqXgrrEKU+wonYl
	T4UVeCHLpKOtYiRBfeFSq8pGkyf7BG+DJyeddBkz2IkawO7XWQTqNX76g0QElayDlMBXuiOEG5J
	p22vNUvLOgx1RJEgRz/iydrYIghnobN6jlc1vo3xysbaqDlKzo01PVrEzgCAW/b56ETWLWSqWNQ
	xyuiPeYJs8xWxZko/
X-Google-Smtp-Source: AGHT+IFuPuP9zPs8W6/sV4OcylbqHrpiozW41O70EnMznZq0UaihiSEaYqW4FvBIRH0yq/WVHcIhdA==
X-Received: by 2002:a05:600c:3554:b0:442:cd13:f15d with SMTP id 5b1f17b1804b1-442fd67197dmr87476655e9.29.1747562503735;
        Sun, 18 May 2025 03:01:43 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd59700asm102934655e9.34.2025.05.18.03.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 03:01:43 -0700 (PDT)
Message-ID: <72a394aa-9ed1-45ec-8aaf-5f5ccf1c18ab@grimberg.me>
Date: Sun, 18 May 2025 13:01:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme/063 failure (tcp transport)
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6mhxskdlbo6fk6hotsffvwriauurqky33dfb3s44mqtr5dsxmf@gywwmnyh3twm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_030146_288660_35BE66F3 
X-CRM114-Status: GOOD (  11.43  )
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



On 16/05/2025 15:31, Shinichiro Kawasaki wrote:
> Hello all,
>
> Using the kernel v6.15-rc6 and the latest blktests (git hash 613b8377e4d3), I
> observe the test case nvme/063 fails with tcp transport. Kernel reported WARN in
> blk_mq_unquiesce_queue and KASAN sauf in blk_mq_queue_tag_busy_iter [1]. The
> failure is recreated in stable manner on my test nodes.
>
> The test case script had a bug then this failure was not found until the bug get
> fixed. I tried the kernel v6.15-rc1, and observed the same failure symptom. This
> test case cannot be run with the kernel v6.14, since it does not have secure
> concatenation feature.
>
> Actions for fix will be appreciated.

Hannes, did you encounter this?

