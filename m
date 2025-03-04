Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2877C021B8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jc0fHINLgpRpFjBoumMxo+EFHaGqMPVtOaRHH1CUD+c=; b=gcK06ecIVA9+8lSPTqsgzTHLCe
	qVHxIHhOHawHsKokAdjaLofBp3WZBrhnPLxsCSVQVYoasRlQ9hs8/M0HdyEvo4r0KTmXGfZ4PPiYn
	e/PUF9wgxznU3HtlfrEj4g4PLby41AToCaTmGsilSB1Az62OTehWJPEfLjXx0uYrz7CvvLDXXWdHU
	Wa4sd3xmuLPj9A6Mpg+VlpJvLSLyktr9hUkHPOkEA9bRXO56kNcAbYeZAYiPAsG9Js66EbSGFeiaD
	tis1sfwW9wjshV+Wq/zwKPdnuWne9Cpm6OWLPvL2dGH8BOq5l5o/0nCYZeOzoW1p/6K8V2j/cQsXE
	w+m+h+pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpWbi-00000005knl-0R75;
	Tue, 04 Mar 2025 18:03:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpVCC-00000005RSF-125T
	for linux-nvme@bombadil.infradead.org;
	Tue, 04 Mar 2025 16:32:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=jc0fHINLgpRpFjBoumMxo+EFHaGqMPVtOaRHH1CUD+c=; b=FU+UVDbdRPlKhHk8HPnGiTgeu5
	7d06tpLcMXTy65g0aK30oxSMfCA9Ch6nh+en/oX4pejYc6rCP8h2Jh1DMLNR/bH0VB8x25L6Nssy9
	9pKYWWBTkj4yec1mYc/1RGauZ1KmkE3fAnX6oj0CJOkf1xBvZBPMu/7Me46+uFXo3wcRdVDbwP68O
	ib48t5R6tvgD42kVDdNhBOv0DOg9gLkzBCTWez+NOgoBvSLBX1NY9DwgoRKg01FNmwA5Swqd6HIPO
	og4fLhqc4FjRbHbaxGI9fsazuYe/4jgJ7TjHx4RxaLZ0SxYOBKTcYpCGIpyamnU0acVeCFdPkdfGf
	Dbz826HA==;
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpVC8-0000000060N-3BS0
	for linux-nvme@lists.infradead.org;
	Tue, 04 Mar 2025 16:32:39 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-390f69e71c8so2540803f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 04 Mar 2025 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741105954; x=1741710754; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jc0fHINLgpRpFjBoumMxo+EFHaGqMPVtOaRHH1CUD+c=;
        b=a5tw5fvQ3eaJDF5QKDVXMYq+kPmm0b+l+C5raJjR6SzDF+xkMpud4BSqbMZZWW6ZzX
         auBV1oD9nQWBvjoRWVtUidQava++BXsMxslpyG4iD7AkbRvtCybQKezD9ux0Jh2cp0z6
         +H1U0AhTTM70ionmSiAWdiuyQ0cOswVCaPsEdhMysdefLf7/BQpSXa2YD0cOEr2qGfBe
         fwaOzcMGe+nbMXaKUgHb9W9sZjIAMhHn/jDwtNZWLdOWe1IBJ7IEksQOsHx9vP30S377
         uc96mJtX4MeemU1D1JuaJS3ZHTlspr3ueaKsUZ2wmdwf53eh1dmAA29YEnd1C453CMS7
         KCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741105954; x=1741710754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jc0fHINLgpRpFjBoumMxo+EFHaGqMPVtOaRHH1CUD+c=;
        b=fTU8e55y2zEtnaMvWHW5cTC2zLguJGKGSWXj8G5QBbpMHc/9tkBftA26x1RAXtnxAg
         PPVWF4KzWWhe1GiCGGjY2aLcfiEjUtI6DoPnoREMH3EuESNqlWIru8suftl3BlPAvs50
         K8S4V3DbRsmYzzPt6Y2uvKayaM+JS8kEODs7XGzp3cKpTQYZ6/cEtqkf8WI0V/ytsj5F
         nFbI6lDAcLcH/DVPVsIeTL4iHluzT81Tvyb3jHUpsxrUUvL5yxdt7lwsE872oSviMRWW
         g87ZWdAYtG5l2OPJvZYOOGcjm8pw5Dh3fyHvjSsx3EbWQ508ZLrOm/2iRMGyJEsfHAo4
         f7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/jRixSYLYh+QUbWgvjqfkoLeTPA6Kie4wQQFro9tHi078luI+jmeXMtLHckrKK7/o+maMEq/dNm0g@lists.infradead.org
