Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB2C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Nov 2021 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dn3JlSLQT9unLajVMFXj26hJHVTESOPmLbf77Et5Cto=; b=HeMH2ZmLeF6cT1tlt5UUaieC2B
	f8lpMjIdxo+HF7Iz/sGsy3rzRTIxR5yiN1/gJo7kwsnmIWGQHlWUW8+JohLVpSwiDdir0fl6DzpTc
	1kswmN5J+qCihY89LJ/TOkN+WfwSzukLFIm9vR6IDAjnsiMX4ZyAmaNl+ns2jz2N1V1xIXyJoVbA0
	cEwdq2qSD+Ln5wVEukTDlegKS1czTqxysCXCS2e3BSXukgP22AOFFjLAovwZP+/8apHTL63fireVq
	g0iASVe7nvsiTPH0770FhAhOXgobpxhgPsUe9ShE9nnCbR46lnlZ0fWo0CCiNmusQttmutQPVn+/X
	oMP3pVgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqgA4-00BXmu-Np; Fri, 26 Nov 2021 18:41:28 +0000
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqgA2-00BXmJ-6U
 for linux-nvme@lists.infradead.org; Fri, 26 Nov 2021 18:41:27 +0000
Received: by mail-il1-x130.google.com with SMTP id i9so9978345ilu.1
 for <linux-nvme@lists.infradead.org>; Fri, 26 Nov 2021 10:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Dn3JlSLQT9unLajVMFXj26hJHVTESOPmLbf77Et5Cto=;
 b=UNjy/Jv4WKcXZelCIVYlBcimUg0Fp/9Y0SMcJdLYa7It/0ARpXcFAH7DXMGioH/USa
 FcmTsiNaR5DOOqqdIAZsb7zTEnFac9CelF5GI6Zh5xGDPZbn9pxHhbNl9DwaSQBq3NXB
 pg6xIt2AKWQBhpjx1jsxoBbD9fq79X6ab0ie1Dd8BIfNxzmtcyEhf2S8gfRCvhN10IyW
 X5GwEKylzoQhqasSxkkWHOwgjo0POyGVrNFu1RubvkX3RkoXf/T7vBIX8kdZVRwKBbcC
 6UfQH3R9tnOZrpyKI/ldw8y/aPZA5IKcMF6tutHL8gV9tGsdSNJzbcPEVcwzyZqWLMbb
 qlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Dn3JlSLQT9unLajVMFXj26hJHVTESOPmLbf77Et5Cto=;
 b=IQOCuVSGepS/fW4T6kC5fpBF+EPiwlg+KLeUlAFe/RFcY7MyEiPV6ek77S264+37o5
 C2WNzjyYp+UYvtd3H/mYB+XRGXauhgI++RTt2hJPGdZK2AXak1kwhDqQD4ZTZByh82Bq
 f7QLwN7wLhdygHmL7oGNBQpgbuFutB/gBq1tc0OVL8goxn7dNIHdqv0kyynMOI9eTwRx
 2x9xur2DKoMBCVnuZr3/p9/Vg72eoNV0JPoosr9yfOg1WRetUP8OK5itASTLXbZ7cMDs
 VyNFPKZJhbBHhMyOWdhWG3NVTFaSTFW4SxNzwkPw5ho/DQN7hiid77geyiFq+izmRxqY
 2VSQ==
X-Gm-Message-State: AOAM531RT0tmsWdF7jbvZb4cfOWofqxwCyBzLsXh/DAWUZj2ffNslOXy
 0K2JmXYhdW+B6vp4BWMBFLOAoTuf2xOnOC7N
X-Google-Smtp-Source: ABdhPJzJK9pUIli5rOMIsOCySu1SxFt6BSM8IWUQXMeRmK3cP+2UPpMd/+bu06A3rIg3MRg5+wUwTQ==
X-Received: by 2002:a92:d38b:: with SMTP id o11mr33208142ilo.35.1637952085029; 
 Fri, 26 Nov 2021 10:41:25 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
 by smtp.gmail.com with ESMTPSA id n12sm3981499ilk.80.2021.11.26.10.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Nov 2021 10:41:24 -0800 (PST)
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
To: "Kenneth R. Crudup" <kenny@panix.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
 <986e942b-d430-783b-5b1c-4525d4a94e48@panix.com>
 <ddc41b84-c414-006a-0840-250281caf1e5@kernel.dk>
 <1ff86d55-f39d-f88b-b8d-b6dfbd2f1b19@panix.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a4d728c2-703d-66be-bffd-3bfde0fddf41@kernel.dk>
Date: Fri, 26 Nov 2021 11:41:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1ff86d55-f39d-f88b-b8d-b6dfbd2f1b19@panix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211126_104126_277217_A24C2F3E 
X-CRM114-Status: GOOD (  13.39  )
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

On 11/26/21 11:20 AM, Kenneth R. Crudup wrote:
> 
> On Fri, 26 Nov 2021, Jens Axboe wrote:
> 
>> I'd just do what you usually do, that's usually the best way to gain
>> confidence in the fix.
> ...
>> That said, I'm pretty confident in the fix,
> 
> OK, then I'll just continue my normal workflow.

Sounds good.

> ... but am I the first report of this you've seen? (I sometimes wonder how many
> people use the master branch as a daily driver; an -rc went out a couple of
> weeks ago that had a commit that broke suspend that manifested right away.)

https://lore.kernel.org/linux-block/20211126095352.bkbrvtgfcmfj3wkj@shindev/

There's another here from today. But this particular window has a pretty
narrow window, which often means that most people won't hit it, while the
people that do hit it all the time...

-- 
Jens Axboe


