Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33471C25B75
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cPggZ9pVR9qxpKAQI4zXgMoKYPYmbU5ua2LBIpa8czI=; b=09pXyi/ozmgCo0sHnbQ5RY32Pb
	SafouutRG1jC3Pt6IiU/MrOmQ8AZy/M6YQJUUCI2yK2df5qkNex87vnLycAlAeRpRg2kDr0T0wD0t
	KBZ22Q+kZqhk+EjNsFhlHbIh5lu60NeDuaaXEOHKl11ovFp41VNX70O9yJdmsQWUzq0quUcf/CVGH
	kJhkDAZT2jm6XhT2pi+aqxugdtjdIZYqB3K//fMtZ3soG9lhnJMfIHUSHaiKKkbJBwvliknHy9uee
	IPE7FtqntZ5aKguqLQwxK98Uv0TnKeVCXnybUf8mMTpbNCiHOiKMx1NzhIFPEDj8pfmJ+3JRQSHQ7
	W8HdjZMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFFLx-0000000AMgN-2wr9;
	Thu, 06 Jun 2024 15:48:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFFLn-0000000AMfB-1tPZ
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 15:48:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BB43D61D00;
	Thu,  6 Jun 2024 15:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B11C32782;
	Thu,  6 Jun 2024 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717688906;
	bh=kGvrhh9vt44tqgRnyfCTTCQ/16e7yxQoW2Mu3o2AbYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+oln5bPyjfE9gzBCUilSGSHPhrea1mfNoB4si8c39KE9ty439swsXFFpTAmyDg9+
	 5OhGgHE0tvjwNtyYXMFOqOnBMKywDw/LZP6LWpgLyDlMONlHDbjpvP5HtYoONMVCx5
	 RGCU6H0dvjp0P+1KQmOJM1FGrSw789VvJTmPARa4Br1xtby86ZuOG4fN4zpyOGowpO
	 jpvi67lnTuAgcLVbqCNgidg3XIUcwm3J2UYa7L8Gmhhvq3v+uLwLa+o70RYZQI+9K3
	 R2Mf/fT1o6LGwnGflSYTT2hLuhadoA/w+muao30xHh2VksaJyT4JTaX/pzzg9i+92u
	 t9xkRemDBbVUA==
Date: Thu, 6 Jun 2024 09:48:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, yebin <yebin@huaweicloud.com>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
	Zhang Yi <yizhan@redhat.com>, "Ewan D. Milne" <emilne@redhat.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmHaR07LgUEhr_zX@kbusch-mbp.dhcp.thefacebook.com>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
 <ZmHH7mW0M80RaPlj@fedora>
 <ZmHNQ56C6Ee01Kcv@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHNQ56C6Ee01Kcv@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_084827_582711_7A8B99FC 
X-CRM114-Status: GOOD (  20.98  )
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

On Thu, Jun 06, 2024 at 07:52:51AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 06, 2024 at 10:30:06PM +0800, Ming Lei wrote:
> > Yeah, that is one area queue freezing can't cover logical block size
> > change, but I'd suggest to put the logical bs check into submit_bio() or
> > slow path of __bio_queue_enter() at least.
> 
> We really need an alignment check in submit_bio anyway, so doing it
> under the freeze protection would also help with this.
> 
> > My concern is that nvme format is started without draining IO, and
> > IO can be submitted to hardware when nvme FW is handling formatting.
> > I am not sure if nvme FW can deal with this situation correctly.
> > Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
> > needs nvme-cli change.
> 
> .. and doesn't protect against someone using a different tool anyway.

It also doesn't work if format is sent from a different host. If you
have a shared namespace, anyone could change the format without
coordinating with anyone else.

That's just an unfixable gap with the current spec. The driver tries to
react to the Namespace Notice AEN for this, but that can be too late or
not even enabled.

> That beeing said, nvme_passthru_start actually freezes all queues
> based on the commands supported an affects log, and
> nvme_init_known_nvm_effects should force this even for controllers
> not supporting the log or reporting bogus information.  So in general
> the queue should be frozen during the actual format.

Just for single host consideration, the our current nvme freeze does
ensure IO is drained before dispatching the format, and should work for
most format changes.

