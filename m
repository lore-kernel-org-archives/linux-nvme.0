Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA87C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 08:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GnYnUD93DOgjDQY7zSBad3gsbyGmvvZSBSHXpp9wxwI=; b=pB+Lo/13+2qcGlKien8zY8D++n
	v/cnsY5WS98hx2BCDK2/F/MrYzf1UI2PTm/luhw4QduBF0WVED3DZrKbzpYFCo0BiS5kkeBDnJDyC
	x3eoVf0Acax1j+++0DnNQt+IwWyioYNtT4iRB9RPGDSMCaUts2M5Yz/mSjMCl/JJhIZrtxzgNCfiu
	IY8zazO9KF/wUqbQuxrvKS0tVos/1GLeuK9LuqwULHjRWyKVvxBIJxqhOvhUzdE3wF10nyEooztMT
	fKbVH5HOMOqeRY7AtsJVWZ9MH/KnUcI91eXx+/TS7+RPIx4xA9VN+zIWaEGDfQEb35zO2DPL3CmVq
	xdRV7RkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o66a4-005Gmo-7b; Tue, 28 Jun 2022 08:28:20 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o66ZS-005GVg-Uc
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 08:27:45 +0000
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.201])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXHkl0stbz6GDGM;
	Tue, 28 Jun 2022 16:26:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 10:27:37 +0200
Received: from [10.126.174.22] (10.126.174.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 09:27:36 +0100
Message-ID: <b530d4ac-2d7b-0989-c5da-6b6351a0a68f@huawei.com>
Date: Tue, 28 Jun 2022 09:27:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 0/6] blk-mq: Add a flag for reserved requests series
To: <axboe@kernel.dk>
CC: <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-mmc@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<mpi3mr-linuxdrv.pdl@broadcom.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nbd@other.debian.org>,
	<damien.lemoal@opensource.wdc.com>, <jejb@linux.ibm.com>, <hch@lst.de>,
	<martin.petersen@oracle.com>, <kartilak@cisco.com>, <bvanassche@acm.org>,
	<satishkh@cisco.com>, <hare@suse.de>, <sebaddel@cisco.com>
References: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <1655810143-67784-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.174.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_012743_402463_21BA0BCB 
X-CRM114-Status: GOOD (  12.36  )
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

On 21/06/2022 12:15, John Garry wrote:

Hi Jens,

about this series, would you be ok to pick this up for merging? Do you 
find the changes acceptable?

Thanks,
John

> In [0] I included "blk-mq: Add a flag for reserved requests" to identify
> if a request is 'reserved' for special handling. Doing this is easier than
> passing a 'reserved' arg to the blk_mq_ops callbacks. Indeed, only 1x
> timeout implementation or blk-mq iter function actually uses the
> 'reserved' arg (or 3x if you count SCSI core and FNIC SCSI driver). So
> this series drops the 'reserved' arg for these timeout and iter functions.
> Christoph suggested that I try to upstream now.
> 
> Differences to v1:
> - Use "scsi_timeout" as name for SCSI timeout function and update docs
> - Add RB tags (thanks!)
> - Split out patch to drop local variables for 'reserved', as requested by
>    Bart
> 
> Based on following:
> 6dbcddf6e76b (block/for-5.20/block) block: bfq: Fix kernel-doc headers
> 
> [0] https://lore.kernel.org/linux-scsi/1654770559-101375-1-git-send-email-john.garry@huawei.com/T/#m22aa9f89e55835edc2e650d43f7e3219a3a1a324
> 
> John Garry (6):
>    scsi: core: Remove reserved request time-out handling
>    blk-mq: Add a flag for reserved requests
>    blk-mq: Drop blk_mq_ops.timeout 'reserved' arg
>    scsi: fnic: Drop reserved request handling
>    blk-mq: Drop 'reserved' arg of busy_tag_iter_fn
>    blk-mq: Drop local variable for reserved tag
> 
>   Documentation/scsi/scsi_eh.rst          |  3 +--
>   Documentation/scsi/scsi_mid_low_api.rst |  2 +-
>   block/blk-mq-debugfs.c                  |  2 +-
>   block/blk-mq-tag.c                      | 13 +++++--------
>   block/blk-mq.c                          | 22 +++++++++++++---------
>   block/bsg-lib.c                         |  2 +-
>   drivers/block/mtip32xx/mtip32xx.c       | 11 +++++------
>   drivers/block/nbd.c                     |  5 ++---
>   drivers/block/null_blk/main.c           |  2 +-
>   drivers/infiniband/ulp/srp/ib_srp.c     |  3 +--
>   drivers/mmc/core/queue.c                |  3 +--
>   drivers/nvme/host/apple.c               |  3 +--
>   drivers/nvme/host/core.c                |  2 +-
>   drivers/nvme/host/fc.c                  |  6 ++----
>   drivers/nvme/host/nvme.h                |  2 +-
>   drivers/nvme/host/pci.c                 |  2 +-
>   drivers/nvme/host/rdma.c                |  3 +--
>   drivers/nvme/host/tcp.c                 |  3 +--
>   drivers/s390/block/dasd.c               |  2 +-
>   drivers/s390/block/dasd_int.h           |  2 +-
>   drivers/scsi/aacraid/comminit.c         |  2 +-
>   drivers/scsi/aacraid/linit.c            |  2 +-
>   drivers/scsi/fnic/fnic_scsi.c           | 14 ++++----------
>   drivers/scsi/hosts.c                    | 14 ++++++--------
>   drivers/scsi/mpi3mr/mpi3mr_os.c         | 16 ++++------------
>   drivers/scsi/scsi_error.c               |  6 +++---
>   drivers/scsi/scsi_lib.c                 |  8 --------
>   drivers/scsi/scsi_priv.h                |  2 +-
>   include/linux/blk-mq.h                  | 10 ++++++++--
>   include/scsi/scsi_host.h                |  2 +-
>   30 files changed, 71 insertions(+), 98 deletions(-)
> 


