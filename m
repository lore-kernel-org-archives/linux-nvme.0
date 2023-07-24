Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40365C0015E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UPCuEaZ5jF65P2p6idU27DWskeRdcXWilJjClNsVdBA=; b=s7tAqzfKPniepC4z5W8kps0vBC
	yXdllCVaywVMIco6AodZ6Zw1vjpY35E1IgTgsUcVvzjm9UwnvO6ooq5/iJS+l03qtMKzzPWPR8XGO
	l8AU7tQwIWUWjf8pM4tf39yFFf5MKPgF1LnKvUpCUvPa1+xhlaGbpnCTPIDjEbftD7BVNhV0EFw25
	2SbxFPUOSMiBEBKrV/rdhW/g329QbQMdFKW9VvYse+jhxg96aHD9CML0afOCydLLLpfrOY0Ocpf6b
	SoVHyiYjh5+KjzAa7Q2YhaYKafQVNwzPkfSH1rYc4K+sfNvp43HORNMUjDU09Vi2iMeRBi0SyFq7c
	5n8l5TVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNymu-004vTI-1q;
	Mon, 24 Jul 2023 16:52:00 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qNyms-004vSl-1x;
	Mon, 24 Jul 2023 16:51:58 +0000
Date: Mon, 24 Jul 2023 09:51:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: drop multipath config option
Message-ID: <ZL6sLk3gCbm5UcXq@infradead.org>
References: <20230719084147.16272-1-dwagner@suse.de>
 <20230719084147.16272-2-dwagner@suse.de>
 <ZLe1QmfGg488wH9D@kbusch-mbp.dhcp.thefacebook.com>
 <egbrvnkgv7dpbcqudnvp5xzj75ng6qh3fe7exedwmmffixibex@cdr4jraimzgk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <egbrvnkgv7dpbcqudnvp5xzj75ng6qh3fe7exedwmmffixibex@cdr4jraimzgk>
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

On Wed, Jul 19, 2023 at 01:13:18PM +0200, Daniel Wagner wrote:
> On Wed, Jul 19, 2023 at 12:04:50PM +0200, Keith Busch wrote:
> > From my reading of this message, I thought the intention was that this
> > driver will eventually replace it with a:
> > 
> >   			goto out_put_ns_head;
> 
> This would obviously make the PowerPath module unhappy. Sure, I am aware of our
> upstream policy so I wont argue.

So what?  non-upstream stuff simply does not matter.


