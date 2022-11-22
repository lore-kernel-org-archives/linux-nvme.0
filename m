Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CF8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 02:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j1V8UmHEgJKQsn1aP0kyN/tyVzUqvqbQuIl18lQ1umI=; b=ZuVUZ2r2LRrjuAu6Q7UgGRJT/E
	FH+VueprTHqD6CNG4wYB6d7RGrA/jZ1TPlr8hCi8+thfIPuYexzVE7UPerb9cvd91gEFpSPyZ8Q2h
	LrwZw++Xc638uPw0BJfnwU2R3yMzynXiWeyFxy2ByoQ45OoZ15c3dAMjDMdRCxsewXtRLlBz5CpKW
	GL3BkndZIUGQnboxvEPe2RVkK3BGTUqEKiH0WqqJPOUJcoZEtJoOtd0st5IfVbDZzodQMsPW5GzjE
	CUW484Tq08ChL5JTKfQjZ8ORAv1Jq+CkTdXYXuQiLrsL2LQdna0uxwnChdWURCySNtUneFBIdcn3a
	ItI5tvUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxJPg-002nwq-4m; Tue, 22 Nov 2022 02:53:32 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxJPb-002nYU-Ue
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 02:53:30 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGTMG67HgzHwLG;
	Tue, 22 Nov 2022 10:52:42 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 10:53:17 +0800
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
To: Shakeel Butt <shakeelb@google.com>, Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>, Hannes
 Reinecke <hare@suse.de>
References: <20221101150050.3510-1-hch@lst.de>
 <20221101150050.3510-15-hch@lst.de>
 <20221121204450.6vyg6gixsz4unpaz@google.com>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <a8e3d7a4-c5f6-13d0-a517-72097daa2a7b@huawei.com>
Date: Tue, 22 Nov 2022 10:53:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221121204450.6vyg6gixsz4unpaz@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_185328_205613_A1BC256C 
X-CRM114-Status: GOOD (  12.66  )
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



On 2022/11/22 4:44, Shakeel Butt wrote:
> On Tue, Nov 01, 2022 at 04:00:50PM +0100, Christoph Hellwig wrote:
>> From: Chao Leng <lengchao@huawei.com>
>>
>> All controller namespaces share the same tagset, so we can use this
>> interface which does the optimal operation for parallel quiesce based on
>> the tagset type(e.g. blocking tagsets and non-blocking tagsets).
>>
>> nvme connect_q should not be quiesced when quiesce tagset, so set the
>> QUEUE_FLAG_SKIP_TAGSET_QUIESCE to skip it when init connect_q.
>>
>> Currently we use NVME_NS_STOPPED to ensure pairing quiescing and
>> unquiescing. If use blk_mq_[un]quiesce_tagset, NVME_NS_STOPPED will be
>> invalided, so introduce NVME_CTRL_STOPPED to replace NVME_NS_STOPPED.
>> In addition, we never really quiesce a single namespace. It is a better
>> choice to move the flag from ns to ctrl.
>>
>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>> [hch: rebased on top of prep patches]
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Keith Busch <kbusch@kernel.org>
>> Reviewed-by: Chao Leng <lengchao@huawei.com>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> This patch is causing the following crash at the boot and reverting it
> fixes the issue. This is next-20221121 kernel.
This patch can fix it.
https://lore.kernel.org/linux-nvme/20221116072711.1903536-1-hch@lst.de/

