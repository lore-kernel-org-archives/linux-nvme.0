Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB52CCD342C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 14:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qqKNIYPkMoykwopHA1SG5bwMqsRRcFPTiOjqZWyHuEM=; b=iwoXogypNHyjKrUNeChhfkxLIp
	3K9MWOGUHpkG9Pff5uFkHwoLW6uDlF8WZ8myCYO4gmvbs20dn15zUJsnCrZpsdBA9WLqK/CiQULca
	OSeIUbwFk+tMyDOR2dxoEl6ZPHT+nir9a4hJX7E2PCq+ahwRBSPrVoMyev8v6qTWHhTpQL2St5daR
	UeIdVg+YO+4Xn4a9UtTGqo1NxE+DsrQIyMJZhzh/EnsTKfjke6yIo+68An8XMULAqY5xLucaAdGoz
	9N4JUAEglS8EMdRmqZ3PnZIKktWra0PjdlEFjPPcASCLCAOZui0EVDubiX/nLA5jMiJG+zOXyF/xZ
	deqDDkzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdVI-000000018qk-3ePP;
	Wed, 06 May 2026 14:45:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKdVH-000000018pF-23Wv
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 14:45:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6D50960103;
	Wed,  6 May 2026 14:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609B1C2BCB0;
	Wed,  6 May 2026 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778078734;
	bh=xDYVVvjyAHuzs5Lvz4nJoCnbJpUDTNG1u+vqQemJ2tA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKJnF5BSBFUB5mGA3J4oFzz8MWpNelG7Or9K+ggSdsa2CVkGHsOK0VgvMP6EaEfIc
	 TLWfj7hO62U/BGcxZdj8jaiWkgrfFJPsWEoL7AxuG89oQc6yKxzsBK1FiprWZIsBOu
	 8f6qL3zPHWiHzA0fOu/g1Ou9AAxHDn34/W6V+BXWZ/xOJPURF+BGYC6DSHek69OuDo
	 sixFzBGg6bm4oo5vYlh9aseuYq+wdTULy5/ZwHUFX3rBncPybMPmBGvtppaGfPhnO2
	 afbnVVpQl5ZRC6H6XZBk+gK9sMJifT8VfOXOJw5b8vN7C7Hx9FBqXkBXfHT2k0bayz
	 TWFfP1MS6Kyrg==
Date: Wed, 6 May 2026 16:45:30 +0200
From: Keith Busch <kbusch@kernel.org>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: NVME-ML <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH RFC] nvme-multipath: optimize path selection in
 queue-depth policy
Message-ID: <aftUCtUZ54bUDCi1@kbusch-mbp>
References: <20260506141544.125089-1-xose.vazquez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260506141544.125089-1-xose.vazquez@gmail.com>
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

On Wed, May 07, 2026 at 04:15:41PM +0200, Xose Vazquez Perez wrote:
> Move the zero-depth check inside the optimized path case to enable early
> exit. It avoids redundant condition checks for non-optimized paths, and
> eliminates the per-iteration check at the end of the loop, improving the
> performance.

The existing code is already well optimized, and even gcc figures out
that the min_depth_opt is only updated in the case as it is.
 
> Cc: Aviv Coro <aviv.coro@ibm.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Benjamin Marzinski <bmarzins@redhat.com>
> Cc: Brian Bunker <brian@purestorage.com>
> Cc: Caleb Sander <csander@purestorage.com>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Cc: Chris Leech <cleech@redhat.com>
> Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Clayton Skaggs <claytons@netapp.com>
> Cc: Constantine Gavrilov <cgavrilov@infinidat.com>
> Cc: Daniel Wagner <wagi@kernel.org>
> Cc: David Santamaría Rogado <howl.nsp@gmail.com>
> Cc: Dmitry V. Levin <ldv@strace.io>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Ewan Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: James Smart <jsmart2021@gmail.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: John Meneghini <jmeneghi@redhat.com>
> Cc: Jyoti Rani <jrani@purestorage.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Li Xiaokeng <lixiaokeng@huawei.com>
> Cc: Marco Patalano <mpatalan@redhat.com>
> Cc: Martin Belanger <martin.belanger@dell.com>
> Cc: Martin George <Martin.George@netapp.com>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
> Cc: Maurizio Lombardi <mlombard@arkamax.eu>
> Cc: NetApp RDAC team <ng-eseries-upstream-maintainers@netapp.com>
> Cc: Nilay Shroff <nilay@linux.ibm.com>
> Cc: Randy Jennings <randyj@purestorage.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Simon Schricker <sschricker@suse.de>
> Cc: Steven Schremmer <Steve.Schremmer@netapp.com>
> Cc: Thomas Song <tsong@purestorage.com>
> Cc: Uday Shankar <ushankar@purestorage.com>
> Cc: Vasuki Manikarnike <vasuki.manikarnike@hpe.com>
> Cc: Wayne Berthiaume <Wayne.Berthiaume@dell.com>
> Cc: Zou Ming <zouming.zouming@huawei.com>
> Cc: BLOCK-ML <linux-block@vger.kernel.org>
> Cc: DM_DEVEL-ML <dm-devel@lists.linux.dev>
> Cc: NVME-ML <linux-nvme@lists.infradead.org>
> Cc: SCSI-ML <linux-scsi@vger.kernel.org>

This is quite an eggregious CC list...

> Status: Compile-tested only. UNTESTED on real hardware.
> 
> [I do not have access to this kind of hardware]

What compelled you to propose this change, then? 

