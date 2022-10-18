Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A070C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 09:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=asQYk2rahpcuJMZ2HxaZfBkfPtWgKqElUFRFbnFL3f4=; b=wCpHAGaY3qWD7EHpwXJfCSXsB/
	56jQoAkElV1X8TeM7Zc+LPmhdtjJtJjxqJ8PY2BkG7GkpBAfHVugqa0QOJfo3PXQKcYkjL0sSJPCZ
	mh8x6a1mWca0PVB7DScydWXanP0vX+lL+IcafYx5Ef+C1CVMnxLjwl6IIXBEuPnN8WM4U3XY5QuK8
	NXNiPJiqy+ynl44rcVY0cNJwWxhJhUBvwc605bPl58tP823MWx7JK1QkVb71Nv5n71HiG1594DgQJ
	zTqV0nFuhvNmk7bI14eky6nWULsZB08fnliS8/w8hh1ulOp6lFPD46V83myV+SJkQCR9pSEdrbYai
	mvbZI0/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okjHL-005KRY-Jl; Tue, 18 Oct 2022 09:52:55 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okjHJ-005KK8-Bx
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 09:52:54 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ms8H9268YzJn2g;
	Tue, 18 Oct 2022 17:50:13 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 17:52:50 +0800
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
To: Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<sagi@grimberg.me>, <kbusch@kernel.org>, <ming.lei@redhat.com>,
	<axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de>
 <20221017134244.GA24775@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <00e6ce8b-5b27-d670-cd50-865fdb57e60b@huawei.com>
Date: Tue, 18 Oct 2022 17:52:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221017134244.GA24775@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_025253_628120_8CE6AA69 
X-CRM114-Status: GOOD (  13.28  )
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



On 2022/10/17 21:42, Christoph Hellwig wrote:
> On Mon, Oct 17, 2022 at 03:39:06PM +0200, Christoph Hellwig wrote:
>> Having to allocate a struct rcu_synchronize for each of the potentially
>> many queues here is a bit sad.
>>
>> Pull just explained the start_poll_synchronize_rcu interfaces at ALPSS
>> last week, so I wonder if something like that would also be feasible
>> for SRCU, as that would come in really handy here.
> 
> Alternatively I wonder if we could simply use a single srcu_struct
> in the tag_set instead of one per-queue.  That would potentially
> increase the number of read side critical sections
> blk_mq_wait_quiesce_done would have to wait for in tagsets with
> multiple queues, but I wonder how much overhead that would be in
> practive.
Now we submit request based on queues, maybe it is difficult to use
a single srcu_struct in the tag instead of one per-queue.
Using start_poll_synchronize_rcu  still need a unsigned long array.
> 
> .
> 

