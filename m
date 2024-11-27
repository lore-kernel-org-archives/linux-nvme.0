Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93640D6ACEF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ugy9qv0eFf1SbSnOPJsIF3aBn39/7Kp16QkcvmqOXWM=; b=PioV+yccGkDvnZHJn57wSP7VPC
	+1ARXKCoJlYpJfLgMG/q1DgQD/KiYQOuCiUWNyjKqfDlnIA27x0MgHjE67Onl4o7eSr/84isUqfBg
	RX8PbeTCKk3BHWhIUASNIhzun2Ywt3CQnx1hTdWrp/L0SpLPcL6bvWg9Fv9+4wTsTRPh2d1Rll4++
	MNbvyk8qeZXITrMV7zEFnZyr4ydILjjLRdPck/Ooib5tAvoQuDAlp1NoA39vA0E0TlrliLgEy0iuw
	2gIAv/61qUL8G+JcpEsi+ozGhN+7/DBLvuUthhybuF86QzoxqtZ60iScf++6v65+gc8d1ViRRkP6R
	/zdtb6uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGKKm-0000000DYe3-2Mmj;
	Wed, 27 Nov 2024 15:52:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGKKk-0000000DYdd-2H4h
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 15:52:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DE34CA438C4;
	Wed, 27 Nov 2024 15:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1EFC4CECC;
	Wed, 27 Nov 2024 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732722725;
	bh=Qk3Ix05dqxG8bJNSHR/5K3MbZSYAVcg0tzJpAUDIU3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mZkAuJpdmN1WtC9JngSoc/qR0glXzF2PkBXdkLYsxUdvPIfz3x5zHY6xKwC+WqRnn
	 N/UQ+A+pJmpB/G/msIuQZZy6bmIW0FVKqVapFaiFSzj8gYao+9q7bLuJI0ZsEqa1EE
	 +zXx/uaQNCGUsv/1lFKJWePFdm9oAkzk6J/cUzzmq4RrvhKFlRKfV9pJfkw6F4ocbd
	 hq86Xu8ipWV7K6hpiOMHW+x6u5rrwdVMARGGD/sjNpyF9Nnlf4jYfhguV4GTtv3mRi
	 cAQALzUyQdcG79mBOFqEkl0pAo8vLOASXlVYAOhGYNGi7VHr/pYOjUm4FgEmYJ158i
	 3ZA/ELjFTS3NA==
Date: Wed, 27 Nov 2024 08:52:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, axboe@kernel.dk, linux-nvme@lists.infradead.org,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: Re: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Message-ID: <Z0dAI_g7bZJUAGHk@kbusch-mbp>
References: <20241127064218.42688-1-hch@lst.de>
 <Z0c-gFbw4n0SaKD9@kbusch-mbp>
 <20241127154812.GA24372@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127154812.GA24372@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_075206_644068_DF681CEC 
X-CRM114-Status: GOOD (  17.87  )
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

On Wed, Nov 27, 2024 at 04:48:12PM +0100, Christoph Hellwig wrote:
> On Wed, Nov 27, 2024 at 08:45:04AM -0700, Keith Busch wrote:
> > I still think this is wrong, and we should just remove the quirk for
> > this device. With the exception to this firmware version, this device
> > generally supports both discards and write zeroes. The only reason it
> > added this quirk was because the quirk used to mean something completely
> > different (specifically, it would set the "discard_zeroes_data"
> > attribute that's no longer used). It didn't mean to prefer discards over
> > write zeroes, but that's what it means now, and that's not what this
> > drive wants.
> 
> I'll have to trust you on this device, and certainly won't object
> removing this weirdo quick.  But as long as we don't remove the
> quirk entirely we'll also need this fix.  So I guess we should go
> for both?

Sure, that sounds good to me.

