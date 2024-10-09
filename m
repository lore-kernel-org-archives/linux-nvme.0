Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DFCCED61E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 08:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=axFQRrF2Y8HkeQ4+fO7T8+Nt4YU1FpmE7EWBJtnvsvg=; b=FNYxOgz7V5YHE9ntvU9OhxguqY
	0DuGTynfHaTsaGmr6RJLJKgCfQ1TVtpduAQ49zAKulHMAxxmsZFAVthmG5QTMtnKjIGAQ8Y6b5V9j
	YHeDXrTDwnjTjCqccG2UP25Qm6CD2aWXQojtSK5oQb5um8JUqk09U4dBtpsMC238ZjiC/BSea+ac3
	FncfTaXPj0/dCobgFzHW837XEvrF8xAeFzxQb8TIvir/+ssF4IWVBiWyUzoaqjlnXo61SgqeBmxr5
	VLbXDeHEeTTKCwUeO1kugQsWb9j6R/PpfS51wzvM9yHZ4Sj3x1Z9peD915cXYYoA4MeEHKNDjYtOJ
	EccYz7Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syRfi-00000008MY2-1Eil;
	Wed, 09 Oct 2024 08:03:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syRct-00000008Lzo-3SGh
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 08:00:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2FF24227A8E; Wed,  9 Oct 2024 10:00:52 +0200 (CEST)
Date: Wed, 9 Oct 2024 10:00:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	axboe@kernel.dk, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kbusch@kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
Message-ID: <20241009080052.GA16711@lst.de>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com> <20241004101014.3716006-2-tero.kristo@linux.intel.com> <20241007061926.GA800@lst.de> <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913b063d0638614bc95d92969879d2096ffc0722.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_010056_028029_FA196501 
X-CRM114-Status: GOOD (  13.99  )
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

On Wed, Oct 09, 2024 at 09:45:07AM +0300, Tero Kristo wrote:
> Initially, I posted the patch against block layer, but there the
> recommendation was to move this closer to the HW; i.e. NVMe driver
> level.

Even if it is called from NVMe, at lot of the code is not nvme specific.
Some of it appears block specific and other pats are entirely generic.

But I still don't see how walking cpumasks and updating paramters in
far away (in terms of cache lines and pointer dereferences) for every
single I/O could work without having a huge performance impact.


