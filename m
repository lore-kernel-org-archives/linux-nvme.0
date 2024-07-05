Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DD2C3814E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 07:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w40R9PRvTa5t8bpf4mgimTEK+M64SuPcuHYzkz5oSW0=; b=gHcJblfDmekAPwQ1i41vT04ZDn
	qkJiGPaNcdPt9J5ThLEC/IV3Thdg9EJgp+VNZlVPJxLWlk53eoFm/6AKtNnj2dF0flhnFWJMi/9NH
	8HQriUL98dG0//zkSWA9bv4u4Ip2ezfDLYwXlP3dAF094R+8ke+K+UV1BgJ3YK5aeLgAXLKPwUNWm
	/HorfLlfHVjUgPdGGf1aSTJ0X2c0gdBirDNMhupJnEOnktzNv0LscjrQ8zsey74SegMpnjyQvLMSI
	197UkxtN/MeUx6DaS2x7Rbt7eXp+gbMYvuZ3Pl+2ccEx/xqKL6n9rWEh5OtmeG1Xx9+okG8EtYpGg
	zzAZMfAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPd5V-0000000F7EC-0JvF;
	Fri, 05 Jul 2024 07:10:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPd5R-0000000F7Ds-3WVb
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 07:10:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47F9268B05; Fri,  5 Jul 2024 09:10:23 +0200 (CEST)
Date: Fri, 5 Jul 2024 09:10:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Tejun Heo <tj@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvme-tcp: per-controller I/O workqueues
Message-ID: <20240705071022.GA13302@lst.de>
References: <20240703135021.34143-1-hare@kernel.org> <20240703135021.34143-2-hare@kernel.org> <7e4444d0-f156-439e-9363-4beb86bb6248@grimberg.me> <c9f73300-9860-4965-88af-9a7b4d7b0e1b@suse.de> <ad15b94b-9414-4ec1-9acf-465a8b190fe5@grimberg.me> <ZoWFOnvgWEiKipW6@slm.duckdns.org> <aaa404b1-72ac-4b15-8c30-a62ef2216004@grimberg.me> <ZoWjxtyjHTC2r285@slm.duckdns.org> <9de5d83c-4b05-4f69-8ab4-b4aa65e5ec62@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de5d83c-4b05-4f69-8ab4-b4aa65e5ec62@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_001030_044616_3E75DF82 
X-CRM114-Status: GOOD (  10.29  )
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

Btw, I don't think brd is what we should optimize for.  brd does
synchronous I/O from ->submit_bio which makes it very non-typical.
Trying to get this as good as possible for QD=1 might be fine,
but once we have deeper queue depth and/or bigger I/O size it will
use a lot more time in the submission context (aka the workqueues here)
than a real device.


