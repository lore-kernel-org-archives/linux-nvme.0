Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD6DD59F5D
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 18:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p3eVCDdqba/8qnv0xB6pqasILeRO0vhAV7/lD7dp+8A=; b=W/A7KPoPwSOxDbelR2qdjn2sJ2
	mzeFC5UCpv1gACtOK8uNUK1CTuUqaDC/Oy9sCwns+PxnlOkC5WRos/fx0D9XOt42rrJxmAa0cpY7f
	fUZ0REgR/pku4OrOcbJLokagBsJJ9Pqn8ERuhBq/PbAkP2zAT0iCZnIm3EWRTeOfBXoT8RN3z79xr
	izrS4odNlkdv8fh3jraO+bygApAitRSNA3wl/fUiU0g3OdOJFfXy2V1Be4BCfcjiQjfMea6s9Sn6C
	So/DO3q8GUHcJLBTSb+Ptqfswp/Qm5uJghLQC+zdU+ZMfPoNgjHgekMhc1hMo9hecTRt55r2y706j
	p29dq41A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8kuc-00000004N5r-3d7D;
	Wed, 06 Nov 2024 18:37:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8ktJ-00000004MlZ-2MwA
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 18:36:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 193975C3A71;
	Wed,  6 Nov 2024 18:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB575C4CEC6;
	Wed,  6 Nov 2024 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730918188;
	bh=d7uZUo4EgxYYzo5iZ+B5585cT/fKf9oBOEL1ue47x3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OHNvOBeT5vC90TwmRCctaWZjktJQY//J9y+dUKRTZs/9ChtFgZFgQEB7o4YNJfvNe
	 /SdUnQfudr+KzKo4DuKK1wyB76/c2wrLk5CW84KbqybdoTxkjw1Ek7UqvQaYtDageE
	 6vuU54XngSAekFTEfRjsJLx6DqBZlAfcWjTE9P/4ZLS1otP1Pg2fKVibQM9PaWsG0t
	 YZq/oULdXhmLM/XzujfxXSjmwFZYADeny+5Z02aGACmzVn/s7XIBF/89cANd6nYkmk
	 BKnx/1/yWLdOPoO2P74o7pcv7guF9NpBCXjkHQGID0OFJvPTKy2c0APWJOjGkhoXxZ
	 gCbmYUbFs1Vew==
Date: Wed, 6 Nov 2024 11:36:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <Zyu3Kc2j8CjcEkiJ@kbusch-mbp>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241105155014.GA7310@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155014.GA7310@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_103629_666316_B1C4F473 
X-CRM114-Status: GOOD (  18.83  )
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

On Tue, Nov 05, 2024 at 04:50:14PM +0100, Christoph Hellwig wrote:
> I've pushed my branch that tries to make this work with the XFS
> data separation here:
> 
> http://git.infradead.org/?p=users/hch/xfs.git;a=shortlog;h=refs/heads/xfs-zoned-streams
> 
> This is basically my current WIP xfs zoned (aka always write out place)
> work optimistically destined for 6.14 + the patch set in this thread +
> a little fix to make it work for nvme-multipath plus the tiny patch to
> wire it up.
> 
> The good news is that the API from Keith mostly works.  I don't really
> know how to cope with the streams per partition bitmap, and I suspect
> this will need to be dealt with a bit better.  One option might be
> to always have a bitmap, which would also support discontiguous
> write stream numbers as actually supported by the underlying NVMe
> implementation, another option would be to always map to consecutive
> numbers.

Thanks for sharing that. Seeing the code makes it much easier to
understand where you're trying to steer this. I'll take a look and
probably have some feedback after a couple days going through it.

