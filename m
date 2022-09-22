Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CA7C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k5Cj/nnVseaa6JJ7ozzLymqUACkukyFogkMehZ8Ki98=; b=yjpPR3T8aT3w3xJpQaAhcEfXF7
	rT92ccvAClAAPhjuZDOINwOaT9PUhERtKtjSc9twwjHOUX6HKazkdESBgu7cMFobI2F92b/yTbLYp
	BW0VeZUFHSzZ4roCn6P4TXm0lTylscVUOB4SwFj1JMgC+Ujzrhxa+81CHvsh4wEgkUMSGAeFM31Z/
	w398W6m1Tzi1d01rwDobgsfvoADl66Y/it9GN0xD5kDUgpuSnxIVCObnQDpyAGtxvnAZHoovZK2ge
	MsbPOaWVLMaqP1q0Hm/7JnGACrMOComMhKPGIoHwS6dicGpwExYs++CJjoXzyLUXjnT6/Q5Xqnt9O
	WC1BSPFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHA1-00E02J-7l; Thu, 22 Sep 2022 08:02:17 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obH9x-00Dzxx-HJ
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:02:15 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MY73r1gW6zHpjs;
	Thu, 22 Sep 2022 15:59:52 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 16:02:02 +0800
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, James
 Smart <james.smart@broadcom.com>, <linux-nvme@lists.infradead.org>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-2-hch@lst.de>
 <c9bc8a76-94aa-5a4c-526e-f92204635a22@huawei.com>
 <20220922054549.GB27338@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <a7bf9d8c-cb39-470c-1abe-ea78dc2d964d@huawei.com>
Date: Thu, 22 Sep 2022 16:02:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220922054549.GB27338@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_010213_796858_3DEE369E 
X-CRM114-Status: GOOD (  13.91  )
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



On 2022/9/22 13:45, Christoph Hellwig wrote:
> On Wed, Sep 21, 2022 at 11:37:08AM +0800, Chao Leng wrote:
>>> +	ctrl->connect_q = blk_mq_init_queue(set);
>>> +        if (IS_ERR(ctrl->connect_q)) {
>>> +		ret = PTR_ERR(ctrl->connect_q);
>>> +		goto out_free_tag_set;
>>> +	}
>> Maybe we should move the connect_q related code to nvme_alloc_admin_tag_set.
>> Thus we don't need to set NVMF_RESERVED_TAGS for tagset,
>> if there are large amount of ns queues, it will save resources.
>> At the same time, it will simplify tagset-based implementation.
>> According to the behavior logic, connect_q is a management resource.
>> However, connect_q use the I/O tagset.
>> As a result, it is difficult to process some logic based on tagset.
> 
> The fabrics connect command needs to be sent on each of the I/O
> queues in addition to the admin queue, which means the admin tag_set
> can't be used.
We can do some special processing in nvme_setup_cmd for connect command to
treat queue mapping.
Do you think that's okay?
> 
> 
> .
> 

