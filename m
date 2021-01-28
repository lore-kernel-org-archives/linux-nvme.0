Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 01:36:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C64864D99
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 01:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C64864D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j3K03LbtPmM6GHk0a5+nU1L1QIc96oe3WnzmiXqNNsQ=; b=JLuCQFIqrEGuH/5mDiAch+e/v
	ldfo8hA2Doa5eeSldXM2U8efuA9SauwsqdT3vn9xa4MFCDLHoYk/+LhM9LOouv4EAe7g9cN0xpGWu
	0vAVz7jYUqsUn1HqQUhwCTu3DOt4KNQJPOVIO4zxcoFB+HrrC5DiBXf+7+bwf2NbrzDIvT9eH3mVe
	26MU48oq1luerKEXg8lfebKpoFRViJnRG9BjA/PPre+LueN5z8iedFHYImbo9g0hLTNn4Hut8RBvS
	0OrV/mJ0m7VBi/f85RKPZiDG7r5hC3c0wCdBjAzLrRtBykUMEUKVzfgdsyALwVg2IVYmEYR9XxblO
	OSzo7GUeQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4wEP-0007Ox-E9; Thu, 28 Jan 2021 01:36:21 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4wEN-0007OC-0F
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 01:36:19 +0000
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DR31n2S46zY3jw;
 Thu, 28 Jan 2021 09:35:09 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 28 Jan 2021 09:36:14 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Thu, 28
 Jan 2021 09:36:14 +0800
Subject: Re: [PATCH v2] nvme-multipath: Early exit if no path is available
To: Daniel Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>
References: <20210127103033.15318-1-dwagner@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <ca8be10a-11fb-dd4d-3606-f9e75a42c99d@huawei.com>
Date: Thu, 28 Jan 2021 09:36:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210127103033.15318-1-dwagner@suse.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_203619_301440_E4C6B474 
X-CRM114-Status: GOOD (  17.84  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org, Jens
 Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/1/27 18:30, Daniel Wagner wrote:
> nvme_round_robin_path() should test if the return ns pointer is
> valid. nvme_next_ns() will return a NULL pointer if there is no path
> left.
> 
> Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> v2:
>    - moved NULL test into the if conditional statement
>    - added Fixes tag
> 
>   drivers/nvme/host/multipath.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9ac762b28811..282b7a4ea9a9 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -221,7 +221,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>   	}
>   
>   	for (ns = nvme_next_ns(head, old);
> -	     ns != old;
> +	     ns && ns != old;
nvme_round_robin_path just be called when !"old".
nvme_next_ns should not return NULL when !"old".
It seems unnecessary to add checking "ns".
Is there a bug that "old" is not in "head" list?
If yes, we should fix it.
>   	     ns = nvme_next_ns(head, ns)) {
>   		if (nvme_path_is_disabled(ns))
>   			continue;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
