Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F50C47077
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 09:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NETILNa0PVW4/P7vbkQQQ0V8g//bQJ+Q86LoL2go+L0=; b=PM9qLc+VGP8XXqRz1nJZ42UC51
	81XpcKp3aGAGDl8+YgENmV5jcbfQebc00ZAfvLdq2WxWP50JPoQbMdkUOQz6sXqEWiHYptaP+NCNT
	sARN5NPKjFHt2WJH0L5jwusgIeAeRc4+VJrdhUny0EAln/P5bqAYy9lSux/1bQr22qgLGeSAIUwnv
	Iw6NySFxu59SBC85kPqTxaHG08zUWZDg9PEpbuctDFlb6rRmWW77p8L5iXch2KOyoLttPfjOq535g
	Yi1vfULW9VPfZHEsxFvsmUVmGk3yEx7ngPtHqzp1ll00uqcafdler02i9vn4v/jwrdg974KIZZ8Pa
	mc0Gr3Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPgCQ-00BcR3-0G;
	Tue, 16 Jan 2024 09:57:38 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPgCN-00BcQC-2j
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 09:57:37 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-lnldJ_1705399051;
Received: from 30.178.82.220(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-lnldJ_1705399051)
          by smtp.aliyun-inc.com;
          Tue, 16 Jan 2024 17:57:32 +0800
Message-ID: <2a71b2aa-7ce3-458d-a065-da38e254bbbb@linux.alibaba.com>
Date: Tue, 16 Jan 2024 17:57:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] nvme: introduce pr_work to handle resv event
Content-Language: en-GB
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kch@nvidia.com,
 chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240114092314.63694-1-kanie@linux.alibaba.com>
 <20240114092314.63694-4-kanie@linux.alibaba.com>
 <dcfe1277-bb99-4245-9f28-ae14e8ed8954@grimberg.me>
 <11bdf630-66b4-433a-a7c2-ff5d6d4f1b76@linux.alibaba.com>
 <0351e7e8-2bfd-4161-a4a4-1a0c521bd337@grimberg.me>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <0351e7e8-2bfd-4161-a4a4-1a0c521bd337@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_015736_229502_B8311BD0 
X-CRM114-Status: GOOD (  14.15  )
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


在 2024/1/16 15:59, Sagi Grimberg 写道:
>
>
> On 1/16/24 04:02, Guixin Liu wrote:
>>
>> 在 2024/1/15 16:59, Sagi Grimberg 写道:
>>>
>>>> When a reservation event is reported, the corresponding log page is
>>>> already on the target side, and the host side needs to send a get
>>>> log command to clear these log pages.
>>>
>>> AENs are already sent to userspace, I don't see why the kernel
>>> should read the log page unless it has something meaningful to
>>> do with it.
>>>
>> Is it tolerable if we dont clear the log page?
>
> Its up to the host. If the host has nothing to do with it
> then it doesn't have to do anything with it. I'm assuming
> that the user exercising reservations would listen to udev.
>
> Perhaps libnvme would be the place we want to allow users
> to consume an api to deal with reservation events.

Agree, the userspace may use the reservation log page's information,

I will do a research on libnvme to see if we can add a consuming api after

this is done.


