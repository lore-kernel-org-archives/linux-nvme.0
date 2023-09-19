Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0340CD54B5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 11:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hoyPJF523kNlJQvch912qZHv5OTTDRWFhenbvIswjaA=; b=bpu9Egb+jcRnPudpPK9Qr1BcZo
	v7/Fy4gk05vmlTu8oKKedDYW3M7N73N9aqHMdMICAURcwZBqWQ9if93F7MRmL4nUv6nzNxCMjOxYc
	kvX/hKTZ9IPBWqeTLWYkt3/LyDFm+1vNjte2IJgSmJIMGn49BaTkUpYNWdJgXZHYQF9Hn1sFH/Gsh
	9SX6X0pGl8fr4WUtkJs5WOfwlKBPfiKqv40NYdiUT0jIk+4ZzFkMJ1ftATnhjy6Ux9MjWP8VDRjGd
	1zebbcTzERNu+4TvZKbHMxuKp9q6AcTzhC2+XSjU381w2fYmClKL+zLLtVdq+KqONHy/QC5zBIwoZ
	uXT6lAWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiZ9l-000KDx-06;
	Tue, 19 Sep 2023 11:44:41 +0000
Received: from domac.alu.unizg.hr ([161.53.235.3] helo=domac.alu.hr)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiZ9i-000KAT-0L
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 11:44:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 1337D60173;
	Tue, 19 Sep 2023 13:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
	t=1695123867; bh=R4zE8eMPjuUOaCwfRsjqIdOLLocNdjk0b1Esnw4mmJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ttKmYOTJgHktlhgxKta2KcZh9iJjhVSjpzLtxh8EukggzFpxluS3QIGxlCCuT47ds
	 6RILjdZmc1qg4v3TOEtSYacMv1jCJrQ5tWlFTlKhO1YsrsHaeojjZpCKnUF6HtgDly
	 FSYQHDMHrslEW3z5XIIYWKFlZhNEgXdW7Wkc0cUyiLJ/MAezxwr4eAyvzsrZGXWte4
	 wKEwNvT0ZRxjHvuEYBabbs9Oa2lHicp0Z/YVxHGkdo9OZwq5a1epjhRc0oNviliZoJ
	 TjJTvWN3ppVikygvpnT7FALboJyD8OYxIfKTVN9RZVPWFzHzMB/K7zhCSC6AQriaYf
	 NQcWHXgaGLJ9A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0StH1V1M6SlU; Tue, 19 Sep 2023 13:44:24 +0200 (CEST)
Received: from [IPV6:2001:b68:2:2600:847a:a5b8:fda0:5de5] (unknown [IPv6:2001:b68:2:2600:847a:a5b8:fda0:5de5])
	by domac.alu.hr (Postfix) with ESMTPSA id B351360157;
	Tue, 19 Sep 2023 13:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1695123864; bh=R4zE8eMPjuUOaCwfRsjqIdOLLocNdjk0b1Esnw4mmJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=djvULSYtqp+qfPMTus3D0NCsJubztH9dXVR0Z7tnEuXgeurWiIfCFO5TtNaAxHQaM
	 iuwmMmoTV8Wn0/OgiRXDR04hgpnxVmxI8zxJiglXuF61QbleHIBK6wfFZs8b9T4aku
	 1es9Jd4x0DPUlvyp2FhjXlUq9fI+tc+C67HyytP3FDRzXvkPMPvtS4WPceO0dYBdh1
	 584LPdCawzpxGCSFGkjToxw0TjsFoDWhpqqaQCDrIX4h7p9KuQKhrI90LIi2vhbQUO
	 zHOTYUR3XLBxv6UVz0nZ+UDW9KwpIsxFYyMw1dexe17Q/lnArYDg3ARchPa+tp8dRh
	 PK40T2ZOfzELA==
Message-ID: <5716ec93-e6c6-4286-ad7d-9fe6faa68c7e@alu.unizg.hr>
Date: Tue, 19 Sep 2023 13:44:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: KCSAN: data-race in folio_batch_move_lru / mpage_read_end_io
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>,
 Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <cbb9d596-43ac-bad4-b6f6-8c13f95d244e@alu.unizg.hr>
 <ZPCpQQVTtlB0FA5A@casper.infradead.org>
 <ZPs8+sLv5oaubrKj@casper.infradead.org>
 <22a42774-ebe1-081a-c9b9-e11f4d74bc3a@alu.unizg.hr>
 <ZQhkfIqwcuTrKxK+@casper.infradead.org>
From: Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <ZQhkfIqwcuTrKxK+@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_044438_325567_21E2F3A4 
X-CRM114-Status: GOOD (  20.47  )
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

On 9/18/2023 4:53 PM, Matthew Wilcox wrote:

> On Mon, Sep 18, 2023 at 02:15:05PM +0200, Mirsad Todorovac wrote:
>>> This is what I'm currently running with, and it doesn't trigger.
>>> I'd expect it to if we were going to hit the KCSAN bug.
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 0c5be12f9336..d22e8798c326 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -4439,6 +4439,7 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
>>>    	page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
>>>    out:
>>> +	VM_BUG_ON_PAGE(page && (page->flags & (PAGE_FLAGS_CHECK_AT_PREP &~ (1 << PG_head))), page);
>>>    	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>>>    	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
>>>    		__free_pages(page, order);
>> Hi,
>>
>> Caught another instance of this bug involving folio_batch_move_lru: I don't seem that I can make it
>> happen reliably by the nature of the data racing conditions if I understood them well.
> Were you running with this patch at the time, or was this actually
> vanilla?  The problem is that, if my diagnosis is correct, both of the
> tasks mentioned are victims; we have a prematurely freed page.  While
> btrfs is clearly a user, it may not be btrfs's fault that the
> page was also allocated as an anon page.
>
> I'm trying to gather more data, and running with this patch will give
> us more -- because it'll dump the entire struct page instead of just
> the page->flags, like KCSAN is currently doing.

Hi, Mr. Matthew,

Yes, I am using "vanilla with your VM_BUG_ON_PAGE()" patch all the time, 
as it seems non-disruptive and I am hoping to catch this spurious page 
alloc.

Best regards, Mirsad Todorovac


