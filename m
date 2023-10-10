Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E72CD68F6
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Oct 2023 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BThUILCJgWvNX4SGvHfLHSU1qOWLTq09HpBj4iolAUI=; b=NqGPDCmbBxclxycSoMD39/7wPO
	zosP0GkqmNJfeAOqGbAQJSblZw+aOXD+fXd0beP0ZmRPusSG/0g1XHPdoDwe+iZDsY+st/0QFHrCA
	U014oJBzzsq4DX2A00RAC5C5MQ0UITsHZR0Ic1EZfXneSt9VCI1rlOfe5Lne8cn6uSDEFgfIZc/wp
	lAjxxCchZLABtZyxh6tjWkqCaMOKK+ed119AYUnhi3ihnEDtmbdV2LTJGRgMahaeXJjagbSkcXo86
	eHqMtADwJxkSM01f+2u87Ily3tOezKilRx/QOTLCTMA3PEK+tv7PXc1/baJBa1+Bd0dQ09xQm3+RY
	+SofkaIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qq7Uc-00Ck5N-0A;
	Tue, 10 Oct 2023 07:49:26 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qq7UZ-00Ck4o-3D;
	Tue, 10 Oct 2023 07:49:23 +0000
Date: Tue, 10 Oct 2023 00:49:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Syms <mark.syms@cloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
	Ross Lagerwall <ross.lagerwall@cloud.com>,
	Andrew Cooper <andrew.cooper@cloud.com>
Subject: Re: NVMe fabric multipathing
Message-ID: <ZSUCA40ROwqGzWtE@infradead.org>
References: <CAPYKksW8SyqG1+P1J7JRbrwnjkj=S5gWA93+yOugB=N+zhD3OQ@mail.gmail.com>
 <ZR5y+2P/NQ25/Rkv@infradead.org>
 <CAPYKksVJgr+XJUe5kFQq7T59Hn1ELvK9nLsz9re8UwvwPRY5Pw@mail.gmail.com>
 <ZR+7bCOan1wPM8jZ@infradead.org>
 <CAPYKksUVW4D7OVxjx4K0V13KdCXz6_3OFO+xPtSA5M4+C8GygA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPYKksUVW4D7OVxjx4K0V13KdCXz6_3OFO+xPtSA5M4+C8GygA@mail.gmail.com>
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

On Fri, Oct 06, 2023 at 09:43:58AM +0100, Mark Syms wrote:
> > > Made unavailable for any reason. So failed switch port, failed HBA,
> > > failed SAN controller, etc. We've been "emulating" this for testing
> > > purposes by unbinding the PCI device for the HBA on the NVMe target
> > > device but I expect the same happens for any of those reasons.
> >
> > If you undbind the device there is no way NVMe can keep any knowledge
> > about the connections it has.  If you have a real path failure on
> > the underlying fabric as long as it hasn't given up on reconnects.  You
> > can set the max_reconnects value to -1 to never stop reconnecting.
> 
> That was an unbind on the remote system not on the system that we were
> pulling status from, that should, from the POV of the client host, be
> essentially the same as dropping the switch port (or indeed a
> controller in an HA Pair dropping offline) should it not? We can
> certainly try dropping a switch port by SNMP and see if the behaviour
> is different.

So how does your controller on the host disappear?  It should be trying
to reconnect, and if you set the max_reconnects value to -1 it should
never go away.


