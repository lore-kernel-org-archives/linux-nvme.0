Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F4AC83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTAuTs2+4PPtYUyVzzoc2XWzO9TfzwsKYKBt+0gPTD8=; b=jWQ41mIdrvdhofZxNx4W7osuMl
	+yUWQNYH+7wpCckPfImrdnkUGiJ2bZW4zI9dxBpr6o0ONif0Lma1hT5ijyveYPJz05TX5eDV/yM+7
	2laajPn4YfN78A8ppDndHEnqUiHWtRUcKBWiSluNiO78kX/EoTpZ6VihgzZamcj2zFpxWJUH/9CKI
	aMson6uoRajaH5VyEGZmZiaEK5HLgTvnnY+xyKQQIn3fiiQlJFEom5gGgUtomY3RGzImuK6wQ/SaL
	kETR60gSvJOOnEJx8hOUNHwYZfhWWCVTlbqXkYze2ka8xOFyj/jpLGQQVjTI9YJXqFs4p2xil6wFj
	us/vdk3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublBz-000000062Ib-40Dp;
	Tue, 15 Jul 2025 19:19:55 +0000
Received: from infra.glanzmann.de ([2a01:4f8:b0:3ffe::5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubk1s-00000005s3w-2gzV
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 18:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
	s=infra26101010; t=1752602721;
	bh=uTAuTs2+4PPtYUyVzzoc2XWzO9TfzwsKYKBt+0gPTD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MG1OOLrO+dh0MfeHUxIhF1b0U4jRxCHTQwi2Fc7Z+QAsdP8jN/ja/k3BWgSXFsIDj
	 1WY8JeWc1z4Pcs4JkW3y9H8Lttzgfp6xTinI7lRaVHYL2SwZyqhfiyZOj1/FGAyMHv
	 0B0D1v3ptadxUbrvnTXcvqpTyVBuS6W8HfOq7KsTS8OkcyiPwj1Czuav6WNzlSZsHu
	 1Z2JHxuZA1pHax/mEU7/Li/KTeHFrt5R7DCWmYcd/MMOltesU5tCzBrTg1S12wQo6O
	 WNdTbwbPXtQZUgOPLdqpF3LXIb1wx+hUyjb4bG35GISh9l7R4yKEiVxnn0bYzIVJfK
	 VO83eZFB4rZeoaidtdIiEn0/CEqxGizEpgy9jkWO8aOxz3LNPet+nF+PtYyNi7KvZm
	 DjTzlVi0BVcjBkK8zrwZ4HQ2fsdjoedu6dlHRc6gUVcF9fLVcIS9BYJRShEjrWQmT/
	 1eqszDIpXeAv+oS2SXoIxR9Q8ko77mXpvXqEj4GS837fxSjQh10vDQK+Fyw0j6HqaB
	 v9yu7m+Z9oQgSXD5GGQ2dbJUJEAON2YQxOvWLYAgby1qMGjwGzSr+dRjmaObo9d4ZK
	 y7D6psj1msrSImTq/SQaLProQow3to9QTIljzQVK/D8T4+RmP36jgUXYJ2J53oXGP0
	 T1aNYjbToE5q60FCV7KSqLKM=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
	id E98907A800B9; Tue, 15 Jul 2025 20:05:21 +0200 (CEST)
Date: Tue, 15 Jul 2025 20:05:21 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Number of data and admin queues in use
Message-ID: <aHaYYYBZ4jk88yqR@glanzmann.de>
References: <aHW1qUJksE5Okflb@glanzmann.de>
 <aHZoBO9cPcRGIDwH@kbusch-mbp>
 <8584a963-a482-47cf-9ca2-a9d34e54b200@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8584a963-a482-47cf-9ca2-a9d34e54b200@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_110525_400654_E4E41B80 
X-CRM114-Status: GOOD (  17.63  )
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

Hello Chaitanya,

> From what I can see you are getting number of queues for both tcp and
> pcie NVMe controller, what is your question?

My question was how to see the number and size of NVMe IO queues but
Keith already answered that. I just thanked him and added some stats
from the NetApp.

> Another way to dig into controller side fields or queue depth you can
> read the CAP space see this from spec

> Figure 36: Offset 0h: CAP – Controller Capabilities :-

> "Maximum Queue Entries Supported (MQES): This field indicates the
> maximum individual queue size that the controller supports. For NVMe
> over PCIe implementations, this value applies to the I/O Submission
> Queues and I/O Completion Queues that the host creates. For NVMe over
> Fabrics implementations, this value applies to only the I/O Submission
> Queues that the host creates. This is a 0’s based value. The minimum
> value is 1h, indicating two entries."

> -ck

> [1]

> For fabrics transport (TCP) number are queues are calculated using
> nvmf_nr_io_queue() to make sure we don't create more read/defult
> queues than CPUs available same check is also applicable for write
> and poll queues.
> nvme_set_queue_count adjusts the queue count based on controller
> capabilities which cal also clamp the queue count.

> nvmf_set_io_queues() set queue count for each queue type read,
> default, poll. then nvmf_map_queues() maps them into blk-mq
> structure so that default/read/poll and each gets attached to
> blk_mq context.

> On My machine I've 48 CPUs so when I create tcp target I get :-

> [ 1196.058440] nvme nvme1: creating 48 I/O queues.
> [ 1196.062370] nvme nvme1: mapped 48/0/0 default/read/poll queues.

> you should be able to see this into debug messages that is coming
> from queue allocation helpers respectively that also has controller
> device name "nvme1" :-

> nvme_tcp_alloc_io_queues()
> nvmf_map_queues()

Tomorrow I'll setup a NVMe/TCP target on Linux and do some benchmarking. I'll
also hookup the NetApp to 64 Gbit/s FC and do some benchmarking with FC and
FC/NVMe.
Thank you for the additional insight, I never paid attention to this but, I did
now:

[ 3730.402432] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping down
[ 3795.115084] subsysnqn nqn.1992-08.com.netapp:sn.e0a0273a60b711f09deed039ead647e8:subsystem.svm1_subsystem_553 iopolicy changed from numa to queue-depth
[ 3795.154560] nvme nvme0: creating 2 I/O queues.
[ 3795.156535] nvme nvme0: mapped 2/0/0 default/read/poll queues.
[ 3801.004641] nvme nvme1: creating 2 I/O queues.
[ 3801.006541] nvme nvme1: mapped 2/0/0 default/read/poll queues.

Than I bumped the queues and queue size on the NetApp and got:

[98114.846603] nvme nvme0: queue_size 128 > ctrl sqsize 32, clamping down
[98727.596158] subsysnqn nqn.1992-08.com.netapp:sn.e0a0273a60b711f09deed039ead647e8:subsystem.svm1_subsystem_553 iopolicy changed from numa to queue-depth
[98727.635617] nvme nvme0: creating 4 I/O queues.
[98727.638218] nvme nvme0: mapped 4/0/0 default/read/poll queues.
[98741.459565] nvme nvme1: creating 4 I/O queues.
[98741.462227] nvme nvme1: mapped 4/0/0 default/read/poll queues.

Cheers,
	Thomas

