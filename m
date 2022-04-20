Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35D8C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2fcLWe0DFPQBlcvBarJQBBvjVD+POqvj0LoXF+RAaI=; b=Eyl79k73ldLf8I6EIOCaCdGVbS
	bnWPCsb/C4wq5d9dpmEHR0MEsJmW3fAA1kgO8xyj57vSH1Qivaa0jN1wmA0vASyOfM+6Rp2lCpm40
	XcW4hRrODrTlsYw83kiyu8xTAxZ6HewwNmt3ZeNXwoXJ3JR9tJwhEdUatDIp8WWfCFjFnLcmZKBn4
	+wvWQ4EUlq4OSRQUqjstMay4TyxCAiYtbV1+orySVor6AWw1x7sSrtj1J7hiRAiAG+NzG4jOc1ZFd
	x3md/efXwd/uTtLUe0aHmnYWqnhbE7pw14dq2y7qfThtk/lw/qO3mWNmHyL0dpq9J9vWXThUcgp9R
	Gx27NuwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh4tQ-007oJB-FH; Wed, 20 Apr 2022 07:36:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh4tN-007oGt-Q6
 for linux-nvme@lists.infradead.org; Wed, 20 Apr 2022 07:36:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3D6CB68AFE; Wed, 20 Apr 2022 09:36:41 +0200 (CEST)
Date: Wed, 20 Apr 2022 09:36:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <20220420073641.GA6859@lst.de>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de> <Yk+KO8hEYpnKdGu3@garbanzo>
 <20220408052907.GA31990@lst.de>
 <b395277c-5721-4773-9bbc-13cfbc1b0401@www.fastmail.com>
 <20220408161052.GA28661@lst.de> <YlB1E/p1uqpl3HiN@bombadil.infradead.org>
 <20220411050533.GB13927@lst.de> <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220420_003650_036457_61304378 
X-CRM114-Status: GOOD (  17.85  )
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

On Mon, Apr 18, 2022 at 11:30:33PM +0000, Alan Adamson wrote:
> I ran into an issue with blktests and my qemu setup when passthru is enabled.  The passthru tests
> do not complete.  This was because the UUID for the passthru device is coming from the a device
> from the same system since the fabric was setup as a loop and nvme_global_check_duplicate_ids() fails.
> 
> This is probably not a valid real life configuration, but since blktests try to test fabrics on a single
> system, we have this issue.
> 
> I’ve hacked together a fix to manipulate Namespace Identifier’s to get the test to work.  Is there a
> why for blktests to hardcode the IDs for the passthru devices?

Hmm.  I suspect the best thing would be to optionally just clear the
IDS entirely.  Optionally as in maybe a fabrics connect argument,
with it defaulting to true only for loop as that is per definition
local.

