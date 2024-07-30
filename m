Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BCCC3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u86n44649ac2REZUwuq21uha97S69U2itrHENm9h5tI=; b=oxNrzUMzYaIQjfibbS/X1kzCPU
	GWxElrWeDPvyd5tMtkB4vYGGSsSIyedTlcAA1HsmbvbQYwD5SG+MqPsQmDg3r7IpkqoPsLJSoK7z6
	J2fB+iCEEEUIP2ZqypENFijPVqGRQZwtqAGBE5ZihPG4RyISyd2kMVROnVLYRyQOPA2pcOy+8vWuC
	PoZe1MfhZzqm2DZI8rqvsdIn7+DB0orXIFObG0V+nBi9x9QxD8+NNXtfElTD/+CrmEFUZyuS8aGaK
	WL8PCH8jWV6pNF2qGlvalCXtBJbqnJp5n8YJ7x0Yt+JfJrnfjmSx81l+JX/l8IKVB81w4RgDaf138
	6Ve4Kdiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYqot-0000000G34e-2NFN;
	Tue, 30 Jul 2024 17:39:31 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYqoq-0000000G343-3Nhy
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jul 2024 17:39:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CB154CE0FE3;
	Tue, 30 Jul 2024 17:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6913C32782;
	Tue, 30 Jul 2024 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722361165;
	bh=7IQUNO1kOJBp9DfcumXq6iEFLOL/qswKjwY8TjFVz9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiTzS0HHo1HnBDfrFLLsjKI5MO9b6axeyhoIf4RASWjsXDyryA+N3nWFlmauw6fea
	 1nfd0BUTEO3AQr25IgWl4o6leykIXj/94bli5NyHlXBD10esePurcoPQDgfgLJXUXG
	 KmkIxAYqrg2Pu6iwaxcPcuFaoVXjjUywWdZ15yUmEYkQYv6HwhDJSvEoEWAuhovZaZ
	 AJ/H9JbKAdZbGoDORxWqBR4WDjviQXNiwdT8mjaVzTb2sl698gfvJzhK1kbZGrjsjn
	 gFB9uGkjGB6qofunJqbdFoV95gfaz/2uNrjTEpWUg9cQv0BdDPIHQUNlt9NP/Mfv6k
	 n1FE/mKuJDHow==
Date: Tue, 30 Jul 2024 20:39:20 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add missing condition check for existence of
 mapped data
Message-ID: <20240730173920.GD4209@unreal>
References: <23e8ca814177474160a516e09b562af339cec837.1721816805.git.leon@kernel.org>
 <ZqkeMJ5PPETMb5d3@kbusch-mbp>
 <20240730172111.GA32320@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730172111.GA32320@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240730_103929_043771_620CDD90 
X-CRM114-Status: GOOD (  18.76  )
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

On Tue, Jul 30, 2024 at 07:21:11PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 30, 2024 at 11:09:04AM -0600, Keith Busch wrote:
> > > +	if (blk_rq_nr_phys_segments(req))
> > > +		nvme_unmap_data(dev, req);
> > 
> > This is already applied, but it is kind of strange. We get here only if
> > metadata mapping fails. Is there actually a command that has metadata
> > without data?
> 
> Well, passthrough can always set metadata to map without data even
> if there is no NVMe defined command that works that way, so we should
> handle the error.
> 
> But I suspect this is due to Leon's dma-mapping work, and it probably
> points to a bug in that :)

Yeah, something like that. I had a bug in my code and saw this
asymmetry while reviewed all paths which lead to nvme_unmap_data().

Thanks

