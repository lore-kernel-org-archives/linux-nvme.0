Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1F3C47089
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 01:21:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AD560E09
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 01:21:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58AD560E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2yPC8KQeumYdGkwp97ulVGdqDeMc7QO9UotWpw8VTU=; b=uGAqfV0q565IJXsz+2vzzSSkPO
	AIxgFmKAbWRUlNefaV+ot094Cy9EBWvQC9oHPyG7TFbvj/vx6sbmYaE4Q7FzcrXDIZs3bxVJLVkH9
	KGxpcx2yy8Vaz4dHN++Ux0IPZ6CrawEKM8n0TbtOg6ERftQvJWm5Gwxw7Xn22mX+W8JhPbWQHcIgf
	zrchZZtuEk+xvEXp0GWpngp8Qzy6leoET0XB9RiMkdNRcBhR3Q8sYM/Q7IS2HCKVeaNfUGFf86EQd
	Jxi/l+QXp/9gaOWBmuS9Eh1z0E21ktzoGoJYOXNzn2+C4QVe2Z0rd92lRpzd14IFD2r6nXrvoxpnH
	ju8qyYaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmRBy-00AuGZ-DI; Fri, 28 May 2021 01:21:38 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmQz8-00Ap4w-04
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 01:08:23 +0000
Received: from dggeml705-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrmhG2r1NzYqQ7;
 Fri, 28 May 2021 09:05:34 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggeml705-chm.china.huawei.com (10.3.17.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 09:08:14 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 28
 May 2021 09:08:14 +0800
Subject: Re: [PATCH] nvme-rdma: fix in-casule data send for chained sgls
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: Max Gurtovoy <maxg@mellanox.com>
References: <20210527204016.379365-1-sagi@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <48f23b84-8a1e-e298-be91-0627c1112fd8@huawei.com>
Date: Fri, 28 May 2021 09:08:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210527204016.379365-1-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme715-chm.china.huawei.com (10.1.199.111) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_180822_261290_0C79E535 
X-CRM114-Status: GOOD (  17.32  )
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



On 2021/5/28 4:40, Sagi Grimberg wrote:
> We have only 2 inline sg entries and we allow 4 sg entries for the send
> wr sge. Larger sgls entries will be chained. However when we build
> in-capsule send wr sge, we iterate without taking into account that the
> sgl may be chained and still fit in-capsule (which can happen if the sgl
> is bigger than 2, but lower-equal to 4).
> 
> Fix in-capsule data mapping to correctly iterate chained sgls.
> 
> Reported-by: Walker, Benjamin <benjamin.walker@intel.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 8d107b201f16..ed1bf214c544 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1320,16 +1320,16 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
>   		int count)
>   {
>   	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> -	struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
sgl need to be defined.
>   	struct ib_sge *sge = &req->sge[1];
>   	u32 len = 0;
>   	int i;
>   
> -	for (i = 0; i < count; i++, sgl++, sge++) {
> +	for_each_sg(req->data_sgl.sg_table.sgl, sgl, count, i) {
>   		sge->addr = sg_dma_address(sgl);
>   		sge->length = sg_dma_len(sgl);
>   		sge->lkey = queue->device->pd->local_dma_lkey;
>   		len += sge->length;
> +		sge++;
>   	}
>   
>   	sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
