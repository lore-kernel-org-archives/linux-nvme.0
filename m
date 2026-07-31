Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE31C55162
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 02:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vcqqfPYtfXrrlcbqu6/axTQddIyRHBUGHo7H+Ol1//Y=; b=wzTK/aZ8fYUw6nD1QmPz1GQ/JG
	GPj1rmALXdBZ/Jtg5fzVEerek2FP8iT+shcxfXO6vB48HpivbUsGwD8byhswK8ogJ1otQTg/p0IQc
	UY/mpPWFmLHkITFKdPLXp46AafzGinIsSRa6kdGLu1gl5Z3iGPYVUGK9cy6+0HSU/189S6Z8JuHOZ
	RKwMkbPZYNf1u+u1xtXfTnDGtUw+NoLKC+gWsn2OEgAJKtRnAAvgiiXAPtP90CjDxPMOnwufSZnjY
	u9l0RMkYQL4EJ5pkT/K5Z4bTTTrXFEXRDcrCvapOvZimwLxLMVVKKCHat4t0/UpULI/FxzJTRt4VH
	nq3Sy1yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpcYU-0000000BbZ5-2dMa;
	Fri, 31 Jul 2026 02:00:58 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpcYR-0000000BbYj-1KW9
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 02:00:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785463253; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vcqqfPYtfXrrlcbqu6/axTQddIyRHBUGHo7H+Ol1//Y=;
	b=gmK6m5gkCKrdTT4QNNqzDaqAmw/HNXVHnFwMZhy2C9Y9+5D2gOFvFQsB7ilbQIgxDAbF01wdQtj/Cup2J0/FjuRenZgKKIQdQ0mjtX4gJ6/KoXn3V+KG60IiK4mKJHL+6/awT3LmtN3z2rGztPPmwl1ARajPWmdefYo2m4jiGFA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X86N3KP_1785463251;
Received: from 30.178.83.106(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86N3KP_1785463251 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 10:00:52 +0800
Message-ID: <6ff44228-8ed1-44e1-a5a8-6d579f9f206f@linux.alibaba.com>
Date: Fri, 31 Jul 2026 10:00:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: clamp FDP placement handle count to the buffer
 size
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Nilay Shroff <nilay@linux.ibm.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
 <CGME20260730051151epcas5p1c47d82291b2bd4437fcf14e7816c4c8e@epcas5p1.samsung.com>
 <20260730043105.3071328-5-kanie@linux.alibaba.com>
 <749b4476-6d8c-4573-b51b-662b0ff57db3@samsung.com>
 <20260730113722.GD25454@lst.de> <amtGXbjK7Vticrnq@kbusch-mbp>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <amtGXbjK7Vticrnq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_190055_643469_F4514F43 
X-CRM114-Status: GOOD (  11.45  )
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



在 2026/7/30 20:41, Keith Busch 写道:
> On Thu, Jul 30, 2026 at 01:37:22PM +0200, Christoph Hellwig wrote:
>> On Thu, Jul 30, 2026 at 03:10:59PM +0530, Kanchan Joshi wrote:
>>> But I feel the need to improve (what we have) with a follow-up patch:
>>> 1. Revise the cap, from S8_MAX - 1 to U8_MAX; since bio->bi_write_hint
>>> is u8.
>> Signed 8-bit -1 is indeed a really odd value, and from looking at the
>> original commit I'm not really sure how we arrived there.
> "S8_MAX - 1" is a weird way to represent it, but the reason that value
> was used (and it's admittedly not a good reason) was that the result
> fits in a page. Not that there's any restriction on admin commands using
> PRP lists; it's just a coincidental limit for all the driver initiated
> admin commands.
I will send another patch build on top of the patch4 to:
   1. Change "S8_MAX -1" to U8_MAX
   2.  Add a warning log

Best Regards,
Guixin Liu


