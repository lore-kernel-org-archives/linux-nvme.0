Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358DFFD8FF5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 18:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3qc3cG3CBMbRsxviVLPDAuFriOhq2qVS24WIYt+JR14=; b=UWwvn0T3YNqLKoSKjY9yGD7NVW
	mverSyGvV2H9GQtxsADpSQ7tXf4RRTpOZx76rN45d2H8TFAJxgcVEd1rul59jWHAQ2CmP8X2UAuW8
	ZUz6PQ//WWcD+s9AOG0snCM2poFLJFpGCr+vzv7mSQ7zpmpWAV04L2w3gL4Z0z/AhMsdul+x71P46
	q9Z09WGNFQkQrc+l3HGlkdgb+z9xZLNeIg0UdlZ5MTV2nzWd9T5gvXQPzG5DsExse7q6UyDMPSITi
	cyv3OQhTuKYred0zFyqyNfIblaPBJfEyoPWgQ5b56beee+Zu7G3Ngnm4vORh7wKo/69pt1i8MZIrz
	ejPabsZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgD9-00000006ywo-2yL7;
	Thu, 26 Feb 2026 18:35:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgD8-00000006ywi-20Zt
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 18:35:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7CA8C60126;
	Thu, 26 Feb 2026 18:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A8C116C6;
	Thu, 26 Feb 2026 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772130941;
	bh=q64WkPKODbw5R7Y6HBWBl7eeNStDCSddNXR9hj6UOJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t8RfmUgw5kbxPxt7OXgge9ghsdPL9MjMGmvGsFpkrAYu22kexv7aGrGoew0WENHVO
	 6xCqPPvLhGeo/uBr28fEmC6gzQqAbv17E0aLx6w8o2hd8IRYsl7qVtgyzGllK8Qs6k
	 DMnPSkR1GLoHIpGWx766D+/hYb5+Hu6qwUmkUdVPNjClBrmnJcs+cqvZbisRQJbsLN
	 GZWJNpZvI4iKexOY9PBxPoSIpj9QHodMsLc8L0p/dKzNinoc4kWLyF6yC2TnMIApfb
	 Ei8fDyQdHD/VZ1J/54NVAINvBfiLtPgdtUYKeaYnIUKw3NWgZ09qbwTiBO1m0BeM11
	 M4K6vbfl89TAw==
Date: Thu, 26 Feb 2026 11:35:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: fix unmatched id's under delayed path deletion
Message-ID: <aaCSe6PZu-PiH72S@kbusch-mbp>
References: <20260225202109.447144-1-kbusch@meta.com>
 <20260225202109.447144-2-kbusch@meta.com>
 <20260226153740.GB31615@lst.de>
 <aaB6BJV3FvAVBuPq@kbusch-mbp>
 <e79a3ed5-e2ae-49f3-919c-735a2ff33358@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e79a3ed5-e2ae-49f3-919c-735a2ff33358@linux.ibm.com>
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

On Fri, Feb 27, 2026 at 12:01:48AM +0530, Nilay Shroff wrote:
> On 2/26/26 10:21 PM, Keith Busch wrote:
> > This is looking pretty tricky to resolve. The best solution I'm coming
> > up with so far is to have the scan_work synthesize a
> > NVME_AER_NOTICE_NS_CHANGED event for every controller in the subsystem,
> > then re-kick their scan work if the scan_work removed anything.
> 
> So does your disk when reuse NSID, changes ns ids such as NGUID/UUID/EUI64?

Yes. The NSID is put back into the available pool when it's deleted, but
the UID associated with it is newly generated upon creation.

