Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8462EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Apr 2022 05:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gNB3twhJwUWxv/EBpnLgD8F0B+nmshRI3oJQyXxFwws=; b=lR8JrPRdYr/uyjx++O1fnaySGW
	hhV/pGgjf4+dOqTw3tXTd6E0LQ/5TYYBdxjAYspLjJvi50NFm6VEuQ1kWVP2BvZPsdaDhiXgEy634
	U4xHIIwrrnh6u/s6ff7HYScTMFrlFeytn42UyXYbHQFUYSFKbxOVB++XLPIMQ19JX+RKmzEapLelF
	9/wUMfi4h6gKnX1b6g0iAK8FGA8t+p29AC4Qa5rCQxfXtdJYhX7FCIqTXqEuVJnftvK/oQfKzsTWF
	Z7oGu82S/j3nK9AhGkXtr0HdJD8oW04iiI8NEFpAsTaN02iogqrYCaL3vDk8JrfdLMmZp+QA85yI6
	TTRMG02g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbc14-00HC5U-1e; Tue, 05 Apr 2022 05:46:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbc0y-00HC3U-Gv
 for linux-nvme@lists.infradead.org; Tue, 05 Apr 2022 05:46:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AEA4D68AFE; Tue,  5 Apr 2022 07:46:01 +0200 (CEST)
Date: Tue, 5 Apr 2022 07:46:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in discovery
 log page for unique discover controller
Message-ID: <20220405054601.GC23466@lst.de>
References: <20220317142634.49324-1-hare@suse.de>
 <20220317142634.49324-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317142634.49324-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_224604_745341_E598867E 
X-CRM114-Status: GOOD (  10.35  )
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

On Thu, Mar 17, 2022 at 03:26:34PM +0100, Hannes Reinecke wrote:
> When an unique discovery controller is configured we should be reporting
> all configured ports, and not just those which are reachable from the
> current port.

Why?

