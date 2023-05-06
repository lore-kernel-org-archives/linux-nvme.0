Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7941C7EE24
	for <linux-nvme@archiver.kernel.org>; Sat,  6 May 2023 00:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8b1QrBm7NAy/H5JZI9VBQ4yDERr4fwkVzpazVyX0h4=; b=Pumy02hpUabLj5VWkC546RDRuw
	MfKJlKvbDF0zNYrBxlW5TfZQz7laoRYYFfhwZ0Alu2SvvyuvnepNGcA/eQuitAWynm4w8xpAjw6WR
	u7Rjm6VAHGwuoaZanKTsNXs//kBqG2m0SzP0yIejiFdvc1fXB+j981pwYxIFD8ceIIX8yU1RJEpmT
	iKy9rpKu/n5QHgdRsWpW1DIPbni7wTNWjOh36jYk+g+Fda1mq3a8AMQi0lyaELkN6h56xuZ5PrGm+
	vDf3FgZ4WEvNtUkPY7jGR2DHlkq51aBDgcXU5gF7t7hnyn6CCi/fu3aoHCq7g/23dJc1AlnhW3u8w
	4d40Ntug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv5TR-00C98I-13;
	Sat, 06 May 2023 00:08:29 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv5TN-00C97G-1u
	for linux-nvme@lists.infradead.org;
	Sat, 06 May 2023 00:08:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ED0AD61575;
	Sat,  6 May 2023 00:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD13C433EF;
	Sat,  6 May 2023 00:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683331704;
	bh=7+4RZ/Snpwvb0zzhi2RjjXRKKk3ABC6o+jcKXRjDTg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJ4CUV1iru3AnzNtA79biymZMjwlHUzSgyfnsWmqGPjDok6TGCQSj9uC7b3O3oPJJ
	 7hYekNdQmu7P41mSRVxUZKoW7l4b2DBxXauxvQJ5VcutuHeMtpvZQrN2ZvYFBY8C0w
	 cFwasIhIocEciWso+pgv0fKmhODCmMTdicFt3Zbm+IEEHYWZteSMzg5HUaEWh1wYsS
	 n6woXHFNKHnn6crfiO3t2IWj/U18s5SnVAkRwJYqfkT4yzROMYiHzuA22rvffXunMJ
	 gSApl7UVcU5tNNRz9aag+tq4sRGFtmNYW7vA1PrXzNDpkEpBxiGadFRA0LlgL6wbC/
	 NAGXWNH4WT4Sw==
Date: Sat, 6 May 2023 00:08:22 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jejb@linux.ibm.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <ZFWadsMT0xck9lYQ@gmail.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
 <ZFWHdxgWie/C02OA@gmail.com>
 <20230505233152.GN3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505233152.GN3223426@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_170825_708872_11343929 
X-CRM114-Status: GOOD (  34.12  )
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

On Sat, May 06, 2023 at 09:31:52AM +1000, Dave Chinner wrote:
> On Fri, May 05, 2023 at 10:47:19PM +0000, Eric Biggers wrote:
> > On Fri, May 05, 2023 at 08:26:23AM +1000, Dave Chinner wrote:
> > > > ok, we can do that but would also then make statx field 64b. I'm fine with
> > > > that if it is wise to do so - I don't don't want to wastefully use up an
> > > > extra 2 x 32b in struct statx.
> > > 
> > > Why do we need specific varibles for DIO atomic write alignment
> > > limits? We already have direct IO alignment and size constraints in statx(),
> > > so why wouldn't we just reuse those variables when the user requests
> > > atomic limits for DIO?
> > > 
> > > i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
> > > constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
> > > DIO alignment requirements in those variables.....
> > > 
> > > Yes, we probably need the dio max size to be added to statx for
> > > this. Historically speaking, I wanted statx to support this in the
> > > first place because that's what we were already giving userspace
> > > with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
> > > along would require a bound maximum IO size much smaller than normal
> > > DIO limits.  i.e.:
> > > 
> > > struct dioattr {
> > >         __u32           d_mem;          /* data buffer memory alignment */
> > >         __u32           d_miniosz;      /* min xfer size                */
> > >         __u32           d_maxiosz;      /* max xfer size                */
> > > };
> > > 
> > > where d_miniosz defined the alignment and size constraints for DIOs.
> > > 
> > > If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
> > > (unit) atomic IO size and alignment in statx->dio_offset_align (as
> > > per STATX_DIOALIGN) and the maximum atomic IO size in
> > > statx->dio_max_iosize, then we don't burn up anywhere near as much
> > > space in the statx structure....
> > 
> > I don't think that's how statx() is meant to work.  The request mask is a bitmask, and the user can
> > request an arbitrary combination of different items.  For example, the user could request both
> > STATX_DIOALIGN and STATX_WRITE_ATOMIC at the same time.  That doesn't work if different items share
> > the same fields.
> 
> Sure it does - what is contained in the field on return is defined
> by the result mask. In this case, whatever the filesystem puts in
> the DIO fields will match which flag it asserts in the result mask.
> 
> i.e. if the application wants RWF_ATOMIC and so asks for STATX_DIOALIGN |
> STATX_DIOALIGN_ATOMIC in the request mask then:
> 
> - if the filesystem does not support RWF_ATOMIC it fills in the
>   normal DIO alingment values and puts STATX_DIOALIGN in the result
>   mask.
> 
>   Now the application knows that it can't use RWF_ATOMIC, and it
>   doesn't need to do another statx() call to get the dio alignment
>   values it needs.
> 
> - if the filesystem supports RWF_ATOMIC, it fills in the values with
>   the atomic DIO constraints and puts STATX_DIOALIGN_ATOMIC in the
>   result mask.
> 
>   Now the application knows it can use RWF_ATOMIC and has the atomic
>   DIO constraints in the dio alignment fields returned.
> 
> This uses the request/result masks exactly as intended, yes?
> 

We could certainly implement some scheme like that, but I don't think that was
how statx() was intended to work.  I think that each bit in the mask was
intended to correspond to an independent piece of information.

- Eric

