Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BCAC433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Q14Ro4GxXqnphbHcHkAMcT3Ofe13f9JuBS+DiJ41+Y=; b=ooOFG42VDKWNv1XVqcgJqOcYzh
	DJmvfbbxSgrqZF2u/SnCNzy2aFu8JX3VYEd6NxpXWQqiMl6/wEvkyH3gh5D+7I/fJf5nJIAv0Xh7U
	kAFAQIRyP/AMA9XqtQhG76Vq46OGL5JC9BCClFRUATm47sn1jTYFb+mq4kI0tYdxDM5s8ciGk1tIK
	USmx2Is5HcDYrwCqwh4T3IMU0ywTYuKhJD/SzrqnX6RxYIqEuCLggXFKmZOo+k2d6pDBO62EYzrHF
	Ctahtcw6bKXsyIBYcBrLiR9wpBYZ8O12DesI3ZZOni6RpgYfzgsqjO1Z4HWor0DS5Ma+c55IlKUnN
	BA6Nd8Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouiZr-005n03-J4; Mon, 14 Nov 2022 23:09:19 +0000
Received: from out0.migadu.com ([94.23.1.103])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouiZo-005mz4-5N
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 23:09:18 +0000
Message-ID: <65816415-303d-5579-4878-d8cba766f797@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1668467352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q14Ro4GxXqnphbHcHkAMcT3Ofe13f9JuBS+DiJ41+Y=;
	b=xu2cyA8RSQdvsixLy39t6XZ9gfOAhEdgCleuGTGifKqtfq/I8uVBhykY6pR3nIsSPn5G5y
	+DNVzgVGhRsS3M391sYMJksEtXHvR8vN1Ec3WvsKdodGsDyNfHr3UU92cBU90JPTd9rWZY
	1nhgTuXIJaPMdhAqlsUCsnpSNJD5vP8=
Date: Mon, 14 Nov 2022 16:09:08 -0700
MIME-Version: 1.0
Subject: Re: Resets during user commands leads to hung task and controller
 stuck in connecting
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@fb.com>,
 hch@lst.de, linux-nvme@lists.infradead.org
References: <d4a25dc1-fd2b-8f25-9ec1-04b28dfac386@linux.dev>
 <1ffea25b-6f67-a1e6-5b96-22bf3b4d89ec@grimberg.me>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <1ffea25b-6f67-a1e6-5b96-22bf3b4d89ec@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_150917_204665_5696DF72 
X-CRM114-Status: GOOD (  10.26  )
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



On 11/13/2022 4:03 AM, Sagi Grimberg wrote:
> 
> 
> On 11/11/22 23:50, Jonathan Derrick wrote:
>> Hi,
>>
>> I'm (again) seeing a hung task when doing resets and formats simultaneously.
>> Controller state is left in 'connecting'
>>
>> Using nvme.git/nvme-6.2 as of 'nvme: implement the DEAC bit for the Write Zeroes command',
>> but I have also repro'd with Christoph's latest reset/probe-split set
>>
>>
>> ctrl="nvme0"
>> nsid=1
>> pci="/sys/block/${ctrl}n${nsid}/device/"
>> echo 30 > /proc/sys/kernel/hung_task_timeout_secs
>> while true; do
>>          nvme format -f /dev/${ctrl}n${nsid} &
> 
> How long to it take the format to complete?
Well it's pretty immediate but I'm under the impression that the
nvme_dev_disable path leads to CC_EN disabling, interrupting any formats

> 
>>          echo 1 > $pci/reset_controller &
>> done
> 
> What happens if you set io_timeout to 20 instead of 30? (given
> that you bound hung tasks at 30 seconds...
It occurs with the standard 120s task timeout too
Also there's no I/O occurring at the moment; just admin work

I added a blktests for this:
http://lists.infradead.org/pipermail/linux-nvme/2022-November/036475.html

