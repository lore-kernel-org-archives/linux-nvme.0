Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A86FC35FF1
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XMA9KMNLJ8tVmVYNg/mO32qQB8uOSIAqDcawm6mUrUY=; b=gl9kWA46W1R2I5HuxhCrN68Qr2
	5WpyyrOES/F50S+O6L1DJT6Ee6R4bc+Njg8aZDmRj6qGnK4mnlMUkhO6NiDIMmDxw2/jK3qS/M1eN
	xV/7JdtsoL3NNcikunE2VPqn1rCaVQ4BTVCc29vUkthJQaA2rVKdDGPfSlzTTDahfGObzsP0ObNvl
	Iw8K763CfCr7LTsPqKzYALpM2ZAYMo1ltzIIG6eA4iLHFlB5zr2ldEupWguE4HHUW/eJMOCBZgqez
	Ddn9k93zA40b19vXIjnleVqSXOX4HQb5qXJ1SzoRrOPNLqohM9m+S9L8fi2nxSpwyGTgjJPksOJmh
	5rPky3Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1treZf-000000033WF-1Gzo;
	Mon, 10 Mar 2025 14:57:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trdB3-00000002nNv-30HG
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 13:28:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5DE6667373; Mon, 10 Mar 2025 14:28:13 +0100 (CET)
Date: Mon, 10 Mar 2025 14:28:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <20250310132813.GA8956@lst.de>
References: <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de> <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp> <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8pB9jQALxMN6WaA@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_062817_895972_228DA70E 
X-CRM114-Status: GOOD (  27.10  )
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

On Thu, Mar 06, 2025 at 05:46:46PM -0700, Keith Busch wrote:
> On Thu, Mar 06, 2025 at 04:16:54PM +0100, Christoph Hellwig wrote:
> > On Thu, Mar 06, 2025 at 08:01:19AM -0700, Keith Busch wrote:
> > 
> > > Or consider a true multiport PCIe where each port connects to a
> > > different host. Each host sees a single port so they're not using
> > > multipath capabilities, and the admin wants the MD behavior that removes
> > > a disk on hot plug. Or even if one host sees both paths of a multiport
> > > PCIe, they still might want that hot plug behavior. The module parameter
> > > makes that possible, so some equivalent should be available before
> > > removing it.
> > 
> > A module-wide parameter is absolutely the wrong way to configure it.
> > You'd ad best want it per-controller or even per-namespace.  One
> > tradeoff would be to disable the multipath code for private namespaces,
> > although that would cause problems when rescanning changes the flag.
> 
> It's not really about private vs. shared namespaces, though.

PArt of it is about that.  A private namespace can't have another
path.


> There
> really is no programatic way for the driver to know what behavior the
> admin needs out of their system without user input. If you don't want a
> module parameter, then the driver will just have to default to
> something, then the user will have to do something to change it later.
> Not very pleasant compared to a simple one time boot parameter.

The point is that different devices want different behavior.  Think of
a fabrics attached array vs a usb4 dongle used by the admin.


