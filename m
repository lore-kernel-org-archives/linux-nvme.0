Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB54C98302
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jW1+HL8hu28GYqAU+8E261fdvTixUT97QQj1kRHk8do=; b=Jg/eXD0oNNt16fcqY2O3847W3l
	Lliwkr0hhwXaY7NV3LyuxVT0PwcQKipifibpGo4oxIqkn1oodq4kDnsn/nyZIrbbLfYJoALv+ooO6
	q0AjDWzaC/kh5Ljd678CVdjHLhPfJapZtcvcSzYWvE0AN+nPZY43ywAx+GFACelh315bIS5S+at08
	JhtLPa05h28J47N6OW3Wh2HBCElfnfHZMPeyWHNyQF77Jdbi84PR8TkjGpbkYEw3KNqeA7IBqfPhC
	+CoWqecDtnVQilMHlxZjdFQrkrQEwJs+suUMGTUYVRdunMDr5W1ET2vIE+sHPTfyp95Y15NitZleR
	m+rrjlEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x921b-00000005mAG-1biO;
	Tue, 22 Sep 2026 15:03:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x921a-00000005mA7-41jQ
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 15:03:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1DBD160052;
	Tue, 22 Sep 2026 15:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803D41F000FF;
	Tue, 22 Sep 2026 15:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089393;
	bh=jW1+HL8hu28GYqAU+8E261fdvTixUT97QQj1kRHk8do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iZ3zyDH0H9INvJD2n/v0Io2cIJ6At+ZMvQPujniHZQpVLtMhWHTygHzCeEiVTqBBu
	 eMXDwtZSf5XkejQ9/F4gwwFe37E+DdNXT5GbDAz5f1J71zkFegkVEs9IP02yGNoyRL
	 Qap7nRUQYK2s/Cup0YhS9ao417gzT0BLwF5+W0jp0HyXVqEBLP6ks8OASurHFjSvV3
	 Y2sfEdGbW0fvlNJEhYqW3VlQ6FcoeSQEaw9igmpB9OWXLe8uSTDS4OK7/a9z4+wyb3
	 oCz4ujE+do/sxhtuCFdRNAi7biBwy/0CwMuWXGWax7BuHW0u3RFouKtl0zLp3DIWr8
	 mnntkkhJj4Slg==
Date: Tue, 22 Sep 2026 09:03:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: use assign_bit() where applicable
Message-ID: <arKYsPBTYdYBVbpV@kbusch-mbp>
References: <20260919130820.3041544-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919130820.3041544-1-peng.fan@oss.nxp.com>
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

On Sat, Sep 19, 2026 at 09:08:19PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with set_bit/clear_bit to the assign_bit API.

Thanks, applied to nvme-7.4.

