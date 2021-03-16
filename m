Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F318C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 01:34:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3A864F6E
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 01:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3A864F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kVRD2E4sEYpAda6oQE6FGDIU46IHiVkNO/cJGQsP9XA=; b=N7K3cbmik+gyf0VxP85UPYXy6
	kaGi0VBYHb3b9NvFRw46rvz1ppuHhgLY8VOZU1AvtCiybFyk0yk7aeV9akAtXwSARXCJKBVaS9I4d
	Hg5WuV4DtmHfXeSUtsoGOlO5g/NRfBIW9eg0vyrkE7tU1fZim5TCfMd7dmbOfNl4u81GNWcu36yCR
	o7stuJQAbWpGM1Pbbt8EnsSunEEwnyZk/vphYlNcSUDQOK4HI31sA0vm6NAJonrDjmATr5AwEXWYg
	+IWsQf8PsPHzpBcDipZXGAySkCrFdFIrxlFqKUc1410HLqouGcaRwMGn4ve/Ft0WMwLGNiMt/706g
	8ZeqE6Tag==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLybQ-00HC5R-5F; Tue, 16 Mar 2021 01:34:32 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLybJ-00HC4q-HG
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 01:34:28 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Dzwjg6V7xzWLy3;
 Tue, 16 Mar 2021 09:31:19 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 16 Mar 2021 09:33:59 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Tue, 16
 Mar 2021 09:33:58 +0800
Subject: Re: [PATCH 2/2] nvme-rdma: Fix possible hang when failing to set io
 queues
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, "Chaitanya
 Kulkarni" <Chaitanya.Kulkarni@wdc.com>
References: <20210315210427.357584-1-sagi@grimberg.me>
 <20210315210427.357584-2-sagi@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <269b5028-9ef1-7f56-1334-d89f52d86d0d@huawei.com>
Date: Tue, 16 Mar 2021 09:33:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210315210427.357584-2-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme717-chm.china.huawei.com (10.1.199.113) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_013426_466432_E07B0289 
X-CRM114-Status: GOOD (  18.00  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2021/3/16 5:04, Sagi Grimberg wrote:
> We only setup io queues for nvme controllers, and it makes
> absolutely no sense to allow a controller (re)connect without
> any I/O queues. If we happen to fail setting the queue count
> for any reason, we should not allow this to be a successful
> reconnect as I/O has no chance in going through. Instead
> just fail and schedule another reconnect.
> 
> Reported-by: Chao Leng <lengchao@huawei.com>
> Fixes: 711023071960 ("nvme-rdma: add a NVMe over Fabrics RDMA host driver")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 53ac4d7442ba..eb093ea5ffa1 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -736,8 +736,11 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
>   		return ret;
>   
>   	ctrl->ctrl.queue_count = nr_io_queues + 1;
> -	if (ctrl->ctrl.queue_count < 2)
> -		return 0;
> +	if (ctrl->ctrl.queue_count < 2) {
> +		dev_err(ctrl->ctrl.device,
> +			"unable to set any I/O queues\n");
> +		return -ENOMEM;
> +	}
>   
>   	dev_info(ctrl->ctrl.device,
>   		"creating %d I/O queues.\n", nr_io_queues);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
