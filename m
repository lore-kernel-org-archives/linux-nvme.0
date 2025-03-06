Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3057C282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 15:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fErD4g+JYTWLuM8iylxwcedkdZfQJDmhUjqElG+nVuY=; b=V+9vWL1ee/+iULPDkseCYBgEZs
	ANNfRA0F0J1wrTF9snoVKV5Kx/wLR7T66aRdReoVDsI/m0ZoSGX3rnBn4q0cPGXnfjg7foDr7tzC6
	fsxQhVQ6EO6fcZOGDExJge+DYaJ0ay3k1HXOddR5IWtCncrCGjl/lpurzYswHQzkBxUqwMqXHhhaq
	VCjqY1hO428mnFawLK5XbUweNKPBeT4HjInxLYvGZpvXLbBh9VNyM7s5MA3z8jcnZAQsWCHMoROkR
	1QB4U88MNQGyuT+yAWQM2fUD0Fh1jqVBTOeyxfDtxBf75XzevQLUhT8Who/oQ4eV5sYO7KRNNP5HG
	Tjris93A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCz0-0000000BIE6-2iQe;
	Thu, 06 Mar 2025 15:17:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCyG-0000000BIAh-0IlS
	for linux-nvme@bombadil.infradead.org;
	Thu, 06 Mar 2025 15:17:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fErD4g+JYTWLuM8iylxwcedkdZfQJDmhUjqElG+nVuY=; b=Onr+ktjrRUhYBEYVw+YAwN7daf
	aa+u09kGjdHC3lLoXhk66ofuwCz6ePxyynMbTj16X4KRuuV4yPqvgLv9prg0cj5liMWGU4z8ZK2QL
	aXPyQkqQs/bJjfdajYmOYKalEWExURDYEF4CUh/ySu7+opTTdKxpkMsDldfoBAPQt3UI4tMiFHd+G
	BmKxg7AIeGKrCUEXFBQ+JmfEkTVW/9kRT8xXO4FnotKw3FZctCun64sdVj0OSbvOX0Hh0T/tyIwvG
	FIv3b2y8krBkjaxMvsq6FvsIUMDipAqJdSMk1wAXrihH80P7SRupzhOGouB49FxAG+J/4tLKwMxSw
	fYm5C14w==;
Received: from verein.lst.de ([213.95.11.211])
	by casper.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqCyA-0000000AP88-41Gt
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 15:17:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A15AC68C4E; Thu,  6 Mar 2025 16:16:54 +0100 (CET)
Date: Thu, 6 Mar 2025 16:16:54 +0100
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
Message-ID: <20250306151654.GA22810@lst.de>
References: <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de> <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de> <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de> <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8m4vzE36UHWjwep@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_151707_800428_36A21B7F 
X-CRM114-Status: GOOD (  13.01  )
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

On Thu, Mar 06, 2025 at 08:01:19AM -0700, Keith Busch wrote:
> > If the device is indeed entirely single ported and Samsung can confirm
> > the setting is incorret and not easily fixable by a firmware update
> > we can quirk it.
> 
> It's not one vendor or device.

I've not seen in in the wild so it can't be that common.

> Or consider a true multiport PCIe where each port connects to a
> different host. Each host sees a single port so they're not using
> multipath capabilities, and the admin wants the MD behavior that removes
> a disk on hot plug. Or even if one host sees both paths of a multiport
> PCIe, they still might want that hot plug behavior. The module parameter
> makes that possible, so some equivalent should be available before
> removing it.

A module-wide parameter is absolutely the wrong way to configure it.
You'd ad best want it per-controller or even per-namespace.  One
tradeoff would be to disable the multipath code for private namespaces,
although that would cause problems when rescanning changes the flag.

