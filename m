Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F289CC369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 22:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sBU9fsVCp2RxfNWj3+AQZ+ZAC87wHzTpqjy8b9Sqqmc=; b=aqSxYaSO/gq+CmVMnmtpgLeGRA
	+gZnT8CEMpBMeHDkjvg2rJHfqySEOmbh7Q93a2hTVt4FHIwrlJNdsTRPc/pJxBb0L2txse6NCEP5X
	bhJe2LGE+YrbcGlxyherc7/rpuQEflMOoZcoSYzmGnArQWwwtuk+wzOGh6GYpyYa7ntx6Y6rmW65u
	l01SfofJgsVmGusr8hXfVe7QDEc5r6b1E6QDapBhLZx4x5O0d5trt7H39chN506YL8JJex2I7DKiC
	Por/twpb0AEyg8eu8IA6n3lmB1qD5Qy6X353YDu/Rit1dsaBjGyM6HdeABUKFqy71e65Bn1unNI3F
	tQUuM4vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5B85-0000000B2Fk-3wVc;
	Wed, 16 Apr 2025 22:21:13 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5B83-0000000B2Et-3inD
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 22:21:13 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso883359f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 15:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744842070; x=1745446870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBU9fsVCp2RxfNWj3+AQZ+ZAC87wHzTpqjy8b9Sqqmc=;
        b=naqi7j6coQ/NUE9/wtUxa6aI2csqZ9BYutzctUQ+O8lDKcQ+slFf/ps6g0aT+CWs97
         GABafHeusZBenrM6Ey1iRQoNZ7ycNYtCJbNnMH5QLrUCaOMzOEcz7d2dwFhNhE5Fe+19
         HjEqYbjPkX9rdCGr9WhEnht7YfHBSs0Jlx1YwcxpHhTM/6jaYYDoIrxqYs9Up3vHMrqk
         Q+dfvbAJQwlQHGAhgxE5SqacVZELT60P6LKe6jDVyPK2gLVYdDRP7sKs64zrkVNU69ph
         JneqCoJ8vm0FKXnPeJws/2V37byBllXDJ3SICTvJHdQXWFknrbAT8gftGmXEUL8W462g
         8fxg==
X-Forwarded-Encrypted: i=1; AJvYcCUe7JqQ7tFdArYqNmuzHrv/T8bsepbIPMXCHnGV5hFzvJ9WWujWIzSFzp4hEQguzu21qukLp7zngVxf@lists.infradead.org
X-Gm-Message-State: AOJu0YwQX2f431oGo9TbsU7XHgHpVuVfhcWWuxkqQm+Z6z37yRvfXsTe
	geu2E2kXy5r702ZQYTeAqZIrJ2WQppM0/WTJPsRVYi+JhNKWBUss
X-Gm-Gg: ASbGncuNSYg5l49bweSeImSX5yD2odAa79QAVa6cO6xmP1mD1N+WNSRDZFimTaYgpnB
	bE4Q9+mzv7SSH+D5uNuWGv8y+C7XRnZpO4B4Hj6iMbQCaUbKmzBKnztU5Q2vuPgQ6D29rsAh/EG
	FC/iJ/tWjO1ACFBW2AzWNZiPzs77YoxL5f0FWZCWtSIjsE6gD/45TU1qAEL9flKAYabRerIb7ju
	Pi5J0hX7N+VgyJeWRr68PqXQ6oVertXxqob0F6Q3sK9xkWFcEHQwYcwaMZp0ACT7+1z5oE4kDRQ
	wrobPpY9HUt4bGgNu3fh/AkWXmUwO+22qGBFzGWWPXXWK6Xyq9h0T5+Z6gQ2+MvbrQZdLLz2
X-Google-Smtp-Source: AGHT+IEYkoHv7dSpAH5J11NYvxRBnI1mFdebJS/ofs3BZrfaNbkQ6ndNhKLzj9LpJo7A4mLdoaB1Aw==
X-Received: by 2002:a5d:64a5:0:b0:39e:e3c5:ee7b with SMTP id ffacd0b85a97d-39eea09ea40mr342538f8f.5.1744842069841;
        Wed, 16 Apr 2025 15:21:09 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f2b9dsm32305355e9.21.2025.04.16.15.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 15:21:09 -0700 (PDT)
Message-ID: <df6cd26e-551a-4bc1-bdc6-9c715e502aa8@grimberg.me>
Date: Thu, 17 Apr 2025 01:21:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <6f0d50b2-7a16-4298-8129-c3a0b1426d26@flourine.local>
 <20250416004016.GC78596-mkhalfella@purestorage.com>
 <3dad09ce-151d-41fc-8137-56a931c4c224@flourine.local>
 <20250416135318.GI1868505-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250416135318.GI1868505-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_152111_939518_89A09864 
X-CRM114-Status: GOOD (  17.75  )
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



On 16/04/2025 16:53, Mohamed Khalfella wrote:
> On 2025-04-16 10:30:11 +0200, Daniel Wagner wrote:
>> On Tue, Apr 15, 2025 at 05:40:16PM -0700, Mohamed Khalfella wrote:
>>> On 2025-04-15 14:17:48 +0200, Daniel Wagner wrote:
>>>> Pasthrough commands should fail immediately. Userland is in charge here,
>>>> not the kernel. At least this what should happen here.
>>> I see your point. Unless I am missing something these requests should be
>>> held equally to bio requests from multipath layer. Let us say app
>>> submitted write a request that got canceled immediately, how does the app
>>> know when it is safe to retry the write request?
>> Good question, but nothing new as far I can tell. If the kernel doesn't
>> start to retry passthru IO commands, we have to figure out how to pass
>> additional information to the userland.
>>
> nvme multipath does not retry passthru commands. That is said, there is
> nothing prevents userspace from retrying canceled command immediately
> resulting in the unwanted behavior these very patches try to address.

userspace can read the controller cqt and implement the retry logic on 
its own.
If it doesn't/can't, it should use normal fs io. the driver does not 
handle passthru retries.

>
>>> Holding requests like write until it is safe to be retried is the whole
>>> point of this work, right?
>> My first goal was to address the IO commands submitted via the block
>> layer. I didn't had the IO passthru interface on my radar. I agree,
>> getting the IO passthru path correct is also good idea.
> Okay. This will be addressed in the next revision, right?

I don't think it should. passthru IO requires the issuer to understand 
the nvme
device, and CQT falls under this definition.

