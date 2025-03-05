Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6A2C19F32
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 01:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L0cupQeDR34bc12mIr5LJldiGIb+iacBSu9kr2ZEz+k=; b=szScRdOXqqCRnwqKHuETdMmB4m
	E8SSrhEAMDe8yuV0laZkqW0loHlvsLmh34vilgxzAh9PrIiSaMoOZear5RnBLNhYQEqi00Er69AOm
	WCAJBA9e1MnBBUWnnPU35TYPLGG44PLpJOg6sVmfTeGD23U09sbiFogI+JsjppsfsRVPpVts5Vzfk
	K7xSs/wI6w2zuu6oPvhkwlquWmwBtqVHbVA40//au13x1P/mBV/hW26gacw9kn1z1CMenDXPN7nAw
	jQwslqrEPy60Uu0MqHsN3YO+scdPziM0C2pZEQylOWEUSrFdut4c5cqu8Jfb/ykuKi/Nc0YgLpEV9
	UfUB7vVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpzeO-00000009kd0-2Qm3;
	Thu, 06 Mar 2025 01:03:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpyWN-00000009eDB-0hhV
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 23:51:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 347BB68BEB; Thu,  6 Mar 2025 00:51:20 +0100 (CET)
Date: Thu, 6 Mar 2025 00:51:19 +0100
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
Message-ID: <20250305235119.GB896@lst.de>
References: <7c588344-f019-4939-8a93-0a450481d4bc@redhat.com> <Z7Sh-3yHbXVmRbNL@kbusch-mbp> <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com> <Z7TARX-tFY3mnuU7@kbusch-mbp> <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com> <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me> <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de> <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_155127_347660_30229A48 
X-CRM114-Status: GOOD (  17.72  )
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

On Wed, Mar 05, 2025 at 08:17:59AM -0700, Keith Busch wrote:
> > > Plus there are some NVMe devices out there which _despite_ being PCIe do 
> > > report NMIC and CMIC set (I won't name names, if you came across them 
> > > you'll know)
> > 
> > ?????
> > 
> > NMIC and CMIC is perfectly normal and expected for multiported PCIe.
> > WTF are you talking about?
> 
> Obviously he's not talking about multiported PCIe.

Why is that obvious?  At least based on the stated works he talks about
PCIe and not about multi-port.  The only not multiported devices I've
seen that report NMIC and CMIC are a specific firmware so that the
customer would get multipath behavior, which is a great workaround for
instable heavily switched fabrics.  Note that multiported isn't always
obvious as there are quite a few hacks using lane splitting around that
a normal host can't really see.

> And he's right, the
> behavior of a PCIe hot plug is very different and often undesirable when
> it's under native multipath.

If you do actual hotplug and expect the device to go away it's indeed
not desirable.  If you want the same device to come back after switched
fabric issues it is so desirable that people hack to devices to get it.
People talked about adding a queue_if_no_path-like parameter to control
keeping the multipath node alive a lot, but no one has ever invested
work into actually implementing it.

