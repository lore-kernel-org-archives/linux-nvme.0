Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8904AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2V6Ye+bXmzpFOutWUlzq7wcs77pQ72lctKXBCAhfnO0=; b=2g3mqOtk5DYrDFS7W1twnmaOhw
	vB1RYUBOwtV7UxHrXcfIOh1J3pKKG8tKdhUXg+MT/rsdTU8gzG/APIPppuT/bqXLxqxWp0f7U8l6d
	6FT9SyPfApfVWvx01dYx7O6VmgKh/jwaioOrINKyDdL2Fq4wKWbzsupvKcJXDDK7TOcIOzLa90pI+
	zIGRB7xzo1AWvqOEQB802rKyVjuGBLIO313rAhMQaaIFJPiWBzKbXotVHVvB0Hium6bNxD92kImZW
	evgY5g6D3f59GyLBLDC+6dNOEksDFJcPqUz4bv4pt4vHWu/2o4QVru9P2Vky56rtAtScU9dMSxNRW
	p+pEl3eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kmZ-0035OC-4i; Fri, 08 Jul 2022 10:00:19 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9kmR-0035Mo-KC
	for linux-nvme@lists.infradead.org; Fri, 08 Jul 2022 10:00:13 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LfTFK5GC8zThJw;
	Fri,  8 Jul 2022 17:56:21 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 17:59:38 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Jul
 2022 17:59:38 +0800
Subject: Re: [PATCH] nvme-pci: use nvme core helper to cancel requests in
 tagset
To: Guixin Liu <kanie@linux.alibaba.com>, <kbusch@kernel.org>, <axboe@fb.com>,
	<hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>
References: <1657249477-88304-1-git-send-email-kanie@linux.alibaba.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <4d25ed5e-ef2c-2700-03ee-2bb1aca2cbbe@huawei.com>
Date: Fri, 8 Jul 2022 17:59:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <1657249477-88304-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_030011_883812_6BEF8DB7 
X-CRM114-Status: GOOD (  11.47  )
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

On 2022/7/8 11:04, Guixin Liu wrote:

> Use nvme core helper nvme_cancel_tagset and nvme_cancel_admin_tagset
> instead of same logic code.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/pci.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e7af223..ab4facf 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2720,10 +2720,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	nvme_pci_disable(dev);
>   	nvme_reap_pending_cqes(dev);
>   
> -	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
> -	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
> -	blk_mq_tagset_wait_completed_request(&dev->tagset);
> -	blk_mq_tagset_wait_completed_request(&dev->admin_tagset);
> +	nvme_cancel_tagset(&dev->ctrl);
> +	nvme_cancel_admin_tagset(&dev->ctrl);
>   
>   	/*
>   	 * The driver will not be starting up queues again if shutting down so

Looks good to me,

Reviewed-by:Ruozhu Li <liruozhu@huawei.com>


