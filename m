Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA75BD3A661
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86nGm1MC4o+a2xTUgYus9Edncau6hRxrVx9vidk16m8=; b=iqMBj431pvEoKqW2mqXPZSWr2e
	N+9i0qy7Y4ztnWoeQla/XuJvagYnhKAFSklcwxrtccmMhaHr6AKmCWI4tV5501+VmLVJR52drQavm
	AJ1HUTtdLarS3pa/MlSIMWPKPyLgriMWxc1Uavy3d5oeIH8Z+iBIh4gUM/qLBTdTgT2LaXceAlXPj
	E2UsVaXE3Bd02+InpxopPB0PWHeMplINf6TQeuOsTfDp3twsPOsdxw1Hpij7F6UYt1X7TmzjfZtyF
	RVB4sowqAIuWWE8EgLJVHSpidYECASvQZd5E01yFMZ3Cutqzal882z8ECkHHqf23bxGmDWw0QOVi8
	lh7DU3Qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5nnL-0000000EooG-2qvo;
	Tue, 29 Oct 2024 15:06:07 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5nft-0000000EndB-13Be
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 14:58:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C6FC75C5C01;
	Tue, 29 Oct 2024 14:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC981C4CECD;
	Tue, 29 Oct 2024 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730213903;
	bh=GNa4N2fUWwELysSBqc84AvRVfFz1dg5fD/u3X802eDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5seOjFXz6ipg4Fk9CgTP/GEjnomAbR65RCW+mw0VwQTlmsqAvZgVB+7clzN7Qt9f
	 lPto744Pt2/hLQxhzxEHN6jSVNCmlndlUxTIXqB0xrjX+ckDxA9IRvNmXddf5Y4lpH
	 HyyfH+U7HQWVUy4etJ51wgcE5TD8+mfQUyvfOszj93fJEtKHDiRq0+RCZ+x+PGx+np
	 6tvjgP8kPjY9ZaJqU0oezWewFWzmImrKJNH0KrY/inRNzWHw/HKXWFdYudU8evbeuY
	 Bgv7DmGcPFwiPVnUH4um/gt/Q+B4i+75/d/vclR9+xYlVzt5rlr0323dM5EiIS/EPD
	 FzO2DYvIqpo3A==
Date: Tue, 29 Oct 2024 08:58:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	hch@lst.de, axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_end_io function
Message-ID: <ZyD4DHPqNj9jWT1s@kbusch-mbp>
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-4-nilay@linux.ibm.com>
 <2c77692c-5a67-4a79-a483-350ba02c8fec@grimberg.me>
 <15db6283-726c-495f-b7d7-eb368559b0ee@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15db6283-726c-495f-b7d7-eb368559b0ee@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_075825_387274_D887435F 
X-CRM114-Status: GOOD (  17.93  )
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

On Mon, Oct 28, 2024 at 10:13:25AM +0530, Nilay Shroff wrote:
> On 10/28/24 03:37, Sagi Grimberg wrote:
> > On 27/10/2024 19:02, Nilay Shroff wrote:
> >> We no more need acquiring ctrl->lock before accessing the
> >> NVMe controller state and instead we can now use the helper
> >> nvme_ctrl_state. So replace the use of ctrl->lock from
> >> nvme_keep_alive_end_io function with nvme_ctrl_state call.
> > 
> > The patch description is not clear. Why do we "no longer need"
> > to take the ctrl->lock? What exactly changed for this?
> > 
> The update of ctrl->state is now done using WRITE_ONCE(). So it 
> makes sense to pair the read of ctrl->state using READ_ONCE(). And
> the helper nvme_ctrl_state(), in fact, reads the ctrl->state
> using READ_ONCE(). So, if we use the nvme_ctrl_state() for 
> retrieving ctrl->state value then we don't need locking. 
> 
> I think I would better format the commit message of this patch
> to describe the above intent.

Makes sense to me. If the code was racing with another thread attempting
to change the state, then we either saw the old state or the new state.
Same is true with using the state accessor without the ctrl->lock.

