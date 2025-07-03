Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25BEC83F07
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 20:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TEShNNGw8YA9FF8iT3UXsWuzd6q34qlsvmUa14RxNng=; b=nO6VE27TdhbrA4moojjUuzHhzJ
	B2Kpm/tlx7XmvD6T9ps6pbWEX1lvL/bgzGVWM1UWtZHOsWWo+QQTv8mWMJVe6HGcBMr0LG6C2nCdO
	aq/nJH7mh/Mq6yrs+QNc+29BR/GPLLb/V/C6B9tfAvcPnjgsItvB70GbJDht9Gj1yhkyrGevpr77A
	fANJu+9ecYTdAto1r2T1sx4Vkb4/xzWglQ6kZMTb0N5PNsZD9YODKSsqJj/f674Q40TShYcBW/38T
	uBNvjfE+Og8bd0ds1R0xprTEcty6kWv5rcl6UXNogF7tHXW0OstUZNxDcAA4k9R4xiHxmZZMYSWuV
	HMXVG2Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXR0a-0000000CUwY-3L5q;
	Thu, 03 Jul 2025 20:58:16 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXMLA-0000000Buez-1fYB
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 15:59:13 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-735b2699d5dso57711a34.0
        for <linux-nvme@lists.infradead.org>; Thu, 03 Jul 2025 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751558351; x=1752163151; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEShNNGw8YA9FF8iT3UXsWuzd6q34qlsvmUa14RxNng=;
        b=cArSN8/Em9tvsebNqFvhLC9La368RmGimZIyUW8ZpjzbkN3q5rUtdddhr7zfSv+Ou9
         jbKijWLWTnLlv8vk67W2WtuCeA+ZRGysS4AaAEEEMadd2KId9cF84cvyNzGggc/aF4OG
         9MehZdd+cxBEUbZMjeUoT3Su7iCqHhLU3XijW+io5ZvY+mB+UigNgfS4//bJ+ltUIKHq
         cikyBehf1tFmrbvky4CXcAsI7ZYw2Uda7GHyJtC+BOM+B92JvRH6uzAx0cF91O5mxbcL
         qHVFQc7DUlEljIB5/7tWEtsW9rIm2AtLaZyWHcF/WH7lUx6+JfnqnPFzyKgHz9Bnqkzs
         dxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558351; x=1752163151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEShNNGw8YA9FF8iT3UXsWuzd6q34qlsvmUa14RxNng=;
        b=WPz/h+Ct7izVPQITHm4t8d4/FfYCs5ffdsy8B496jIpzeYqipVn4M+bKYorfrzrCQb
         2G0XEft1XNrOp9lBxQMNihjr0/0HhDTVvDOgdqS2Rn+9N5rsLwgXHUa7QkmcK6sWloDE
         xdxYYKnYopkaKUQuUj2hRZRW7Zjo8Jf55tkc445Tl2huYqMD1lRQzPy/OyjvYlhaiaoR
         0Ue+aBDkXMvZyNmevDu1h8zD4k7ku0UH7bkIqGteNiFwfzIOY+82jZ2nu34511gwmGhr
         UpkccWgbvKZboDXiOYFCcL77kLtNDpamaiblSuSO53M3rUMJZHtCFP7XVy8o0AMr12Nm
         O/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXvie5072npvgUsrg0h/m0Tq1wEzbtS5fx9ySIbM+Uu0zozeO3N63qcIe7eiAYzhZhaCOTnV+70Rk4p@lists.infradead.org
X-Gm-Message-State: AOJu0YyCyHJCQlOUXVMgjATBtSLZUnEuhBOHMDY2GtITJC1bv5+M324/
	0VQlSlSn3Rl2tEnXIteSOr3Wsbe/e69CYKsI1uB2gcTBluZQbuJxzaNt
X-Gm-Gg: ASbGnctcMRro9+mbePoeXsidlCLZzqTx5Iic6dzaxbCuUEERmAg8aVtOQGiHFP6frMF
	6UahmooUYTsm40EjUMgkh2q2ukvPUPWqWGbK9aotCK9u4tUkVDdH4rPK/VtLsoUpWvxF6xFctwA
	4RSgMsZeRqlGJOCNr56VJcEX0sCa1QnankK1LtSQdRto9DDOpgr/UZCsUiJCWR7/EExLTBC+rVm
	06mTWoQkCYh6S2Q6hBHGRnTK3IIhd4CQ7HllNMJIkNmn1BFRLoWV30eudfp7Px2JG796TX1DMex
	O5NN+zbZ9ZhxpNZzVB7qMszsVUu9gCVdLnjvV5f2fBopnS2nZp41R4DQjdbu++VNNPFa42ydd/2
	rVD9pcH2fBYZbagUYpmnmk3XdLA+dIgfTcGcH52O9WRiiYfw=
X-Google-Smtp-Source: AGHT+IH3XSWyuRx4s4rWAzGyVmRCzIl6dx+V/4MhE8t8BbqVL+X1lePf0vai1om3aMrYs1aq7sCYNw==
X-Received: by 2002:a05:6830:370c:b0:73a:e90d:5c95 with SMTP id 46e09a7af769-73b4cd6cd74mr5712699a34.26.1751558351027;
        Thu, 03 Jul 2025 08:59:11 -0700 (PDT)
Received: from [192.168.1.7] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f7351cbsm10537a34.7.2025.07.03.08.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 08:59:10 -0700 (PDT)
Message-ID: <893b1fd8-9f34-4118-9c53-05a1295850fd@gmail.com>
Date: Thu, 3 Jul 2025 10:59:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Nathan Chancellor <nathan@kernel.org>,
 Jan Kiszka <jan.kiszka@seimens.com>, Bert Karwatzki <spasswolf@web.de>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20250703114656.GE17686@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_085912_445537_3B27E714 
X-CRM114-Status: GOOD (  21.46  )
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

On 7/3/2025 6:46 AM, Christoph Hellwig wrote:
> On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
>> Address resource and timing issues when spawning a unique async thread
>> for every device during shutdown:
>>    * Make the asynchronous threads able to shut down multiple devices,
>>      instead of spawning a unique thread for every device.
>>    * Modify core kernel async code with a custom wake function so it
>>      doesn't wake up threads waiting to synchronize every time the cookie
>>      changes
> 
> Given all these thread spawning issues, why can't we just go back
> to the approach that kicks off shutdown asynchronously and then waits
> for it without spawning all these threads?
> 

If you mean for drivers to have an extra call like shutdown_start() 
that's called for all devices before waiting for any of them to finish, 
it seems like that would just push the work of spawning a shutdown 
thread onto the individual drivers (unless they just had a single 
command they issue to the device that takes all the time), and 
synchronization might be more of an issue since shutdown_start() could 
be called on a device before that device's children or dependents have 
finished shutting down.

With the async shutdown code from this patch set in place, any driver 
can be fully enabled to shut down devices asynchronously with no work 
other than setting a flag to allow it, and no device will start shutting 
down until its children and dependents have finished.

I think the main issue in the previous version of this patch was just 
that it was taking too long on smaller systems to spawn a thread for 
every single device shutdown, when most or all of those devices were 
shutting down synchronously anyway. This version of the patch solves 
that issue... it should only spawn on the order of roughly 2N threads on 
systems with N async shutdown devices, and it improves the kernel async 
code to make synchronizing to a cookie faster, too.


