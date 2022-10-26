Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C62CC38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/CSMVsiGdVJI/owM7/1PbY+wh0xjU6PMg9On9xPWDjw=; b=FbBk6jfNEs4S2UqIjm+L0MxzTy
	50CuXRZ7b7K5cHT5t3/avm4qBPm73XGJiKx7syepK5f2cD/RW7cYmVdPkLVSuA2Uj2huAPkecnL9v
	tIQQhwp3XNl8A2gqT/JQk+DnLUw9KafjrQ169P6CFgL0AXFGtYSE41gH8BJsECxIdrv4Yd635oFtI
	DAqUw1txwuz5DudAHS+cpeK9OGRVQk1+Z8a5QzBxN1ewof1rnZW83GeWHhKJ4Pkl6W9art39mz+HI
	uVIPBxST+kYF6GbbdstBHgAOoZx19c6yaA5M3Ru9U4//niE4CL4qc9T2HvJSx3HpS0SzQSwmtoKdy
	5xScmfZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbuZ-008ahm-Su; Wed, 26 Oct 2022 08:37:19 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbuW-008aeY-UM
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:37:18 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4My2D142j7zJn8L;
	Wed, 26 Oct 2022 16:34:25 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:37:11 +0800
Subject: Re: [PATCH 12/17] nvme-pci: don't unquiesce the I/O queues in
 apple_nvme_reset_work
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-13-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <f18af4bb-6b85-c85f-ed0f-d2b9621fb264@huawei.com>
Date: Wed, 26 Oct 2022 16:37:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221025144020.260458-13-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_013717_175775_F819A731 
X-CRM114-Status: GOOD (  13.07  )
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



On 2022/10/25 22:40, Christoph Hellwig wrote:
> apple_nvme_reset_work schedules apple_nvme_remove, to be called, which
> will call apple_nvme_disable and unquiesce the I/O queues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/apple.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 14bee207316a0..44e7daf93e19c 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1154,7 +1154,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
>   	nvme_get_ctrl(&anv->ctrl);
>   	apple_nvme_disable(anv, false);
Same suggestion as the previous patch:
	apple_nvme_disable(anv, true);

