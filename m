Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5E9C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 13:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HVi1ub09isEcgABI6tbdTngQbHhGOmGPGHpkznwZkVQ=; b=PBHZGxPLLIxm7ThdfYrnyD57i5
	x8J0BQx56hvucWXMtPn/dBhwV03RuRwnpReTpzTIVSW8mfbqK2vz4Ukbu8k1p3+OZT5KQm3g5+M1f
	2x/9/az+NqB09J4YqZzWOCQyDke5OJoAD55E/Z1F1JgeOLtqm8C9Mj2R4IRu00WeNQTuJlOLngejP
	7mHCQbtWcUdQGV6oTZuFoJ9fMVKVKm7+lXx77XjWeRfmQ4cnRMblHIJ6p8/J4oG+VljZZhE6pEp+2
	adB8g2r8N0IjG5RJeiJVFcC20UzI6qs85bbaXSqgvIMyc+u+0yC0DlAlJqVLW7tTzDtHRbTXzTi1o
	ySNe215g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGhYa-00EHGX-Mr; Wed, 27 Jul 2022 13:58:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGhYY-00EHEn-35
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 13:58:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 99471617A3;
	Wed, 27 Jul 2022 13:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605FDC433C1;
	Wed, 27 Jul 2022 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658930313;
	bh=17GP6FcLTV3Rd1Cweg5aWI41jqGfgh4ZCwrLv6DSbNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U0XYX2AGZyJwdWANtRg6LpwcQuvl+xr2HLGkGWnpFK5y9KS+L7APi/5fmpqxLrmt8
	 pi08uxzPVmGID7HPPwwV4MzMyj08Yt3sr/xeoriz1WkIEcFVHuvWLkTEARGo7A/ks1
	 +IxvxeQNCcx2xHYDlk83yCjWDdAowVnr6Y0DQRVdNkCX1dOVmpE5SEJ2KRGuyvuEx3
	 qqGf6CbF/zgA/bzKOBBRboLeqjO5JE4wVWtVKnheMazRD0815JGRWFUg22GuTGZS0P
	 87hj+zrYLG6G+eZBrzr+EKBDDRv5M2CpCTffLva8z06ztsvgl0ChFqYyA8J5a0/CK2
	 qR1D574xhT7Tg==
Date: Wed, 27 Jul 2022 07:58:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuB09cZh7rmd260c@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuB09cZh7rmd260c@ZenIV>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_065834_194017_12B2BB41 
X-CRM114-Status: GOOD (  14.34  )
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

On Wed, Jul 27, 2022 at 12:12:53AM +0100, Al Viro wrote:
> On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:
> 
> > +	if (S_ISBLK(file_inode(file)->i_mode))
> > +		bdev = I_BDEV(file->f_mapping->host);
> > +	else if (S_ISREG(file_inode(file)->i_mode))
> > +		bdev = file->f_inode->i_sb->s_bdev;
> 
> *blink*
> 
> Just what's the intended use of the second case here?

??

The use case is same as the first's: dma map the user addresses to the backing
storage. There's two cases here because getting the block_device for a regular
filesystem file is different than a raw block device.

