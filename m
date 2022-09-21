Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF61C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qZixGkfzqI/2LNbOOCB87XTtFWzs3bCYglVrktfOzw4=; b=tEibEQnTwh0Ok/exWpuaaUOq6Q
	pHtwfCeb2efSxx51E3Ln9eIqdjKioKs6xFVAWn6asl28Hs76oZtIcs8mBTkpl8PS/3kEdlaOfqNvG
	jpkmE0J0H0T43tIXD14v5HdUkYNACLVlWwlxVvX4u9P93Ojz8OzHkejMGouIWoy+ZmzfETtEa2QRr
	zkvBb+sNGckTKp0D4KzgwsUq7/yufnN9B5I+pK0wSKrVSMzWe2m8scl71Sn2n/uo9mjWTNDL+f+Dc
	nX5WyuXCyp8Wc18ih5aDe9fxFNhqDUscsYoVT7gKbPOZJzB3nMSkuuahb47nkwqS47zLEIcFj8rr8
	NxG1+B7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oawa2-00AiJa-O0; Wed, 21 Sep 2022 10:03:46 +0000
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oawZy-00AiGA-LP
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 10:03:44 +0000
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1oawZs-0007eK-Bn; Wed, 21 Sep 2022 12:03:36 +0200
Message-ID: <d6dd7b47-2c32-2de2-7282-0112ab73dc15@leemhuis.info>
Date: Wed, 21 Sep 2022 12:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com, Inc. NVMe
 SSD Controller" from 5.19.y (issue bisected) #forregzbot
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc: linux-nvme@lists.infradead.org
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
 <7883f05d-9ed8-2be3-3f9f-4f814aefe55a@leemhuis.info>
In-Reply-To: <7883f05d-9ed8-2be3-3f9f-4f814aefe55a@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663754622;aa14fda4;
X-HE-SMSGID: 1oawZs-0007eK-Bn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_030342_869126_89FCBE13 
X-CRM114-Status: GOOD (  10.66  )
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

On 08.09.22 12:41, Thorsten Leemhuis wrote:
> TWIMC: this mail is primarily send for documentation purposes and for
> regzbot, my Linux kernel regression tracking bot. These mails usually
> contain '#forregzbot' in the subject, to make them easy to spot and filter.
> 
> On 07.09.22 08:05, Jaroslav Pulchart wrote:
>> Hello,
>>
>> I would like to report a regression issue in 5.19.y in NVMe driver.
>>
>> The issue is reproducible at AWS EC2 instances with local NVMe storage
>> like "r5d.*". Kernel report "IO queues not created":
>> [    2.936641] nvme nvme0: 2/0/0 default/read/poll queues  <- EBS volume
>> [    2.939493] nvme nvme1: 2/0/0 default/read/poll queues  <- EBS volume
>> [    2.940797] nvme nvme2: IO queues not created              <- Local volume
>> with 5.19.y (kernel 5.19) and the nvme storage cannot be used.
>>
>> I bisected the issue to commit
>> "aa41d2fe60ee2e4452b0f9ca9f0f6d80a4ff9f9d" (nvme: set controller
>> enable bit in a separate write). Reverting it makes the nvme device
>> working again:
>> [    3.025599] nvme nvme0: 2/0/0 default/read/poll queues
>> [    3.032467] nvme nvme2: 8/0/0 default/read/poll queues
>> [    3.040040] nvme nvme1: 2/0/0 default/read/poll queues
> 
> #regzbot ^introduced aa41d2fe60ee2e4
> #regzbot title block: nvme: AWS EC2 instances with local NVMe storage fail
> #regzbot ignore-activity

#regzbot invalid: will be fixed by a rollout of a new firmware, for
details see the answers to this mail:
https://lore.kernel.org/linux-nvme/18e67378-1365-5e36-981b-13cada73bcda@leemhuis.info/

