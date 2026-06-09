Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54398CD6E79
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jun 2026 09:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lx1Uj9ALacAYcxK3gPmx8FCujSx8SGCSZJ/pzDLpCcY=; b=KHmC//i+Xo9ognKkiUoEsvBysY
	TLe5BEpma3SRLUMmIlnKqnSxj6gOMH0JS2/1YblaFaKi0+l3cIP4rKD36NU5IezUjSlWA0OR19fUe
	Or/vvdAHuq0cWnjvXzgT/gNGd3abjWgSTGgtyOEZw62rASKzbH7MzZGhv8DmWSkRVbpZjA5LsVcdt
	2ao3dkzkaUGUt0l/vvUGLGqRsdMQiQ15l8kE1YsfkJLSokH6rxEhXPvaoG+QxREOcORavUG/2SYDp
	rVQw0dQFwZTwkCGsxhpqG80UYFhNFVYei+w5CTJzSJYgpcmmpymdVvgCz8nzkE/TdtgRpcWwJa/L1
	o/GdQ/vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWsuH-00000005E1n-3Ltb;
	Tue, 09 Jun 2026 09:38:01 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWsuE-00000005E0d-2Nbg
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jun 2026 09:38:00 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-490b1c39fe4so5345495e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jun 2026 02:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780997876; x=1781602676; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx1Uj9ALacAYcxK3gPmx8FCujSx8SGCSZJ/pzDLpCcY=;
        b=Qd7yFMOKpqDM2FaIo8t9xLtd5YBlJhJa8GrZNnGmXWsE1/tXF6oG1YFnSwAFxInfOE
         UOmdUGPwhu7eX7hS5VJc+eoW7Q3NaGja2XQfgnXuaB2pupUo6tp9wemEqVjL7/jzjcOe
         8Kr3sOjugAVgnYcty0IzlDH1yKQ/N5YURyKTm8zrc97lrSAe8rC7zBIdkMFhRkgLIW9t
         3z/ZYQpRUsxyZeXVHII2iJRsNNSPd1Wj4NLpC/kHEEfChXaDoY7HGUh5bqQu6iSxUTCU
         aqYNVPwuW27+3Ty1z/1QZF48P2c71dso91OjURTbEI8DKGRhH+/+lsodRZipMzLWCtsI
         xOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997876; x=1781602676;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lx1Uj9ALacAYcxK3gPmx8FCujSx8SGCSZJ/pzDLpCcY=;
        b=BHwYDhyxKaofPPdHbVDmb6MOUVElAUJQSx1nLTgUK5QlLKVGgwyahq5QC9do302UVo
         QICY+OaWHywWrt3OOplcutNlF5lhlxV66+D9xWhXM+KZojhYeBGwunkLObYAG+eRNNSv
         c7AHAAzACDt7lYKOUQQo6+fPEABqVz3nFrUGM8bQd+nYNOgL57v2mRCCT01zk2jxtYo+
         Sh6LEvSp67Vn83y31VnEEDdu2eRNbvdYhVTy2nTQAZf/X9eD6w4Vb+AtNMz2MMmhmHqS
         6mIoiCI5DLml5x026ldRo4GjzcMHALdNrxBf1p3KBFzgwrYtKnJdnRBrBNr9NfWfK7Qy
         fNKA==
X-Forwarded-Encrypted: i=1; AFNElJ/QJqJrjPzhhfgwV9ds+CeLmOGfgr4K5lR5pI77y6JhvV3RXXt/vsf8tXQidvDZsTmNteBOTI/UqkHv@lists.infradead.org
X-Gm-Message-State: AOJu0Yz05VT7QybSkiolhrDeslIvyvsT05T9tKs+vqHITbyTVYjZLvBK
	6CDOpliy4uzzP0ax/TFbqeoQoNVkHuadBXVaBEibv0HjB2xTgRASycYuo7jJEAh0+IU=
X-Gm-Gg: Acq92OE+p64KaFQ5NjbkJhrzc4ip0hLkhDYnFhwkHJlLh+VkBRObn9av6aIxAP3yHet
	JXUj4vypVLgq8nkk17corOjUBshZfh9QZGGf0IVKUP0XKToA/ywQM1k6vSHg34JQIIldhbC6nGG
	IVuQsnvvhK5K4GwwDzDEJNE0aGz/qOHWf2+6oZeOhjEtWuIngfyfFxjphHQ9wKoErHzjqdvIf80
	lVmJw/L4H3pZXudSq8CRQ5yqm0XT9Q0tYqn2W0uR5aUSHAu10agpGLCy6aBY177ZR0EFKUNSEoR
	+W9XEgj03z0LPiGAAvuroN5RkAf2/92M8bbe+z7ktn9xsGulyULhAgMdbgBVAm+kJd9LUm112Ql
	Q23aeFnzoAexBC3JKG49pvlSiX69yO/2gx4+tQovnh043eE3BxlahMhXNgrXPS9ubTJln+IIZAy
	GiLIG/LfGJln9tddQQwgumZzrKhvEe
