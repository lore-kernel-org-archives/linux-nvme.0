Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E18C38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eql2LRl/Q0QR6n29BQ7E3OUSfHEoTxDIPvKmLHmkpA4=; b=PzuB+ZhdphRyrc5GJu9qbJyGoO
	OBltRcYp2+Zv9lXmH3Vq5f8p/GRhG9xsqAA7vYsP1P2Bj1hytO3EEKl0kn3sfE+ZCySQbgNAafc4n
	9t2Pf3c/Jn9TbcC9PrD+1kiRL1MgXTS9Pyn51JnMuOw4eg+Rn2mGyCrzYWInANP3TFKMj5nCu5Uie
	x7/UeUGyASAQ/DuOG1rUwWGsG1uaW6yKx/k0V5UhV8w0QnqBzQDk1PFBXOwmKrs0akFTFHTsjln54
	NrHy5E3ueehzjsy05ilFnBOijXbE2wNn8NuACDDaUhmRih3vXXGA6PAdn48AJ4BxbhhJCgXdXkPzk
	oiJhSgvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbsA-008ZpP-Ll; Wed, 26 Oct 2022 08:34:50 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbs6-008ZlI-LF
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:34:48 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4My28H1WfCzpStJ;
	Wed, 26 Oct 2022 16:31:11 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 16:34:36 +0800
Subject: Re: [PATCH 11/17] nvme-pci: don't unquiesce the I/O queues in
 nvme_remove_dead_ctrl
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-12-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <cf78bcbb-b918-e9f5-186a-d1d804406011@huawei.com>
Date: Wed, 26 Oct 2022 16:34:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221025144020.260458-12-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_013446_916361_B71EA762 
X-CRM114-Status: GOOD (  14.26  )
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
> nvme_remove_dead_ctrl schedules nvme_remove to be called, which will
> call nvme_dev_disable and unquiesce the I/O queues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index bef98f6e1396c..3a26c9b2bf454 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2794,7 +2794,6 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>   	nvme_get_ctrl(&dev->ctrl);
>   	nvme_dev_disable(dev, false);
Currently set the parameter "shutdown" to false, nvme_dev_disable() do not unquiesce the queues.
Actually we should set the parameter "shutdown" to true.
         nvme_dev_disable(dev, true);



