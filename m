Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2FCC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+SmgjS10bYVgGGd9funAxhCENKaThy2chz6qXAPHaaQ=; b=vhjDPYfGytEj6ajYURsMF4dYY3
	rpKpTa+n4uMmCLdbGL+Hzqhb5NHO2YoJC1EiWrIOraatFNd5z4z99yygRwN34kmyUBEmdd7NRwZjh
	8M0UuTzpPbElCr3uZ5mM9MInvlANLoUKb2wUtzVc/E/3sRhb8DTptRoHzoOq6ONHPQYnLDC2xhzIN
	THqXUxYh0G6hbYOhklh/71NW267aiycnfsazGzK0DvNS/tSdZcTqQR908XcNji3UgNW8nmrJj8PKC
	DVvRXbG874TjI/nMDHCU7yk/yoGinS8514B9Ly7Wn/DOksUjfrbGcB5y9MF/Ea69/ZLkQfchcc67i
	IlPQpQfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pezK5-00GGiQ-00;
	Wed, 22 Mar 2023 14:20:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pezK2-00GGhO-16
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 14:20:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3758067373; Wed, 22 Mar 2023 15:20:10 +0100 (CET)
Date: Wed, 22 Mar 2023 15:20:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/3] nvme: add polling options for loop target
Message-ID: <20230322142010.GA18721@lst.de>
References: <20230322002350.4038048-1-kbusch@meta.com> <20230322002350.4038048-3-kbusch@meta.com> <20230322082310.GA22782@lst.de> <20230322084651.xmnup2ag3ve6jr3a@carbon.lan> <20230322135200.GA16587@lst.de> <20230322140619.zy2msly7mcuwgo6a@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322140619.zy2msly7mcuwgo6a@carbon.lan>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_072014_525482_59CF2939 
X-CRM114-Status: GOOD (  16.61  )
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

On Wed, Mar 22, 2023 at 03:06:19PM +0100, Daniel Wagner wrote:
> On Wed, Mar 22, 2023 at 02:52:00PM +0100, Christoph Hellwig wrote:
> > Who says that we could support polling on all current and future
> > fabrics transports?
> 
> I just assumed this is a generic feature supposed to present in all transports.
> I'll update my new blktest test to run only tcp or rdma.

The best idea would be to do a trival and error, that is do a _notrun
if trying to create a connection with the options fails.

