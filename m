Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF57CC6FA86
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+sAn29xG7sck0avWEL+tbt9oaixEIIg1jttkKFObsOU=; b=0wUC5MqTsdGrqnXT0TrEaCbXDK
	Ul67uP1uv+sL7qJ4KZXnKF23FyvX8/mKD7XYRZ3V87QXIbu3qyaBpFLxBzyWGlfw9kg4uOubdG38W
	ydF18Yg0iHLLmlIVy/gnuawzN3fiqLdxncCmVUK4fdHUInStj5BMz8cyoHpC/3F3Co61uWtkIjV8P
	f3Rt6x+GbsayFPO//Zz7Hf7xxMghjvTKwaOFBCTGDrRojtCInWQqC5c8SOLzPDBmg4yRbzO3Qiiu3
	mobU+lU2D+XBCzil32zkJlz2mXyAh8rqZB5bo+Dgp2YzAl0hg9RDYjr3H9+V0SasWofRn7bSyubmM
	QkIKX/Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaIEl-00CCYT-DE; Mon, 19 Sep 2022 14:59:07 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaIEj-00CCXq-JX; Mon, 19 Sep 2022 14:59:05 +0000
Date: Mon, 19 Sep 2022 07:59:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gilles BULOZ <gilles.buloz@kontron.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe write protection support
Message-ID: <YyiDufvEa+dEtziJ@infradead.org>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <YugctzU0uDZvfAal@infradead.org>
 <DU0PR10MB62528A77489B4ADE66503166809D9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <Yu4nt1bzSynhmeUF@infradead.org>
 <DU0PR10MB6252E237D18FCFB37CB17B8F80729@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
 <6a50bd55-e8be-283d-1e57-731958bd1820@linux.dev>
 <d92eae14-8ae7-a142-fb6b-26cc40791741@linux.dev>
 <e49c0b48-cf93-9247-6362-c3f2efd40ee0@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e49c0b48-cf93-9247-6362-c3f2efd40ee0@kontron.com>
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

On Tue, Sep 13, 2022 at 07:17:57PM +0200, Gilles BULOZ wrote:
> But in my case the WP pin when enabled would make the initial state of the
> namespace at the time of its creation be "Write Protect". Or I could
> simulate a transition from "No Write Protect" to "Write Protect" but this
> would be without "Set Features" command.
> In both cases I would be out of specs.

I don't think you need that.  Just set bit 0 of the NSATTR field in
the Identify Namespace stucture to 1 and ignore the Set/Get Features
parts.  If your pin can be chaned at runtime, make sure that the bit
is updated based on it and that the Namespace Attribute Changed
AEN is sent when that happens.

> Also if the implementation is correct in the NVMe, and assuming the kernel
> already supports this case gracefully, what king of kernel message would I
> get (in dmesg) in case of a write to a protected device ?

Opening a block devie that was set to read only before will return
-EACCES.  If it is set to read-only after it was opened there is no
special handling and you'll get a good old -EIO.


