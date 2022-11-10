Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDE2C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Nov 2022 03:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m30dfx43+zhL75O5CfOQ07VKqElJ5yCiCjFkt72ZxHg=; b=iC0wmzEzoUU6Gw0Euj6HuiQxmk
	MUG26cL+AaHDJ1Z6+b9/E20sLqdki1aVt6DqKIfDzZP6eO+j6lZSnZja0Ipt//VwqpHaH0luIIzDX
	Tr6Jm5vBVMZWcuT8rrVz1TPybeI5jV4ONmday6GCzpiq+4OhA9QhYtVpDvbNqjmOOtpSynHr9CAfS
	2cp1cjEljh9VNQ403BpgvFOoT6gIOABSW4k4W3cMXJETR8pwgXQos3QS044Li7QbKsiiByB/CKQvm
	8rTPfXQ/HdDgBolc9XQti6jzDDfHR8FRumDq3wJbtOQtgdY1TOEdbQiYK3V+OSRbye74V7iyP8/84
	d9E0aoGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osy4R-002BYN-MZ; Thu, 10 Nov 2022 03:17:39 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osy4G-002BVj-G4; Thu, 10 Nov 2022 03:17:30 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N76Pn0Y6YzJnZk;
	Thu, 10 Nov 2022 11:14:21 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:17:22 +0800
Subject: Re: [PATCH 11/12] nvme-pci: split the initial probe from the rest
 path
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, <asahi@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-12-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <37a66baf-7654-3064-6692-0aea6340cf32@huawei.com>
Date: Thu, 10 Nov 2022 11:17:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221108150252.2123727-12-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_191728_911157_F2792633 
X-CRM114-Status: GOOD (  29.24  )
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



On 2022/11/8 23:02, Christoph Hellwig wrote:
> nvme_reset_work is a little fragile as it needs to handle both resetting
> a live controller and initializing one during probe.  Split out the initial
> probe and open code it in nvme_probe and leave nvme_reset_work to just do
> the live controller reset.
> 
> This fixes a recently introduced bug where nvme_dev_disable causes a NULL
> pointer dereferences in blk_mq_quiesce_tagset because the tagset pointer
> is not set when the reset state is entered directly from the new state.
> The separate probe code can skip the reset state and probe directly and
> fixes this.
> 
> To make sure the system isn't single threaded on enabling nvme
> controllers, set the PROBE_PREFER_ASYNCHRONOUS flag in the device_driver
> structure so that the driver core probes in parallel.
> 
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> Reported-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 139 ++++++++++++++++++++++++----------------
>   1 file changed, 83 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1b3c96a4b7c90..1c8c70767cb8a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2821,15 +2821,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	result = nvme_pci_enable(dev);
>   	if (result)
>   		goto out_unlock;
> -
> -	if (!dev->ctrl.admin_q) {
> -		result = nvme_pci_alloc_admin_tag_set(dev);
> -		if (result)
> -			goto out_unlock;
> -	} else {
> -		nvme_start_admin_queue(&dev->ctrl);
> -	}
> -
> +	nvme_start_admin_queue(&dev->ctrl);
>   	mutex_unlock(&dev->shutdown_lock);
>   
>   	/*
> @@ -2854,9 +2846,6 @@ static void nvme_reset_work(struct work_struct *work)
>   		 */
>   		memset(dev->dbbuf_dbs, 0, nvme_dbbuf_size(dev));
>   		memset(dev->dbbuf_eis, 0, nvme_dbbuf_size(dev));
> -	} else {
> -		if (dev->ctrl.oacs & NVME_CTRL_OACS_DBBUF_SUPP)
> -			nvme_dbbuf_dma_alloc(dev);
>   	}
>   
>   	if (dev->ctrl.hmpre) {
> @@ -2869,37 +2858,23 @@ static void nvme_reset_work(struct work_struct *work)
>   	if (result)
>   		goto out;
>   
> -	if (dev->ctrl.tagset) {
> -		/*
> -		 * This is a controller reset and we already have a tagset.
> -		 * Freeze and update the number of I/O queues as thos might have
> -		 * changed.  If there are no I/O queues left after this reset,
> -		 * keep the controller around but remove all namespaces.
> -		 */
> -		if (dev->online_queues > 1) {
> -			nvme_start_queues(&dev->ctrl);
> -			nvme_wait_freeze(&dev->ctrl);
> -			nvme_pci_update_nr_queues(dev);
> -			nvme_dbbuf_set(dev);
> -			nvme_unfreeze(&dev->ctrl);
> -		} else {
> -			dev_warn(dev->ctrl.device, "IO queues lost\n");
> -			nvme_mark_namespaces_dead(&dev->ctrl);
> -			nvme_start_queues(&dev->ctrl);
> -			nvme_remove_namespaces(&dev->ctrl);
> -			nvme_free_tagset(dev);
> -		}
> +	/*
> +	 * Freeze and update the number of I/O queues as thos might have
> +	 * changed.  If there are no I/O queues left after this reset, keep the
> +	 * controller around but remove all namespaces.
> +	 */
> +	if (dev->online_queues > 1) {
> +		nvme_start_queues(&dev->ctrl);
> +		nvme_wait_freeze(&dev->ctrl);
> +		nvme_pci_update_nr_queues(dev);
> +		nvme_dbbuf_set(dev);
> +		nvme_unfreeze(&dev->ctrl);
>   	} else {
> -		/*
> -		 * First probe.  Still allow the controller to show up even if
> -		 * there are no namespaces.
> -		 */
> -		if (dev->online_queues > 1) {
> -			nvme_pci_alloc_tag_set(dev);
> -			nvme_dbbuf_set(dev);
> -		} else {
> -			dev_warn(dev->ctrl.device, "IO queues not created\n");
> -		}
> +		dev_warn(dev->ctrl.device, "IO queues lost\n");
> +		nvme_mark_namespaces_dead(&dev->ctrl);
> +		nvme_start_queues(&dev->ctrl);
> +		nvme_remove_namespaces(&dev->ctrl);
> +		nvme_free_tagset(dev);
nvme_free_tagset is not necessary when IO queues lost.
nvme_free_tagset can be called in nvme_pci_free_ctrl.
If we call nvme_free_tagset here, nvme_dev_disable will still cause a NULL pointer references
in blk_mq_quiesce_tagset.

