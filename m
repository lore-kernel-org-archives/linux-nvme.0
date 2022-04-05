Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960BEC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 04:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCgocASYb5ArghU+oTyvqsztKe9LiYcQI30nZn4L4rs=; b=3ioAOW8Mknp5ow84qDn3NGeZk6
	Otka/LvRzjgWp6bZH9gAOo3+PvAvZDt0eRyR6G+WJ1EpEau1ruGUEQ1/mcoTY7MubwFxZeq/T3zm8
	RAIYUJCNtDhTsZm101rMiZz9JPh6c3BHTUe+yzvBbshTg8GpEstC17kYVpLiUSI1yQJxCjl+VXfqt
	+N1xotUU2Q36Tgh/MzvVNNAnhXcOuM05+hxlkYz983Oo6k926lBZ5jHM6bhhE7thG453kyK1ma9Q3
	j2Ip5NZhRvjKVyhVQ7JSllBBntjwuAO9ZI40l4bwOVEaJ/TMcHSZz7xBi/bRPPlflbOC2nZNZPQFx
	VB9iihcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbb3J-00H5eW-1L; Tue, 05 Apr 2022 04:44:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbb2c-00H5aQ-OT
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 04:43:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 71A6168AFE; Tue,  5 Apr 2022 06:43:31 +0200 (CEST)
Date: Tue, 5 Apr 2022 06:43:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Ariel Elior <aelior@marvell.com>, Anna Schumaker <anna@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christian Benvenuti <benve@cisco.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>,
 Bernard Metzler <bmt@zurich.ibm.com>, Bart Van Assche <bvanassche@acm.org>,
 Chuck Lever <chuck.lever@oracle.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 Max Gurtovoy <mgurtovoy@nvidia.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Mustafa Ismail <mustafa.ismail@intel.com>,
 Nelson Escobar <neescoba@cisco.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, rds-devel@oss.oracle.com,
 Sagi Grimberg <sagi@grimberg.me>, samba-technical@lists.samba.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Steve French <sfrench@samba.org>, Shiraz Saleem <shiraz.saleem@intel.com>,
 target-devel@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: Re: [PATCH] RDMA: Split kernel-only global device caps from uvers
 device caps
Message-ID: <20220405044331.GA22322@lst.de>
References: <0-v1-47e161ac2db9+80f-kern_caps_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-47e161ac2db9+80f-kern_caps_jgg@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_214342_987914_2F54D54B 
X-CRM114-Status: GOOD (  20.48  )
X-Mailman-Approved-At: Mon, 04 Apr 2022 21:44:23 -0700
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

On Mon, Apr 04, 2022 at 01:18:00PM -0300, Jason Gunthorpe wrote:
> Split ib_device::device_cap_flags into kernel_cap_flags that holds the
> flags only used by the kernel.
> 
> This cleanly splits out the uverbs flags from the kernel flags to avoid
> confusion in the flags bitmap.

> Followup from Xiao Yang's series

Can you point me to this series?

> -	if (!(device->attrs.device_cap_flags & IB_DEVICE_ALLOW_USER_UNREG)) {
> +	if (!(device->attrs.kernel_cap_flags & IB_KDEVICE_ALLOW_USER_UNREG)) {

Maybe shorten the prefix to IBD_ ?

> +enum ib_kernel_cap_flags {
> +	/*
> +	 * This device supports a per-device lkey or stag that can be
> +	 * used without performing a memory registration for the local
> +	 * memory.  Note that ULPs should never check this flag, but
> +	 * instead of use the local_dma_lkey flag in the ib_pd structure,
> +	 * which will always contain a usable lkey.
> +	 */
> +	IB_KDEVICE_LOCAL_DMA_LKEY = 1 << 0,
> +	IB_KDEVICE_UD_TSO = 1 << 1,
> +	IB_KDEVICE_BLOCK_MULTICAST_LOOPBACK = 1 << 2,
> +	IB_KDEVICE_INTEGRITY_HANDOVER = 1 << 3,
> +	IB_KDEVICE_ON_DEMAND_PAGING = 1ULL << 4,
> +	IB_KDEVICE_SG_GAPS_REG = 1ULL << 5,
> +	IB_KDEVICE_VIRTUAL_FUNCTION = 1ULL << 6,
> +	IB_KDEVICE_RDMA_NETDEV_OPA = 1ULL << 7,
> +	IB_KDEVICE_ALLOW_USER_UNREG = 1ULL << 8,
> +};

And maybe not in this patch, but if you touch this anyway please add
comments to document allthe flags.

