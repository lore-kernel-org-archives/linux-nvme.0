Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B848ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 13:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tbVLFarkq7sCNfRDKII53vpd7diSz1XniHfFx25Dd78=; b=TBbU/lN94UramrZQWlNhaUyywN
	xuNxjv+AkIFuabCRcXR4x0Lo/Jv4WTp7MFmA/NKy+0DQQHHi1d2aHmCJu4TTdQIf42yavgkE7wugn
	vq9zJerIlbraFifK68lFSJPqaLjYOYqRYqqV88GW3yFwjZihljy3p+2tVma4MxqzB6BpMItWwQ+ON
	1Q+riqo3tJfSLAZfM/DAaasrZhkl2+ax5zuHVIfVlpLMLzX8aN7JS43MFnxwLkZAwdPVWVaRX2qrP
	950Hzt+L+dke8WidKygFTRMlLA7jfSmA5zGh01R3vNS5hs5xIOjCIDI1clbDh+c9++917e1F49ML7
	r9S4urng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSfEC-00ArgG-1M; Mon, 29 Aug 2022 13:55:00 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSed1-00Abw1-OK
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 13:16:45 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGW7G5xS8zYcy6;
	Mon, 29 Aug 2022 21:12:10 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 21:16:32 +0800
Subject: Re: [PATCH v3 3/3] nvme-rdma: Handle number of queue changes
To: Daniel Wagner <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes
 Reinecke <hare@suse.de>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-4-dwagner@suse.de>
 <5cc0b557-7e56-36c9-cfe4-05ca76f5e83e@huawei.com>
 <20220829093219.6ii76hne6pjzxjws@carbon.lan>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <8df0c325-0215-4019-d4cf-c7516863dbe4@huawei.com>
Date: Mon, 29 Aug 2022 21:16:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220829093219.6ii76hne6pjzxjws@carbon.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_061644_097836_41DBC414 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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



On 2022/8/29 17:32, Daniel Wagner wrote:
> On Mon, Aug 29, 2022 at 05:22:50PM +0800, Chao Leng wrote:
>>> +	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
>>> +					ctrl->tag_set.nr_hw_queues + 1);
>>> +	if (ret)
>>> +		goto out_wait_freeze_timed_out;
>> nvme_rdma_start_io_queues(ctrl, 1, nr_queues) need to clean.
> 
> the teardown path in nvme_rdma_stop_io_queus() is using
> 
>     test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags)
> 
> when iterating over all nr_hw_queues.
I mean that we need realloc the ctrl->queues for
nvme_rdma_start_io_queues(ctrl, 1, nr_queues).
Otherwise, unallocated memory will be accessed when
the new queue_count is bigger than the old one.
> .
> 

