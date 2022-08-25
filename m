Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B80AC28D13
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 10:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q2FKWbY0bQ1KKR2vtH+3Kal7QcFLPAKp3Z2BnE/X5pc=; b=tVz6r0olyhkSKu/bh4P/oV2NFq
	OzQip9N5lfojyEgfSYBlDuxagSVv6CN1G3ex89bjEkWz5Uww+DRHYGWPglULJsnDa653UIFIfNwb+
	fwSSrelWo9YW0xJFeU9Q1W6DBxuGiYSUxPh4mIc4lsg9ULTcaHgz/vK2OIHuFyvK35uvN3UulxNXi
	GYwztgRT508yX3MXfgqbhCnsHfky6boXqCZ1HyYbQ2uY3iUZf5VWFLH4Os8usy+zbE78SNgZxnDgC
	GE9+XP+/7ikDHTOSVj9b4FB+l8/ARyxHSS9pyCr80nDPbdds8m/K6VT3/4Vnq1ijBXj9NtFR8ayJW
	dg54y4XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR9kF-00Bksb-QF; Thu, 25 Aug 2022 10:05:51 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR9kD-00Bkrp-J9
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 10:05:50 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MCz6116pjzlWYY;
	Thu, 25 Aug 2022 18:02:17 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 18:05:32 +0800
Subject: Re: [PATCH 2/2] nvme-pci: don't wait freeze during resetting
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	<linux-nvme@lists.infradead.org>
CC: Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-3-ming.lei@redhat.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <fcd5d4c6-b803-db9f-a00c-abfe7365f364@huawei.com>
Date: Thu, 25 Aug 2022 18:05:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220821084754.340585-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_030549_821575_4BDE4EEB 
X-CRM114-Status: GOOD (  14.93  )
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



On 2022/8/21 16:47, Ming Lei wrote:
> First it isn't necessary to call nvme_wait_freeze in nvme_reset_work().
> If tagset isn't allocated, there can't be any inflight IOs; otherwise
> blk_mq_update_nr_hw_queues can freeze & wait queues.
> 
> Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> while requests are in progress"), it is fine to unfreeze queue without
> draining inflight IOs.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/pci.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3a1c37f32f30..91b2903fcc24 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
>   		nvme_free_tagset(dev);
>   	} else {
>   		nvme_start_queues(&dev->ctrl);
> -		nvme_wait_freeze(&dev->ctrl);
It is not safe.
nvme_dev_add may call blk_mq_update_nr_hw_queues, blk_mq_update_nr_hw_queues
require the state is frozen.
>   		if (!dev->ctrl.tagset)
>   			nvme_pci_alloc_tag_set(dev);
>   		else
> 

