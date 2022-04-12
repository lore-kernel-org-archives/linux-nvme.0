Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288DBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 10:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=agnH2dVH0u3x1p8AnqNtQBANZpqgruYy4X1/w67MmrU=; b=rpR3Gy0YvtScEH47EPmtbWjlKi
	MEEI/juGIYHSyWlDwKD/diA8rfLvEQ+h/WPhuldzp+0maoMgOOoNp2vc2/J5fySpjQEd1GM8soZuk
	1lMk7PYqPNEVaJOwlohqac2KunbUq8btrdhcvy6IZWMvpEHPEWROqa1dSydM6sb73qiozYvLcNM17
	XkeS3Nt7U5r7iQf14IE29RN7bL+O0nJwuxVpKUl3FwlBmm++wiinZnVvxsqlLQUhtp9kOnbNXQXLi
	RCtss7rn1ZVR3r1gbaJnDDAgwlTBPR6AGIwDHzJRpESI8gejrY9G9DlZPWIQSfVGu0ZYN7lOTSe8r
	bsZ0wqcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neE6z-00DRPt-49; Tue, 12 Apr 2022 10:51:05 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neE5p-00DQxo-Es
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 10:49:57 +0000
Received: by mail-wr1-f50.google.com with SMTP id k22so8563567wrd.2
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 03:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=agnH2dVH0u3x1p8AnqNtQBANZpqgruYy4X1/w67MmrU=;
 b=NcYMTThq9MKKiYlwYM46SPUnIMR034kb+41NVWLq5GxUJRIQtpqD35uWQOcWb8U7mZ
 xphn0OhZkhbKB1V2NVfBcbnI9dEIRAUvvo8QImU3daLsmQh+Mt3vpg+VCIKLV0dSmZlU
 m+XEkqPV8uFuSFu3hICLHvTVLxYSpH9xz6DpWxIaXs9J/dEADL3kT5/fQuXc13g1JbjZ
 lu+oUF8n2lAkuNeKFqiimajs7gNAO9nsKIwVabgJr8rji3Jt4OfQ6wfbCAkP4hlEhAtl
 xaULmv4WSKitKLxrVXRA1z0Hgv2q9Nbmbjsh+OBw2PRGZJrxnbYdKyQKvSeVq19h5QRG
 OG/Q==
X-Gm-Message-State: AOAM530P0w+7A7VBcCxIQF3hMgQbpoUIWSQvuedBUkJ4Mnypl9fitW63
 Si8rRN3SmfWUQ4Hf256Gf6Y=
X-Google-Smtp-Source: ABdhPJwa7XDkkC5dKPiFg6ghAi+Wh3tA1voPivalvysH/f6CrgJ5qA9u/NwCYTVTpakzdH5OR4eJKQ==
X-Received: by 2002:adf:dd10:0:b0:207:a8ce:c152 with SMTP id
 a16-20020adfdd10000000b00207a8cec152mr6052270wrm.714.1649760590309; 
 Tue, 12 Apr 2022 03:49:50 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c214800b0038ec51d544csm2229837wml.27.2022.04.12.03.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 03:49:49 -0700 (PDT)
Message-ID: <e7ffdfcb-7617-4377-a427-080ef3eccaa4@grimberg.me>
Date: Tue, 12 Apr 2022 13:49:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220408065930.123015-1-hare@suse.de>
 <20220408065930.123015-4-hare@suse.de>
 <dddcb416-e4c8-b1d7-e893-416d819653dd@grimberg.me>
 <ff897f9c-0b7d-d745-b780-4336b0e4820e@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ff897f9c-0b7d-d745-b780-4336b0e4820e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_034953_583339_AAC4EA82 
X-CRM114-Status: GOOD (  28.31  )
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


>>> When a per-port discovery subsystem is used we should include
>>> all configured ports in the discovery log page, not just that one
>>> through which the controller was connected.
>>>
>>> - /
>>>    o- ports
>>>    | o- 1 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=8009]
>>>    | | o- subsystems
>>>    | |   o- nqn.discovery
>>>    | o- 2 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4420]
>>>    | | o- subsystems
>>>    | |   o- nqn.discovery
>>>    | |   o- nqn.io-1
>>>    | o- 3 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4421]
>>>    |   o- subsystems
>>>    |     o- nqn.io-2
>>>    o- subsystems
>>>      o- nqn.discovery
>>>      o- nqn.io-1
>>>      | o- namespaces
>>>      o- nqn.io-2
>>>        o- namespaces
>>>
>>> A discovery on port 8009 will return information about
>>> - nqn.discovery at port 8009
>>> - nqn.discovery at port 4420
>>> - nqn.io-1 at port 4420
>>> A discovery on port 4420 will return the same information.
>>> A discovery on port 4421 will return information about
>>> - standard discovery subsystem on port 4421
>>> - nqn.io-2 on port 4421
>>
>> This is a different functionality than supporting unique discovery
>> NQNs.
>>
> 
> Yes.
> 
>> If I want in your example to use a unique discovery subsystem but to
>> report only on the port local I have to use two different unique
>> discovery subsystems. Which is different than the standard discovery
>> subsystem, why?
>>
> Because this was a logical step from the way I've implemented unique 
> discovery subsystems.
> 
> As discovery subsystems (in my implementation) are treated like 'normal' 
> subsystems, they should be able to be linked to ports. If they are not 
> linked we would have to implement some magic on which ports this 
> subsystem will show up, and also making it inconsistent with all other 
> subsystems.

They can be linked to ports, but why do they need to return subsystems
that are attached to all ports differently from the normal discovery
subsystem?

>> I'd submit to you that IMO unique discovery subsystems should not behave
>> differently than the standard discovery subsystem. Please explain why
>> do you think that unique discovery subsystems should behave differently
>> with respect to the content of the log page.
>>
> Well, arguably.
> But I haven't been able to find a good way of keeping the original 
> behaviour _and_ support unique discovery subsystems.
> 
> Sure, one could implement some magic variable in configfs like 
> discovery_nqn, but that would have to be in configfs root directory, and 
> really doesn't match up with current configfs layout.
> One could go with your suggestion of having a discovery_subsystem entry 
> per port, but we're back to the issue which killed my original patch:
> How do we ensure uniqueness?
> Each NQN here _need_ to be validated with the existing (and future) I/O 
> subsystem NQNs, as they need to be unique. That requires a lookup over 
> all ports and all referenced subsystems.
> And we have to figure out if we allow for duplicated discovery NQNs; one 
> can find arguments for either side.
> 
> That's why I came up with this approach.

I'm just talking about the content of the log page. You are making the
functionality of unique discovery subsystems different from the standard
one. I'd either make the unique return subsystems attached to the
current port like the global one, or change the standard one to return
on all ports, or make it explicitly configurable that you can turn on
for each discovery subsys. But making the unique and the standard behave
inherently different is not coherent.

> 
> And that's also why this is a separate patch, as it does expand existing 
> functionality :-)

My issue is that its causing the unique disc-susbsys behavior diverge
from the standard one...

