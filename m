Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29083C43458
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 01:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0w71MA2ljhv2XrRfCQRwFFnzTbOhRZu4sDnxCZj9HNY=; b=AzC58rHsvnSFTaiRdcxm/Pw28h
	0ULHF0GfB4mc2l/M37v2p2UfafVvH+yxy0g3PVGetWn8FYTCCsBvC6j9w+AzTtlJAFS2XxG0u5NMz
	d4wsIl9ZtQc/dMdYXVtsGTZ/aSo3b/bDg1LU7p+TUwDk4MECIuJa3amzhSJjyKZ8VngHX1IrxA9G3
	Id6zPhzoCN7rmUpQqM/0FvmQYEqizs3m21J6Z9bGr83JytBVs5rr1fpvi3kSkjzPpbPU8PNHelOHb
	qpHWVe8fVki/GuN/wdgHIS+UwJ1EqGx3n7ntzhDMrTmtck1Lz3XmXAlF518XOAPdTk6waADcXS0gU
	cTDF/FPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfT3r-00000005qMy-3It2;
	Fri, 03 Jul 2026 01:51:23 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfT3n-00000005qMO-3fAX
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 01:51:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783043475; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0w71MA2ljhv2XrRfCQRwFFnzTbOhRZu4sDnxCZj9HNY=;
	b=CfDXd58FaJ5ubZOWAkc/RxPxe/lEfMGaOSlYa1Ew/FAi5vEszDuyoUEzxlW6wEMGIUKGCP0YFgUr1UOSQA5pIJI5VcC1iwJgORe72aHl51u6+bzEKWdBoI/sym34H7J2/BqDNRd2CmZbPlGjimKnGrAzFw0eRu/tDLYozTvmFBk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X6HIFuJ_1783043474;
Received: from 30.178.82.218(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X6HIFuJ_1783043474 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 09:51:15 +0800
Message-ID: <74cb62d6-8003-437b-a57e-0bdbd9e9cc69@linux.alibaba.com>
Date: Fri, 3 Jul 2026 09:51:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmet: add ABI documentation for target configfs
 interfaces
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 John Garry <john.g.garry@oracle.com>, Nilay Shroff <nilay@linux.ibm.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 xlpang@linux.alibaba.com, oliver.yang@linux.alibaba.com
References: <20260702034845.3066876-1-kanie@linux.alibaba.com>
 <20260702034845.3066876-3-kanie@linux.alibaba.com>
 <9b41ed73-9539-4e6d-bdc1-bdde4652e715@flourine.local>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <9b41ed73-9539-4e6d-bdc1-bdde4652e715@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_185120_543197_356FB505 
X-CRM114-Status: GOOD (  10.11  )
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



在 2026/7/2 21:33, Daniel Wagner 写道:
> On Thu, Jul 02, 2026 at 11:48:44AM +0800, Guixin Liu wrote:
>> Add Documentation/ABI/testing/configfs-nvmet documenting all NVMe
> As far I am aware, nvmet is actually also used in production systems.
> Thus it's not just an testing API I think.
>
> Thanks for doing this!
>
> BTW, I agree with Hannes, grouping them together makes it easier to
> consume. Obviously they can still be sorted by time withing a group if
> this makes sense.
>
> Cheers,
> Daniel
Yes, please see the v2 patch set.

Best Regards,
Guixin Liu


