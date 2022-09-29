Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3600C04A95
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 01:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZCoVjVT94dvPUsw+mVcFwoTwjbWiHN1RRcinUMZTMLA=; b=XwpenGfjXB7KzDgY1ZoJtV+ku8
	8tQj/RhGsPEyAdD7CUeMvHpXOJAC/EUIUQlgm8dyG+5lP7BSU9Z0cuayZrxvb8cnyBWvbuQb2u/2I
	CXoXE4bOT1PqoX4fjDRVKJvL5py5Kg0jwyyq9yW5rR1jdj5S86u3FRYhGU2NneIWzWVeruBRAysTi
	vajHBP1hg6Hf2nncIX+h5zR0417SMJ1Ri6e1U4e43i3mbZaTYsJcs7ulQKGKoWlhaXw4MSGnU0WEp
	RDLBEZAPZTbzwKzjKYrzKzWPEwBR25GENpm1zt/tcz/GM0K9aBdPmdCHy6EiNmZKjVDKX0dw5b9ju
	WWPN5vHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odiQ1-000qRA-Bb; Thu, 29 Sep 2022 01:32:53 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odiPy-000qQY-8B
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 01:32:52 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MdG2x3Cj9zWgsy;
	Thu, 29 Sep 2022 09:28:25 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 09:32:31 +0800
Subject: Re: [PATCH v2] nvme-multipath: fix possible hang in live ns resize
 with ANA access
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, Yogev
 Cohen <yogev@lightbitslabs.com>
References: <20220928201031.166876-1-sagi@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <dc0c4500-957b-b7f7-0cec-b26e11a138f7@huawei.com>
Date: Thu, 29 Sep 2022 09:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220928201031.166876-1-sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_183250_680694_DC5814BF 
X-CRM114-Status: GOOD (  23.74  )
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



On 2022/9/29 4:10, Sagi Grimberg wrote:
> When we revalidate paths as part of ns size change (as of commit
> e7d65803e2bb), it is possible that during the path revalidation, the
> only paths that is IO capable (i.e. optimized/non-optimized) are the
> ones that ns resize was not yet informed to the host, which will cause
> inflight requests to be requeued (as we have available paths but none
> are IO capable). These requests on the requeue list are waiting for
> someone to resubmit them at some point.
> 
> The IO capable paths will eventually notify the ns resize change to the
> host, but there is nothing that will kick the requeue list to resubmit
> the queued requests.
> 
> Fix this by always kicking the requeue list, and if no IO capable path
> exists, these requests will just end up being queued again.
> 
> A typical log that indicates that IOs are requeued:
> --
> nvme nvme1: creating 4 I/O queues.
> nvme nvme1: new ctrl: "testnqn1"
> nvme nvme2: creating 4 I/O queues.
> nvme nvme2: mapped 4/0/0 default/read/poll queues.
> nvme nvme2: new ctrl: NQN "testnqn1", addr 127.0.0.1:8009
> nvme nvme1: rescanning namespaces.
> nvme1n1: detected capacity change from 2097152 to 4194304
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> block nvme1n1: no usable path - requeuing I/O
> nvme nvme2: rescanning namespaces.
> --
> 
> Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
> Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - fix commit msg body format
> - follow reverse-xmas declaration pattern
> 
>   drivers/nvme/host/multipath.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 6ef497c75a16..1113139c9736 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -173,15 +173,17 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>   {
>   	struct nvme_ns_head *head = ns->head;
>   	sector_t capacity = get_capacity(head->disk);
> +	struct nvme_ns *n;
>   	int node;
>   
> -	list_for_each_entry_rcu(ns, &head->list, siblings) {
> -		if (capacity != get_capacity(ns->disk))
> -			clear_bit(NVME_NS_READY, &ns->flags);
> +	list_for_each_entry_rcu(n, &head->list, siblings) {
> +		if (capacity != get_capacity(n->disk))
> +			clear_bit(NVME_NS_READY, &n->flags);
>   	}
>   
>   	for_each_node(node)
>   		rcu_assign_pointer(head->current_path[node], NULL);
> +	nvme_kick_requeue_lists(ns->ctrl);
We just need to schedule the requeue_work of the head instead of all heads.
we can do like this:
   kblockd_schedule_work(&head->requeue_work);
>   }
>   
>   static bool nvme_path_is_disabled(struct nvme_ns *ns)
> 

