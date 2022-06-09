Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3718C43334
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jun 2022 03:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o26SJ9+lISQpwAp7MK1vxitJfZHo3Mc10Vuk1bwuQeU=; b=HXtmEWdG4MamcdvPOOIjQn5Afp
	B277baNOCWkgR4JH2mu/p2B19vHbhLZh8nbm95+mlVROb3RsZLk9iKiA+f4zekQLJZMBAtZVX4iQN
	xWxu3D+A0ov9RxO+86QBOqI+glcT8TdslWccxelWt722ta7Vh+wMns7ImSXcHqQxxWT0x8dlco9y5
	eqQtNS/XQks2IsWMdCjgyMXMv7odeOWyPgG0zFcjlpYpBj/HtQvV1jUqBnwPYqW49afRL9siuI4kL
	pXbRe27GW6sNOEoTtt8o3qeXrwwzxqJ8zhyKsJ7kzsVVx7q1Us3JPtQ9jL231DV8Yr3JFPFgP25Xb
	88UVjDyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz9Ef-00FzSP-VD; Thu, 09 Jun 2022 03:53:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nz9Ed-00FzPp-Ho
	for linux-nvme@lists.infradead.org; Thu, 09 Jun 2022 03:53:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1203268B05; Thu,  9 Jun 2022 05:53:24 +0200 (CEST)
Date: Thu, 9 Jun 2022 05:53:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Alan Adamson <alan.adamson@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220609035323.GA31248@lst.de>
References: <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org> <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de> <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com> <20220420073641.GA6859@lst.de> <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com> <20220608075252.GB13027@lst.de> <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com> <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220608_205327_778470_F43658A4 
X-CRM114-Status: GOOD (  14.27  )
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

On Wed, Jun 08, 2022 at 01:04:48PM -0600, Keith Busch wrote:
> On Wed, Jun 08, 2022 at 06:11:04PM +0000, Alan Adamson wrote:
> > > On Jun 8, 2022, at 12:52 AM, Christoph Hellwig <hch@lst.de> wrote:
> > 
> > How do we get the clear_ids setting from the connect to the target?
> 
> I'm assuming something like this (untested):

This is a good start.  I think we still want to allow setting it
in the fabrics opts to allow clearing it for say a local passthrough
tcp connection.

And of course clear the identifiers in Identify Namespace as well.

