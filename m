Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B3ECDC18E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jan 2026 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pr+lt1Ch0E+axfhx3pE3FOAJ1aIxZZRzJz3T25FMQ0I=; b=RH3XT7X9rxoy4u/vmrqBopakzk
	V8LRTrw2R2xS6tmf/1LSdESzvFe9L30SHngd1e0kQBS0EjFJrrbWw2/HCneGuUzf9SY2JUFzG3k6y
	7z/leEw7jhYTLx+01/TctVuXx7AB2XFepfL+tSibgmAL2KVXK6u0Cz7N5R+2/boq7l2I+uQMsmhhh
	J3VMJFORhvNvT0yazCYPFrzs/BgCV+/UYwwqF7tqjP/vSdXGaoVnZRb6pZsgtt2pixXpHrerw/tjt
	drG3IzLpyafZylO5k+bJCpHRyzcXAwWdJTPn9+oJ1JXtp6NA0wEmjlJkC+39UfPgfBGNG3F9kL4Rx
	x5Z2J30A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd6SB-0000000D1HT-2iwh;
	Tue, 06 Jan 2026 12:46:27 +0000
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd6S8-0000000D1H3-3iXn
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jan 2026 12:46:26 +0000
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-459a516592eso608821b6e.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 04:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767703583; x=1768308383; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pr+lt1Ch0E+axfhx3pE3FOAJ1aIxZZRzJz3T25FMQ0I=;
        b=bAId9lL77f87rv5IhU+EynJfpe7t1CiE6Acz1IRjrmwG+Sui4tzNeiqPQHqml0x3x2
         v2whjeS6G9xqXrxPbO0qaoogqtyeVXDoyC2RdE4k4K0SYDsPGsdnmqBM/z6MgYSMN1KR
         hxPMShdmITI1Hgkq69CKfjV9UN4SJtPm5Ws1RI3VvZIrsvfM+UghpMpHxmBMMO0y1pX8
         kJ1CXXLh62U/la3xw85800QLV+9eOLTDWO5tcHWoc9azt7A6NfSUNPJuaAtphNNpst3X
         JNH9sdoAaLdDnn9l27O+GPIKbICeqTJQabCYATqoV9DiXvr19dIyxvAtwWy+afN5RyIz
         9muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767703583; x=1768308383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pr+lt1Ch0E+axfhx3pE3FOAJ1aIxZZRzJz3T25FMQ0I=;
        b=IBNemEWBLWq0toUB5Q11nybrqfKpSL8eZKGShi5l8FZcuSXVkqyRmou0QzpNAyCMr3
         XwRBXBK1Q0SiXODKClB8d+z0AuZj8jnicXLqAqPCgEUmlCGJh4Oe6XnroebRkZdfs8/8
         eaS4+EdWcc/jg0GrLTQx0rLX/bLR82gKzherlRICgTa1NCSQqSkPX0+Trq8iigQxwlbk
         mpLA9/dhwSdSyeK2yAPvedZN2qh15Kh13XRPQuo/BGwv8o08ahLiVy0oN7IsStAVm5kk
         nBa1yqSJSXzsiY2epOyllcvDOCP2agKH+0VDF73vez7yLUTmusjJ+Su3dzheJUvH32Iy
         wIEA==
X-Forwarded-Encrypted: i=1; AJvYcCUaM9KY3Pcoy4EMkjWkwIqaKhL5pNkRldRVtfDKYn8biRDxA4ihhcrY4Cy3GDmfFF9dic9L+HR6rVWs@lists.infradead.org
X-Gm-Message-State: AOJu0Yxt1mHlhY0JQhBADYouAauODGhNauC+qmo2Lz0AL7s8YQuoVwyw
	WAwjmQElX7zw0tgMpQhUQPLuKtQFUwyueoEMGyev2d5cD9bfliMt/Ag+Xo67t/u4shBuHwctlL6
	LfGmQ
X-Gm-Gg: AY/fxX5HNRdM3Cy1H0wTIyyqAvOgCi6Ad0BCgfmRwv07D4nmGkGfbkp8+dfwwVxQhWL
	zLtB5jyJvQ3FgF0UC5KOHPF5Bg7ly4QohQEztaYU+RoES1Y9dC/KUM1QP5RlaTy2xDveQZvj7zl
	42sFTS2C0w6QUDpOgHwGInSdYuEwgsUIMoGo29qO+xCNIsTj4M9rDuTFu7FMo71YEzTDEae9BLF
	Blmh+Pqq1wIM+MfzPdfhfrfJoVPU9tDpt2U1zhK8EDPT6WBgVa2u7pbrRDehYsF0ZMr++zA9F9h
	m8PTL6DvuV3nT/ZJ1FaHX9jsfENpPZR58hO3Iy5EokvW6iC2No+mqPEzPzOd9u5q+v2Px0ebD8O
	+ExTekRkJHbI9cjNYu6PyUaf88xy8e5L7uEnAdMNjCqCT0vSWv1lf8tgD8+qUl7w5Qw+Enhvlqg
	pZPUhMomIL
X-Google-Smtp-Source: AGHT+IHc2lcTDeoYYXv75EDUp9CHROOBR7QiN7T52GiFkXS92SGUSQ2yanZmFDd2NjtTHIO3ToClsg==
X-Received: by 2002:a05:6808:c3ea:b0:450:89ee:922c with SMTP id 5614622812f47-45a5b1df806mr1793325b6e.27.1767703583556;
        Tue, 06 Jan 2026 04:46:23 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e17cd0esm924524b6e.3.2026.01.06.04.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 04:46:22 -0800 (PST)
Message-ID: <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
Date: Tue, 6 Jan 2026 05:46:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
To: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260104151517.GA563680@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_044624_930582_B448BD90 
X-CRM114-Status: GOOD (  12.64  )
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

On 1/4/26 8:15 AM, Leon Romanovsky wrote:
> On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
>> Jens,
>>
>> I would like to ask you to put these patches on some shared branch based
>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
>> and DMABUF code.
> 
> Jens,
> 
> Can we please progress with this simple series?

If Keith/Christoph are happy with it?

-- 
Jens Axboe


