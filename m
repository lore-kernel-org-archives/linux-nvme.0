Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0133FC021BE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 08:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CBiMrYaCwEpTtq0SMRID4c5oa7BMuzwnJ2AuGWplzGo=; b=cG9OFGSV9bTPOhJb55l/Uesh99
	LS74knip5hgMx88aW7LX36UWNbBDLQmhadgc8Ne90mO44aeh2OaN8rg/KfD58okJWKKob9DTKYZbm
	JPbo5rVkCPDcymtHN4zKx3HWhFtE/QjhetNHVYg8PFg+61DuEXGdztO1cBGfr5S2WRvIhjYhu2nad
	8ky7sNCguzL0p+zgcmy9/26tENonNbiNt+HK/doF3fkM1xuhyJPImP4n5NqTwdDdvFMZ3oKa/c0Bt
	WpqzP1A5gfA23iJD/74m3h8iT5lNCx9nKJbF0RtrpZ2Kw7KCbzZCdHV0bNFzfmN9B0NHpJUeVVDBk
	NQa0KsPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnZTo-00000006jSG-2Z7I;
	Thu, 27 Feb 2025 08:42:52 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnZRP-00000006j4X-1t69
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 08:40:24 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f325dd9e6so319786f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 00:40:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645621; x=1741250421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBiMrYaCwEpTtq0SMRID4c5oa7BMuzwnJ2AuGWplzGo=;
        b=rAn3DnqTmw5/tUBCVBJeWFGl0E6RQciGfN7aXWfihJOdZxPWPnQcHdea0Kg6wZzyqs
         uA1EgvGv6Jvec0rfff0VbZDaN1py+/1ZszTqrmdAdLFoETB808W/eiV7sy/BJAIcM/87
         8JRcopvZ3R5HTsZcLopkIPgtxZfgYvOvIl5iXId9lQeJgBL9GYiqVA+g9OqzN+jAHHzl
         +cOjKFAU3FFd2fEDVF5vFNOnzSek0e5qBmJqfyGFAfPOL9UOY6fo/msZqK2hLD2pcEqX
         isXjoW+GnyiYxnB1KsYB9hwV93syT3SqDSIH7hxzqsWwnnbKdEBzTweZ8k+AvpqpKjO1
         fxbg==
X-Forwarded-Encrypted: i=1; AJvYcCVmSo4pO8PwSC0wf0mkhM35XBDqrmIET3ZjJOzDe454U6tJsjMtP38leludMG21fJeGFJPaBf/8NnjS@lists.infradead.org
X-Gm-Message-State: AOJu0YzQ1kjKtaLPvN7nuc8yBmhNiewP2BEhjwLd/RcGhNHZlczRH5Qm
	zQEIvdNuK+vjMftaGF01Yp0bLUxMlTsMVFrHsJYiRawOG33PU/qX
X-Gm-Gg: ASbGnctLtLMeDjbn3Ph8IP+tGgd7e61zk/qnsf4B7spIlMSaUrXmV/ikQKOI/yNeDyk
	J+JD0yhOHUarK6n8U+eEF6Q4XckggABqa4DptezfKTTGrqjcvR2JUvryUSE7lVrdc072yjXh82R
	ecvStcT8hbVdKbekaI4yxeqZrFSwQvcSmb2BESWayWdK2CymARTHOmUbRS2Aqu0BaWmgIrg+nBS
	WAeVlZGXD4TQhpFUFS2BvgejLryzykQZg1FYIROeyJxw+1SuOPYbdnGnEah881YVd68C1jq8Zmg
	2vsk5DJHLpA5gH5KKDnNY9aws01ZOktdShMHTVU1csSBF4gPszCh7eodHs68NQ3V2bfL
X-Google-Smtp-Source: AGHT+IHCj1YDxnzG0WRO886qNsWeimMlVbhzY+geKE49V6NA2GvjXeyoTTXBC6i2t7dhRbH5sHTj+A==
X-Received: by 2002:a05:6000:2a5:b0:38c:617c:ee2f with SMTP id ffacd0b85a97d-390d4f3ba5cmr4706618f8f.13.1740645620811;
        Thu, 27 Feb 2025 00:40:20 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5393e5sm46589845e9.20.2025.02.27.00.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 00:40:20 -0800 (PST)
Message-ID: <cfd791d0-f394-49bb-86a7-9f13614c4c24@grimberg.me>
Date: Thu, 27 Feb 2025 10:40:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
To: Hannes Reinecke <hare@suse.de>, Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250226062841.60688-1-ebiggers@kernel.org>
 <03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
 <20250226190122.GA3949421@google.com>
 <7ccc3a88-b92c-45b8-bbfd-af98ab439be7@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <7ccc3a88-b92c-45b8-bbfd-af98ab439be7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_004023_485007_56BA22A7 
X-CRM114-Status: GOOD (  20.44  )
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



On 27/02/2025 9:26, Hannes Reinecke wrote:
> On 2/26/25 20:01, Eric Biggers wrote:
>> On Wed, Feb 26, 2025 at 10:37:55AM +0100, Hannes Reinecke wrote:
>>> ... and it also eliminates a sporadic crash which we've seen
>>> where 'snd_hash' wasn't initialized when sending PDUs.
>>> Thanks for doing this!
>>
>> I'm not sure how that could have happened, since the ahash was 
>> allocated when
>> 'if (queue->hdr_digest || queue->data_digest)' which seemed to match the
>> conditions for when it was used.  But yeah, it's certainly nice to 
>> not have the
>> pointless allocation to worry about.
>>
>>> (Note to self: check the nvme-tls code for crc32c usage ...)
>>
>> I have patches for nvme-tls almost ready too.  Just been taking my 
>> time since
>> I've been updating all other users of "crc32" and "crc32c" in the 
>> kernel too.
>> And I need to decide what to do about skb_copy_and_hash_datagram_iter().
>>
> If it were me I would _love_ to switch the nvme-tcp recv patch over to 
> recvmsg and kill the ->read_sock() implementation.
> ->read_sock uses a completely different codepath in tls_sw, and nvme is
> the only user of that. So there's a fair chance that we might miss any
> improvements or fixes.
>
> Plus we currently have no good way of handling TLS records from 
> ->read_sock(), which is something we might want to do in the future.
>
> So if we had an equivalent for skb_copy_and_hash_iter() for recvmsg()
> I could revisit my original patchset and work on getting ->read_sock()
> replaced.

Indeed, we want to calculate rolling crc32c as we copy the data vs. 
doing this afterwards...

