Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA8DC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 03:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qu9lwLogHwk0Ja5uPnO0qEC+tgCZwwo8mqiUjjo17Dk=; b=ShuI3MBeeElKbs05a0+h6BJJwr
	JUIFbG05XTivfZpc+SpA34h9Ua9xHuVm08yPyDuSWipa+67yXhFQwu9B9CMJpvKmlDbQA9aMtbUJ2
	g7HEHDlF7hwQpqU5hUOIzXIOrbsvebf2QXs2+rfLUz81YtXqXq1r7iQt7ihxwPIlILnzA7AleH5o/
	6BZhhZXzAtCfjFOg9rn40KlzleZ+sbDqcmTGWfh3E5GaycqQtsnivBa9hi0AvkgBkYQth8UoxQrR2
	ntXfk9IyLwg00Y30uDuMcxI93IJX8ZACPijbSuFoODy3Bn2lQ38URAzy2DJU3gBEy0ArNexyQPn6N
	Tw2MrRJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaqbX-008d0z-3o; Wed, 21 Sep 2022 03:40:55 +0000
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaqbT-008czw-Mb
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 03:40:54 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VQM7hzd_1663731646;
Received: from 30.178.80.176(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VQM7hzd_1663731646)
          by smtp.aliyun-inc.com;
          Wed, 21 Sep 2022 11:40:47 +0800
Message-ID: <e1d773e0-8964-dded-fbc1-b9f0a39bab8c@linux.alibaba.com>
Date: Wed, 21 Sep 2022 11:40:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for nvme
 devices
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
 <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
 <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com>
 <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
 <20220919143556.GA28122@lst.de>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20220919143556.GA28122@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_204051_937949_A8F25D89 
X-CRM114-Status: GOOD (  13.66  )
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


On 2022/9/19 22:35, Christoph Hellwig wrote:
> On Mon, Sep 19, 2022 at 08:10:31AM -0600, Jens Axboe wrote:
>> I'm not disagreeing with any of that, my point is just that you're
>> hacking around this in the nvme driver. This is problematic whenever
>> core changes happen, because now we have to touch individual drivers.
>> While the expectation is that there are no remote IPI completions for
>> NVMe, queue starved devices do exist and those do see remote
>> completions.
>>
>> This optimization belongs in the blk-mq core, not in nvme. I do think it
>> makes sense, you just need to solve it in blk-mq rather than in the nvme
>> driver.
> I'd also really see solid numbers to justify it.
>
> And btw, having more than one core per queue is quite common in
> nvme.  Even many enterprise SSDs only have 64 queues, and some of
> the low-end consumers ones have very low number of queues that are
> not enough for the number of cores in even mid-end desktop CPUs.

Hi

Thank you for your suggestion. Here is what I think about it. NVMe 
devices that can support
one core per queue are usually high-performance, so I prefer to make 
more optimizations
for high-performance devices, while for ordinary consumption class NVMe 
devices, such
modifications will not bring special additional overhead.

Thanks


