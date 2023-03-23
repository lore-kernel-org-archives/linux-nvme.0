Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212D8C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sy6+BKtTrpb9aSrmkIBJqRQbr06WOMWdW7hAg/Efcyo=; b=1unCL5qimm7vY/5CPxxCz2+vsM
	J4W5Sh0Ffr3G2QCRlfcZmk5+zzpr3xI6CISmZpTEZUcZE8AwfYBqE0CML6ac7znYIj0KuGTWzDCF1
	FrcBc9nKAevv4aE6w3pkGNnxifNstIkuCdSunrMrzKO0lOeb7ytStQCysEaj1nVAtCSaJTTHT8YLP
	pLSaNxTMUkp6tuZOsZbI/TADBTd1hdTk/SJ3AcI43HxG9NI0T4f9bYlbjfJdPAtfpmruJtxbEKBUr
	CIzCT1tPGWlbecTcA4CLDJO9O152cc9Hbc/Rm6Ub8yCiZpO1rGNcjvzBq11+QNLIKn+LV2exs9Y7I
	FamMBWsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFcG-0018PK-18;
	Thu, 23 Mar 2023 07:44:08 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFcD-0018Ol-2s
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:44:07 +0000
Received: by mail-wr1-f47.google.com with SMTP id m2so19431074wrh.6
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 00:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679557442; x=1682149442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sy6+BKtTrpb9aSrmkIBJqRQbr06WOMWdW7hAg/Efcyo=;
        b=rjrmFWj76aHD5t0FHvI9BPBU+UIImtnqMPV1C63wwPRvVNGt2N0xNIxYljzvEO2LXC
         /b8SCHxKL5migcUqU4OnFFqixUnt/+rhuhA5tyKy1JVb9reTdp8FLQJtZBTCji/yBRkw
         BKoiiwGFusXqJxNSjVM44QM9VgmgapSSKjL2WiInw1CL42XAjd6Ah/6D9RxIRhmSBQ+s
         FamZ6UGZnXCXVjkY6AmffbcrhdlaG0wc0h6JNfMInUWQpi7scZ/0zL1gSfiALj0ORXh9
         Zuscz2mbbFzMXL1s8dAgnGWBDm4bfMhnsp0STq74eAQVV5mby7NZenfjJxAVC6ngpITj
         z/ZQ==
X-Gm-Message-State: AO0yUKUbol3qQp3SMRPbDRgaQPN7MSkEk/YN8Zrm6oBU8wNGXPeXOsVH
	zatSlKOwNgop+Mq9sJqYAC4=
X-Google-Smtp-Source: AK7set/znm807dTtc9Lhqya2EwS34NjO7Iuo/J151gJIFfF2UKnXXQ1QdWt4lFkwWp90L1Qb1ibBgg==
X-Received: by 2002:adf:ef06:0:b0:2c7:175e:e201 with SMTP id e6-20020adfef06000000b002c7175ee201mr5459039wro.1.1679557442544;
        Thu, 23 Mar 2023 00:44:02 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d590f000000b002cfec8b7f89sm15660865wrd.77.2023.03.23.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:44:02 -0700 (PDT)
Message-ID: <e86eae9f-f6f5-0e3d-e657-6758f582895a@grimberg.me>
Date: Thu, 23 Mar 2023 09:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
 <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
 <b8a2e1d4-3571-447b-25c6-c6dd25fbad02@suse.de>
 <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
 <c426d104-b7f2-e736-c23a-b94fda54ed37@suse.de>
 <e0620d94-9729-014c-2cb8-8ff826ebbefa@grimberg.me>
 <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_004405_929231_17026009 
X-CRM114-Status: GOOD (  43.11  )
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

Hey Hannes,

>>> To be precise: that's the reasoning I've come up with.
>>> Might be completely wrong, or beside the point.
>>> But what I _do_ know is that without this call userspace would
>>> _not_ see any data, and would happily sit there until we close the 
>>> socket due to a timeout (which also why I put in the timeout
>>> module options ...), and only _then_ see the data.
>>> But with this call everything works. So there.
>>
>> I may be missing something, and maybe its because I haven't looked at
>> the userspace side yet. But if it calls recvmsg, it should either
>> consume data, or it should block until it arrives.
>>
>> I'm finding it difficult to understand why emulating almost 100% the
>> default socket .data_ready is what is needed. But I'll try to understand
>> better.
>>
> Oh, I don't claim to have a full understanding, either.
> I had initially assumed that it would work 'out of the box', without us 
> having to specify a callback.
> Turns out that it doesn't.
> Maybe it's enough to call sk->sk_data_ready() after the upcall has been 
> started. But we sure have to do _something_.
> 
> If you have other solutions I'm all ears...

