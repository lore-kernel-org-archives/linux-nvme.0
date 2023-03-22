Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D83C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z6l9nP91HpVaIuu5J7D+loIMCJ0ccMNyNWJa5DOX8PI=; b=CoMpTPwTwt297D2jN3aLY7UdoL
	kZvz1KMrP9V4ZyC4Q57ZyXMvqUJ3jzAcc87o+phQCT9/dq/6PFnGNjuOBa3JgqmBucOt14sTSwHds
	5NN5PydGa9M6f6c0ACvi0b707qOGIsocLeeOIs+2AGe3Dy+ojZ11wF0XF3/3XFwGc8+iBvJAe9bSG
	6ZwZf6A7LHxpMEh0LskwhkZdPcyepYepdwpxwxssIj6pQy+cAq3InekS3uH6+UFImx6/Xl6oVCpaI
	COmRLFRoFzRldsk4o40KlH0nysiMbJA7xIBhlqWbULvw9E6SbCKZhNoGPxbJQHnO2Gq4MRZwKq8ZE
	tSCqEhng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pexaZ-00Fvxf-2R;
	Wed, 22 Mar 2023 12:29:11 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pexaX-00FvwY-0m
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 12:29:10 +0000
Received: by mail-wm1-f45.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso526065wmo.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 05:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679488148; x=1682080148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6l9nP91HpVaIuu5J7D+loIMCJ0ccMNyNWJa5DOX8PI=;
        b=nHqH4ycd+KAmtXqoiYQQC0fISwPlcjz0tLP5MTbEqmPrff6yaR0PiKKAkdtCBzWrxp
         bm5rmS+FdM0i7JBU5sgDfyRsf4/4cbKDfZfq3S38jOmDdSY2o1Z594TZnbvnfEYR6xYM
         Ew9oYfjUYvOuTLU7AyKJwxNYxMTO2dnU8Y2r5dJfGOS6Z0kO9KnN+DkJRf64j6b6J6rY
         irgQRSq90e2S/UDD+/TAdVRZKbuhJDroh+ecNthGHkhIe73I7us4n7lhB+Pkl88h1w82
         ZtxrVxNidPQfTVEfzsWbJBGGCq7pZb/rRRuAv1EWECdI8iJGuKKt1g6EKeQhV6QdTRJU
         c5Dw==
X-Gm-Message-State: AO0yUKVOttszmy4j/sUx9UZVKahpXbJYtXCBhCFeNQPUrT0zrJTWmNQ8
	7wRpmBKuQUR1KTAis+HQ5xB+Z4KNbdg=
X-Google-Smtp-Source: AK7set8Yi1EJ4lm4bVZdQyskjPfglKWMWCCOuRm+yAHxrUf4xwo+ybQm2BZ3H5yRmDgBOdSSFdofkA==
X-Received: by 2002:a05:600c:4ec7:b0:3e9:b564:fae4 with SMTP id g7-20020a05600c4ec700b003e9b564fae4mr5841377wmq.0.1679488147855;
        Wed, 22 Mar 2023 05:29:07 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003edddce5b00sm10888500wmn.12.2023.03.22.05.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 05:29:07 -0700 (PDT)
Message-ID: <4963a908-8829-5894-a815-9b27fd0f9dd7@grimberg.me>
Date: Wed, 22 Mar 2023 14:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/18] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-12-hare@suse.de>
 <0be88516-8e29-a1a5-f0ff-204830c0fba5@grimberg.me>
 <cd37b4a7-41e7-b142-e87d-908a2e7bcfc7@suse.de>
 <0cfcab69-c4a1-2072-a85b-12c5a087db58@grimberg.me>
 <0a8061ca-9c44-cae5-aab4-fd3222f372bd@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0a8061ca-9c44-cae5-aab4-fd3222f372bd@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_052909_276370_E4F2E0F6 
X-CRM114-Status: GOOD (  19.85  )
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


>>>>> kTLS is sending TLS ALERT messages as control messages for recvmsg().
>>>>> As we can't do anything sensible with it just abort the connection
>>>>> and let the userspace agent to a re-negotiation.
>>>>
>>>> Is this a problem if we do end up adding read_sock to tls?
>>>> Although I do see that the tls code does manage this in the
>>>> sk_buff control buffer, so I assume there is access to this info.
>>>>
>>>> CC'ing Boris here as well.
>>>>
>>> Yeah, that was the other reason; cmsg aka TLS alerts are only 
>>> available for recvmsg().
>>>
>>> However, for TLS 1.3 the only TLS alert which does not trigger a 
>>> connection reset would the the ominous 'new session ticket' alert.
>>> But during TLS handshake development we already decided to _disable_
>>> session tickets as they are pretty meaningless for our us.
>>> Consequently all TLS alerts will trigger a connection reset, and 
>>> realistically we don't _need_ to know which alert type has triggered
>>> the reset.
>>>
>>> So 'read_sock()' could be implemented by closing the connection on
>>> any TLS alert, and not giving us access to any of the alerts via
>>> control messages. If that makes life easier ...
>>
>> Most likely read_sock() is the wrong place to ignore alerts. Probably
>> the better way is to do this in nvme, although its a bit harder.
> 
> But that's just the point; you don't have OOB information for 
> read_sock(). So I wouldn't know how you could pass the TLS alert 
> messages.

tls_sw populates cmsg from skb control block, and accesses it from the
skb with tls_msg(skb)...

> Hence my idea of converting them into a connection reset for 
> read_sock().

Probably its the wrong layer for this decision.

> As the whole idea of using ktls is that you do _not_ have to handle TLS 
> details, it's questionable what exactly one could do here except from 
> resetting the connection...

Well, in theory, you could have passed it to userspace along with the
sockfd to handle it for you. But I'm definitely not suggesting that we
do that. But at least the connection reset should be decided above
read_sock.

