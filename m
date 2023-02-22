Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA96C636D7
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Feb 2023 02:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/MJtiBiP40AwMd8vNU5uTZ3N/zDDyP/uL1fL9oDo8d4=; b=I1TO3BKAj0NkMhBZiKVyAyWpRk
	pBjqz8+wkl6spBQzdmd05XvsG0tlKpVsARu36huoXlo6/wCXUfkiBsRct0FPonbPaTpClpfxDGFWY
	HDy7etEghfP0j1N2vJTk+r9pXRb6i2hyU5/OfqSnjznzEz2ASfyjAp9SyrN8U5PDRypwOLB/oNvpA
	lmjOHI94yvmPdoN6xN80aowavaL4KdzI5DY+W5pInUOy5lV9FvrtS7yuilVq3as/yjUpaX1Li7IP1
	2v2guBxpsg8Pil9MDdOzBiZRueRgS/1RLu5WKuHtSQH3wjhklzFy+KpOz3QFIWKEcmPxpoGbm2cQT
	rD6HBbOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUf1W-00AQlo-Qf; Wed, 22 Feb 2023 02:38:26 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUf1P-00AQkt-QD
	for linux-nvme@lists.infradead.org; Wed, 22 Feb 2023 02:38:21 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VcEEUep_1677033493;
Received: from 30.97.49.34(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcEEUep_1677033493)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 10:38:14 +0800
Message-ID: <874be627-cb9e-bca6-4845-18dcd65f0f3f@linux.alibaba.com>
Date: Wed, 22 Feb 2023 10:38:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org
References: <Y9KtCc+4n5uANB2f@casper.infradead.org>
 <8448beac-a119-330d-a2af-fc3531bdb930@linux.alibaba.com>
 <Y/UiY/08MuA/tBku@casper.infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <Y/UiY/08MuA/tBku@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_183820_090789_06C2B42E 
X-CRM114-Status: GOOD (  28.59  )
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



On 2023/2/22 03:58, Matthew Wilcox wrote:
> On Wed, Feb 22, 2023 at 02:08:28AM +0800, Gao Xiang wrote:
>> On 2023/1/27 00:40, Matthew Wilcox wrote:
>>> I'd like to do another session on how the struct page dismemberment
>>> is going and what remains to be done.  Given how widely struct page is
>>> used, I think there will be interest from more than just MM, so I'd
>>> suggest a plenary session.
>>
>> I'm interested in this topic too, also I'd like to get some idea of the
>> future of the page dismemberment timeline so that I can have time to keep
>> the pace with it since some embedded use cases like Android are
>> memory-sensitive all the time.
> 
> As you all know, I'm absolutely amazing at project management & planning
> and can tell you to the day when a feature will be ready ;-)

yeah, but this core stuff actually impacts various subsystems, it would
be better to get some in advance otherwise I'm not sure if I could have
extra slots to handle these.

> 
> My goal for 2023 is to get to a point where we (a) have struct page
> reduced to:
> 
> struct page {
> 	unsigned long flags;
> 	struct list_head lru;
> 	struct address_space *mapping;
> 	pgoff_t index;
> 	unsigned long private;
> 	atomic_t _mapcount;
> 	atomic_t _refcount;
> 	unsigned long memcg_data;
> #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> 	int _last_cpupid;
> #endif
> };
> 
> and (b) can build an allnoconfig kernel with:
> 
> struct page {
> 	unsigned long flags;
> 	unsigned long padding[5];
> 	atomic_t _mapcount;
> 	atomic_t _refcount;
> 	unsigned long padding2;
> #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
> 	int _last_cpupid;
> #endif
> };

Okay, with the plan above, how to make it work with memdesc in the long
term?

Also in the future at least I'd like to know if it's possible / how to
get folio itself from page and how to know if some folio is actually
truncated or connected to some (or more) inodes.

Anyway, all of the above are interesting to me, and that could avoid
some extra useless folio adoption in the opposite direction.  Also I
could have more rough thoughts how to get page cache sharing work.

I could imagine many of them may be still in the preliminary form
for now, but some detailed plans would be much helpful.

> 
>> Minor, it seems some apis still use ->lru field to chain bulk pages,
>> perhaps it needs some changes as well:
>> https://lore.kernel.org/r/20221222124412.rpnl2vojnx7izoow@techsingularity.net
>> https://lore.kernel.org/r/20230214190221.1156876-2-shy828301@gmail.com
> 
> Yang Shi covered the actual (non-)use of the list version of the bulk
> allocator already, but perhaps more importantly, each page allocated
> by the bulk allocator is actually a separately tracked allocation.
> So the obvious translation of the bulk allocator from pages to folios
> is that it allocates N order-0 folios.
> 
> That may not be the best approach for all the users of the bulk allocator,
> so we may end up doing something different.  At any rate, use of page->lru
> isn't the problem here (yes, it's something that would need to change,
> but it's not a big conceptual problem).

Yes, I just would like to confirm how to use such apis in the long term.
Currently it's no rush for me but I tend to avoid using them in a vague
direction.

Thanks,
Gao Xiang


