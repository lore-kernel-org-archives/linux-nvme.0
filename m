Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25583C88E5C
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gfrgnU5kGcBcgW+Uhw3uEW/ezFI1EDvxmGj0bmDTCL8=; b=AQq/fiRxhMtNRYnPnBWTu3DIuj
	FAODZb89CAVHMb+2u/d+ODyPH/wAYmVxQdGNYiGce8V662cFmuRVTiLmKqpqTrFBnp7jOD02gNcMo
	D1IsgA6I+/G3EgnPGSnT+UTw9dbMqlyAvBqHbeO1RaY/ZdbX9Tw9hY2ovDJiqBhEuVEA3RIOQICr9
	dpOythPO5cfEURRaW4hVIIx5l5iKXnuaMC/o176x7WTQECU1Z9vwi1nHlJsP3YrR6MXqpiQFIexox
	wEJjxwU4xP9JY0CNEukE0mnLO6cndjsns0GM0O8upzCRyq+H8iwFbnLFm48F8K5LJgKkXir2l6s68
	QCtW0BYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6nzw-000000095z7-3yyy;
	Wed, 16 Sep 2026 11:40:20 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6nzt-000000095yK-0cYQ
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 11:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789558810; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gfrgnU5kGcBcgW+Uhw3uEW/ezFI1EDvxmGj0bmDTCL8=;
	b=W5TP5kn80aol/HpoYjSu8pXaEMD+1pCZFqAitcRCO5EUFGOM5cGqvMwPZ89oEGumQm3sbt0I5+Zh4ky4T1v10irp5TSq+eeueyCYnO3cd7cQkkpf4DvOClUy18PjFOnCVUyXW84CCtWRyehi009AYwaCAcIZ1/Fy4sWw3FBhC+E=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XB4wQn2_1789558808;
Received: from 30.178.84.130(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB4wQn2_1789558808 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 19:40:09 +0800
Message-ID: <c31cb0a3-cf24-458f-b77c-a97530963914@linux.alibaba.com>
Date: Wed, 16 Sep 2026 19:40:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme/070: add a test for Identify CNS 07h NULL pointer
 dereference
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, nilay@linux.ibm.com,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 linux-nvme@lists.infradead.org
References: <20260804024644.3830277-1-kanie@linux.alibaba.com>
 <ansFVrVVtnxfhi0Y@shinmob>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ansFVrVVtnxfhi0Y@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_044017_701259_AD9486ED 
X-CRM114-Status: GOOD (  14.26  )
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



在 2026/8/11 19:21, Shin'ichiro Kawasaki 写道:
> On Aug 04, 2026 / 10:46, Guixin Liu wrote:
>> nvmet_execute_identify_nslist() handles both the Active Namespace ID list
>> (CNS 02h) and the per-command-set variant (CNS 07h). For CNS 07h it
>> filtered the list on req->ns->csi, but this handler never resolves
>> req->ns, so it is always NULL. As soon as an enabled namespace with an
>> NSID above the requested value exists, the target dereferenced a NULL
>> pointer and oopsed.
>>
>> This test connects a target with a single namespace and issues an
>> Identify with CNS 07h starting from NSID 0, which is exactly the
>> condition that triggered the crash. Without the kernel fix [0] the target
>> oopses; with it the command completes normally.
>>
>> [0] https://lore.kernel.org/linux-nvme/20260730043105.3071328-2-kanie@linux.alibaba.com/
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>> v1 -> v2:
>>    - Use "nvme list-ns --csi=0" instead of a raw admin-passthru to issue
>>      Identify CNS 07h, as suggested by Nilay and Shinichiro; it drives the
>>      same target code path via the existing nvme-cli subcommand.
> Thanks for this v2 patch. It looks good to me. I will wait for the kernel side
> fix get settled on Linus master branch before I apply this patch.
Hi Shin'ichiro, the kernel side fix patch is already applied to master,
could you please apply this patch?

Best Regards,
Guixin Liu

