Return-Path: <SRS0=Nmzz=DV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680A4C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 01:32:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B91D21D7B
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2020 01:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nj6eeEg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B91D21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ax0LdWL3mHaQ/YncQEboXOTT0CrOJFl11Vydv7pwvY0=; b=nj6eeEg/mSLHgex5tZniNgnu6
	CBMjxpwGbn14HlTHS43N3vGCEJRiBsDkl2OTVmMnammfxHrosyEOw4ixOXQxSFkDyV4DRH9allpQP
	8eIikbN3nsELaCQGL4IjcGJ6efusasobvL9SGRcPo4jQN14keyyQkWGzoCiBhIOKoHM+FAmRqr9IT
	g8oO0AqjviQh0EgD2f1pVd2otuWdzZhowQDVOHcxFX1Iy1oemfQkhwpmrOnL/l0Q+2CWTSxT7xOZz
	RNXr8lGp+RNwXdacQKe0z9VxTVQnkHcWuUaxMkuiSmYYdkATWg8GMpvSIoN4MXJv08vQ867brNr6P
	4OnPuDr/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSVev-0006FB-0X; Wed, 14 Oct 2020 01:32:53 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSVeq-0006Dp-0V
 for linux-nvme@lists.infradead.org; Wed, 14 Oct 2020 01:32:51 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 3E51DDEB758DD8C8C171;
 Wed, 14 Oct 2020 09:32:41 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 14 Oct 2020 09:32:40 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Wed, 14
 Oct 2020 09:32:39 +0800
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To: Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
 <5e05fc3b-ad81-aacc-1f8e-7ff0d1ad58fe@huawei.com>
 <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6f9f59be-5d83-390e-b3cf-b5955ffa7259@huawei.com>
Date: Wed, 14 Oct 2020 09:32:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e19073e4-06da-ce3c-519c-ece2c4d942fa@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_213249_986985_158B3D87 
X-CRM114-Status: GOOD (  14.88  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020/10/14 6:36, Sagi Grimberg wrote:
> 
>>>> This may just reduce the probability. The concurrency of timeout and teardown will cause the same request
>>>> be treated repeatly, this is not we expected.
>>>
>>> That is right, not like SCSI, NVME doesn't apply atomic request completion, so
>>> request may be completed/freed from both timeout & nvme_cancel_request().
>>>
>>> .teardown_lock still may cover the race with Sagi's patch because teardown
>>> actually cancels requests in sync style.
>> In extreme scenarios, the request may be already retry success(rq state change to inflight).
>> Timeout processing may wrongly stop the queue and abort the request.
>> teardown_lock serialize the process of timeout and teardown, but do not avoid the race.
>> It might not be safe.
> 
> Not sure I understand the scenario you are describing.
> 
> what do you mean by "In extreme scenarios, the request may be already retry success(rq state change to inflight)"?
> 
> What will retry the request? only when the host will reconnect
> the request will be retried.
If irq interrupt the timeout work, and cause the timeout work pause long time(more than 100ms).
The reconnect may already success, and start requests. And then timeout work continue run to
wrongly stop queue and cancel the request.
The probability of this happening is very low.
> 
> We can call nvme_sync_queues in the last part of the teardown, but
> I still don't understand the race here.
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
