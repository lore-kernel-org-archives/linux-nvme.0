Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63F3C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AdV6TZveSeGX04cT7SBmu58cwbWGwgje7nGBW5gWx6A=; b=tm80NwIASC0Cf3Bc+DDhxtK0nZ
	r9eNuI00ta/693Nb5MxEnZuJOy/aMTrgBsFL5fc8LqMHFRfpXzkZMRxNJlEetKiCWqaO/jUlurOA3
	fi6odbmhcTaD5ZQpMYWCSVxQq5pZZ8O18448wNdCOdZeR6weex7+8mxTqA5cjVHTKVkIqtRKfnD5Y
	pMxBftZaBoSERYuwgnw/skVHO/TV9gMB9XqZaZXtFeJkQ8+jYOX7Lgigzx4PEL9symPN1/FDQOMKC
	kneQYz2NsWgsH95rwkCo2XwoLxNdf6/nZcxhn1kC365MwawDjXeDh7oEs3OQhQz0MZbeU2TDTIPU/
	mM1nISNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rib4k-00000009Wek-12IY;
	Fri, 08 Mar 2024 14:19:54 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rib4f-00000009Waj-26KV
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 14:19:52 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e79eca772so107985f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 06:19:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907586; x=1710512386;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdV6TZveSeGX04cT7SBmu58cwbWGwgje7nGBW5gWx6A=;
        b=g2bCrZPT5HD72OFdV3G6EFZ5C6j9hrsMWjXCmZtOzlyH79SqnrzZ0wPndjBdozsrR9
         hBa/fitjfAj4rPZK0UglWIUa23T8GJl1iuWXTs5UVg8b3lFAJMRFiLDnrslueAYy1Hlb
         +l2le6+wdYlLtFeI+q8X97MA+iO2kG5PyzwDRvq0ptkubLiYWlgArLv4e3zBGb3HYbQx
         MpkdpB54yWh273aV80c8lSyovLS3Z3JfKiCGXAppLtdAULcFAJSA0p0EUBnPGIBVMV9K
         6wJx1tfx/jIx0wvS+tmJz4fM9aggTJWchHLtH5CxJl+qLWhX/aTFNINmeTgNqP43P/p/
         WBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2JdsfJiUdzGAvUpvfztwX/algjBdGhEUBxab1aY9zEdppIN1GkPZEbItg2EmgZEoS9/j5BAK/ZeEzEo7j5lxGltrpAd53zHjJF61HJpU=
X-Gm-Message-State: AOJu0YxctpivhSZKH0E0DCnGHlKVTfyoGUfXaRGXtlP0pWduKmHplW7l
	kT894qP5mY+wwy6QPNnOyJXSmD3j/cK7Zl8SaCerJXaAgSOf2R4dnp8el4KA
X-Google-Smtp-Source: AGHT+IFrjukXj/51Y6pNIhp1LInIpZlj/CUHPTL1zdB1dXy5yaBrgI9YScz2AUfkWY5bUbGHgW8Wfw==
X-Received: by 2002:a05:6000:1b0f:b0:33d:568f:8986 with SMTP id f15-20020a0560001b0f00b0033d568f8986mr1451599wrz.2.1709907585685;
        Fri, 08 Mar 2024 06:19:45 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d59c7000000b0033e475940fasm10768889wry.66.2024.03.08.06.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:19:45 -0800 (PST)
Message-ID: <32e337ef-a041-4b73-a6f6-211458a5c71e@grimberg.me>
Date: Fri, 8 Mar 2024 16:19:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-fc: FPIN link integrity handling
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, hare@kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240219085929.31255-1-hare@kernel.org>
 <1dfa9a4e-e4a2-4d48-b569-85e48ce4311c@grimberg.me>
 <1c3eea31-b80f-4b95-ab15-ac42f7c45c16@suse.de>
 <7ff7c9cc-6b02-4adc-9b78-8bab26341049@grimberg.me>
 <0b18f1f9-5011-46f4-a0a1-a69cd54bfc88@suse.de>
 <2b0bdbfb-1bff-405a-8f95-163a99022d94@grimberg.me>
 <4f3ee04a-daeb-4813-9f08-6450cffa1d70@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <4f3ee04a-daeb-4813-9f08-6450cffa1d70@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_061949_673957_E8AE7F07 
X-CRM114-Status: GOOD (  20.73  )
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



On 08/03/2024 16:09, Hannes Reinecke wrote:
> On 3/8/24 11:38, Sagi Grimberg wrote:
>>
>>
>> On 07/03/2024 14:13, Hannes Reinecke wrote:
>>> On 3/7/24 13:01, Sagi Grimberg wrote:
>>>>
> [ .. ]
>>>>
>>>> stopped is different because it is not used to determine if it is 
>>>> capable for IO (admin or io queues). Hence it is ok to be a flag.
>>>>
>>> Okay.
>>>
> But wait, isn't that precisely what we're trying to achieve here?
> IE can't we call nvme_quiesce_io_queues() when we detect a link 
> integrity failure?
>
> Lemme check how this would work out...
>
>>> So yeah, we could introduce a new state, but I guess a direct 
>>> transition
>>> to 'DEAD' is not really a good idea.
>>
>> How common do you think this state would be? On the one hand, having 
>> a generic state that the transport is kept a live but simply refuses to
>> accept I/O; sounds like a generic state, but I can't think of an
>> equivalent in the other transports.
>>
>
> Yeah, it's pretty FC specific for now. Authentication is similar, 
> though, as the spec implies that we shouldn't sent I/O when 
> authentication is in progress.
>
>> If this is something that is private to FC, perhaps the right way is 
>> to add a flag for it that only fc sets, and when a second usage of it 
>> appears,
>> we promote it to a proper controller state. Thoughts?
>
> But that's what I'm doing, no? Only FC sets the 'transport blocked'
> flag, so I'm not sure how your idea would be different here...

I know, I just came a full circle with our discussion :)

