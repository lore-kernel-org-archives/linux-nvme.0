Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6812C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 05:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/AgoQ66Gx1QNJluQMlsR452ZiotXg+Sue4g3ozRJhw=; b=ri1y9uvi6BdajYSL1hLw2CCFi1
	C4hZVT6T6hnshLkEkufvGXiZXi0e2jzv7Kn+2zVXrk2wXLRThth4mJIyOPvqhaE8uC4RIqj531BYm
	L5yNgSZ7E2bzD6Tr38tAW3R2rBQQaLeNNlh0wquoH8QyzyXCkPAe8sKSUPp4PixtCh7xaLqFD9zGm
	pvaFyD4zM+adxfz0E9uVPFB6E4Hs9YmGLaL+dtMXeMrw8Agumdzv/toigQtX7eJFHNL3JTVzoXwfC
	xg/z4nZIDxnfd+dQ3pfr5LrLMu/N6sud3SO07TNt0bPovxxBzDGZ8ErDyUWPWXpurZuJWil36j1zc
	7J/X0I2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wox22-00000006xFU-47Nd;
	Wed, 29 Jul 2026 05:40:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wox1y-00000006xFN-0YhB
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 05:40:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id F2A0C60A5F;
	Wed, 29 Jul 2026 05:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292741F000E9;
	Wed, 29 Jul 2026 05:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785303636;
	bh=H/AgoQ66Gx1QNJluQMlsR452ZiotXg+Sue4g3ozRJhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kejc6IsBmAytfBzRNDmMxidpJx3JKjUc4QNt7tAoLpYtCEpIz9y44Jl/0xuNpQUa8
	 wNCJ7NQex0VTglRMeGmkpNpxz7rV96LC45gmsZi1TqYGMXs2dKkF6fqqW/+4BPasy+
	 2m23amk5pJQ3/nNyMJjMyudM0ttYzXCkyYREP+5c=
Date: Wed, 29 Jul 2026 07:39:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH] nvmet-tcp: Do not WARN on remotely-controlled oversized
 SGL allocations
Message-ID: <2026072944-express-relapsing-42d7@gregkh>
References: <20260727-nvme-tcp-v1-1-61c0e36763eb@linuxfoundation.org>
 <amjjhnBMMcHACoKp@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amjjhnBMMcHACoKp@kbusch-mbp>
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

On Tue, Jul 28, 2026 at 11:14:46AM -0600, Keith Busch wrote:
> On Mon, Jul 27, 2026 at 10:03:31PM +0200, Greg Kroah-Hartman wrote:
> > When fuzzing the nvme target code, I tripped a kernel warning in
> > nvmet_tcp_map_data() because the length passed into the allocator is
> > controlled by the remote initiator.
> 
> Thanks, applied to nvme-7.3 with a minor fix for an overly long line.

Thanks, I thought you all would allow stuff longer than 80 columns like
the rest of the kernel does in places :)

greg k-h

