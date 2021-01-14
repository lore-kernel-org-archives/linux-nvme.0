Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B88C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:58:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44CA52395C
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 06:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CA52395C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qs87NV8DwhSlA8s8x2Oqgx5eW4LxcRPZLsQoawKyw14=; b=02qfV5dsNo/r82MeBEiplrLHu
	mzJ2AesFuQ47WfVKFO0beWRujTvZYd5caV69MWHIxF0zKlmGOD7RlT895mSnKakCTPgNNHEiTZjYX
	X73HgTF4uBrq+Osb6NIBqOur2xjW6pT63HR1xOj3Zfe+sQ+YW+aDLpbokNuu+Pco2ukRfIrpqRcZu
	t/eC32vsFq5ouL4BKeH+X5XZBv7kfoSjOevheXDr9qPP1OI0K0uepnu6XxVKY0k7rsuy/MH/eHvlK
	HPIuieYzMv7/po2cFjvAXz09re9o/MQM5zOaCyq0NiQw41S+a063YJZI/6fC38ieXknGTjg/4lUbG
	cZ2YfkvZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzwac-0000QB-Vc; Thu, 14 Jan 2021 06:58:39 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzwaZ-0000Og-Fs
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 06:58:37 +0000
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DGZqL4SdNz13h8m;
 Thu, 14 Jan 2021 14:56:46 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 14 Jan 2021 14:58:11 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Thu, 14
 Jan 2021 14:58:10 +0800
Subject: Re: [PATCH] nvme-rdma: avoid repeated request completion for
 concurrent nvme_rdma_timeout
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
References: <20210106063635.7452-1-lengchao@huawei.com>
 <002e7d37-433c-f8fa-f460-bfb2447d6bc0@grimberg.me>
 <8a5b4b58-98be-4da1-a769-dc173d2a3be0@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <39b076de-2fff-418f-0938-64a0415ccff1@huawei.com>
Date: Thu, 14 Jan 2021 14:58:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8a5b4b58-98be-4da1-a769-dc173d2a3be0@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme718-chm.china.huawei.com (10.1.199.114) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_015836_420948_433E1903 
X-CRM114-Status: GOOD (  12.98  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/14 9:15, Sagi Grimberg wrote:
> 
>> On 1/5/21 10:36 PM, Chao Leng wrote:
>>> A crash happens when inject completing request long time(nearly 30s).
>>> Each name space has a request queue, when inject completing request long
>>> time, multi request queues may has time out requests at the same time,
>>> nvme_rdma_timeout will execute concurrently. Multi requests in different
>>> request queues may be queued in the same rdma queue, multi
>>> nvme_rdma_timeout may call nvme_rdma_stop_queue at the same time.
>>> The first nvme_rdma_timeout will clear NVME_RDMA_Q_LIVE and continue
>>> stopping the rdma queue(drain qp), but the others check NVME_RDMA_Q_LIVE
>>> is already cleared, and then directly complete the requests, but the
>>> rdma queue may be not stopped and the request may be already completed
>>> in qp and wait treated, the request will be repeated completed.
>>> Add a multex lock to serialize nvme_rdma_stop_queue.
>>
>> This looks reasonable to me,
>>
>> Mind sending one for nvme-tcp as well?
> 
> BTW, I'm assuming you mean use-after-free or double completion when you
> are referring to repeated completions? I think it would be easier to
> understand if you just say that completing request before the qp is
> fully drained may lead to a use-after-free condition.
ok, thanks for your suggestion.
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
