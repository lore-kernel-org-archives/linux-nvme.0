Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3ACC021AD
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/vho69PJU6pmsngkYo60zUbTPmSGSRcOrkl74ZQ0/s=; b=2QWJ3tlOl7ilTfSB/JkUBVpY0P
	XqgqffoAx8QpLil8Ti6Dvi1PezYRioMdk2Qbrrf8IoNbQHrRgdXFuk62MLnwix3PjYa7eCCCYSp4G
	/LRckigUTPO9f7DXASiSyLApRWgdnG2rb/PEbBynfD2lPvfcsq3+m6r4tE+z6zvGgruCAfPKTdrCM
	/dVuJzH99ty/H+KMxXH+2aLNp9hDFSc2Fendmfi5h3n+64E6DfwhHvlqqanDbkble+YEyNtek6+8x
	WOUhTrXvpS8dX79EIAImtMbdSbGCFGAal6F6+zeGEMUpiSwMPp3ow+b0mygRtrEubtPDqVN5VEOzT
	mXo4t+Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPlb-00000008nww-32kz;
	Tue, 18 Feb 2025 15:44:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPlV-00000008nvW-4C6P
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:44:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 28F785C2C4B;
	Tue, 18 Feb 2025 15:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D498C4CEE2;
	Tue, 18 Feb 2025 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893445;
	bh=jzZu4W55cRQ7Nlz0usvWffw+R56yQ33h0B1doS9KmVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtFuNJWzsU4fSucSYS3ZXCwwqA8O8tQzkXcZcVhCMnetv+dmWECIb/I3DSX7r6D9e
	 ueHkqj0CqX3O8K8yIbYQL4jWyYj/tp6glG42EwLpkhSEK8Y7B4vqzw5kC0QCm04oO4
	 39iZ52WBFy14Imsal/hnlxI+xYh1oVToluxYBVRDIymgVPSI+pvpAbIN0J3yFZFblf
	 sHB/yptnoP0jk84Z0440twMOw3bJyUJJDTBU+bK1Rxx4QIhOo2YOqSqlCJw3A6DOxe
	 lt4amR/NWZ33bS1xWv+UPGue2gQGShlT6DLQkx4X+/+mNoZJWwUahS13QIpq9pfHKA
	 ANsZfMrAJLnOw==
Date: Tue, 18 Feb 2025 08:44:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christopher Lentocha <christopherericlentocha@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
Message-ID: <Z7Sqwg-pY9Aj3dGh@kbusch-mbp>
References: <381a838c-bb8a-8e95-c35a-343601cbe8e3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381a838c-bb8a-8e95-c35a-343601cbe8e3@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074406_092033_193BDC16 
X-CRM114-Status: GOOD (  14.51  )
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

On Tue, Feb 18, 2025 at 08:59:29AM -0500, Christopher Lentocha wrote:
> 
> In order for two Acer FA100 SSDs to work in one PC (in the case of
> myself, a Lenovo Legion T5 28IMB05), and not show one drive and not
> the other, and sometimes mix up what drive shows up (randomly), these
> two lines of code need to be added, and then both of the SSDs will
> show up and not conflict when booting off of one of them. If you boot
> up your computer with both SSDs installed without this patch, you may
> also randomly get into a kernel panic (if the initrd is not set up) or
> stuck in the initrd "/init" process, it is set up, however, if you do
> apply this patch, there should not be problems with booting or seeing
> both contents of the drive. Tested with the btrfs filesystem with a
> RAID configuration of having the root drive '/' combined to make two
> 256GB Acer FA100 SSDs become 512GB in total storage.

Thanks, applied to nvme-6.14.