X-Gm-Message-State: AOJu0YxjXz1dTF4/kmbR1csd4w/gJ8zaFNSWY8kIzgtgFMRjPPo7bJPc
	MBUcfEgDibA4au7bpnKCI/NNCE8tu73refI0gQJ2uf8g1bSMGL9PncjsDo3uBz01sQT/6UYxhiK
	wMH8=
X-Gm-Gg: ASbGncvV42VDD/F0Wijyjh/ga439x7+8G506025RmOk0G4BbRqFvMFpJZZO5sKv89U7
	50GmhICjeOcFG4JOtYsppk4MAEY4IqBzgrmC9pnHnSm76k/86pVJ24Mg7rTZbi3cWbT6M80tEQV
	9U3Y7mcGH4Ab5aG0S6G4Gnegu/65vSoJB9FfQPCKZMg09yCxIYLDKovTR6rDWA5jjLkDEjvL2Ij
	zaNRIQ70D9mgrWJLTc4B1F6RYNK+LDSR03ibitHg/chSv6MACBogD4TFCP6ALmzcg46k5utnlpq
	QXaYcvJSEpgcuAcPrJ0ic1bB3gGwZ3vbgMcipAVATApEY21JJHhzm1bRRteV50UuIBQumTR6d2q
	BsNaMrCcyvsHuSwY=
X-Google-Smtp-Source: AGHT+IE9XHPKCWYKHmfXqhIFhQbBA+5LnUK+LBGTEc5R7+PxSq+ocpU3+RvEvLUOWl1sPoOEowzQ0Q==
X-Received: by 2002:a05:6000:154e:b0:390:fe2d:3172 with SMTP id ffacd0b85a97d-391155fa457mr3008728f8f.3.1741105953921;
        Tue, 04 Mar 2025 08:32:33 -0800 (PST)
