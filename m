Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC57EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 14:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vOIuOqOsuwF3/q5uasrOQ6+tbdvo7/hwKfio5nNH6/A=; b=W5ONqfH0cfdIkluWpQZDsergMd
	wWhqx6a+t2hoCdjyZh8tidhLKTVTAgRPR4nLs0kef+K1vj7WkZAcUOXTBmbIcXmQD853LMbXqoSOS
	zA3ReEe50tNuTKm56hTDQFqSg5MUybUdGP3viBWuDIbA+GXS9DZNFOoVqZdGMjX/N31HySErao1Mi
	0K2UJvILboA6j7kfD8IlGfLem567hHc95126utxgV1asRViEcprzUePgUh6I+M8ECzS4A9zwLm2ck
	kkJfrqo5/NJH0VkEbbtsxKv0chzQ1N6cGUwxcGUh610EmRtinSygndV24lgCzK5zL5IgeszXwa1WZ
	cQTIy2qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJE69-00F50m-0s;
	Tue, 11 Jul 2023 14:12:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJE66-00F4zz-2s
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 14:12:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5BEA76150B;
	Tue, 11 Jul 2023 14:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED1CC433C7;
	Tue, 11 Jul 2023 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689084729;
	bh=NRBCd7EYg1Ttg7Sd52hrW/FKaUnozUqBArGH46pm5Hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dv3ZPcOrttwlRQ7ym+XMaMprZg4jGyXAIcnMCZRSQeRCMr+rPOx+AR2x6FEX+gXnQ
	 JsZ9nzbfIpxOMv7EyoXY5LJgHFl8NMwBFdr6qI/rnUm22VqNc+CWNgEThskgCZR0JZ
	 9XOm7XCRs+H/vlnlGMQ5Vg0k9wAffpQtZ8WSlAYw=
Date: Tue, 11 Jul 2023 16:12:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	"Clemens S." <cspringsguth@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Javier Gonzalez <javier.gonz@samsung.com>,
	=?utf-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <2023071135-opt-choosing-51dd@gregkh>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
 <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
 <20230711120609.GB27050@lst.de>
 <23017407-83eb-8fb0-5d91-2c7c4ae02544@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23017407-83eb-8fb0-5d91-2c7c4ae02544@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_071210_970542_D0183B9B 
X-CRM114-Status: GOOD (  24.46  )
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

On Tue, Jul 11, 2023 at 03:14:54PM +0300, Sagi Grimberg wrote:
> 
> > > Well, that "They keep pumping out more and more devices with the same
> > > breakage" and the "new device" comment from Pankaj below bear the
> > > question: should we stop trying to play "whack a mole" with all those
> > > quirk entries and handle devices with duplicate ids just like Windows does?
> > 
> > As far as I can tell Windows completely ignores the IDs.  Which, looking
> > back, I'd love to be able to do as well, but they are already used
> > by udev for the /dev/disk/by-id/ links.   Those are usually not used
> > on desktop systems, as they use the file system labels and UUIDs, but
> > that doesn't work for non-file system uses.
> > 
> > And all this has been working really well with the good old enterprise
> > SSDs, it's just that the cheap consumer devices keep fucking it up.
> > 
> > If we'd take it away now we'd break existing users, which puts us between
> > a rock and a hard place.
> 
> Maybe the compromise would be to add a modparam that tells the driver
> to ignore it altogether (like allow_bogus_identifiers) that would
> default to false. Then people can just workaround the problem instead
> of having the back-and-fourth with the vendor?
> 

Module parameters do not work on a per-device basis, sorry.  This isn't
the 1990's anymore, please do not attempt to add new ones :)

thanks,

greg k-h

