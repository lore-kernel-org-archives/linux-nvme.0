Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F050CC433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 05:56:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA34207BB
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 05:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TxLIKyMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA34207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=41BiwdWxY5YNxP+szh+27No1sUx271LLP/4VBvcZuqA=; b=TxLIKyMH71uxpH/8f8aYhGFKB
	tQ2kfFIVivbJS6ESIx3fDzYpZZnkvitLpH0r+B3bTHf8PbH6mIARsuR/smdbW5uvdbUXwPQBvTrM6
	yabuKrEtfjoSzNvRG87edOcPNb6sZLmQx2veeGgzIO5+AyYjgm3s79aEbTGkfqIElZwdEPYZDDhE2
	i8ydAe+by1jAi0x93PhNqWKHJGi83icSYTMYnBtRgVMzYfOx/GwYt2XuGK7Y3OCNrEUoGFxpUeFXM
	RGgmMKtohPyxAeWYpQ1B1AZrKv3+KHZSEiKSIFQkRupFMrr9EIQOfv1xGwL/F4+KCXbHpbpwQY6VH
	D5f7xNLIg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzw7L-0006Qh-P0; Mon, 27 Jul 2020 05:56:07 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzw7I-0006JC-5L
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 05:56:05 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2C129B3B47A385A0E7F0;
 Mon, 27 Jul 2020 13:55:54 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0;
 Mon, 27 Jul 2020 13:55:53 +0800
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To: Ming Lei <ming.lei@redhat.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <f9ed3baa-2a83-c483-6ba0-70a84d40f569@huawei.com>
 <20200727035033.GD1129253@T590>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <79ab699e-3f50-26c0-3c85-1962ae4dedac@huawei.com>
Date: Mon, 27 Jul 2020 13:55:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200727035033.GD1129253@T590>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_015604_455576_0A54DEEC 
X-CRM114-Status: GOOD (  11.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/7/27 11:50, Ming Lei wrote:
> On Mon, Jul 27, 2020 at 11:33:43AM +0800, Chao Leng wrote:
>>
>>
>> On 2020/7/27 10:08, Ming Lei wrote:
>>>> It is at the end and contains exactly what is needed to synchronize. Not
>>> The sync is simply single global synchronize_rcu(), and why bother to add
>>> extra >=40bytes for each hctx.
>>>
>>>> sure what you mean by reuse hctx->srcu?
>>> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
>>> to each hctx for just simulating one single synchronize_rcu().
>>
>> To sync srcu together, the extra bytes must be needed, seperate blocking
>> and non blocking queue to two hctx may be a not good choice.
>>
>> There is two choice: the struct rcu_synchronize is added in hctx or in srcu.
>> Though add rcu_synchronize in srcu has a  weakness: the extra bytes is
>> not need if which do not need batch sync srcu, I still think it's better
>> for the SRCU to provide the batch synchronization interface.
> 
> The 'struct rcu_synchronize' can be allocated from heap or even stack(
> if no too many NSs), which is just one shot sync and the API is supposed
> to be called in slow path. No need to allocate it as long lifetime variable.
> Especially 'struct srcu_struct' has already been too fat.

Stack is not suitable, stack can not provide so many space for
many name space. Heap maybe a choice, but need to add abnormal treat
when alloc memory failed, Thus io pause time can not be ensured.
So the extra space may must be needed for batch srcu sync.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
