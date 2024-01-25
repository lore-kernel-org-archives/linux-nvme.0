Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF08AC46CD2
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 00:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=po/0oteFTmQ9rnAeCbF01IarKtBSBYdzRdjPkncGo0s=; b=RWjq9pKUMC37fFmp9g2mlPUD9v
	6RuOp4Cc5c9whYFvdt9ZGqjkJA+gicaKCUqtRoVl2C6lRqfMP13f1swTgdPt4TCpSr/Wl6WMQvKhM
	0D6NBuYq57zTq9TIsXd/cyisUMejxvFthQ2SkyV3t+e10xoTYsO8PR4SPpS/Mf+mKMYxjNDS2aLnf
	I93O9cphy72s1fhc/5RhbzLOcG8jViek5Yovl6F49ZruxNDe1U0xx24XE0KpweTntsrSPvmkB2zBD
	fHLNBLMmfoebC1bscr3rMIKvxRgbIunXz+g740lP8L1gYFI3VHWEnG6jr9Rt5cevxzeecz+RVZ+Jo
	xM9StHvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSnyl-005k14-1Q;
	Thu, 25 Jan 2024 00:52:27 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSnyi-005k0S-1d
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 00:52:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 432C9CE2D9D;
	Thu, 25 Jan 2024 00:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC799C433F1;
	Thu, 25 Jan 2024 00:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706143939;
	bh=OC+XjcopZnLmb3krF+LmINeVCFSSzz1GKe4Bd/HF3is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjVf039jecmwPe9R72x3rAlCy7CKTs7nEXwzknpB92pT0W5/sT6udGTVQ1r1ooKkL
	 QzygMx99xtOFMc3xgRjzEjiK+KWse1MhzwiXhemYGRiX8tYKNg8QrmAsy3j4c2v0R2
	 MG3n1VtEdNMKgyUKQ5qZhb0lvf0cQfJWPcLs5RWaZNvT0nJLMz7b+1jI1i+oY8oMEw
	 DX3Aoi7n6PZuvySPFQic7XTReDwm7uxPykDUoTEr8ORokUt+x2GyV19gA+bKhDYRAb
	 f404L0eJjoURXfAbvQ/nUgC8vpiaVgoUFMq+GyeYm+RXAJCQcF3iwweOPAEx4Z07fw
	 bROl+5bpH/8lA==
Date: Wed, 24 Jan 2024 17:52:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
	ming.lei@redhat.com, ojaswin@linux.ibm.com, bvanassche@acm.org,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Message-ID: <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-16-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124113841.31824-16-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_165224_743748_3910ED95 
X-CRM114-Status: GOOD (  17.25  )
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

On Wed, Jan 24, 2024 at 11:38:41AM +0000, John Garry wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5045c84f2516..6a34a5d92088 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -911,6 +911,32 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  	if (req->cmd_flags & REQ_RAHEAD)
>  		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
>  
> +	/*
> +	 * Ensure that nothing has been sent which cannot be executed
> +	 * atomically.
> +	 */
> +	if (req->cmd_flags & REQ_ATOMIC) {
> +		struct nvme_ns_head *head = ns->head;
> +		u32 boundary_bytes = head->atomic_boundary;
> +
> +		if (blk_rq_bytes(req) > ns->head->atomic_max)
> +			return BLK_STS_IOERR;
> +
> +		if (boundary_bytes) {
> +			u32 mask = boundary_bytes - 1, imask = ~mask;
> +			u32 start = blk_rq_pos(req) << SECTOR_SHIFT;
> +			u32 end = start + blk_rq_bytes(req);
> +
> +			if (blk_rq_bytes(req) > boundary_bytes)
> +				return BLK_STS_IOERR;
> +
> +			if (((start & imask) != (end & imask)) &&
> +			    (end & mask)) {
> +				return BLK_STS_IOERR;
> +			}
> +		}
> +	}

Aren't these new fields, atomic_max and atomic_boundary, duplicates of
the equivalent queue limits? Let's just use the queue limits instead.

And couldn't we generically validate the constraints are not violated in
submit_bio_noacct() instead of doing that in the low level driver? The
driver assumes all other requests are already sanity checked, so I don't
think we should change the responsibility for that just for this flag.

