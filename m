Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C99C19F32
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 01:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NKn/ymCxtfuJuiRXj6st0LntHO0OWI4y7Hy3SlVYAeY=; b=CP3rmwMB5FMeJltO/hb/BpDMQy
	P1aBj4leQI1ux8TBAI+u2DtNtuMn9ntyXrHQ84FSal6pP57NLWqVOELiTEMGZ+uEDiTxxPk0lojWG
	yn45bu9Pwk87B7Xpo4cYHWuf/pCD2P3S9DCmUWU4fZjeN1tm5g0lfbCgx1eowo64nOXw7G6YguCpA
	ZE7fRQDtmKRFn6+XFm+U0Byib1DwG5AYfQR23qOFJZ4Jxq2Q4J9wb+QxpAh69c0QyOg3TtZOQ0URn
	SlkAq+xZljXAlUzjPJFeH7QYG6VUP2xDh0wZhJRS1PBAfLyXhaoUmHDiJ3ptY8FjceZop2a1UTeBQ
	Wf2p7vvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpzsv-00000009lon-2TJJ;
	Thu, 06 Mar 2025 01:18:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpyiX-00000009fLm-4702
	for linux-nvme@bombadil.infradead.org;
	Thu, 06 Mar 2025 00:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NKn/ymCxtfuJuiRXj6st0LntHO0OWI4y7Hy3SlVYAeY=; b=Rv+Svyr27dxdKBt3quVyenyB3d
	/6J7G57g7I8fFv0GsoIomJXwKF+I7ZTZ9nbpjg04o/+nITurk+nTsG45qIpkwe3LfxEgJij/AkeWS
	a3HWs4wl9xiwVOK0ZuikO4ibkYCh/l23Kf+7LbnT9swxD0gOJNXGuVkMLSFnwyxvuC5bcm7tI41HR
	EVck6G/kf4eJFSs0bc677dd5ie59fl6LblxIOSnO9/55d1cYv6fOw+F/O5/y2unaFvd3qu0/Nssj7
	LEp2N588KSHP0zLfUMJ49KWrN5D9Jk8Dr5A3YBVWssdxKFUwxp3oVxv35waAGYVvQgz7jLsofdkCo
	ptpS82Ew==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpyiU-00000000pEk-125l
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 00:04:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18EF568BEB; Thu,  6 Mar 2025 01:03:49 +0100 (CET)
Date: Thu, 6 Mar 2025 01:03:48 +0100
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
Message-ID: <20250306000348.GA1233@lst.de>
References: <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com> <Z7TARX-tFY3mnuU7@kbusch-mbp> <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com> <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me> <Z7dct_AbaSO7uZ2h@kbusch-mbp> <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de> <20250305141554.GA18065@lst.de> <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de> <Z8jk-D3EjEdyBIU5@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8jk-D3EjEdyBIU5@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_000358_439042_44CEA605 
X-CRM114-Status: GOOD (  25.92  )
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

On Wed, Mar 05, 2025 at 04:57:44PM -0700, Keith Busch wrote:
> > > Obviously he's not talking about multiported PCIe.
> > 
> > Why is that obvious?  
> 
> No one here would think a multiported device *wouldn't* report CMIC.

I hopes so.

> The
> fact Hannes thinks that's a questionable feature for his device gives
> away that it is single ported.

Well, his quote reads like he doesn't know about multiport PCIe devices.
But maybe he just meant to say "despite being single-ported"

> > At least based on the stated works he talks about
> > PCIe and not about multi-port.  The only not multiported devices I've
> > seen that report NMIC and CMIC are a specific firmware so that the
> > customer would get multipath behavior, which is a great workaround for
> > instable heavily switched fabrics.  Note that multiported isn't always
> > obvious as there are quite a few hacks using lane splitting around that
> > a normal host can't really see.
> 
> In my experience, it's left enabled because of SRIOV, which many of
> these devices end up shipping without supporting in PCI space anyway.

If a device supports SR-IO setting CMIC and NMIC is corret, but I've
actually seen surprisingly few production controllers actually supporting
SR-IOV despite what the datasheets say.

> 
> > > And he's right, the
> > > behavior of a PCIe hot plug is very different and often undesirable when
> > > it's under native multipath.
> > 
> > If you do actual hotplug and expect the device to go away it's indeed
> > not desirable.  If you want the same device to come back after switched
> > fabric issues it is so desirable that people hack to devices to get it.
> > People talked about adding a queue_if_no_path-like parameter to control
> > keeping the multipath node alive a lot, but no one has ever invested
> > work into actually implementing it.
> 
> Not quite the same thing, but kind of related: I proposed this device
> missing debounce thing about a year ago:
> 
> https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/

Yes, that somehow fell off the cliff.

