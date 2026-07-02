Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BC6C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 02:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8kqHDz1T8vPkOVeqe1XSIrL8LjI68jWeARu4pzITenY=; b=vVolQULoqJ0sMKVdwti6zLtVjb
	8227bUVN5/stc6aviTeqY20C9btYJlPzzkxJgYeGTNU03Sg35fak88Qve13bjHrSu2YvjMy4Cm5jV
	hVmCDeAc/JCSrOzoPTwwhw50wEm/gtTXOrWlj4LMQ+gQDCR+w1XEb5NfAU9jtD7h3hKFWSiEsQeXE
	slQ40HNpXpC/qHib7BMjn4NccYY+DJc2U24c5JEJ0OzoMWxj7j8SvjydTQqV135iQrFs74P+mWs9F
	hPBACH8lOQ4/X5ij/oseu51BwU/RgXA7gmT8CmRWGRVCB9I5/W+JyM4qtiIOyA8y3rned2P3P842D
	SS9n3QLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf7GV-00000003QzV-1l7v;
	Thu, 02 Jul 2026 02:34:59 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wf7GR-00000003Qyr-2PQ5
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 02:34:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782959689; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8kqHDz1T8vPkOVeqe1XSIrL8LjI68jWeARu4pzITenY=;
	b=LUR6SWoimTDoiHVKvUNSg2DIF4pP9A9ZBw8ggc5mrxVmE+3VDAbJxMT3yuF5k6+SnmWiIEdJXsHfJwFxfTVg3bUQ6k2UVzHQ0r6OZsBd8Qzd/OWv5Y0jEZn/+hNCxCktdubmHGqNebSepOEena4WdyX58Mf1pmp4LZGukTa3r6w=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X6COG0M_1782959686;
Received: from 30.178.83.30(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6COG0M_1782959686 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jul 2026 10:34:47 +0800
Message-ID: <2dc374ad-b365-48c0-8d45-aacf53f80e4c@linux.alibaba.com>
Date: Thu, 2 Jul 2026 10:34:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme: Introduce service-time iopolicy
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, onathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org
References: <20260617114602.2224074-1-kanie@linux.alibaba.com>
 <8103a626-d07b-4b20-b10e-d258485176ee@suse.de>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <8103a626-d07b-4b20-b10e-d258485176ee@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_193456_323336_E4DA0348 
X-CRM114-Status: GOOD (  12.00  )
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



在 2026/7/1 19:14, Hannes Reinecke 写道:
> On 6/17/26 1:45 PM, Guixin Liu wrote:
>> Hi all,
>>    I developed the service-time iopolicy in nvme native
>> multipath, please review, all comments are wellcome.
>>
>> Guixin Liu (2):
>>    nvme-multipath: add service-time I/O policy
>>    docs: nvme-multipath: document service-time I/O policy
>>
>>   Documentation/admin-guide/nvme-multipath.rst |  31 +++-
>>   drivers/nvme/host/multipath.c                | 165 ++++++++++++++++++-
>>   drivers/nvme/host/nvme.h                     |   6 +
>>   drivers/nvme/host/sysfs.c                    |   5 +-
>>   4 files changed, 202 insertions(+), 5 deletions(-)
>>
> We're still waiting for the adaptive I/O policy to be included, so I
> guess this patch should build on top of that.
>
> Cheers,
>
> Hannes
Yes, I work on that adaptation. But I thought it would be helpful
for the maintainers to review the logic here first before I proceed.

Best Regards,
Guixin Liu


