Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119DDCD8C9F
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 15:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cMzcioYuB6Di79ZAvhskrIxXkdQtLzFhYkxDW4jk4RA=; b=zAu7B17nXCP3YbAsHhCThMvzbx
	5SYzWgcVVOSvzhejbDBAAPIhva2CrQjNHE2PbevARyWlJmD36mUdkkpdb1lEv+ranz9Pk2qnXem+H
	xo2fPdyeyUomk3KnWZaH57li0b4KYiwn2icut9O3+erdsQv6Z4wQbnBA/GuUR9vtB+0vVqMfogb6B
	Y27eBC+hTdzO58xBW5hbcZ6Pnevv9W1G93TIs+FPWIirQ1NWhjjk0tpL7sI5/OT58k8ihysV7Luw5
	hahavm7GaTh8Oqgoh4646TVWeaAL4IENZkPsZBqv7deiT6gGZuf7jSiCdFteT6g0cZIOeO7YznIia
	fEfi0/tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbV4-00000003ujl-3rZY;
	Mon, 08 Jun 2026 15:02:50 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVl2B-00000001UjQ-0Z1t
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 07:01:32 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 36F9220B7168; Sat,  6 Jun 2026 00:01:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36F9220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780729274;
	bh=cMzcioYuB6Di79ZAvhskrIxXkdQtLzFhYkxDW4jk4RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfiYLgAyM5X/Pp8g7mBNzlfTZuGrIEceOzfPeiO/YB1r6+Ng/0LarUrvfKUDmqic6
	 1yqjSp4BBat3h2X0imFMfW3HbOFJ3MP7LYUm2rV90O1SlNLucv3fblEEH+a83yxxU3
	 tC0IfjxdahYBZIqi0Rl7RSFPogCClEYIOy+uUBRM=
Date: Sat, 6 Jun 2026 00:01:14 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, zyjzyj2000@gmail.com,
	sagi@grimberg.me, mgurtovoy@nvidia.com, haris.iqbal@ionos.com,
	jinpu.wang@ionos.com, bvanassche@acm.org, kbusch@kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	kch@nvidia.com, smfrench@gmail.com, linkinjeon@kernel.org,
	metze@samba.org, tom@talpey.com, chuck.lever@oracle.com,
	jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, trondmy@kernel.org, anna@kernel.org,
	achender@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	kees@kernel.org, andriy.shevchenko@linux.intel.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v6] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <aiPFuqrpy0gJQB73@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601092534.1764560-1-ernis@linux.microsoft.com>
 <20260602123327.35aa286a@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602123327.35aa286a@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_000131_240679_E8BC5ABA 
X-CRM114-Status: GOOD (  18.97  )
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:02:49 -0700
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

On Tue, Jun 02, 2026 at 12:33:27PM +0100, David Laight wrote:
 > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 6482ad859bd1..852213365ecd 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1731,7 +1731,7 @@ static int create_con(struct rtrs_srv_path *srv_path,
> >  		 * All receive and all send (each requiring invalidate)
> >  		 * + 2 for drain and heartbeat
> >  		 */
> > -		max_send_wr = min_t(int, wr_limit,
> > +		max_send_wr = min_t(u32, wr_limit,
> >  				    SERVICE_CON_QUEUE_DEPTH * 2 + 2);
> 
> That should compile as min().
> (The constant is known to be non-negative.)

Okay, I'll update this in the next version.
> 
> ...
> > diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> > index e6e2c3f9afdf..fd6923198ec1 100644
> > --- a/drivers/nvme/target/rdma.c
> > +++ b/drivers/nvme/target/rdma.c
> ...
> > @@ -1553,8 +1554,8 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
> >  
> >  	param.rnr_retry_count = 7;
> >  	param.flow_control = 1;
> > -	param.initiator_depth = min_t(u8, p->initiator_depth,
> > -		queue->dev->device->attrs.max_qp_init_rd_atom);
> > +	param.initiator_depth = (u8)min_t(u32, p->initiator_depth,
> > +		min_t(u32, U8_MAX, queue->dev->device->attrs.max_qp_init_rd_atom));
> 
> I think you've change one of those to min_3().
> Nesting min() is a good way to bloat the pre-processor output.
> You don't need any of the casts.
> 	
> 	param.initiator_depth = min_3(p->initiator_depth,
> 		queue->dev->device->attrs.max_qp_init_rd_atom, U8_MAX);
> should be fine - if a bit long.
> 
> There are also (u32)U8_MAX casts lurking - pointless.
> 
Okay. I'll use min3 as suggested in the next version and remove
unneccesary casts.

Thanks,
Vennela
> -- David

