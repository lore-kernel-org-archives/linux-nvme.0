Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD70C77B7C
	for <linux-nvme@archiver.kernel.org>; Fri,  5 May 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k8kxNlUbJOR09VOZkWdp3ubEF7gqx7bFnJhBwgj1yPU=; b=SAzYgTogUdYxk26p8LLnT2tU2A
	ksHjovnPA870QovG1YDkTgv7Ndgse+VwdJrHXsScvOPIayN/QM2V2heAhovy6hG5Li2Fl9Br0mLp2
	zLpdA6MxdhDEdG/5zIPPIdahQUDbZoG8PzC3hyURQEqL7WRsHfMUbmldM+THNrDeo/NLMBRGXyyBc
	3aGPvNaGd02ptNvCLr1bpR87Np8GfolmfAeb1iQbD+SBH9JUTrRyZxKegpRDnstZKgSe76bjMlxJ9
	4ti/HiPZ3Wj/lzSqkl3nWZDVHIqk0dfhH9exidty2AeSu5oyNobUxMfnAzhcSHESbDsMP32xGBjhP
	+Q0ck8qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pv4Cz-00C1CP-0e;
	Fri, 05 May 2023 22:47:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pv4Cw-00C1BX-2U
	for linux-nvme@lists.infradead.org;
	Fri, 05 May 2023 22:47:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ED71961590;
	Fri,  5 May 2023 22:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4B0C433D2;
	Fri,  5 May 2023 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683326841;
	bh=D0qbriAJbRPAwi0B8rnE/70zyZxx/MoRWZ/NxcKY3o4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYLwKlKdOz6DTtddRRpzE/g5GUU5YeP9nw5j3gbN5Oz8o/mRC/Tq3TL4r8inm1/5v
	 zCQxxwI42ekZKTzyB4UpzNeEHV8K12BxmOw3f/930wcqHv3deUCbnP/y6LoW3L0xzX
	 tw4sbrAehxrxSzE3UA9ERBQjlnAQMcJcQ0ueaneOY4ffcP/7P8CORy9MiNBmPtCKiT
	 QVlfg70i8qpYpGRLOP1VuVwqBo4hFm+BKzhtU/KyHNOcWRSUUR8Z5lmZs2GavGCrBR
	 NCH4Ig18O2PysnslWZU0MjaS8vFR6Rlwh85P1WfQXTluAmwcLcbicIbNC4DMbbVoui
	 YQltmUUIC6f6A==
Date: Fri, 5 May 2023 22:47:19 +0000
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
Message-ID: <ZFWHdxgWie/C02OA@gmail.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504222623.GI3223426@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_154722_903934_00021093 
X-CRM114-Status: GOOD (  22.27  )
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

On Fri, May 05, 2023 at 08:26:23AM +1000, Dave Chinner wrote:
> > ok, we can do that but would also then make statx field 64b. I'm fine with
> > that if it is wise to do so - I don't don't want to wastefully use up an
> > extra 2 x 32b in struct statx.
> 
> Why do we need specific varibles for DIO atomic write alignment
> limits? We already have direct IO alignment and size constraints in statx(),
> so why wouldn't we just reuse those variables when the user requests
> atomic limits for DIO?
> 
> i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
> constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
> DIO alignment requirements in those variables.....
> 
> Yes, we probably need the dio max size to be added to statx for
> this. Historically speaking, I wanted statx to support this in the
> first place because that's what we were already giving userspace
> with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
> along would require a bound maximum IO size much smaller than normal
> DIO limits.  i.e.:
> 
> struct dioattr {
>         __u32           d_mem;          /* data buffer memory alignment */
>         __u32           d_miniosz;      /* min xfer size                */
>         __u32           d_maxiosz;      /* max xfer size                */
> };
> 
> where d_miniosz defined the alignment and size constraints for DIOs.
> 
> If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
> (unit) atomic IO size and alignment in statx->dio_offset_align (as
> per STATX_DIOALIGN) and the maximum atomic IO size in
> statx->dio_max_iosize, then we don't burn up anywhere near as much
> space in the statx structure....

I don't think that's how statx() is meant to work.  The request mask is a bitmask, and the user can
request an arbitrary combination of different items.  For example, the user could request both
STATX_DIOALIGN and STATX_WRITE_ATOMIC at the same time.  That doesn't work if different items share
the same fields.

- Eric