See my response to Chuck.

>>
>>>>> As outlined in the response to the nvme-tcp upcall, on the server 
>>>>> side we _have_ to allow for non-TLS connections (eg. for discovery).
>>>>
>>>> But in essence what you are doing is that you allow normal connections
>>>> for a secured port...
>>>>
>>> Correct.
>>
>> That is not what the feature is supposed to do.
>>
> Well ... it's a difference in interpretation.
> The NVMe TCP spec just says '... describes whether TLS is supported.'.
> It does not say 'required'.
> But there currently is no way how the server could describe 'TLS 
> supported' vs 'TLS required'.

But it doesn't make sense. If a subsystem wants to expose itself via
tls and non-tls, it needs to use 2 different ports, Which is a perfectly
reasonable requirement. Making TLS advisory misses the point, regardless
of the spec language.

Having support for advisory TLS is essentially implementing a permissive
mode, and that needs to be explicitly enabled (assuming we want to
support that), not the other way around.

>>>> btw, why not enforce a psk for the discovery controller (on this port)
>>>> as well? for secured ports? No one said that we must accept a
>>>> non-secured discovery connecting host on a secured port.
>>>>
>>> Because we can't have a PSK for standard discovery.
>>> Every discovery controller has the canonical discovery NQN, so every
>>> PSK will have the same subsystem NQN, and you will have to provide 
>>> the _same_ PSK to every attached storage system.
>>
>> Right, because they have the same NQN. Sounds good, what is the problem?
>> It is much better than to have sectype be nothing more than a
>> recommendation.
>>
>> If sectype tls1.x is defined on a port then every connection to that
>> port is a tls connection.
>>
> See above. Only if we decide to give TSAS a 'TLS required' meaning.
> With the this patchset it's a 'TLS supported' syntax.

Yes, tls should be a hard enforcement, regardless of the spec language.
The only way that tls would be a soft enforcement, is via an explicit
permissive-mode setting.

>>> If we had unique discovery controller NQNs everything would be good,
>>> but as we don't I guess we have to support normal connections in 
>>> addition to secured ones.
>>
>> Its orthogonal. the well-known disc-nqn may be "weaker", but tls
>> is still enforced. when we add unique disc-nqn, we can use different
>> psks.
>>
> Not only weaker, but _identical_ for each server.

I don't see any issue with that. I do see an issue with making tls
advisory universally in nvmet.

>>> As I said; maybe it's time to revisit the unique discovery NQN patches;
>>> with those we should be able to separate the various use-case like
>>> having a dedicated secured discovery port.
>>
>> I don't see why this would be needed.
>>
> We don't if we treat TSAS as 'TLS required', true.
> But that's not what the spec says.
> And there is also the dodgy statement in section 3.6.1.6:
>  > If a host that supports TLS for NVMe/TCP receives a discovery
>  > log entry indicating that the NVM subsystem uses NVMe/TCP and
>  > does not support TLS, then the host should nonetheless
>  > attempt to establish an NVMe/TCP connection that uses TLS.

First of all, "should" != "shall", so we are not obligated to do
this if it doesn't make sense for Linux, but regardless that is fine,
the host can fallback to non-tls in such a case if we choose to
implement this.

> which really indicates that the TSAS field is a recommendation only.
> 
> But really, we shouldn't read too much into what the TSAS field says.
> With the upcoming TPAR for TLS clarification all these different 
> interpretations should be clarified.
> 
> The key question, however, will remain: Do we _want_ to support a 'TLS 
> supported' mode for nvmet?
> I'd say we should, to have compability with older (client) installations.

That is great, but only with an explicit permissive port setting that
needs to be enabled, and later on disabled (i.e. when all the hosts get
upgraded over time).

> And I guess we have to anyway for secure concatenation
> (as this _requires_ that we start off unencrypted).

That I can understand. But it definitely should not mean that we
do a universally permissive tls.

> So I'd suggest to leave it for now, have the code to support both, and 
> wait for the TPAR to be ratified and then revisit this issue.

This is not a matter of a TPAR. It is about Linux. It doesn't make sense
to make tls universally permissive for _Linux_. I think we should
introduce code needed to support for secure concatenation only when
it is actually introduced.

