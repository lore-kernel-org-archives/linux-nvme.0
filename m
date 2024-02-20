Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C90EC48BC3
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 08:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MC/hKwHw5f7K92g7kMNwdPpaAl+5ZBdxbwAudJi/BpE=; b=dO4LcOioc2/ssUjq7gy7Q9CIpR
	6+ggA397rQG7R7HfWeay4knZ7lxXoOxa96n4GD4aCXKhsrnfJDS0OB1ad3sT54VriLwsJR7VtpLjA
	GM462sbFkH46HoYWy6zCm+5ZaamH79zKQa77usVGhXuCeE6MVeafY2JfDc6m51MJmfKFHIIvnuK6O
	YiCPcu76HJZX91BRxvpUcpUYrnH17gOZR8+jhztFKEy45/LiLRxbpawcZKWebV1jmKimChLMkZ41s
	wxmlHVnH0qdf3wGEyLveel/iNUk414ZzuMIElpyqmp3wd/u2Lbvc5FwR5sYfX6WqEih4AsNOXEQ1H
	1AqhQoeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLOw-0000000Dfnp-37JK;
	Tue, 20 Feb 2024 08:22:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLOu-0000000Dfmh-21h7
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 08:22:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B616D68CFE; Tue, 20 Feb 2024 09:22:45 +0100 (CET)
Date: Tue, 20 Feb 2024 09:22:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v4 05/11] block: Add core atomic write support
Message-ID: <20240220082245.GB13785@lst.de>
References: <20240219130109.341523-1-john.g.garry@oracle.com> <20240219130109.341523-6-john.g.garry@oracle.com> <ZdPdHzNAVb5hqlkY@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdPdHzNAVb5hqlkY@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_002252_686953_59F257C3 
X-CRM114-Status: GOOD (  19.25  )
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

On Tue, Feb 20, 2024 at 09:58:39AM +1100, Dave Chinner wrote:
> > +	lim->atomic_write_hw_max_sectors = 0;
> > +	lim->atomic_write_max_sectors = 0;
> > +	lim->atomic_write_hw_boundary_sectors = 0;
> > +	lim->atomic_write_hw_unit_min_sectors = 0;
> > +	lim->atomic_write_unit_min_sectors = 0;
> > +	lim->atomic_write_hw_unit_max_sectors = 0;
> > +	lim->atomic_write_unit_max_sectors = 0;
> >  }
> 
> Seems to me this function would do better to just
> 
> 	memset(lim, 0, sizeof(*lim));
> 
> and then set all the non-zero fields.

.. which the caller already has done :)  In the block tree this
function looks completely different now and relies on the caller
provided zeroing.

> > +void blk_queue_atomic_write_max_bytes(struct request_queue *q,
> > +				      unsigned int bytes)
> > +{
> > +	q->limits.atomic_write_hw_max_sectors = bytes >> SECTOR_SHIFT;
> > +	blk_atomic_writes_update_limits(q);
> > +}
> > +EXPORT_SYMBOL(blk_queue_atomic_write_max_bytes);
> 
> Ok, so this can silently set a limit that is different to what the
> caller asked to have set?
> 
> How is the caller supposed to find this out if the smaller limit
> that was set is not compatible with their configuration?
> 
> i.e. shouldn't this return an error if the requested size cannot
> be set exactly as specified?

That's how the blk limits all work.  The driver provides the hardware
capabilities for a given value, and the block layer ensures it
works with other limits imposed by the block layer or other parts
of the device limits.

