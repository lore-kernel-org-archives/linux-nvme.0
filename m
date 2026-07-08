Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB02CC44501
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 07:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tHbyxUhrsarzNRWmvxSCy2nePku4Gzl46NyrQxhVDTU=; b=pSgsOzhKdQFJ9CrsdvxYD5kIud
	1pJUQo5i5hpG5mqWZAQ5UCjTiMJ/nmBTinEDdWmZ8Vx9fs8ssVcBOWfxy2CygcCSuFw4MzZvU3Bcr
	b2NkbT3zIppucw4U8gwupVG4gsWHuBzJXu7UCzhT2Yylp0ZMJChr9IB8IDGeXA6MhMaXIBVJp58g5
	WUsm3G8F3NZ/x0PzXmlMVlbaGKVr2ar84+/cqvNboAzJtE5v69s3Pljp5799yVj2TLsM/QR+RUALa
	m8aWWcUJf8DNs37tjUGOotB5/OneJNkN/eQVoCybZv86BKMH9OqcCRBShU7DIC+xV1ll73wNKM/QA
	cKPj2Mlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whN59-0000000GXhI-1C1U;
	Wed, 08 Jul 2026 07:52:35 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whMoc-0000000GW7A-207W
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 07:35:31 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 26DD120B7166; Wed,  8 Jul 2026 00:35:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 26DD120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783496124;
	bh=tHbyxUhrsarzNRWmvxSCy2nePku4Gzl46NyrQxhVDTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAsgFV8/gFHDIknrIuM61IsHT48x6Hsbl9j5ukuVc1teGLGUh1Zt8FHbdnALVrRRY
	 RRYuc2/2EKDusilkbW6yOfVYGoTlH6EYPSgM+MQE/8aDz01mTJZKLrqSxb29uA46oC
	 h+ZVMHiTsNZT7wYzxSh5PrBsQOvtxvc8pe/JHbPQ=
Date: Wed, 8 Jul 2026 00:35:24 -0700
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
Message-ID: <ak39vJTvGCNJSHwi@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260703060329.896125-1-ernis@linux.microsoft.com>
 <20260706084950.GK15188@unreal>
 <akzS9EdxScQsx9n8@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260707102546.GM15188@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707102546.GM15188@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_003530_547633_6B650200 
X-CRM114-Status: GOOD (  24.06  )
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

> > I originally left max_srq as int because its only consumer pairs it with
> > num_comp_vectors (a signed int) in nvmet_rdma, so keeping it int let
> > that site stay a plain min() instead of a min_t().
> > 
> > num_comp_vectors is the completion-vector count, legitimately int and
> > never anywhere near INT_MAX, so I'd prefer to leave it signed rather
> > than convert it everywhere. Does that work for you, or would you rather
> > num_comp_vectors be converted too?
> 
> In this patch no, but it is worth to write this in commit message.
> 
> Thanks

Thanks for the confirmation, Leon.

I'll use min_t for max_srq and document it in the commit message.


- Vennela
> 
> > 
> > If it needs converting, I'll do it as a separate patch, since it lives
> > in a different struct (ib_device) and touches many call sites.
> > Otherwise, using min_t() for just this one call is fine too.
> > 
> > Thanks,
> > Vennela
> > 
> > > 
> > > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > > index f599c24b34e8..aae4f3f6bcba 100644
> > > --- a/drivers/infiniband/core/nldev.c
> > > +++ b/drivers/infiniband/core/nldev.c
> > > @@ -454,7 +454,8 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
> > >         };
> > > 
> > >         struct nlattr *table_attr;
> > > -       int ret, i, curr, max;
> > > +       u64 curr, max;
> > > +       int ret, i;
> > > 
> > >         if (fill_nldev_handle(msg, device))
> > >                 return -EMSGSIZE;
> > > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > > index cfee2071586c..1b2f9df49e28 100644
> > > --- a/drivers/infiniband/core/restrack.c
> > > +++ b/drivers/infiniband/core/restrack.c
> > > @@ -61,7 +61,7 @@ void rdma_restrack_clean(struct ib_device *dev)
> > >   * @type: actual type of object to operate
> > >   * @show_details: count driver specific objects
> > >   */
> > > -int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
> > > +u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
> > >                         bool show_details)
> > >  {
> > >         struct rdma_restrack_root *rt = &dev->res[type];
> > > diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
> > > index 451f99e3717d..c081384740ce 100644
> > > --- a/include/rdma/restrack.h
> > > +++ b/include/rdma/restrack.h
> > > @@ -123,7 +123,7 @@ struct rdma_restrack_entry {
> > >         u32 id;
> > >  };
> > > 
> > > -int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
> > > +u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
> > >                         bool show_details);
> > >  /**
> > >   * rdma_is_kernel_res() - check the owner of resource