Received: from [192.168.178.47] (aftr-62-216-202-126.dynamic.mnet-online.de. [62.216.202.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7a2asm18282891f8f.37.2025.03.04.08.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:32:33 -0800 (PST)
Message-ID: <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
Date: Tue, 4 Mar 2025 17:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
 <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <Z8cm5bVJsbskj4kC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_163236_935539_F34F8C8E 
X-CRM114-Status: GOOD (  26.14  )
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

On 3/4/25 17:14, Matthew Wilcox wrote:
> On Tue, Mar 04, 2025 at 11:26:07AM +0100, Vlastimil Babka wrote:
>> +Cc NETWORKING [TLS] maintainers and netdev for input, thanks.
>>
>> The full error is here:
>> https://lore.kernel.org/all/fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de/
>>
>> On 3/4/25 11:20, Hannes Reinecke wrote:
>>> On 3/4/25 09:18, Vlastimil Babka wrote:
>>>> On 3/4/25 08:58, Hannes Reinecke wrote:
>>>>> On 3/3/25 23:02, Vlastimil Babka wrote:
>>>>>> Also make sure you have CONFIG_DEBUG_VM please.
>>>>>>
>>>>> Here you go:
>>>>>
>>>>> [  134.506802] page: refcount:0 mapcount:0 mapping:0000000000000000
>>>>> index:0x0 pfn:0x101ef8
>>>>> [  134.509253] head: order:3 mapcount:0 entire_mapcount:0
>>>>> nr_pages_mapped:0 pincount:0
>>>>> [  134.511594] flags:
>>>>> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>>>>> [  134.513556] page_type: f5(slab)
>>>>> [  134.513563] raw: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>>>>> ffff8881000402f0
>>>>> [  134.513568] raw: 0000000000000000 00000000000a000a 00000000f5000000
>>>>> 0000000000000000
>>>>> [  134.513572] head: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>>>>> ffff8881000402f0
>>>>> [  134.513575] head: 0000000000000000 00000000000a000a 00000000f5000000
>>>>> 0000000000000000
>>>>> [  134.513579] head: 0017ffffc0000003 ffffea000407be01 ffffffffffffffff
>>>>> 0000000000000000
>>>>> [  134.513583] head: 0000000000000008 0000000000000000 00000000ffffffff
>>>>> 0000000000000000
>>>>> [  134.513585] page dumped because: VM_BUG_ON_FOLIO(((unsigned int)
>>>>> folio_ref_count(folio) + 127u <= 127u))
>>>>> [  134.513615] ------------[ cut here ]------------
>>>>> [  134.529822] kernel BUG at ./include/linux/mm.h:1455!
>>>>
>>>> Yeah, just as I suspected, folio_get() says the refcount is 0.
> 
> ... and it has a page_type of f5 (slab)
> 
>>>>> [  134.554509] Call Trace:
>>>>> [  134.580282]  iov_iter_get_pages2+0x19/0x30
>>>>
>>>> Presumably that's __iov_iter_get_pages_alloc() doing get_page() either in
>>>> the " if (iov_iter_is_bvec(i)) " branch or via iter_folioq_get_pages()?
> 
> It's the bvec path:
> 
>                  iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> 
>>>> Which doesn't work for a sub-size kmalloc() from a slab folio, which after
>>>> the frozen refcount conversion no longer supports get_page().
>>>>
>>>> The question is if this is a mistake specific for this path that's easy to
>>>> fix or there are more paths that do this. At the very least the pinning of
>>>> page through a kmalloc() allocation from it is useless - the object itself
>>>> has to be kfree()'d and that would never happen through a put_page()
>>>> reaching zero.
>>>>
>>> Looks like a specific mistake.
>>> tls_sw is the only user of sk_msg_zerocopy_from_iter()
>>> (which is calling into __iov_iter_get_pages_alloc()).
>>>
>>> And, more to the point, tls_sw messes up iov pacing coming in from
>>> the upper layers.
>>> So even if the upper layers send individual iovs (where each iov might
>>> contain different allocation types), tls_sw is packing them together
>>> into full records. So it might end up with iovs having _different_
>>> allocations.
>>> Which would explain why we only see it with TLS, but not with normal
>>> connections.
> 
> I thought we'd done all the work needed to get rid of these pointless
> refcount bumps.  Turns out that's only on the block side (eg commit
> e4cc64657bec).  So what does networking need in order to understand
> that some iovecs do not need to mess with the refcount?

The network stack needs to get hold of the page while transmission is 
ongoing, as there is potentially rather deep queueing involved,
requiring several calls to sendmsg() and friends before the page is 
finally transmitted. And maybe some post-processing (checksums,
digests, you name it), too, all of which require the page to be there.

It's all so jumbled up ... personally, I would _love_ to do away with
__iov_iter_get_pages_alloc(). Allocating a page array? Seriously?

And the problem with that is that it's always takes a page(!) reference,
completely oblivious to the fact whether you even _can_ take a page 
reference (eg for tail pages); we've hit this problem several times now
(check for sendpage_ok() ...).

But that's not the real issue; real issue is that the page reference is
taken down in the very bowels of __iov_iter_get_pages_alloc(), but needs
to be undone by the _caller_. Who might (or might not) have an idea
that he needs to drop the reference here.
That's why there is no straightforward conversion; you need to audit
each and every caller and try to find out where the page reference (if 
any) is dropped.
Bah.

Can't we (at the very least) leave it to the caller of 
__iov_iter_get_pages() to get a page reference (he has access to the 
page array, after all ...)? That would make the interface slightly
better, and it'll be far more obvious to the caller what needs
to be done.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

