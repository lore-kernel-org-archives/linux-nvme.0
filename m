Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B193CC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=441oD1++hubgGUElzvL75rwNbLNzT7P+xGK0zmQs+Fg=; b=rssReiksPPbtqz5nMLc+7yr5Hr
	SP2KFIy2jd8xaNmFrgWQE4rOlMeoHI4O95ACdSiht7as6FoiQk+2uz44s2ZfPlargcsXmgwlbDQki
	BpmiVkgW0AtCbmh5YbFmilL0UPPU/mZxky2YJUwUGoieMJHtBOBznu83egrFBeUpH6Vtki+mgdKz7
	gV0gNgTJSWpgWWA06KOQqxqCpaNbwyx/5yFMXE5NYlwj6416GBJCBT+5ha9zGhdZZ0DF3Ip1XeLR4
	MlF7WuTMcDYEFSCC4/HSRVMw8CJ+6mrmbEZpPi9KqA1JiwLezla8yAqwobx34TWMv4fLOGsX/6S94
	Z0QFclHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whN59-0000000GXh5-068n;
	Wed, 08 Jul 2026 07:52:35 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wh2uw-0000000EjI3-0C1F
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jul 2026 10:20:44 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id EF08620B716B; Tue,  7 Jul 2026 03:20:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF08620B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783419636;
	bh=441oD1++hubgGUElzvL75rwNbLNzT7P+xGK0zmQs+Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YjtfsGHZJBrWJ+Vy4Ipz+WqFrtJd6xZWrR8UEtusUUwjXIr8jP+wo4On9qsOyJ+pA
	 JnztyI1H/EvD+jIspehtVLEjQwRJEGFtTbArD4gVwsHH9VlNuQr6y4XZuKoSYZUyRU
	 wdBJG2gkJwBJDu6T8/gqWpO/X6dc27dL+jU6UXmE=
Date: Tue, 7 Jul 2026 03:20:36 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, mkalderon@marvell.com,
	zyjzyj2000@gmail.com, sagi@grimberg.me, mgurtovoy@nvidia.com,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, bvanassche@acm.org,
	kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	cel@kernel.org, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
	anna@kernel.org, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org,
	andriy.shevchenko@linux.intel.com, clm@meta.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v9] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <akzS9EdxScQsx9n8@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260703060329.896125-1-ernis@linux.microsoft.com>
 <20260706084950.GK15188@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706084950.GK15188@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260707_032042_124294_1B9420B7 
X-CRM114-Status: GOOD (  21.64  )
X-Mailman-Approved-At: Wed, 08 Jul 2026 00:52:34 -0700
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

On Mon, Jul 06, 2026 at 11:49:50AM +0300, Leon Romanovsky wrote:
> > ---
> >  drivers/infiniband/core/cq.c               |  3 +-
> >  drivers/infiniband/hw/qedr/verbs.c         |  2 +-
> >  drivers/infiniband/sw/rxe/rxe_qp.c         | 22 +++++-----
> >  drivers/infiniband/sw/rxe/rxe_srq.c        | 16 +++----
> >  drivers/infiniband/ulp/ipoib/ipoib_cm.c    | 10 ++---
> >  drivers/infiniband/ulp/ipoib/ipoib_verbs.c |  3 +-
> >  drivers/infiniband/ulp/iser/iser_verbs.c   |  5 +--
> >  drivers/infiniband/ulp/isert/ib_isert.c    |  7 ++-
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c     | 11 ++---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c     | 11 ++---
> >  drivers/infiniband/ulp/srp/ib_srp.c        |  2 +-
> >  drivers/infiniband/ulp/srpt/ib_srpt.c      | 21 +++++----
> >  drivers/nvme/host/rdma.c                   |  8 ++--
> >  drivers/nvme/target/rdma.c                 | 22 ++++++----
> >  fs/smb/smbdirect/accept.c                  |  5 ++-
> >  fs/smb/smbdirect/connect.c                 |  5 ++-
> >  fs/smb/smbdirect/connection.c              |  8 ++--
> >  include/linux/sunrpc/svc_rdma.h            |  4 +-
> >  include/rdma/ib_verbs.h                    | 50 +++++++++++-----------
> >  net/rds/ib.c                               | 10 ++---
> >  net/rds/ib_cm.c                            | 10 ++---
> >  net/sunrpc/xprtrdma/frwr_ops.c             |  7 +--
> >  net/sunrpc/xprtrdma/svc_rdma_transport.c   |  5 +--
> >  net/sunrpc/xprtrdma/verbs.c                |  2 +-
> >  24 files changed, 122 insertions(+), 127 deletions(-)
> 
> The following code is still missing. 

I'll make this change in the next version.

>Also, what about mxa_srq?
> Why wasn't it converted as well?

I originally left max_srq as int because its only consumer pairs it with
num_comp_vectors (a signed int) in nvmet_rdma, so keeping it int let
that site stay a plain min() instead of a min_t().

num_comp_vectors is the completion-vector count, legitimately int and
never anywhere near INT_MAX, so I'd prefer to leave it signed rather
than convert it everywhere. Does that work for you, or would you rather
num_comp_vectors be converted too?

If it needs converting, I'll do it as a separate patch, since it lives
in a different struct (ib_device) and touches many call sites.
Otherwise, using min_t() for just this one call is fine too.

Thanks,
Vennela

> 
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> index f599c24b34e8..aae4f3f6bcba 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -454,7 +454,8 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
>         };
> 
>         struct nlattr *table_attr;
> -       int ret, i, curr, max;
> +       u64 curr, max;
> +       int ret, i;
> 
>         if (fill_nldev_handle(msg, device))
>                 return -EMSGSIZE;
> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index cfee2071586c..1b2f9df49e28 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -61,7 +61,7 @@ void rdma_restrack_clean(struct ib_device *dev)
>   * @type: actual type of object to operate
>   * @show_details: count driver specific objects
>   */
> -int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
> +u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
>                         bool show_details)
>  {
>         struct rdma_restrack_root *rt = &dev->res[type];
> diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> index 451f99e3717d..c081384740ce 100644
> --- a/include/rdma/restrack.h
> +++ b/include/rdma/restrack.h
> @@ -123,7 +123,7 @@ struct rdma_restrack_entry {
>         u32 id;
>  };
> 
> -int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
> +u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
>                         bool show_details);
>  /**
>   * rdma_is_kernel_res() - check the owner of resource

