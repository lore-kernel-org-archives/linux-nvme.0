Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCDEC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 06:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85td8lfeKN6qjBLmZIKTnsiFfWCuq1Xuhwm1YzEO3Qs=; b=DpNOlo0SLmTwwF1kNNect/BKhl
	WEagrrTcyGARWzWs7/NO2PjY0y9PCRJ40XPpm4czEpM8rUGNVsCL+Q9CM2/p+BdRjVcQbcEVVcuUL
	W0IwgB3/gWsCvgspjw1GVpsSnpmHQzoI06gj0XGeEKBRxh5aLNHy9dsbxhRl/zFF88fVadgBmEEy+
	ujgP+DSON+el533MarEa7laGopYuG3eu48M3I1KappHMooripjTQCYMjD0O26UNCUhKeTXr0z1z9G
	1Oj1Aqb//+FhIiM46M2Wp395nh+ei8yH0mM2VkOT3kIPMF1+bMrXSaLT4i6zWCYIu59kyk22LjM8q
	XBt+5soQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7rUW-004Feq-1x;
	Tue, 28 Nov 2023 06:22:40 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7rUT-004FeF-0z
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 06:22:38 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VxJbmTM_1701152551;
Received: from 30.178.66.233(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0VxJbmTM_1701152551)
          by smtp.aliyun-inc.com;
          Tue, 28 Nov 2023 14:22:33 +0800
Message-ID: <65b0c372-b308-46dd-c2f2-a5ddb50adb10@linux.alibaba.com>
Date: Tue, 28 Nov 2023 14:22:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] nvme: fix deadlock between reset and scan
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kanie@linux.alibaba.com
References: <1700737213-110685-1-git-send-email-yaoma@linux.alibaba.com>
 <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
From: yaoma <yaoma@linux.alibaba.com>
In-Reply-To: <ZWTa0DJmcLKHRWWC@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_222237_499716_343BD84B 
X-CRM114-Status: GOOD (  13.51  )
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

Hi Keith Busch

Thanks for your reply.

The idea to avoid such a deadlock between nvme_reset and nvme_scan is to 
ensure that no namespace can be added to ctrl->namespaces after 
nvme_start_freeze has already been called. We can achieve this goal by 
assessing the ctrl->state after we have already acquired the 
ctrl->namespaces_rwsem lock, to decide whether to add the namespace to 
the list or not.
1. After we determine that ctrl->state is LIVE, it may be immediately 
changed to another state. However, since we have already acquired the 
lock, other tasks cannot access ctrl->namespace, so we can still safely 
add the namespace to the list. After acquiring the lock, 
nvme_start_freeze will freeze all ns->q in the list, including any newly 
added namespaces.
2. Before the completion of nvme_reset, ctrl->state will not be changed 
to LIVE, so we will not add any more namespaces to the list. All ns->q 
in the list is frozen, so nvme_wait_freeze can exit normally.


On 2023/11/28 02:07, Keith Busch wrote:
> On Thu, Nov 23, 2023 at 07:00:13PM +0800, Bitao Hu wrote:
>> @@ -3631,6 +3631,11 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>   		goto out_unlink_ns;
>>   
>>   	down_write(&ctrl->namespaces_rwsem);
>> +	/* preventing adding ns during resetting */
>> +	if (unlikely(ctrl->state != NVME_CTRL_LIVE)) {
> 
> We can't rely on ctrl->state for preventing deadlocks. Reading unlocked
> ctrl->state is often used, but should be considered advisory-only since
> the state could change immediatly after reading it.
> 
>> +		up_write(&ctrl->namespaces_rwsem);
>> +		goto out_unlink_ns;
>> +	}
>>   	nvme_ns_add_to_ctrl_list(ns);
>>   	up_write(&ctrl->namespaces_rwsem);
>>   	nvme_get_ctrl(ctrl);

