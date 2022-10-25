Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80484C67871
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 01:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jpHrtm9VLAr7CCTKFZFxZgxxWYYOfDeeym/IQXkW714=; b=JucKsyQsLZshz/CVyi/xA2qSs9
	/rpMiapXyWMvZWBlfUXcGm+oH181X8S4YKuD5zIlG5grWnkS6HxbRitkPHTJUEXyr29XJNb3Iz7E5
	P2eU5ZzexyZA30tt+igUWT/fGLXCKdcwEPi1VN/Oqce/DtcBa5OcIeZ7O60wHeiQaKKebLd0/ptGk
	FH03BGOThPSYSJDgG61uWC91OmF+fs+cbG/D4oYo9D2EpvTK7cNrOATPYspgt0SnfDWA+tNB5W5Wx
	TjtnuKnL7rNAALEoMmhTm8XIddEsuFR+MUaLweSjERVh3KDfSbCkC2ytnXlIOQR1UMoINNd5xmIWc
	db7xIsnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on8u2-003ZNR-2L; Tue, 25 Oct 2022 01:38:50 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on8tz-003ZMl-0P
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 01:38:49 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MxDxC1F39zmVJL;
	Tue, 25 Oct 2022 09:33:51 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 09:38:41 +0800
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
 <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
 <e092e8b6-66d5-b191-805d-f49ffdafc8a8@huawei.com>
 <77784776-4e58-47d9-abde-a782f5ca7d3a@acm.org>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <3e055ac9-7ab9-d9f4-9f07-b0a422b35967@huawei.com>
Date: Tue, 25 Oct 2022 09:38:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <77784776-4e58-47d9-abde-a782f5ca7d3a@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_183847_248696_DBECC544 
X-CRM114-Status: GOOD (  11.42  )
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



On 2022/10/24 21:35, Bart Van Assche wrote:
> On 10/23/22 18:57, Chao Leng wrote:
>> blk_mq_quiesce_tagset() support concurrency. blk_mq_quiesce_tagset() just
>> check the flag(QUEUE_FLAG_SKIP_TAGSET_QUIESCE), it has no impact on concurrency.
> 
> Hi Chao,
> 
> I think it depends on how the QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag is set. I agree if that flag is set once and never modified that there is no race. What I'm wondering about is whether there could be a need for block drivers to set the QUEUE_FLAG_SKIP_TAGSET_QUIESCE flag just before blk_mq_quiesce_tagset() is called and cleared immediately after blk_mq_quiesce_tagset() returns? In that case I think there is a race condition.
> 
Even if dynamically modify the QUEUE_FLAG_SKIP_TAGSET_QUIESCE, it still has no
impact on concurrency of blk_mq_quiesce_tagset(). It may affect atomicity of
blk_mq_quiesce_tagset(), blk_mq_quiesce_tagset() do not ensure atomicity, the caller
should ensure it if needed.

