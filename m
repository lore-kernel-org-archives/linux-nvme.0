Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8404C25B6B
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 11:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SCzUKe7iFNhaufqVV95qlFlM/MWyLPs+2YdoIIE7ucU=; b=GqHhQU26J0r/ksilRfmEO2RqBA
	p/GkCZ/sm/HJipNnv1Y1skXPqDZ0hqSpEJZTSP0UJ95CdlfTZ2TcuS5OLIch7UjFkQre8Zx5KPt7A
	rGcC5HCxbTM9cUf3oABL/sGvvUWCw8Zu1UCApOwbOCjzTsLH386Osm8xEu80hHhR+lmOW19iSCqXB
	csfjX9mI/x+1E+NaaCk5MyH4DRYM9MfhpeGCre7ISc3x/14HAWqbZSBYYvs+oAP69/WnPlvrJzYFe
	AG+25mmh1sikLO5d/2LJmwbmeVUjFcXz0afVmq7smXHPIm8EcUkm9sVeQun7XaZ93eENeP1WZCL/W
	HNLyHSrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvz0y-00EPA4-0d;
	Thu, 26 Oct 2023 11:59:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvz0u-00EP9f-1m
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 11:59:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D51B68AFE; Thu, 26 Oct 2023 13:58:56 +0200 (CEST)
Date: Thu, 26 Oct 2023 13:58:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Message-ID: <20231026115855.GB3314@lst.de>
References: <20231025081253.113738-1-hare@suse.de> <20231025081253.113738-3-hare@suse.de> <2d945ecf-6313-488e-bed4-26d87df0f61e@app.fastmail.com> <4591215b-6ffa-4a74-8966-3ad0a3b9c239@suse.de> <24b5d8da-3804-4761-b480-69f1b5577fc0@app.fastmail.com> <08007889-a2ed-4d71-8eb2-4731fd012f7f@suse.de> <8fad2dc6-3c1a-40c6-8067-ed9bb8ad7532@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fad2dc6-3c1a-40c6-8067-ed9bb8ad7532@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_045901_196544_73477D7F 
X-CRM114-Status: GOOD (  20.93  )
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

On Wed, Oct 25, 2023 at 05:35:12PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 25, 2023, at 17:00, Hannes Reinecke wrote:
> > On 10/25/23 14:16, Arnd Bergmann wrote:
> >> On Wed, Oct 25, 2023, at 11:11, Hannes Reinecke wrote:
> >>> On 10/25/23 10:20, Arnd Bergmann wrote:
> >
> > 'IS_REACHABLE' is the keyword here; if we use that in nvme-keyring.h
> > things are resolved.
> >
> > Will be sending an updated patch.
> 
> Please don't use IS_REACHABLE(), it's almost never the right
> solution, even if it avoids this particular build failure,
> it tends to cause hard to debug problems when features that
> are enabled as modules end up not working correctly.

Agreed.

> Another option would be to use Kconfig or Makefile logic
> to force it to be built-in if at least one of the two
> callers is built-in and at least one of them tries to
> use it.

That's the only sensible thing to do, a that is what the user
really wants.

