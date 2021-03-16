Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAFAC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 01:23:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012FC64DC4
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 01:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012FC64DC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pPO2b9tuNlf/IhdWphJMqo72WTUOql+RHqyEIxZUVKg=; b=j1qDL5xQoMaueoEPApsjJ/Ijy
	CcFvX3U2EkDJc9mr6tVJLO75+zzAZcGDKTZnYP2Xye7Qep3pMVhG/uGLx/lwDtdvB5tJFiDdySe5Y
	+r/hdwzU114zcAneY5WjbUOme79V3/iCuHIvn7Psk/M28132MAvnoc5qDO112YpZym5mu+ZWSWi5r
	KzeJvbuY6vsXjinJQ+2874H0dIZdtyKGJrMdIQBjLS56NYNfb+zJV3BIhiEJvdGtcMaH4xAHrLdwV
	BBE1B5zY9EX1aubDu12sBvRx1Q4n3ejs6GqqZPZN6N676BK8BEeiwbM1/6lqlg0OpXYgAN/Ib+eiU
	1qA7/aeng==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLyQy-00HBSy-No; Tue, 16 Mar 2021 01:23:44 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLyQs-00HBR2-5S
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 01:23:41 +0000
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DzwT24NjbzWLx7;
 Tue, 16 Mar 2021 09:20:22 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 16 Mar 2021 09:23:22 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 16
 Mar 2021 09:23:22 +0800
Subject: Re: [PATCH] nvme-fabrics: fix crash for no IO queues
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>
References: <20210304005543.8005-1-lengchao@huawei.com>
 <020b9f27-459a-2b98-2e76-ebcc874c9c32@grimberg.me>
 <78c5e9f9-f5b8-b8e5-1c36-3a5803d4b047@huawei.com>
 <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <aac125ec-561a-002d-7054-782ee450067e@huawei.com>
Date: Tue, 16 Mar 2021 09:23:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <45d16780-79a0-c2e2-8e90-246dae0b3e23@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_012338_835536_DA69A700 
X-CRM114-Status: GOOD (  16.27  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/3/16 1:08, Sagi Grimberg wrote:
> 
>>>> A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeout in nvme
>>>> over rdma(roce) reconnection, the reason is use the queue which is not
>>>> alloced.
>>>>
>>>> If queue is not live, should not allow queue request.
>>>
>>> Can you describe exactly the scenario here? What is the state
>>> here? LIVE? or DELETING?
>> If seting feature(NVME_FEAT_NUM_QUEUES) failed due to time out or
>> the target return 0 io queues, nvme_set_queue_count will return 0,
>> and then reconnection will continue and success. The state of controller
>> is LIVE. The request will continue to deliver by call ->queue_rq(),
>> and then crash happens.
> 
> Thinking about this again, we should absolutely fail the reconnection
> when we are unable to set any I/O queues, it is just wrong to
> keep this controller alive...
Keith think keeping the controller alive for diagnose is better.
This is the patch which failed the connection.
https://lore.kernel.org/linux-nvme/20210223072602.3196-1-lengchao@huawei.com/

Now we have 2 choice:
1.failed the connection when unable to set any I/O queues.
2.do not allow queue request when queue is not live.

 From a service continuity perspective, I think it is better that failed
the connection when unable to set any I/O queues.
Diagnose is less important, I prefer service continuity, because if failed
the reconnection and then try new reconnection, it is possible to recover.

> 
> This should be fixed for both rdma and tcp.
> .

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
