Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5D4ECAAD4
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Aug 2022 01:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N3iPjvdj5pOAeCbs7IhdKizKIbggeWdos0pHYCZdnuY=; b=qLw5t0+8+6S/bA9igDpVkzx/+j
	xBeN2yG+SHA8BFllOQ+xuTctkLSWIeUemQRrpMo7Oy2ViAtR/xz5Kk8a4AMPL6CueBNnw21+W8E9L
	xllBgCFaBm7hkN6hpBl35z/XhQXPhkD3HoET3RRD6VMiyMB8wMGzXVw2TM6EdEV+P7OcOS1X+K5ES
	G+zl1ACVSkL2uiBDgvvvYimugDVfJoC2l7VC/v5kidX6ffRApp2Pdto4OpQl2akV+pFW1iuqaAd8L
	tSz+hDh9iajXG18R04UnRNU0cGlnINTSAJrI0l52zPKD4lwQc2YlLuM/lqusJx1/giEtquZs3LlVT
	L6BQuXXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRkDZ-00Gn1n-CX; Sat, 27 Aug 2022 01:02:33 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRkDW-00GmSs-2j
	for linux-nvme@lists.infradead.org; Sat, 27 Aug 2022 01:02:32 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDyy76JwXzlWFc;
	Sat, 27 Aug 2022 08:58:55 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 09:02:13 +0800
Subject: Re: [PATCH v2 3/3] nvme-rdma: Handle number of queue changes
To: Daniel Wagner <dwagner@suse.de>
CC: <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-4-dwagner@suse.de>
 <17886a4c-8443-19a1-c2fa-d7ea0f2e5a1f@huawei.com>
 <20220825105550.3hxjveuex4nmup54@carbon.lan>
 <a232a477-b2a3-af6e-58fd-265d8f10bb25@huawei.com>
 <20220826063024.tndzjp7j6xhx3234@carbon.lan>
 <e9caacd6-033a-3f93-e9d5-2ad80fa07cfe@huawei.com>
 <20220826113341.nac4rgu3goa4enfq@carbon.lan>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <f7b6548b-8277-a52b-43c1-989b40b0a99b@huawei.com>
Date: Sat, 27 Aug 2022 09:02:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220826113341.nac4rgu3goa4enfq@carbon.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_180230_342074_80B48068 
X-CRM114-Status: GOOD (  15.32  )
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



On 2022/8/26 19:33, Daniel Wagner wrote:
> On Fri, Aug 26, 2022 at 03:31:15PM +0800, Chao Leng wrote:
>>> After seeing both version I tend to do say the first one keeps the
>>> 'wierd' stuff more closer together and doesn't make the callside of
>>> nvme_rdma_start_io_queues() do the counting. So my personal preference
>> I don't understand "do the counting".
> 
> Sorry. I meant we fist start only queues for which have resources
> allocated (nr_queues in my patch). And then we only need to start
> potentially added queues.
> 
>> Show the code:
>> ---
>>   drivers/nvme/host/rdma.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 7d01fb770284..8dfb79726e13 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -980,10 +980,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>>                          goto out_free_tag_set;
>>          }
>>
>> -       ret = nvme_rdma_start_io_queues(ctrl);
>> -       if (ret)
>> -               goto out_cleanup_connect_q;
> 
> Again, these need to start so that...
> 
>> -
>>          if (!new) {
>>                  nvme_start_queues(&ctrl->ctrl);
>>                  if (!nvme_wait_freeze_timeout(&ctrl->ctrl,
> 
> ... this here has a chance to work.
Some request will be submited, and will failed, and then retry
or failover. It is similar to nvme_cancel_tagset in nvme_rdma_teardown_io_queues.
I think it is acceptable.
> .
> 

