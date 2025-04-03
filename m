Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE8DC3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gorDfBBrZ3CjmyAivfOwac52aytx9jm2PBXT7i3U/x8=; b=lojd8jeeIVY790PBrrNIChF02a
	tGrPxD792qdOrLIfiNwRTVYdtQA/sX03hOeozT7M4LBrRTgbpYh2pZ82P3kC2cA0Mb/YOH6gVFUxH
	+xR8ptf9qoXkO/6utJJlUDvrQcPeYkzzqA1NBk1shuHHfuoLY35SkQbzlLr9EV0D4alg1nKZU5Bqp
	E3hGdrGqlUFfbKMJ2nzlIHVVTm/cEvIzE4AUm2zygsR/ZFJTnVh3A39LZlDZlgsWi3DNlW2tJWsU3
	WGeeQsgnC85S32wLb+w1Dso5bsiWFRF459Os01V0HtOoG1jPsfDxQJUcMFKT+YIu0J2JNizXkENUl
	cR2STNrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0L8L-00000008zYy-2IY7;
	Thu, 03 Apr 2025 14:01:29 +0000
Received: from [1.203.97.240] (helo=smtp.cecloud.com)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0L6y-00000008zEu-11zK
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 14:00:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by smtp.cecloud.com (Postfix) with ESMTP id EA3EE900115;
	Thu,  3 Apr 2025 21:59:54 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [10.32.170.7] (unknown [111.48.58.12])
	by smtp.cecloud.com (postfix) whith ESMTP id P3907747T281458165674352S1743688793004956_;
	Thu, 03 Apr 2025 21:59:53 +0800 (CST)
X-IP-DOMAINF: 1
X-RL-SENDER: shaopeijie@cestc.cn
X-SENDER: shaopeijie@cestc.cn
X-LOGIN-NAME: shaopeijie@cestc.cn
X-FST-TO: hch@lst.de
X-RCPT-COUNT: 8
X-LOCAL-RCPT-COUNT: 2
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 111.48.58.12
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <b8a06d17501ce1179f14244e491592d0>
X-System-Flag: 0
Message-ID: <bd5f2f8a-94f0-43b0-af02-565422d12032@cestc.cn>
Date: Thu, 3 Apr 2025 21:59:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix netns UAF introduced by commit 1be52169c348
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 gechangzhong@cestc.cn, zhang.guanghui@cestc.cn
References: <1f55b71d-8e28-4eac-b14e-d32a7e704578@cestc.cn>
 <20250401061934.2304210-1-shaopeijie@cestc.cn>
 <20250403043001.GA22526@lst.de> <20250403043034.GB22526@lst.de>
Content-Language: en-US
From: Peijie Shao <shaopeijie@cestc.cn>
In-Reply-To: <20250403043034.GB22526@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_070004_498284_CFBEBA96 
X-CRM114-Status: UNSURE (   9.88  )
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

On 4/3/2025 12:30 PM, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 06:30:01AM +0200, Christoph Hellwig wrote:
>>> +	ret = sock_create_kern(&init_net,
>>>   			ctrl->addr.ss_family, SOCK_STREAM,
>>>   			IPPROTO_TCP, &queue->sock);
>>
>> This can be realigned:
>>
>> 	ret = sock_create_kern(&init_net, ctrl->addr.ss_family, SOCK_STREAM,
>>   			IPPROTO_TCP, &queue->sock);
> 
> Also did the original patch get merged already?  If not please fold
> both into a single one.
> 
> 

Thanks!

Yes,the patch is merged into 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1be52169c3488ef98582ed553ab35cefa3978817

Style problems will be fixed in v2 version.






