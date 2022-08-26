Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACDEECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vJ9vKNsulK0IgX2Zznad0BpjeEiHiJKQyDelwvDIRkQ=; b=m4MD73ggnWqP2nlbGu5opVGjrf
	Mq3Bi9jqiSjWhyLRT5s0vhvI+YFyzieXALJ9AnuSPus2uCuztH6dLnueE9bqadUuK2+Bi5RtnY7Fn
	cXbwpo3sOYMYqbFZ3Vf8P0t8A/xxipLgRu3x8tP9+Cbm7EsddaAfi+ke1AQFT9j5GPmE8Y9DxjipM
	NDqf15RL3OW3P7tsloYwYOUnycCwZ6MuOyLz4bfZFOVpJX8vRkvkVgiZxOy4vEqUp1axWvrfe5Iiw
	nUnZvnzSPks1hXN7yar8LK5TJM4H2ehEeCUR/FW8TBji95+xgrqz8W+bASYi+NUwWWHx+9U5gdg4q
	v6KQyJIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRNrV-004kGj-GP; Fri, 26 Aug 2022 01:10:17 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRNrR-004kC5-UZ
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 01:10:15 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDM9N6gpXzkWK5;
	Fri, 26 Aug 2022 09:06:32 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:10:05 +0800
Subject: Re: [PATCH v2 3/3] nvme-rdma: Handle number of queue changes
To: Daniel Wagner <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-4-dwagner@suse.de>
 <17886a4c-8443-19a1-c2fa-d7ea0f2e5a1f@huawei.com>
 <20220825105550.3hxjveuex4nmup54@carbon.lan>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <a232a477-b2a3-af6e-58fd-265d8f10bb25@huawei.com>
Date: Fri, 26 Aug 2022 09:10:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220825105550.3hxjveuex4nmup54@carbon.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_181014_192399_CDC3ECA2 
X-CRM114-Status: GOOD (  11.60  )
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



On 2022/8/25 18:55, Daniel Wagner wrote:
> On Thu, Aug 25, 2022 at 06:08:10PM +0800, Chao Leng wrote:
>>> +	/*
>>> +	 * If the number of queues has increased (reconnect case)
>>> +	 * start all new queues now.
>>> +	 */
>>> +	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
>>> +					ctrl->tag_set.nr_hw_queues + 1);
>>> +	if (ret)
>>> +		goto out_cleanup_connect_q;
>>> +
>> Now the code looks weird.
>> Maybe we can do like this:
>> first blk_mq_update_nr_hw_queues, and then nvme_rdma_start_io_queues.
> 
> We have to start the exiting queues before going into the 'if (!new)'
> part. That's why the start of queues is splited into two steps.
Indeed it is not necessary.
It's just a little negative: some request will failed, and then retry
or failover. I think it is acceptable.
> 
> .
> 

