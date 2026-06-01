Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C886CD6E56
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 10:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1dBsl+usX+yNit5uL7Cl+L0xh4XKIwuUK/l5Em4lMN4=; b=JGZV9h24Fu61wqY9Y6eOpvJBB0
	A2blY5T4oidVkVkStTcFgBHpuQHicfJg8LZeqfnsMi2/Lf4eC0PZcG+8qFciVKsc06B0h6UCbOr4K
	YW+fayvzLZPrhj/0kNeRn+mE1HWvtY96wY0oTC27WIr6Xa6jhXs2zXw+Lrup30CGvtlijv6m27EEa
	f5zed7SetKDDmrhJjVTlB27O6SHnCCLwwMyOLvXQ7qO40Ktee7gz48VlGgTBEJtvmrCtPIO8/RJDF
	IThCiARYQiF79BQZLSMS1yq59XYaaUGItkmV8L6zFD6GfenLZBE67TKHBhmdQ8JE9MzlfRm9sSO/x
	ChvAJJlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU0H3-0000000Aftq-3zzU;
	Mon, 01 Jun 2026 10:53:37 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTysI-0000000AUDq-39On
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 09:23:59 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 1BFE020B7167; Mon,  1 Jun 2026 02:23:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1BFE020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780305825;
	bh=1dBsl+usX+yNit5uL7Cl+L0xh4XKIwuUK/l5Em4lMN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gc0VUppuySH6OSGGa44IlxUBt26W6vYFDTARrKiIVzcCNWCKExJMK4v51ZKXUiE7L
	 9JMRMjVx8SaYOW/bF9YMEu8SR33UiVwg9pO1J1o73UdEyNp6AVmhEWh9m/oHLHyMeA
	 JYQjkX8fKzc6s3ReVmCH86g/p4UkGhWDdslPI9j4=
Date: Mon, 1 Jun 2026 02:23:45 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
	sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, bvanassche@acm.org, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, trondmy@kernel.org,
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
	neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, andriy.shevchenko@linux.intel.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com
Cc: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next v5] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <ah1PoREU8DSqYHxj@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601091505.1763912-1-ernis@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601091505.1763912-1-ernis@linux.microsoft.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_022358_974859_C516BF9B 
X-CRM114-Status: GOOD (  11.08  )
X-Mailman-Approved-At: Mon, 01 Jun 2026 03:53:37 -0700
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

On Mon, Jun 01, 2026 at 02:14:44AM -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
Sorry for the incorrect prefix in v5 (used net-next instead of
rdma-next).
Please considerthe next version v6.

Thanks,
Vennela

