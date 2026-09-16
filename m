Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F3FC88E5C
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Sep 2026 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l95ewKo8MGq9C+aZQGGQhmw6GY/07EhgBM3hrGT0b+4=; b=SszhHc1eo2oQuUgBQLLqm1usv2
	edl7DwYporOp+CmSavv/eCa1+dybK/lOaNTTQLJnq/ib1GVRsvNoT0RU0C55P7W71MgaHMAbFQ/kJ
	14S5SQt+QzfjOdPUMJID57QiKu1Usf781n07jEpdgaOxAbUzbJZAijgNX0dinEB6zASyOKozpmwcI
	VLMK0kDN6+Fde9EMY1IlVZaDEfKbiYo5NzFn9Tm4LT8lPvzZGX1zW+w2qzRw84lip2uMsk3mQ0b0r
	EoeGyEGvBOBgzFWczalaHWNSjKrCq9YeSYTStTeGVAEIPih+2q6ejQL2Hri0uPBx3dyN1LbXhrjB7
	DZh5+toQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6mCx-00000008sp6-3TTR;
	Wed, 16 Sep 2026 09:45:39 +0000
Received: from out-94.mta0.migadu.com ([2001:41d0:1004:224b::5e] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6mCv-00000008so2-3X3q
	for linux-nvme@lists.infradead.org;
	Wed, 16 Sep 2026 09:45:39 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=mO98Mkuc0nB/Kxdxx3wdKcIT3x3Ro8TrzEDgQ/nqMZs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789551934; v=1; x=1790156734;
 b=UoGyjsDA05FO3rzuMNqOn6xaKx7tVxXwa/OHr44UcPTzN0Vrdhs9mZc2bitTg3ZJicqNePDK
 TNTzDissS+lLsuBmBxkDyeyPNNnrqIJWvqtMc1QfgTcIaTt699ZjZ7u6WJyuih4svlrAmFxq81P
 vEei0CEdZAzk9SzMhaWIuQZ0=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id 4e1f0847cc37f286;
	Wed, 16 Sep 2026 09:45:13 +0000
X-Mizu-Trace-ID: 4e1f0847cc37f286
X-Migadu-Flow: FLOW_OUT
Message-ID: <cf378b14-8e59-47c0-af44-c28415a640bf@linux.dev>
Date: Wed, 16 Sep 2026 10:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/3] fix NVMe multipath partition diskstats
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260821084831.4155943-1-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.garry@linux.dev>
In-Reply-To: <20260821084831.4155943-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260916_024538_030630_CFDC11CF 
X-CRM114-Status: GOOD (  15.95  )
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

On 8/21/26 09:48, John Garry wrote:

Hi guys,

Any opinion on this one? Specifically how to improve the per-path disk 
partition cloning here.

Cheers

> Currently the NVMe multipath partition diskstats are not maintained.
> This is because the functionality to update the diskstats only updates
> for the whole disk (and not per partition).
> 
> As an example:
> $ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
> ...
> $ more /proc/diskstats | grep nvme1
>   259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
>   259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
>   259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
>   259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0
> 
> Notice how all values are 0 for nvme1n1p1.
> 
> This series addresses that problem by first updating the gendisk code to
> create the partition table for hidden disks, as suggested by Keith.
> 
> This is done by cloning the partition table from the multipath disk.
> 
> Secondly the NVMe multipath functionality to handle the diskstats is
> modified to handle the gendisk partition, by looking up this partition
> from the per-path disk partition.
> 
> Setting as RFC as I am not too happy with the block partition cloning
> code.
> 
> Difference to v2:
> - don't scan per-path disk, and clone from multipath disk instead
> 
> John Garry (3):
>    block: support linking disks to clone partitions
>    block: don't show partition diskstats for GENHD_FL_HIDDEN
>    nvme-multipath: fix diskstats for partitions
> 
>   block/blk.h                   |  1 +
>   block/genhd.c                 | 35 +++++++++++++++++++++++-
>   block/partitions/core.c       | 45 +++++++++++++++++++++++++++++++
>   drivers/nvme/host/core.c      |  1 +
>   drivers/nvme/host/multipath.c | 51 ++++++++++++++++++++++++++++-------
>   include/linux/blkdev.h        |  8 ++++++
>   6 files changed, 130 insertions(+), 11 deletions(-)
> 


