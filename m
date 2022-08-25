Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EE8C04AA5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Aug 2022 10:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SFpsHHiCKKGcK68CxBminy5B0zZuS5RoY6sH2iu9fnU=; b=I/osPV5RqU2iR3+dz/6c5Gvs8f
	fB6W7p46ORUPwtgX2+vVL5/cHqFRbc28oiWCGU6O4CxGsX/m5wIs2MlINYq/NjaOA+pGqjE05wLeZ
	Sh7irb1C0Z4waTLJhgiwAcv32S1qfcBKzVeMOapSJ1Ym155Zx13ZgEFfBxY4F0vBfwfxklf0D/Ypx
	UuwoiZbWyBKdQEivinfdpplseAN7yifUi3NaDlXetDEkBpIK6yovka0WGZz642a4GZqHvOGMHbJ/M
	I/XM9gP4fC9mPN9veE/3JfB6RE+y0fH3m2cKQxGJrHnqlnVfmWjeZtSU7IT65PUuxwQx2epA2mvmr
	IKyYKKxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR9hD-00BiNu-FL; Thu, 25 Aug 2022 10:02:43 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oR9h9-00Bi9Q-UJ
	for linux-nvme@lists.infradead.org; Thu, 25 Aug 2022 10:02:41 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MCz4P4y2YzGpr5;
	Thu, 25 Aug 2022 18:00:53 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 18:02:33 +0800
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	<linux-nvme@lists.infradead.org>
CC: Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
References: <20220821084754.340585-1-ming.lei@redhat.com>
 <20220821084754.340585-2-ming.lei@redhat.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com>
Date: Thu, 25 Aug 2022 18:02:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220821084754.340585-2-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220825_030240_351270_FCD3C127 
X-CRM114-Status: GOOD (  17.09  )
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
> From: Keith Busch <kbusch@kernel.org>
> 
> In some corner cases[1], freeze wait and unfreeze API may be called on
> unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
> freeze APIs more reliably, then this kind of issues can be avoided.
> And similar approach has been applied on stopping/quiescing nvme queues.
This leads to another problem: the process that needs to be
in the frozen state is not actually frozen.
It's not safe.
There is the same risk on stopping/quiescing nvme queues.
> 
> [1] https://lore.kernel.org/linux-nvme/20220801125753.1434024-1-ming.lei@redhat.com/
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Link: https://lore.kernel.org/linux-block/CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com/#r
> 
> Add comment log.
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 16 +++++++++++++---
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index af367b22871b..fe4ae3616ed1 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5028,8 +5028,11 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
>   	struct nvme_ns *ns;
>   
>   	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (!test_and_clear_bit(NVME_NS_FREEZE, &ns->flags))
> +			continue;
>   		blk_mq_unfreeze_queue(ns->queue);
> +	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_unfreeze);
> @@ -5040,6 +5043,8 @@ int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
>   
>   	down_read(&ctrl->namespaces_rwsem);
>   	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (!test_bit(NVME_NS_FREEZE, &ns->flags))
> +			continue;
>   		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
>   		if (timeout <= 0)
>   			break;
> @@ -5054,8 +5059,11 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
>   	struct nvme_ns *ns;
>   
>   	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (!test_bit(NVME_NS_FREEZE, &ns->flags))
> +			continue;
>   		blk_mq_freeze_queue_wait(ns->queue);
> +	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_wait_freeze);
> @@ -5065,8 +5073,10 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
>   	struct nvme_ns *ns;
>   
>   	down_read(&ctrl->namespaces_rwsem);
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		set_bit(NVME_NS_FREEZE, &ns->flags);
>   		blk_freeze_queue_start(ns->queue);
> +	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_start_freeze);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1bdf714dcd9e..702ba19b5647 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -484,6 +484,7 @@ struct nvme_ns {
>   #define NVME_NS_FORCE_RO	3
>   #define NVME_NS_READY		4
>   #define NVME_NS_STOPPED		5
> +#define NVME_NS_FREEZE		6
>   
>   	struct cdev		cdev;
>   	struct device		cdev_device;
> 

