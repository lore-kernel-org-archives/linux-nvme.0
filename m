Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB80C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 07:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nb/ievp3rzibCMnlZ8iWjqjqUsf+1AmpEcRGtqSt+0g=; b=MSlVBaooCCi8p7rJQj1pHJc9ZL
	bRX9F4UyT7oaFHK3Lg3ohKHeE199MV7fwYm9MAkFG1+uJO4PadWC8LVm4IUPDRsXUEteLeo/Ot3VJ
	Gzqafk6rrU+UoNcS4V2681w7i4hvgRQ6w8r2UrOH93ehD6I2rsBqTwI9K+Ryzu7WzOC6wKqlOBsti
	EM5hP/rw63AzzhD4uSAmf5/KZABlslW7Cu/luowDWD6mN6OuMz6p9nB5KmXDMv99+/lExQ4WzMtaq
	A2muqwuesakyZIe/hhsiE+7090DZwT3+qGn25qxZstCCZmJ7ufES/CpAKhzrgsfbSBVoVcnQXnY8+
	W/GZZmrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovDDi-000zLD-Tl; Wed, 16 Nov 2022 07:52:30 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovDDg-000zJ4-4B
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 07:52:29 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NBwHS22rszmW1c;
	Wed, 16 Nov 2022 15:52:04 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:52:26 +0800
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
To: Christoph Hellwig <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, Gerd Bayer <gbayer@linux.ibm.com>
References: <20221116072711.1903536-1-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e3aabd5a-d20b-f317-1791-1af16066cf87@huawei.com>
Date: Wed, 16 Nov 2022 15:52:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221116072711.1903536-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_235228_363585_5E50A554 
X-CRM114-Status: GOOD (  17.10  )
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

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/11/16 15:27, Christoph Hellwig wrote:
> The NVMe drivers support a mode where no tagset is allocated for the I/O
> queues and only the admin queue is usable.  In that case ctrl->tagset is
> NULL and we must not call the block per-tagset quiesce helpers that
> dereference it.
> 
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> Reported-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> It turns out we have a bunch of other quiesce calls that can happen when
> only the admin queue is live.  So bring back the original quick fix to
> check for the tagset pointer in the quiesce helpers.
> 
>   drivers/nvme/host/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3195ae17df309..fd2e26cb7a688 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5215,6 +5215,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
>   void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
>   {
> +	if (!ctrl->tagset)
> +		return;
>   	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>   		blk_mq_quiesce_tagset(ctrl->tagset);
>   	else
> @@ -5224,6 +5226,8 @@ EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
>   
>   void nvme_unquiesce_io_queues(struct nvme_ctrl *ctrl)
>   {
> +	if (!ctrl->tagset)
> +		return;
>   	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>   		blk_mq_unquiesce_tagset(ctrl->tagset);
>   }
> 

