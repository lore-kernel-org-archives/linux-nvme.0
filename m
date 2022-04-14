Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502B5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Apr 2022 04:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WUOMrR/t4m2+T7sIR07iDsODLM47R9ua3QYfpzC9Sjk=; b=aSA3R3bwaqNICLnIcOGVG7SN8F
	MlNsVSh8K0U69ZWoM9JfoPevMZTXFAhZrh0GU61qxjpNDOFbwh9HsG3NQsOPxbfKihfNI8xYdLeDA
	x6v9eBtStcu+ndJNLOAuXFls1KXUnvn4+d/lFC+ACAAqKt5txQJWr3kOThhtB4kY+f1VRMtglKGs/
	PvJJQVV9Mt4YSJ7724uOOeqGTmpSHu6w3nVlpcSVq4Zu28WEGhJ8rTkeLNrwMvjB+CNjsSBq6SQMf
	LbGSeV+FEb5/gRjLOfWk4JoPtYCCXX28iWEXsD10jx0zmxLDgO2YBWEp8o2bq9HhD+lEqVlwU16Sx
	HWNh3V4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neqxH-003nw8-00; Thu, 14 Apr 2022 04:19:39 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neqxD-003nvT-Nc
 for linux-nvme@lists.infradead.org; Thu, 14 Apr 2022 04:19:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9D37268AFE; Thu, 14 Apr 2022 06:19:27 +0200 (CEST)
Date: Thu, 14 Apr 2022 06:19:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Luis Chamberlain <mcgrof@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Message-ID: <20220414041927.GA10493@lst.de>
References: <20220413044905.376785-1-hch@lst.de>
 <20220413044905.376785-4-hch@lst.de> <YlZ8j70shRKv/tif@x1-carbon>
 <YlaMjz7SoctkLzYo@apples> <20220413153432.GA27146@lst.de>
 <YlbxCdgPaVUykcqx@apples> <20220413155047.GA28740@lst.de>
 <Ylct1QXgzpoxpHaq@apples>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylct1QXgzpoxpHaq@apples>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_211935_954211_68090B3B 
X-CRM114-Status: GOOD (  18.13  )
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

I've added the quirk to the old ID for now.


