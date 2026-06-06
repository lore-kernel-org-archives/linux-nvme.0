Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A47CD8CA4
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsHAuFj8qDrb/asd6/0OdPIBZRNfzb9n3bx0A4hh4+Q=; b=NPxymeVHg97+zBQaze4f9DQ9Or
	cW04PxGHHIDIIZBznoCehViReYnSHHlu7jYMsRHkdxCqyCRT8nTt5hyzYh+PM5ujpfCHltL6Tr7ft
	mOA9Nr+BmkrF8FR8nh8zMfzjvDvFJGtzeWdM/pLq837Rl0xpmrXNEoDWY2Jg5tYUk0kyErsKcvnzW
	1GQf9uAqbJ2lkyTG4c4PH8EeDB/Qz+3flZD65QRNQvjAo9U/uDVcq3LUN/kMN+Gfqc18K5N99WfBd
	Pw05LgW+uqzmBXNJqBZnaglwZR5m2lFVF2u81J3ZYGvmOtyqgZ/UH41QZ8hjplaqjeYml5z1Ok4Ib
	TabdwG6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbV4-00000003ujS-2HTD;
	Mon, 08 Jun 2026 15:02:50 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVkqY-00000001UMh-0iuv
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jun 2026 06:49:31 +0000
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 4B9E620B7168; Fri,  5 Jun 2026 23:49:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B9E620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780728554;
	bh=jsHAuFj8qDrb/asd6/0OdPIBZRNfzb9n3bx0A4hh4+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fN1/ZLAwCc6QU6vEstgU4YpQ182PQpaT+lXfZXLnZSKIWWsInznamLl/Gq7Re790Z
	 6GTjnvrIrWM4o47gTCHOZFz9dWKG9NvabDco+iGUoZavh7ctRRh5lVeutFBYfVyrfg
	 /UZXQZqC1j8TikWl0+urTqePdP59dOTmYl/zXFG0=
Date: Fri, 5 Jun 2026 23:49:14 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: mkalderon@marvell.com, Jason Gunthorpe <jgg@ziepe.ca>,
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
	kees@kernel.org, ebadger@purestorage.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	target-devel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	rds-devel@oss.oracle.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH net-next v5] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <aiPC6vQC7ICmD7q8@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601091505.1763912-1-ernis@linux.microsoft.com>
 <ah6gWPQP56RO6_ho@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6gWPQP56RO6_ho@ashevche-desk.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_234930_238017_CC038D04 
X-CRM114-Status: GOOD (  16.10  )
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

On Tue, Jun 02, 2026 at 12:20:24PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 01, 2026 at 02:14:44AM -0700, Erni Sri Satya Vennela wrote:
> > The capability counter fields in struct ib_device_attr are declared
> > as signed int, but these values are inherently non-negative. Drivers
> > maintain their cached caps as u32 and assign them directly into these
> > int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> > negative value visible to the IB core.
> > 
> > Change the signed int capability fields to u32 to match the
> > underlying nature of the data. Also update consumers across the IB
> > core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> > are not forced back through signed int or u8 via min()/min_t() or
> > narrowing local variables.
> 
> ...
> 
> >  	attr->max_qp_rd_atom =
> > -	    min(1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> > -		attr->max_qp_init_rd_atom);
> > +	    min_t(u32, 1 << (fls(qattr->max_qp_resp_rd_atomic_resc) - 1),
> > +		  attr->max_qp_init_rd_atom);
> 
> Just no. min_t() usage has to be very well justified. It's a beast which may
> stub one in the back. As Linus said in most of the cases one wants clamp()
> rather than min().
> 
> Please, redo this and similar pieces.

Thankyou for the suggestion, Andy.
I'll be updating this in the next version v7.

- Vennela
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

