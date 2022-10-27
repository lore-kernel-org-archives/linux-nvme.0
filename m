Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5749CC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 02:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nsbN8Xi5CeBowLrlRszzVU5oEz3grHRVXAMx3vv3+as=; b=vNGMWv9zXD0fNvcIwABggorAI/
	gYT1hgjK+xKPfGrR89xnjbN3mwAb39diUHNhc6hlodK8VZu26lW32c6+S2abgouNytMu7AqM/HsKh
	0i8HMo0bZuOIHvzIJsI6DyZcUv7aGCcjb0miUt3SdLLHAH3y0Pxl5QLdYEEJ5rx0F15y0rJH5VCzz
	CtbYy4qbyNLRcx+ewy2rZ46JQnDpjlrUruC3zixzJ5/LxamaKeBUKIltWcIcF89H2lnMFN1fs2IQk
	lPGFgmBB5xmWZ21oZIubGFb/BIE3O5c+GQLmUafPyPRAnDY22VU7fuGQ+ltN386lnoQBbbs1eaCPJ
	RKabez+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onsxu-00Bcqu-UB; Thu, 27 Oct 2022 02:49:54 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onsxr-00Bcpw-IE
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 02:49:53 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MyVQD3SvRz15MBZ;
	Thu, 27 Oct 2022 10:44:52 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:49:45 +0800
Subject: Re: [PATCH 14/17] blk-mq: move the srcu_struct used for quiescing to
 the tagset
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-15-hch@lst.de>
 <12eb7ad8-6b70-092a-978c-a2c1ba595ad4@huawei.com>
 <73072365-adc5-1430-0b12-f552fd99b96e@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <276f0800-2927-624d-0d90-8a5722f6d93b@huawei.com>
Date: Thu, 27 Oct 2022 10:49:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <73072365-adc5-1430-0b12-f552fd99b96e@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_194951_784721_E065CB63 
X-CRM114-Status: GOOD (  10.49  )
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



On 2022/10/26 21:01, Sagi Grimberg wrote:
> 
> 
> On 10/26/22 11:48, Chao Leng wrote:
>>> +
>>> +    if (set->flags & BLK_MQ_F_BLOCKING) {
>>> +        set->srcu = kmalloc(sizeof(*set->srcu), GFP_KERNEL);
>> Memory with contiguous physical addresses is not necessary, maybe it is a better choice to use kvmalloc,
>> because sizeof(*set->srcu) is a little large.
>> kvmalloc() is more friendly to scenarios where memory is insufficient and running for a long time.
> 
> Huh?
> 
> (gdb) p sizeof(struct srcu_struct)
> $1 = 392
I double recheck it. What I remember in my head is the old version of the size.
The size of the latest version is the size that you show.
Change the srcu_node array to a pointer in April 2022.
The link:
https://github.com/torvalds/linux/commit/2ec303113d978931ef368886c4c6bc854493e8bf

Therefore, kvmalloc() is a better choice for older versions.
For the latest version, static data member or kmalloc() are OK.

