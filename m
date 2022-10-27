Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E779C38A2D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 02:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AIpK0zgOw9mFt7iotpX1xX9H1fvK6dQmg05JFITrd7Y=; b=TEfBqlGzSZJCUHjR63TdrWjsCb
	CEHg//TkfwgXI06H19e6yYKkzJUJtVrCc6dMxs3HCYryxil3qySpKacbWyDyij6qFA9PGtQp22Lr7
	U2NMMA3dfkh1agworWcQ9dlvLBzsVhVKfqTvF4/B+yCSDIxCxXTvbBKH/YfNAoDIE+TOLBk3vAdnr
	ZN2v+56PgbXsYZKYMb4azD39eRhxCTYEXGAjqP76YaJkhigpiMS2LMaHfm2XZ38NQtvLeNiPOn/j0
	XJvWBFM5O1hW08hZftjh+YXsOK5j1U3TA5/n+F1mj97hoFo6K2ah1a9bZ8pbXI9UEOzEZIK5WnYf7
	L/jj50Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onsuo-00BcJY-HM; Thu, 27 Oct 2022 02:46:42 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onsuh-00BcGz-J6
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 02:46:40 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MyVN83sY5zpW5s;
	Thu, 27 Oct 2022 10:43:04 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 10:46:30 +0800
Subject: Re: [PATCH 11/17] nvme-pci: don't unquiesce the I/O queues in
 nvme_remove_dead_ctrl
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-12-hch@lst.de>
 <cf78bcbb-b918-e9f5-186a-d1d804406011@huawei.com>
 <224ee1a1-e5ef-6644-36c4-8c1d84af10b0@grimberg.me>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <969c8745-74e6-0b4e-b7f3-62bd7ee488d7@huawei.com>
Date: Thu, 27 Oct 2022 10:46:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <224ee1a1-e5ef-6644-36c4-8c1d84af10b0@grimberg.me>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_194635_866577_DD1C0BA8 
X-CRM114-Status: GOOD (  11.27  )
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



On 2022/10/26 20:58, Sagi Grimberg wrote:
> 
>>> nvme_remove_dead_ctrl schedules nvme_remove to be called, which will
>>> call nvme_dev_disable and unquiesce the I/O queues.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>   drivers/nvme/host/pci.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index bef98f6e1396c..3a26c9b2bf454 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -2794,7 +2794,6 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>>>       nvme_get_ctrl(&dev->ctrl);
>>>       nvme_dev_disable(dev, false);
>> Currently set the parameter "shutdown" to false, nvme_dev_disable() do not unquiesce the queues.
>> Actually we should set the parameter "shutdown" to true.
>>          nvme_dev_disable(dev, true);
> 
> But the final put will trigger nvme_remove no?
No, it do not trigger nvme_remove.
However, the controller is actually in deleting state.
Unquiescing the queues seems to be the better choice here.

