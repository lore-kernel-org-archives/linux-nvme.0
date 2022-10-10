Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBB4C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Oct 2022 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88C0hS2W6y5H7jG06tYJs9MLmjDb6gtejt+jn8F3lIM=; b=uGwJwRYipBH/I/6N5TJ73qhsCh
	sRFNPu2cTjxuGFMNlCrnSulB/XPKIomL2rWf1/D1iN4F4699hqzfmYNv+wg3b3Ab5jFG+e+gWPCHE
	PHmkPEv4unlmzLc8f5TQlXZZYLAXdh9Oa5JZB8vObFZod+1PY96EO3a7YEK8SC8kRzGXJa7HTP8nv
	Ad2qBjfehDe6k174DocP+1BNWLNqQTjwROu57xgm5XwbzMUtSrXDm1hKdXlaJ/p6YH30VVEwOhwI8
	hfekKxIVAzA9tUWYykO/aCpAWvNq5xufchqYTTI0fIkXSh+7t2SKyvaIxHowWWTtrVgPfvmkEoFys
	UGAWCbMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoQp-0005Bk-G2; Mon, 10 Oct 2022 08:46:39 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ohoQm-00057L-E8
	for linux-nvme@lists.infradead.org; Mon, 10 Oct 2022 08:46:38 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MmC870VP2zVhqx;
	Mon, 10 Oct 2022 16:41:59 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 16:46:22 +0800
Subject: Re: [PATCH 0/3] improve nvme quiesce time for large amount of
 namespaces
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<kbusch@kernel.org>, <axboe@kernel.dk>
References: <20220729073948.32696-1-lengchao@huawei.com>
 <20220729142605.GA395@lst.de>
 <1b3d753a-6ff5-bdf1-8c91-4b4760ea1736@huawei.com>
 <fc7a303f-0921-f784-a559-f03511f2e4be@grimberg.me>
 <20220802133815.GA380@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <537c24ba-e984-811e-9e51-ecbc2af9895d@huawei.com>
Date: Mon, 10 Oct 2022 16:46:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220802133815.GA380@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221010_014636_674803_4D6916E2 
X-CRM114-Status: GOOD (  15.59  )
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



On 2022/8/2 21:38, Christoph Hellwig wrote:
> On Sun, Jul 31, 2022 at 01:23:36PM +0300, Sagi Grimberg wrote:
>> But maybe we can avoid that, and because we allocate
>> the connect_q ourselves, and fully know that it should
>> not be apart of the tagset quiesce, perhaps we can introduce
>> a new interface like:
>> --
>> static inline int nvme_ctrl_init_connect_q(struct nvme_ctrl *ctrl)
>> {
>> 	ctrl->connect_q = blk_mq_init_queue_self_quiesce(ctrl->tagset);
>> 	if (IS_ERR(ctrl->connect_q))
>> 		return PTR_ERR(ctrl->connect_q);
>> 	return 0;
>> }
>> --
>>
>> And then blk_mq_quiesce_tagset can simply look into a per request-queue
>> self_quiesce flag and skip as needed.
> 
> I'd just make that a queue flag set after allocation to keep the
> interface simple, but otherwise this seems like the right thing
> to do.
Now the code used NVME_NS_STOPPED to avoid unpaired stop/start.
If we use blk_mq_quiesce_tagset, It will cause the above mechanism to fail.
I review the code, only pci can not ensure secure stop/start pairing.
So there is a choice, We only use blk_mq_quiesce_tagset on fabrics, not PCI.
Do you think that's acceptable?
If that's acceptable, I will try to send a patch set.
> 
> .
> 

