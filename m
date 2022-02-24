Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D84C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 09:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rT7PvizBAdIzCiWh+Igan8zu1AcQiqiITJ61YsJwm40=; b=3nL6NxPrx98RLyTcgq6Obzl7oc
	CAUX4J0Roxc15Ti5TWM5pa08g5i9To7b2DCg/ml+prTgcsH/TexgZ0PPRY/ADu42FYN7vJGTKwxgg
	/TY2zBNE9B+SvLAuptPBsjoXtkqKskWXN0+CW/nfGB0hJDYxbuADjmhaDBtRvInbu2/cJo1q5Xow9
	kObemiZU6FLSwU0O0fOZwQwqbKQ8zQagOpO7O0bi7XX22FMVKsVJgnxbDut3Xqdq82wywel+Oh/vG
	Dzgfe9jN/sRUtJ1r+klFxUmDz3R/F+YgqwSDqYmwZPkHasllEZKB9Jn9btdH442gS+eMiJ/1Rdtpe
	mmQWieZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nNAT6-0005aS-2I; Thu, 24 Feb 2022 09:31:24 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nNAKR-0001NK-10
 for linux-nvme@lists.infradead.org; Thu, 24 Feb 2022 09:22:28 +0000
Received: by mail-wr1-f43.google.com with SMTP id d3so1974277wrf.1
 for <linux-nvme@lists.infradead.org>; Thu, 24 Feb 2022 01:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=rT7PvizBAdIzCiWh+Igan8zu1AcQiqiITJ61YsJwm40=;
 b=OwcOKpw5MzrvYG15LL9+bepgSWBfyW7IDfZtpBe2ylDCYwmhQ0Scv3wiS54l2w7Hvo
 V0ttZGQ2Y8PjTle5D0/9VfuMLLbNKwcKBb1yZn9JgmyRBWQXruJrUWc4cJySlnaSiWuD
 yG76MCxo4CIOTZNuZUKAZzeb71w/F3J0LFI6MHagAy23mY9m5tIqcwHhKEN1naHF2mg+
 IcywZy4TwQ8YN09JWzMHLMN4WVVXZguoWbolN0htnOvBytL4s8b/F26W9oHi2ExtlTUV
 Zr5tbRJ5m61W1wb6fflf9ddjeg6a01KE5V8vn7MFbQBv0AfluoYLmqphggjKgipd5LaC
 K7ow==
X-Gm-Message-State: AOAM530TGzrZZqETPz8Lm6qh+GtFQbC3ogEgU2j9jdf2C8CxKsKKbgWz
 hgPfR8HF7Jx64PS0CsFskHllk3VfqzU=
X-Google-Smtp-Source: ABdhPJwP5KpG0f4Rcx+AgxKRWTSO5AE81wfb8C99Tqjb2xWNbh03ZqJnKva5MMQuP8J2+NblbbysCQ==
X-Received: by 2002:a5d:45c1:0:b0:1ed:c02b:5f4f with SMTP id
 b1-20020a5d45c1000000b001edc02b5f4fmr1471830wrs.115.1645694543424; 
 Thu, 24 Feb 2022 01:22:23 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id a9sm2167388wrr.20.2022.02.24.01.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Feb 2022 01:22:22 -0800 (PST)
Message-ID: <d01b7cf5-e46c-0cf3-5e58-64547f84817e@grimberg.me>
Date: Thu, 24 Feb 2022 11:22:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: nvme-tcp: invalid h2cdata pdus in response to r2t
Content-Language: en-US
To: Jonathan Nicklin <jnicklin@blockbridge.com>, linux-nvme@lists.infradead.org
References: <CAHex0coRbCPVnwVfeHYVxLHQp3HRd5V3aWZJ5uVwyyr-zk9=Sg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHex0coRbCPVnwVfeHYVxLHQp3HRd5V3aWZJ5uVwyyr-zk9=Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220224_012227_137504_FACF9290 
X-CRM114-Status: GOOD (  13.09  )
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


> As recently as 5.16.10, when a target issues an r2t, the host driver
> responds with an h2c pdu of whatever length was requested. If the
> requested r2t length exceeds MAXH2CDATA, the response causes a fatal
> transport error.
> 
> In reviewing the code, the driver does not appear to generate multiple
> h2c pdus in response to an R2T. We're a bit confused because commit
> 1d3ef9c3a39e seems to indicate that the code behaves otherwise.

Yes

> 
> I can see there was some discussion and work on this back in November.
> Is there any plan to incorporate the fix? If so, is this likely to
> make its way into LTS kernels?

We'll need to see if it applies cleanly... If you have specific desire
you can send a backport to a specific LTS to stable kernels.

