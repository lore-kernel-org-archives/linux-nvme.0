Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C7FECAAD8
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Sep 2022 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+AO7U6rbzNweEuYBd2ieEx4GN79koF6S4GZfhXV5mc=; b=lMQvmYsKVcfjizoMGETpQHsedr
	e/ezyHAvjyUP5YRnaDoBP1YAPVoopuU3C/udAKzuXqkry4IRU8VL+FUI/r3LjeBiWnsF2+dgoRXU7
	oUG7Th11+NYExi31caWcb6T0ggE2vc2FgWY7775oTrk3a7w6LE2MPzbS9dT5wypOcSzuhMK4iryBo
	q08etJJlXXv8lE3IIF0V9uqxrvraitLCgZqy++GDapB5wo3dP6mcZZKm1KNhEjMjfA6uZ7XWgdN27
	1W7FVIGKGkM6b6uuOEhqRH3YPKxve2aX9WG+Pl252u/oIA8w1J1weHdmzIz8NHjalsg2iiGPffZlM
	hd15j5JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZwsG-000R6u-4I; Sun, 18 Sep 2022 16:10:28 +0000
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZwsD-000R18-Az
	for linux-nvme@lists.infradead.org; Sun, 18 Sep 2022 16:10:27 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VQ2jLUb_1663517416;
Received: from 30.39.108.176(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQ2jLUb_1663517416)
          by smtp.aliyun-inc.com;
          Mon, 19 Sep 2022 00:10:17 +0800
Message-ID: <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com>
Date: Mon, 19 Sep 2022 00:10:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for nvme
 devices
To: Jens Axboe <axboe@kernel.dk>, kbusch@kernel.org, axboe@fb.com,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
 <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220918_091025_606430_49A579E9 
X-CRM114-Status: GOOD (  13.20  )
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


On 2022/9/18 00:50, Jens Axboe wrote:
> On 9/17/22 10:40 AM, Liu Song wrote:
>> From: Liu Song <liusong@linux.alibaba.com>
>>
>> NVMe devices usually have a 1:1 mapping between "ctx" and "hctx",
>> so when "nr_ctx" is equal to 1, there is no possibility of remote
>> request, so the corresponding process can be simplified.
> If the worry is the call overhead of blk_mq_complete_request_remote(),
> why don't we just make that available as an inline instead? That seems
> vastly superior to providing a random shortcut in a driver to avoid
> calling it.

Hi

This is what I think about it. If it is an SSD with only one hw queue, 
remote requests will
appear occasionally. As a real multi-queue device, nvme usually does not 
have remote
requests, so we don't need to care about it. So even if 
"blk_mq_complete_request_remote"
is called, there is a high probability that it will return false, and 
the cost of changing the call
to "blk_mq_complete_request_remote" to determine whether 
"req->mq_hctx->nr_ctx" is 1 is
not only a function call, but more judgments in 
"blk_mq_complete_request_remote".
If "blk_mq_complete_request_remote" is decorated as inline, it also 
depends on the compiler,
there is uncertainty.


Thanks