X-Received: by 2002:a05:600c:8b82:b0:490:abf1:2ddb with SMTP id 5b1f17b1804b1-490c2603825mr139566865e9.6.1780997876074;
        Tue, 09 Jun 2026 02:37:56 -0700 (PDT)
Received: from ?IPV6:2001:1a48:8:903::e14? ([2001:1a48:8:903::e14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f34413csm59623796f8f.21.2026.06.09.02.37.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:37:55 -0700 (PDT)
Message-ID: <44bff0d5-3884-45d8-a525-15c6325620ea@suse.com>
Date: Tue, 9 Jun 2026 11:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Memory fragmentation with large block
 sizes
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@infradead.org>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org
References: <f22caf98-1375-493a-a275-0500ffac3e81@suse.de>
 <aifAm1rRKF75HVeM@infradead.org>
 <1225376d-dc29-44a1-add6-0cb14926a538@suse.de>
From: Vlastimil Babka <vbabka@suse.com>
Autocrypt: addr=vbabka@suse.com; keydata=
 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
 pYekxJujNeEDkUlky0Y=
In-Reply-To: <1225376d-dc29-44a1-add6-0cb14926a538@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_023758_649751_81589F9F 
X-CRM114-Status: GOOD (  33.69  )
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

On 6/9/26 10:39, Hannes Reinecke wrote:
> On 6/9/26 09:28, Christoph Hellwig wrote:
>> Hannes,
>> 
>> can you share your results on the mailing list?
>> 
> I sure can.
> 
> We have run a simple testcase with on fio job on an LBS-enabled device, 
> and another job permanently allocating and deallocating arrays of pages
> of various array lengths.
> 
> We then took snapshots of /proc/buddyinfo to track memory pressure
> over time.
> 
> Results are visualized in the attach plot.
> 
> With 4k block sizes we have seen a high number of 0- and 1- order pages,
> and then the expected decline towards higher orders.
> 
> With 8k and 16k block sizes a noticeable 'bump' in free pages was 
> developing in 2- and 3- order pages, which we think is down to 
> compaction trying to merge pages together.
> The number of 0- order pages increased slightly, but only half of the
> maximum number of pages in the 'bump'.
> 
> With 32k block sizes the picture changed completely; the 'bump'
> vanished, and there was only pronounces spike with 0-order pages
> (about four times the size of the spike with 4k block sizes).
> 
> This led me to assume that compaction broke down at 32k block sizes;
> this assumption was confirmed by Vlastimil Babka who pointed out that
> there is a maximum order to which page compaction is attempted:

Yep, but after the LSF/MM session I've realized I made an off-by-one error
thanks to the misleading name of the define.

> include/linux/mmzone.h:
> /*
>   * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
>   * costly to service.  That is between allocation orders which should
>   * coalesce naturally under reasonable reclaim pressure and those which
>   * will not.
>   */
> #define PAGE_ALLOC_COSTLY_ORDER 3

Which is 32k

> and it's main usage is 'order > PAGE_ALLOC_COSTLY_ORDER'.

And indeed, this means any changes in behavior due to this should only
happen at 64k (order 4) or more. The value of 3 is in fact something like
"PAGE_ALLOC_MAX_CHEAP_ORDER". I'd send a rename patch (Kiryl fixed a similar
off-by-one gotcha with MAX_ORDER), but I suspect we'll be making more
involved changes here so I'd wait for that first.

> Which ties in directly with what we're seeing.

So it's probably not that straigtforward. We should investigate more first?

> It will probably make sense to align the maximum block size which we
> currently support (ie 64k) with this value to ensure that compaction
> works with larger block sizes. Or maybe even the other way round;
> tie the maximum block size which we support to PAGE_ALLOC_COSTLY_ORDER.
> But that would mean to restrict the blocksize to 16k, whereas xfs
> works happily with 32k. So we might want to raise PAGE_ALLOC_COSTLY_ORDER.
> 
> Question is, though, how could we measure the impact?
> This particular value has been in since 2007 (commit 5ad333eb66ff1 
> 'lumpy reclaim V4'), and it might well be that the original
> reasoning doesn't apply anymore.
> 
> At the same time, this value is tied to a _LOT_ of things
> (not to mention the page allocator itself), so increasing it
> to '4' has an extremely high chance of impacting mm performance.
> 
> I'll probably run mmtests and see what I get.
> 
> Cheers,
> 
> Hannes
> 
> 
> fragmentation.png
> 
> 
> _______________________________________________
> Lsf-pc mailing list
> Lsf-pc@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc


