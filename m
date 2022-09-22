Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A06C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+mdDdVn4mz4QnPbYza5INneS/lO8AK8+s2NIEZCowfY=; b=PovKbgHy6P4AZRWsuuuWGR5K7R
	h6LRjxpPsdAvhJ5IoDXY5J+o7RbEgLe8Y6831lcZczTmBGnZve6RUeqC4H1lriFapfncEfv8AAeG4
	D1fKmUX7ktIvvHcdpVjkp5GvsxItya0WvVsJ0TzIf7CR++i6ah1TGHoITuj7vPf4TKNl9aNs2kwJT
	Hvey+i/npxrCPjkT1jaAI5vQ+4APVNzwEtUT93XGn+L8HiGMw/xeDl+KSwXbFVZM1uioIj8RhrkRI
	XDX6Fih/ay6KjbwS6amg13DCB999udqS8fiLdziNlpkghGPqWxhXhixMyByamXwg7VHxlkvIl6WOj
	3o2iCIBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHGy-00E1zT-Uo; Thu, 22 Sep 2022 08:09:28 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHGt-00E1w6-Cj
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:09:25 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MY79v2D7lz14S4h;
	Thu, 22 Sep 2022 16:05:07 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:09:14 +0800
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
	<linux-nvme@lists.infradead.org>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-2-hch@lst.de>
 <cc827eb3-96d2-ff65-7204-05213bc018e8@grimberg.me>
 <20220922054837.GC27338@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5a1247d3-0f0e-ef51-a9e2-82794a8c5010@huawei.com>
Date: Thu, 22 Sep 2022 16:09:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220922054837.GC27338@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_010923_634393_D3CE176E 
X-CRM114-Status: GOOD (  16.64  )
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



On 2022/9/22 13:48, Christoph Hellwig wrote:
> On Wed, Sep 21, 2022 at 11:25:11AM +0300, Sagi Grimberg wrote:
>>> +	if (ops->map_queues)
>>> +		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
>>> +	ret = blk_mq_alloc_tag_set(set);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>
>> if (ctrl->ops->flags & NVME_F_FABRICS) {
> 
> Incremental fixup:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f8d9f32adc87c..91c2cb59c4eb6 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4877,10 +4877,12 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   	if (ret)
>   		return ret;
>   
> -	ctrl->connect_q = blk_mq_init_queue(set);
> -        if (IS_ERR(ctrl->connect_q)) {
> -		ret = PTR_ERR(ctrl->connect_q);
> -		goto out_free_tag_set;
> +	if (ctrl->ops->flags & NVME_F_FABRICS) {
> +		ctrl->connect_q = blk_mq_init_queue(set);
> +        	if (IS_ERR(ctrl->connect_q)) {
> +			ret = PTR_ERR(ctrl->connect_q);
> +			goto out_free_tag_set;
> +		}
>   	}
Maybe we should not add the checking of NVME_F_FABRICS.
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
+		ctrl->fabrics_q = blk_mq_init_queue(set);
+		if (IS_ERR(ctrl->fabrics_q)) {
+			ret = PTR_ERR(ctrl->fabrics_q);
+			goto out_cleanup_admin_q;
+		}
+	}
nvme_alloc_admin_tag_set should not check NVME_F_FABRICS either.
The new helpers is just used for fabrics.
Maybe adding fabric to the function name would make it clearer.
Like this: nvme_alloc_fabric_admin_tag_set.
Thus can avoid confusion with nvme_alloc_admin_tags.
>   
>   	ctrl->tagset = set;
> 
> .
> 

