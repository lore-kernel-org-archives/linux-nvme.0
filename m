Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEFDE7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYj9F5un81VZkuYIomWj1cf5jVTxtaK8pKhyUInligA=; b=1RnY3JYQnr7TpbS0XQzOQQQA6h
	quX3hKMXs/qNXdNanI19TBhqsLiIJ3gzIUTYoQ8dlL/Mds99nLrw8jezmGwgRJ+QQ8wuRBkNG+ryj
	rW6JQBQ+myIge7obLToymQvs+kUnzxOgn2rwn8cpo4RjqD7iHcsWvUEzVlecTTl4nmlqZ4/WUZeaS
	br0H7Iigo2MscX+sGFGIZ191j5l5SmwvRAPjVV4mswDuqVW5PPm3VLELg6JPMfu30du8Yq6EhfTlu
	mqCUfu8EluKBabroC+T6M14Yzg8pEFjIuYxd8BUm31C/xJY5D9/KPX/23yNyjOyNFJ65KvCbfD6zA
	ACH241NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLiCn-00000000MDT-3094;
	Thu, 12 Dec 2024 12:22:09 +0000
Received: from cloudserver094114.home.pl ([79.96.170.134])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLiCX-00000000M8Z-2ROW
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 12:21:54 +0000
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 9bd38cac647772b5; Thu, 12 Dec 2024 13:21:51 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id BBC377F5D85;
	Thu, 12 Dec 2024 13:21:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1734006111;
	bh=kWUPjvQaoxNBzOTT4VbNlf0Zq+E3gREB48uYjM0Jcyc=;
	h=From:Subject:Date;
	b=X08qOiSZDhFsu40YznaIwmRogZC0ucTkN/P6t6t7Oni4/pxdDDc6cvKFulHy/qPED
	 6FNFLl2A9hywmOBg5RyN4qSSA1maGKhSCdB/LoiYVaEhNW2tXx2EfupwCFJypliYe6
	 3ypuD9fMQ5dr97faASrG95dzZEj1e6foEMTRoGRGlB7AXIJUcJrg2g4SunoR2ggsda
	 PEjHm+c7/mkD3JwjjAqCV3+liaoQ7R60dgG0iDwK0T0APd3+UtdS8dmEr6Cvg5rNF1
	 DbTwbUnSw7iiF5Ju8ayK6U2peHwGvRebBjwUq6HG4QDSZqyluTFTtKCVkJdgW4dL5Z
	 UROxHiBKNw6cw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 andersson@kernel.org, konradybcio@kernel.org,
 Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>,
 linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
Date: Thu, 12 Dec 2024 13:21:50 +0100
Message-ID: <13662231.uLZWGnKmhe@rjwysocki.net>
In-Reply-To: <20241212055920.GB4825@lst.de>
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehmrghnihhvrghnnhgrnhdrshgrughhrghsihhvrghmsehlihhnrghrohdrohhrghdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgtphh
X-DCC--Metrics: v370.home.net.pl 1024; Body=15 Fuz1=15 Fuz2=15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_042153_776019_110298D9 
X-CRM114-Status: GOOD (  18.36  )
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

On Thursday, December 12, 2024 6:59:20 AM CET Christoph Hellwig wrote:
> On Mon, Dec 09, 2024 at 08:08:21PM +0530, Manivannan Sadhasivam wrote:
> > > 
> > > The istory here is the the NVMe internal power states are significantly
> > > better for the SSDs.  It avoid shutting down the SSD frequently, which
> > > creates a lot of extra erase cycles and reduces life time.  It also
> > > prevents the SSD from performing maintainance operations while the host
> > > system is idle, which is the perfect time for them.  But the idea of
> > > putting all periphals into D3 is gaining a lot of ground because it
> > > makes the platform vendors life a lot simpler at the cost of others.
> > 
> > No, I disagree with the last comment. When the system goes to low power mode
> > (like S2R/hibernate), it *does* makes a lot of sense to put the devices into
> > D3Cold to save power.
> 
> Yes.  That's what the pm_suspend_via_firmware call in nvme_suspend is
> supposed to catch.

pm_suspend_via_firmware() is to distinguish different flavors of system
suspend.

For runtime-suspend, there are different callbacks, but it doesn't look
like they are used by NVMe.  At least nvme_dev_pm_ops doesn't set them.




