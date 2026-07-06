Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960C7C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 09:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRL7pG9oS+Cc8gRoy9K4FqN1EbPMLhQ6QlGEGx+2a+g=; b=F7GLJ39tFNLhTdAiNSHkDs0f9y
	HX4ZSlTlBrFEoLPezVkJGXZpXPSyjv99MQGic6KVqYUTH79WmdsLzO/v1NmWf4fV78I6xbw5Iorjy
	GgoARoJVm2q2Zd/xK8OosRVxDEvf3Ce+S4iiFkq/fj9nCxVgsjgmQaoa6vkWdJxcXAui93Nc+mR6r
	9GWKsPdSTx4GILDCwnzLphbssc5Cg+fG6bXYqLA7tOoaBhaNocVpwlIrEUPuqaXWWGF3vaUA3j1oS
	DpMQQHy+gVCQPR6MlBsOhvGVE0/12nl+rog8t6rTlAtEpILM4tJ4Le3AW92wnDvD8DhfhHkIAB406
	N+H54LcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgg1o-0000000C72S-2fUi;
	Mon, 06 Jul 2026 09:54:16 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgg1l-0000000C71q-2Asx
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 09:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783331650; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BRL7pG9oS+Cc8gRoy9K4FqN1EbPMLhQ6QlGEGx+2a+g=;
	b=vN3BvAYAsEmUnJnp0dEsT3k3IWB+BMq1gJdNwO6IBxuQ1T+Hl6Ygi5l9sWqm7xaO1RILnNN3l1yj4isB69+2HZ26y1ODj7FhGkvmqptGV85KPVKEfGcF1mI9SFJdMH34ctCeF1H3zwAI5KHfjp08PCosTRVm1V01EfEAwGkHf2s=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6Tig-z_1783331648;
Received: from 30.178.84.17(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6Tig-z_1783331648 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 17:54:09 +0800
Message-ID: <d7a0a987-3b79-4c94-ab42-2044556c835e@linux.alibaba.com>
Date: Mon, 6 Jul 2026 17:54:07 +0800
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
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ba0bd2f7-48e2-4a79-ae92-4c856c991d62@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_025414_363675_4FD7B010 
X-CRM114-Status: UNSURE (   8.95  )
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



在 2026/7/6 15:50, Daniel Wagner 写道:
> On Mon, Jul 06, 2026 at 10:34:39AM +0800, Guixin Liu wrote:
>>   T:	git git://git.infradead.org/nvme.git
>> +F:	Documentation/ABI/testing/configfs-nvmet
>>   F:	drivers/nvme/target/
> Didn't catch this in the previous path, but why do think these API
> should be in testing section?

Some of these interfaces have been around for a long time,

while others were only added in recent versions.

I'm not sure what criteria to use for splitting them between stable and 
testing,

so I've put them all under the testing directory for now.

If the maintainers later feel that some of them are mature enough to 
move to stable,

we can split them out at that point.


Best Regards,

Guixin Liu



