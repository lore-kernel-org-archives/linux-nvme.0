Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C84C282D9
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Mar 2025 10:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mM6uhVuxdq3yTuuEuc4jtPzNlL9cRg4isSUjeaJbmAs=; b=I36s60vZCVFnIDXDz43m99IJFX
	hCWXsMRHEBHkpUsesvr/i+03YN1xEIqK+0WvRe0LvEiR/jAv25nLRjlRdRUpTb0nHoI9rAd9hmV6W
	kWnLgpOFCPw65tKnXRkooqUgyXHQoqxGLgjLmA9QmL7W1qY1STH1303Adco0eRGggo1iI0yVhhJhf
	y+9zS1aBu969Lq/Xi/AOlW0G20CQqGXZcobv1cO182xTZzHPZMMYuiVO8BZo30i36IyW5xJLd/U+h
	T4zrFlhSbpGPVMCgHClPErTVNef3qvw0MaqwFKIuoCe9UuEeEj0UlAYm9Vm0XOdM2znWHPwHRz0LE
	UFndXF6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpPci-00000004B7I-1NJg;
	Tue, 04 Mar 2025 10:35:40 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpPNp-000000046Nt-3Q0V
	for linux-nvme@lists.infradead.org;
	Tue, 04 Mar 2025 10:20:19 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-390d98ae34dso4409926f8f.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Mar 2025 02:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741083615; x=1741688415; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mM6uhVuxdq3yTuuEuc4jtPzNlL9cRg4isSUjeaJbmAs=;
        b=UTxKmx68IgxT0a2xWP0gy//V7FgJExAv19pqvtFS3tjBpoGLbsjjRmKvpa/4YSNO8i
         fLMeysGTmIehLJuJfa6D9Dd1ywR+bsjboD8ZgG3C1rKme26rBwbIK6uVoI01eWn2p7ht
         /IFtfyNDd6xo8NrUrh97WRwIfSP1n5D0r1dVEwTz8a1n4RinKVW53avqxdscI8D2l7wy
         A1uaf1+BY6AEm29QRehUHdxhKSHw6H31mRvXpBTKqoib34KrtJpMILsTjKXVFVTBtOPq
         Y6waBjQQBPQV4ERoG/hefUP9q+KbVyfbS7c/xVz9+PTDrREJixJKCJxEay5u48iTTmr0
         Zm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741083615; x=1741688415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mM6uhVuxdq3yTuuEuc4jtPzNlL9cRg4isSUjeaJbmAs=;
        b=DG4eCMVr1N7hEbaSi8OxvrUDBTQKTm52On2wbEdvYF75RoplLxXSRZOCWVPSDkQj7d
         agcbIT9pQtrNrFJrNQWRFiwD/lsYL4Ry18NoZMs0kDXo95LJ3THremTzI1V5qd2GxnzV
         umn8InCpRKAqmTJWhI/s6aAheqcYTiKTN/ar0LG7B81dX/4KvLvI4S5co0bjVj9Cu6BU
         KVu0w6LSnLV07QegHwHv2UB5fI5XIjiMo9EgveHkXq3NG4JzLEcUN5GFFENCMRhyTg7H
         b15Y0WB9J6n7QOatBb7nEOVYgyQx9aav9ScxuyC9IHQOCTALQ3F9kSgauEmRgBC0jre3
         L5uA==
X-Forwarded-Encrypted: i=1; AJvYcCW0H0jSvYyda2dWM2N/eXI9m1RRzSqO8Ct0dxC/4Yv4wjhQ0jS2HRaRbLJevx/ErPgLNgovjjJXUj/3@lists.infradead.org
X-Gm-Message-State: AOJu0YwPaAwubCySZG4OL4tXJs3tsMR5QFtz8IbpYHlr4ADShBALcWA1
	Yr4f/pvJNsQY2ecLN0GLJcZbNrg+/t9myPQ40gbBmTA9kpjruHebnjGF3ooWuuM=
