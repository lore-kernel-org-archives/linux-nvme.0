Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274F5C636D7
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Feb 2023 02:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vheMgIeyBmFp8M+KRFI7nxqQK7jpJFBeI07QhK/zr4A=; b=p7dLqGxlEq1tzgj+0bFkLH/zNN
	gOao1S72ITntj540z6RjgoLW5akvNi7x1a61xh6s0c0Be6k0MyVP4wkvaco/fiK5BIfeZYYZq9LqW
	9CJ5bU1DSyBKyumuC+juOWNJKfUWx86YpvyeEeEdGQf3iCe9SNM62s9jUuA4pexxFmtNwjkZJwdAk
	UUbOSo42Tlwp4Fbcyrqy21xnCWTM/WNMxj3Ij6eMY2gq5+D8u5OO6KAognCuIK09mWlTxbPU3r3Sh
	kwWcSTOFosIuB7XSpSlDscNGlkbIqeBm4RQoUdAxSLIPbMviSf/1Q9MAWSTMQlYJc0EJQiIVVbeMx
	u6OA1HLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUf3J-00AR5B-3P; Wed, 22 Feb 2023 02:40:17 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUf3F-00AR3u-Sy
	for linux-nvme@lists.infradead.org; Wed, 22 Feb 2023 02:40:15 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VcEfCHA_1677033609;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcEfCHA_1677033609)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 10:40:10 +0800
Message-ID: <a328da48-a5aa-c31b-074c-d52132997afd@linux.alibaba.com>
Date: Wed, 22 Feb 2023 10:40:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Yang Shi <shy828301@gmail.com>, Mel Gorman <mgorman@techsingularity.net>
Cc: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
 <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <CAHbLzkqsyv6rw-RRvNcB0PoEE75qS9ZtmywhJYZbVA05d5tj5A@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHbLzkqsyv6rw-RRvNcB0PoEE75qS9ZtmywhJYZbVA05d5tj5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_184014_156211_24D61996 
X-CRM114-Status: GOOD (  16.66  )
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



On 2023/2/22 03:09, Yang Shi wrote:
> On Tue, Feb 21, 2023 at 10:08 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2023/1/27 00:40, Matthew Wilcox wrote:
>>> I'd like to do another session on how the struct page dismemberment
>>> is going and what remains to be done.  Given how widely struct page is
>>> used, I think there will be interest from more than just MM, so I'd
>>> suggest a plenary session.
>>>
>>> If I were hosting this session today, topics would include:
>>>
>>> Splitting out users:
>>>
>>>    - slab (done!)
>>>    - netmem (in progress)
>>>    - hugetlb (in akpm)
>>>    - tail pages (in akpm)
>>>    - page tables
>>>    - ZONE_DEVICE
>>>
>>> Users that really should have their own types:
>>>
>>>    - zsmalloc
>>>    - bootmem
>>>    - percpu
>>>    - buddy
>>>    - vmalloc
>>>
>>> Converting filesystems to folios:
>>>
>>>    - XFS (done)
>>>    - AFS (done)
>>>    - NFS (in progress)
>>>    - ext4 (in progress)
>>>    - f2fs (in progress)
>>>    - ... others?
>>>
>>> Unresolved challenges:
>>>
>>>    - mapcount
>>>    - AnonExclusive
>>>    - Splitting anon & file folios apart
>>>    - Removing PG_error & PG_private
>>
>> I'm interested in this topic too, also I'd like to get some idea of the
>> future of the page dismemberment timeline so that I can have time to keep
>> the pace with it since some embedded use cases like Android are
>> memory-sensitive all the time.
>>
>> Minor, it seems some apis still use ->lru field to chain bulk pages,
>> perhaps it needs some changes as well:
>> https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
>> https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com
> 
> The dm-crypt patches don't use list anymore. The bulk allocator still
> supports the list version, but so far there is no user, so it may be
> gone soon.

Thanks, it's just a detailed minor stuff relating to page->lru.  Currently
I'm no rush to evaluate/use it.

> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> This will probably all change before May.
>>>
>>> I'd like to nominate Vishal Moola & Sidhartha Kumar as invitees based on
>>> their work to convert various functions from pages to folios.
>>

