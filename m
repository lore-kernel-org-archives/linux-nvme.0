Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61911C282D1
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 00:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4yWQo9nalAIJJPe+0669+Fjq1LeGg4wIrlqjZLnPPU=; b=tKYfGB4XZ/FVoTvDZxb8A/P9CJ
	D2gS5HS4mhF+mVmfEZtK27s9xuIs6hd0oDRgFBjWbcw/xfBOXYw+LZXIbI7X8dD57xqL1fY1WgqGd
	fGfQEubu5T+avTI83xs9+a1h1ClT+POcCUNiOy9/8w7IPmNa49/kWX+L8TK69Ef7X5Eoj5JhRL3NG
	PJ6hy8HLMJul+jUGb0/wZsICilSFi6GZYAYqcFCc3V3+bbun5zZJwlgTS5ECutxOOSOUGNjHrGY+V
	GSY2IJ6UUeQVmXwgY27WpQQIMdwmutzLz/Gitu6SsGNC4o0Yrc5lcQZ0yHmgQCnCENSg272v1ZZJP
	fEHjBI/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqLvt-0000000Cgmc-3XJZ;
	Fri, 07 Mar 2025 00:51:21 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqLrW-0000000Cg3I-2iEO
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 00:46:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 115D3A45333;
	Fri,  7 Mar 2025 00:41:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFD8C4CEE0;
	Fri,  7 Mar 2025 00:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308409;
	bh=8pNhQWmAhUdyD5g7swxPHj4G3ZDU584ff49iiikDCS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjMKw7Z9r3X0zZFif14xXSNl+iQpRkd53GeL6jKpUG8smTb73GiABFRBLvmmHKDLD
	 h46BjJem0AXzyT5r4gVHP6EaMtU/7E9IXx2dV7xVFwJ1ZZbf6SbFZE9L1av4RdpSfn
	 tviWzhCdEpTOm5G5ldGaQX7riCoTHJ7sz1krTEZAK/EEGzqZstzUgft8OyyDkXY2OP
	 pbhwT8heupSxcWcUOOVxOv6blA60afT6EATUBnAzfbm/5+Z0b265/Jqy51LwrF5fkZ
	 Mq52c36vrNsZKS2txwmONqywHAAvCuiWGa6USHpPwH57uRlWbiMewD4fdd/r/qAoSF
	 LF3VHYyz2oLRQ==
Date: Thu, 6 Mar 2025 17:46:46 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8pB9jQALxMN6WaA@kbusch-mbp>
References: <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
 <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp>
 <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de>
 <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306151654.GA22810@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_164650_768257_0C1832B9 
X-CRM114-Status: GOOD (  18.62  )
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

On Thu, Mar 06, 2025 at 04:16:54PM +0100, Christoph Hellwig wrote:
> On Thu, Mar 06, 2025 at 08:01:19AM -0700, Keith Busch wrote:
> 
> > Or consider a true multiport PCIe where each port connects to a
> > different host. Each host sees a single port so they're not using
> > multipath capabilities, and the admin wants the MD behavior that removes
> > a disk on hot plug. Or even if one host sees both paths of a multiport
> > PCIe, they still might want that hot plug behavior. The module parameter
> > makes that possible, so some equivalent should be available before
> > removing it.
> 
> A module-wide parameter is absolutely the wrong way to configure it.
> You'd ad best want it per-controller or even per-namespace.  One
> tradeoff would be to disable the multipath code for private namespaces,
> although that would cause problems when rescanning changes the flag.

It's not really about private vs. shared namespaces, though. There
really is no programatic way for the driver to know what behavior the
admin needs out of their system without user input. If you don't want a
module parameter, then the driver will just have to default to
something, then the user will have to do something to change it later.
Not very pleasant compared to a simple one time boot parameter.

