Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC96C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 05:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U257Kb1LRFOk76SED7btSb1YeSvePpQ36x4DmwmxZFo=; b=Kh+4NMJLhdaoHhXza9BkAfEZkt
	fZlS9eYAyT48kiULa3ystnzsy9RiGsU4x3CMxBTOJ97ceblkTYbuQokHKhKZzGAZ2eJqlXlAlPm2f
	JKbT3pWwfVFVPSgD8ka7NbEqw8krAcI2iClmqRM+BvjjPhy+rp+jLC2DntFaeKJetC6H/HrOlP3X+
	C6hCxB1usK3/XMbG8cxUlago7kosuYcXKEXaNVHMnjxDQk+m5YvJedVzdc1Jv+hxswzK/Q2OrwhpV
	CQEv39bGEZA9xXOrqUTAZGadtwLJ5Aw2ljvJytc7c2CrOBfnHPtYg/dIMWXt8gM9HcEmi6gGgyyVS
	sF7wQG1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNRcp-00AQvt-0y;
	Wed, 10 Jan 2024 05:59:39 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNRcm-00AQur-14
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 05:59:37 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-Kyl0H_1704866337;
Received: from 30.178.83.60(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-Kyl0H_1704866337)
          by smtp.aliyun-inc.com;
          Wed, 10 Jan 2024 13:59:30 +0800
Message-ID: <4ea7ccb9-a402-4ce8-9f76-b6ac9c74a83a@linux.alibaba.com>
Date: Wed, 10 Jan 2024 13:59:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: support reservation feature
Content-Language: en-GB
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
 <ZZ1713_D7MojvHUu@kbusch-mbp>
 <a56b996e-8d38-42e9-914c-8877182c5cc0@linux.alibaba.com>
 <a1e024e0-5218-4f94-ae31-05ba30bf77a9@nvidia.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <a1e024e0-5218-4f94-ae31-05ba30bf77a9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_215936_548885_12FCF0F3 
X-CRM114-Status: UNSURE (   8.93  )
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


在 2024/1/10 12:36, Chaitanya Kulkarni 写道:
> On 1/9/24 19:19, Guixin Liu wrote:
>> 在 2024/1/10 01:01, Keith Busch 写道:
>>> On Tue, Jan 09, 2024 at 08:10:08PM +0800, Guixin Liu wrote:
>>>> This patch implements the reservation feature, includes:
>>>> 1. reservation register(register, unregister and replace).
>>>> 2. reservation acquire(acquire, preempt, preempt and abort).
>>>> 3. reservation release(release and clear).
>>>> 4. reservation report.
>>>>
>>>> And also make reservation configurable, one can set ns to support
>>>> reservation before enable ns. The default of resv_enable is false.
>>>>
>>>> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>
>>>> ---
>>>> Hi guys,
>>>>       I've implemented the NVMe reservation feature. Please review
>>>> it, all
>>>> comments are welcome.
>>> Why? If you have a real use case, let's add a blktest example added to
>>> that project.
>> OK, I will research the blktests, and add some tests.
> Here is it :- https://github.com/osandov/blktests
>
> Please CC me and Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> when you send tests.
>
> -ck
>
Sure.

