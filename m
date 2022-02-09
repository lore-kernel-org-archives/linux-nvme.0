Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0555C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Feb 2022 14:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKBI1r2ZI3+lUmcRouurYYwxY0Ib6gevToqZh5vhP0Q=; b=v3mgVJe3bSJZsC21IReSYZBUd7
	C8mfMvZFFQTV/N0+6iH+ArLATAH3tWdQ5xCUhLD118p51YPRAyxMAecC/xvJBYQ3JZXhwl3ffDsnM
	xdhyFkdcNSpnu8Vh9h0hj3OvvamOin0R+0wAtJakscJ0RrI0h3eoyyEwT3wlIs9fNxI3pZ6ABxlXk
	g2w38nV1o7ar5zn7Y8+ubIpL48YLnjAXFc5yk4t7BawwcLJaroGqtBm0SXFjgcf9TNysH4U7PRdG/
	krEf/VT3jNJRdSeTJ8y6Knh6Dm9XglH8o/wWFNsoyI2krsrN6cog2TMs8r5pWiQT10svV/HOO0dwI
	ORZNbCGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHnYD-000HrF-T5; Wed, 09 Feb 2022 14:02:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHnTq-000Gjl-Td
 for linux-nvme@lists.infradead.org; Wed, 09 Feb 2022 13:58:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C80B67373; Wed,  9 Feb 2022 14:57:55 +0100 (CET)
Date: Wed, 9 Feb 2022 14:57:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
Message-ID: <20220209135755.GA20679@lst.de>
References: <20220207100005.34404-1-hare@suse.de>
 <20220209080747.GA9851@lst.de> <7bef474d-f6c4-0ecc-3a5b-44a310e2e026@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bef474d-f6c4-0ecc-3a5b-44a310e2e026@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_055759_142600_31256CE1 
X-CRM114-Status: GOOD (  14.17  )
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

On Wed, Feb 09, 2022 at 09:49:16AM +0100, Hannes Reinecke wrote:
> How so?
> I'm just reverting the check; instead of having the nsid listed in the ana 
> log page and check for a match between the nsids we now check for a match 
> between the group id in the ana log page and the ana grpid from the 
> 'identify namespace' output.
> So I'm still able to identify which namespace this change belongs to.

And how this this catching namespaces that move between ANA groups?

How does it deal with the hang fixed by Anton in commit af8fd0424713?