X-Gm-Gg: ASbGncs6fwY3I3Dy89Hot41l5kVfQ8DHQnawmaA+DPu9xitXiV5SoWjt+mPmfE9R+9W
	riUOhnc4Z1FilQ9IRFeb8Ebyfjw9zzeTgcIiLcOgunf81KuuKHXYJm8q872Vm+J0TPhNihj2AiM
	/IGVJA60thK5i8eP7GRLMHwcCZkBAZAzvo7wPhVJIxBY9vgA2U+BTpET2EEJnUJxS6C0I1gaomP
	oDl9sZcv56r04sTK/r88QUOEzx9py8t8LpJ2KnsZCTwQxpAaUkrcxiC83wDWhkMAAC3Zcl549OH
	gXmJCWfz7M71WaP70AGDEjJE0LAJh+jdziH4TJNMCqcHSHQdai6JA9vKai281ukk0Fj5YA==
X-Google-Smtp-Source: AGHT+IEJYUHkHpDXnLexQIZ1xTZQsresalMyN3ct2lfKJwO55dx4NW2ku8asHz4sUsXDXgCX8DGrmg==
X-Received: by 2002:a5d:584d:0:b0:391:12a5:3cb3 with SMTP id ffacd0b85a97d-39112a53f00mr4610609f8f.3.1741083615391;
        Tue, 04 Mar 2025 02:20:15 -0800 (PST)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? (megane.afterburst.com. [2a01:4a0:11::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73703caesm189761065e9.12.2025.03.04.02.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 02:20:15 -0800 (PST)
Message-ID: <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
Date: Tue, 4 Mar 2025 11:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Vlastimil Babka <vbabka@suse.cz>, Hannes Reinecke <hare@suse.de>,
 Matthew Wilcox <willy@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>
References: <08c29e4b-2f71-4b6d-8046-27e407214d8c@suse.com>
 <509dd4d3-85e9-40b2-a967-8c937909a1bf@suse.com>
 <Z8W8OtJYFzr9OQac@casper.infradead.org>
 <Z8W_1l7lCFqMiwXV@casper.infradead.org>
 <15be2446-f096-45b9-aaf3-b371a694049d@suse.com>
 <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250304_022017_855299_E72A717A 
X-CRM114-Status: GOOD (  19.29  )
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

On 3/4/25 09:18, Vlastimil Babka wrote:
> On 3/4/25 08:58, Hannes Reinecke wrote:
>> On 3/3/25 23:02, Vlastimil Babka wrote:
>>> On 3/3/25 17:15, Vlastimil Babka wrote:
>>>> On 3/3/25 16:48, Matthew Wilcox wrote:
>>>>> You need to turn on the debugging options Vlastimil mentioned and try to
>>>>> figure out what nvme is doing wrong.
>>>>
>>>> Agree, looks like some error path going wrong?
>>>> Since there seems to be actual non-large kmalloc usage involved, another
>>>> debug parameter that could help: CONFIG_SLUB_DEBUG=y, and boot with
>>>> "slab_debug=FZPU,kmalloc-*"
>>>
>>> Also make sure you have CONFIG_DEBUG_VM please.
>>>
>> Here you go:
>>
>> [  134.506802] page: refcount:0 mapcount:0 mapping:0000000000000000
>> index:0x0 pfn:0x101ef8
>> [  134.509253] head: order:3 mapcount:0 entire_mapcount:0
>> nr_pages_mapped:0 pincount:0
>> [  134.511594] flags:
>> 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
>> [  134.513556] page_type: f5(slab)
>> [  134.513563] raw: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>> ffff8881000402f0
>> [  134.513568] raw: 0000000000000000 00000000000a000a 00000000f5000000
>> 0000000000000000
>> [  134.513572] head: 0017ffffc0000040 ffff888100041b00 ffffea0004a90810
>> ffff8881000402f0
>> [  134.513575] head: 0000000000000000 00000000000a000a 00000000f5000000
>> 0000000000000000
>> [  134.513579] head: 0017ffffc0000003 ffffea000407be01 ffffffffffffffff
>> 0000000000000000
>> [  134.513583] head: 0000000000000008 0000000000000000 00000000ffffffff
>> 0000000000000000
>> [  134.513585] page dumped because: VM_BUG_ON_FOLIO(((unsigned int)
>> folio_ref_count(folio) + 127u <= 127u))
>> [  134.513615] ------------[ cut here ]------------
>> [  134.529822] kernel BUG at ./include/linux/mm.h:1455!
> 
> Yeah, just as I suspected, folio_get() says the refcount is 0.
> 
>> [  134.529835] Oops: invalid opcode: 0000 [#1] PREEMPT SMP
>> DEBUG_PAGEALLOC NOPTI
>> [  134.529843] CPU: 0 UID: 0 PID: 274 Comm: kworker/0:1H Kdump: loaded
>> Tainted: G            E      6.14.0-rc4-default+ #309
>> 03b131f1ef70944969b40df9d90a283ed638556f
>> [  134.536577] Tainted: [E]=UNSIGNED_MODULE
>> [  134.536580] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> 0.0.0 02/06/2015
>> [  134.536583] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>> [  134.536595] RIP: 0010:__iov_iter_get_pages_alloc+0x676/0x710
>> [  134.542810] Code: e8 4c 39 e0 49 0f 47 c4 48 01 45 08 48 29 45 18 e9
>> 90 fa ff ff 48 83 ef 01 e9 7f fe ff ff 48 c7 c6 40 57 4f 82 e8 6a e2 ce
>> ff <0f> 0b e8 43 b8 b1 ff eb c5 f7 c1 ff 0f 00 00 48 89 cf 0f 85 4f ff
>> [  134.542816] RSP: 0018:ffffc900004579d8 EFLAGS: 00010282
>> [  134.542821] RAX: 000000000000005c RBX: ffffc90000457a90 RCX:
>> 0000000000000027
>> [  134.542825] RDX: 0000000000000000 RSI: 0000000000000002 RDI:
>> ffff88817f423748
>> [  134.542828] RBP: ffffc90000457d60 R08: 0000000000000000 R09:
>> 0000000000000001
>> [  134.554485] R10: ffffc900004579c0 R11: ffffc90000457720 R12:
>> 0000000000000000
>> [  134.554488] R13: ffffea000407be40 R14: ffffc90000457a70 R15:
>> ffffc90000457d60
>> [  134.554495] FS:  0000000000000000(0000) GS:ffff88817f400000(0000)
>> knlGS:0000000000000000
>> [  134.554499] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  134.554502] CR2: 0000556b0675b600 CR3: 0000000106bd8000 CR4:
>> 0000000000350ef0
>> [  134.554509] Call Trace:
>> [  134.554512]  <TASK>
>> [  134.554516]  ? __die_body+0x1a/0x60
>> [  134.554525]  ? die+0x38/0x60
>> [  134.554531]  ? do_trap+0x10f/0x120
>> [  134.554538]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.568839]  ? do_error_trap+0x64/0xa0
>> [  134.568847]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.568855]  ? exc_invalid_op+0x53/0x60
>> [  134.572489]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.572496]  ? asm_exc_invalid_op+0x16/0x20
>> [  134.572512]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.576726]  ? __iov_iter_get_pages_alloc+0x676/0x710
>> [  134.576733]  ? srso_return_thunk+0x5/0x5f
>> [  134.576740]  ? ___slab_alloc+0x924/0xb60
>> [  134.580253]  ? mempool_alloc_noprof+0x41/0x190
>> [  134.580262]  ? tls_get_rec+0x3d/0x1b0 [tls
>> 47f199c97f69357468c91efdbba24395e9dbfa77]
>> [  134.580282]  iov_iter_get_pages2+0x19/0x30
> 
> Presumably that's __iov_iter_get_pages_alloc() doing get_page() either in
> the " if (iov_iter_is_bvec(i)) " branch or via iter_folioq_get_pages()?
> 
Looks like it.

> Which doesn't work for a sub-size kmalloc() from a slab folio, which after
> the frozen refcount conversion no longer supports get_page().
> 
> The question is if this is a mistake specific for this path that's easy to
> fix or there are more paths that do this. At the very least the pinning of
> page through a kmalloc() allocation from it is useless - the object itself
> has to be kfree()'d and that would never happen through a put_page()
> reaching zero.
> 
Looks like a specific mistake.
tls_sw is the only user of sk_msg_zerocopy_from_iter()
(which is calling into __iov_iter_get_pages_alloc()).

And, more to the point, tls_sw messes up iov pacing coming in from
the upper layers.
So even if the upper layers send individual iovs (where each iov might
contain different allocation types), tls_sw is packing them together 
into full records. So it might end up with iovs having _different_ 
allocations.
Which would explain why we only see it with TLS, but not with normal
connections.

Or so my reasoning goes. Not sure if that's correct.

So I'd be happy with an 'easy' fix for now. Obviously :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

