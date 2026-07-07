Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA1BC43602
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2026 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kAbzOhSpBup51V3SsMfK3exDEEwOqma51KRW8M3oE54=; b=KvniDb+RQmillYxtzBTBz0mOe1
	o4CYYs+5JJ5s5XvjgAl0h0UoUY9y/Se0u0j05rG3HczZ++t/fz1tDeg3BzfRpggsm3lQx0apZn67J
	nNVm0ok965ZPDQ4NA4gJWQbAImsquQP/KUJK44pLrm3Vyiy48s2yfUsMvZ9wPulz1s9CqcdUufvY7
	gPCT53mYV+lUtVxFhPamLRpuU7hVUiElGn1RwAgxlz6Lyj4nwSbX1fOrTqAr074qykYpbUOZamgKu
	AJj8uOPRj/FcDmP9ou7m0SMnntlweiXmhb9qz36GaYnBbJj29UYSmPjsEG+S1CANUP7RjokT/lhj3
	0gW1fyyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh2Me-0000000Eers-1Dwd;
	Tue, 07 Jul 2026 09:45:16 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh2Mb-0000000EerN-2fuY
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 09:45:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783417507; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kAbzOhSpBup51V3SsMfK3exDEEwOqma51KRW8M3oE54=;
	b=Fi9JstslOw+GZoQZLd2VBgFIuSQzsDA6CEyi4510/EfDzFh53VB0BCxZZ7OfjDOX5+m4XHWcBqoHM8bwfea1081jog0reqWuctgn1aihkrItiFcz27cH6gN/u3qOEEDIP4cpgUZZOAPOuq/v9EXF+J+0x/MFx0H0EOmgKrlptvE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6d1oUl_1783417505;
Received: from 30.178.83.41(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6d1oUl_1783417505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jul 2026 17:45:06 +0800
Message-ID: <ef44efdb-dbc3-40ea-8bae-743e6f93884a@linux.alibaba.com>
Date: Tue, 7 Jul 2026 17:45:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add missing NVMe documentation files
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260706023439.3054578-1-kanie@linux.alibaba.com>
 <20260706023439.3054578-4-kanie@linux.alibaba.com>
 <ba0bd2f7-48e2-4a79-ae92-4c856c991d62@flourine.local>
 <d7a0a987-3b79-4c94-ab42-2044556c835e@linux.alibaba.com>
 <7f5a765a-1f2b-4d67-b03d-f2cd7c73218c@flourine.local>
 <fb23530e-3b0c-4993-ac98-d7c1ba3f5986@linux.alibaba.com>
 <e2ac204c-83bf-4738-bbed-a1fffc98a678@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <e2ac204c-83bf-4738-bbed-a1fffc98a678@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_024514_010335_E9E05070 
X-CRM114-Status: UNSURE (   6.75  )
X-CRM114-Notice: Please train this message.
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



在 2026/7/7 17:20, Daniel Wagner 写道:
> On Tue, Jul 07, 2026 at 09:40:01AM +0800, Guixin Liu wrote:
>>>> so I've put them all under the testing directory for now.
>>> The NVMe APIs are definitely not in the 'testing' section. The nvmet
>>> APIs are also not in 'testing', IMO. While they are used upstream
>>> predominantly by blktests, there are also people out there using them in
>>> production systems, if we like or not.
>> You mean we can put them all under stable directory?
> Exactly, let's go ahead and put them under the stable directory.
OK，changed in v4.

Best Regards,
Guixin Liu


