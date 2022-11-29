Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBBFC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yo08tUo3SIJFDob9GuuiIhb2KPRnVC9af2iiBXvROWU=; b=KyxZJtv0tJgGXLZtBR8jUaF+Mu
	bB28HW8vxl5lcm/R0GV+3Hw3J3s9UsWSzYjofYMdA5JWl0PpE70oEtIStIE1J8nalZLAwDzkpdVSq
	G3tdNo69pkjTGUq8lIgZLJxCCo5Yhm3cYAuA8EhNndp1CLcrzBXohuXBpHT5P/YXPNXAQY4oQUJEP
	oY6bxKra1DLe9DFbL4rkVHwwgTQIPhoVslv/WMlHoZGRFSzT+y9JubKlWm7Z22mSjQHwGb/xMmFQ5
	BYU8CbH0+dH+l+A3mCzaWeUsXhQMEwl+RWUURz6eUCjSuf8gdtDXb7NUrM5PhB8Yq9b9P79odAY56
	snNftsmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p023U-009VUE-4a; Tue, 29 Nov 2022 14:57:52 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p023R-009VSk-8N
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:57:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 974AFB816B3;
	Tue, 29 Nov 2022 14:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AF6C433D6;
	Tue, 29 Nov 2022 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669733866;
	bh=iM3+acKUpSRYvrxiVSHFXb1YzekYZBEKMzhVqNBwxOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlyHNh+qoJSTjxLQ9dGDgFofluIr0iuiimfh0PBahWYbrqNDplK5c4dbQfU1cFJF3
	 XELGrtcvGic+S8WoxP+kwsenmLWlmAM/2LWLxcCBPp579J1QpvI+CvAZQgGm4JJ+wk
	 1AmwLjq02DpwidWxh00GTc8SIwhUFw8kkoN5WG0Q9TLkDmSpX9tV7jpg3eqBwlANTt
	 ubt1/a3Snq0bUj+1A4LUFq0q9A+S+gY4Ea+A58XNbE+5eoZLfx/TllDUZh4TIkjdZZ
	 hmf5E/Zo9wIwXDQo1JXnmJBH51NWejWJylgiUSkuq7UShLfE4akgfa5TS1adB7g9NV
	 5UordQf7v6Ngw==
Date: Tue, 29 Nov 2022 07:57:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: sagi@grimberg.me, hch@lst.de, chaitanyak@nvidia.com,
	gost.dev@samsung.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 1/1] nvme : Add ioctl to query nvme attributes
Message-ID: <Y4Yd5zPs8KQf5hgr@kbusch-mbp.dhcp.thefacebook.com>
References: <20221122092244.899894-1-j.granados@samsung.com>
 <CGME20221122092632eucas1p2648479360860fa80e35c964d99b54f0b@eucas1p2.samsung.com>
 <20221122092244.899894-2-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122092244.899894-2-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_065749_474433_02ADC7B0 
X-CRM114-Status: GOOD (  13.36  )
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

On Tue, Nov 22, 2022 at 10:22:44AM +0100, Joel Granados wrote:
> An ioctl (NVME_IOCTL_GET_ATTR) is added to query nvme controller
> attributes needed to effectively write to the char device without needing
> to be a privileged user.  They are also provided on block devices for
> convenience. The attributes here are meant to complement what you can
> already get with the allowed identify commands.
> 
> New members are added to the nvme_ctrl struct: dmsl, vsl and wusl from
> the I/O Command Set Specific Identify Controller Data Structure in the nvme
> spec.

I think what you have here is fine given the constraints you have work
with, though inventing new structures to report things in existing
structures still seems off to me. Is there actually any privileged
information contained within the controller scope identifications that
require the driver prevent non-admin users from seeing? If not, I think
relaxing that access restriction will set us up for longer term success.

