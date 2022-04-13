Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219CEC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 20:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RyigBHPFZ0X1+cUpaSLOKDA78OV89fXGQGSZqoFE41o=; b=RsbtmMxIcZ14/Nkk1hSYugCh7L
	Ns94WHZV9v1hy1++P+FW7e5obb3FcqMxGE0hcXVylx6FyG9wG6hpjC2bTqRz6WKmLnOwoL8/lDVeX
	EPK8/ZtaPjgNbvtsFJjYS4/teQ3a1uUwHP6NL2YPaXZXccDIQX9P/6ZTf9BOhEPeza0EJFzwivX3b
	1lpkxdHfEhat+h2rycp7e1qez8WDA0bO2ze3vCDqA9dCO2W/pVlWePJTUY91YIQYuN8vy4293ElK+
	D+toSTQcdhs5ELqL6WiR2Rcx6OLTyuagEi5/YQrNGbfEOh8RTlQnfFfbeddfDW4ebvh+k9c2ZTTNC
	Ot6terwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nejlE-002fKv-5G; Wed, 13 Apr 2022 20:38:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nejlA-002fKJ-Q8
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 20:38:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 88B3961E03;
 Wed, 13 Apr 2022 20:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2D3C385A3;
 Wed, 13 Apr 2022 20:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649882319;
 bh=7CkNmG5BVnrj+OotAbQuct6V9GFHZkXVS2aQhuCX7Uw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oHlMfPB4nrA10SrnfdmiYSJDgYyOlKFcuhnme7IXorVZLYPmc4aTFPrE6CL+XjyCX
 yEbACEy3UAklDu8kOsKa6kYCT9/anindBcdIqdUujtvj2XCO6Q7XZfNp5EkD/TKc5P
 Gg4jJhFZ92PJJrT3x29cPs8L47diHvU+J16PLR5CQ/dgIbVyksV1+V6mdyg988gNpc
 pIz5eQHLFaDUgbpEqKzigARGJ/WvSvmq7AiI0wfvcgSfLqVdDcjkDU099aohl2le/g
 p5PVcUf7u/GVxu3SvlSq8qzFyKAbNAhX0Rhxdqvs/1BK2VHmrA/PuP5Dv+aBhCDZiY
 N62xEVhAGD+0w==
Date: Wed, 13 Apr 2022 14:38:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <Ylc0yyZa8QSW3Xlj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220413044905.376785-1-hch@lst.de>
 <20220413044905.376785-4-hch@lst.de> <YlZ8j70shRKv/tif@x1-carbon>
 <YlaMjz7SoctkLzYo@apples> <20220413153432.GA27146@lst.de>
 <YlbxCdgPaVUykcqx@apples> <20220413155047.GA28740@lst.de>
 <Ylct1QXgzpoxpHaq@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylct1QXgzpoxpHaq@apples>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_133841_118090_1027E482 
X-CRM114-Status: GOOD (  26.05  )
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

On Wed, Apr 13, 2022 at 10:08:53PM +0200, Klaus Jensen wrote:
> On Apr 13 17:50, Christoph Hellwig wrote:
> > On Wed, Apr 13, 2022 at 05:49:29PM +0200, Klaus Jensen wrote:
> > > This means that the 'use-intel-id' compatibility parameter may cause a
> > > 5.2 nvme device to present itself with the Intel PCI vendor/device id,
> > > either because the user explicitly set it, or because the machine is
> > > launched using a pre-5.2 machine type (i.e. `-machine pc-q35-5.1`),
> > > which you would normally do if you want launch an existing VM on a new
> > > version of QEMU.
> > 
> > But if it presents an old machine it also shouldn't support a new
> > identify call, right?
> > 
> 
> You are absolutely right in the case of live-migration, but hw/nvme is
> marked unmigratable, so we do not worry about that.
> 
> We probably screwed up with the compatibility parameter here, since it
> really only guarantees the id and some headaches for you as driver
> maintainer. I'm sorry about that - I'll keep this in mind for the
> future.
> 
> Regardless, the fact remains that it is possible to have a device with a
> buggy uuid namespace descriptor using the Intel identifier, so we should
> add the quirk for that as well.

Reporting that identifier really should be deprecated and removed if at all
possible. There was a miscommunication regarding if that PCI device ID was
actually reserved for this purpose (it wasn't). Intel at some point will use
that DID for some device that isn't NVMe, then we're really going to be in
difficult spot.

