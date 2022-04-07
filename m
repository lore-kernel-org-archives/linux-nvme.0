Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485BEC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8vBiaatvjWUPQUZwZ3kEHQ7w5o2lf7XfdfkkXFjtatM=; b=zK7q2egV7sSB1exs5uZcov8Ukm
	/w1PZKWW+U2c6yNj5JVwfKYwvoe/k8l71iO6+hX7Mn5VjgiyQziVALNHLhazSK1zySfuNixnJnsCd
	X9G+AetXarEh+n8hrbQwBmAGm37zNrGfV30Z/d+vkB/RFjr73mK8wP+ZA04FskpVL+2yPn/tLtRsm
	SQF3lwiXTf+x++cy3oeWfNktvqbNqnAmiItRstVZM5PSl44iRPEnjcB84KQLOD+egn8kZuFDJWUWd
	xJY/Q/UgCAS8pznhgs+rbyx8f5VkBf7ead5JzDOtfnsWFIno+H1Qu0zOL0LdRM5cHXGbpudn0KAek
	RjFrDUYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncUcI-00CvGr-Qz; Thu, 07 Apr 2022 16:04:14 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUCy-00CkdZ-7X
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 15:38:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5387168BEB; Thu,  7 Apr 2022 17:38:00 +0200 (CEST)
Date: Thu, 7 Apr 2022 17:38:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the
 discovery log page
Message-ID: <20220407153800.GA15988@lst.de>
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-4-hare@suse.de>
 <81dd2585-3c71-370f-70da-302072f3e9af@grimberg.me>
 <f28bed4d-a5a5-b1e4-020e-c76ded479c5b@suse.de>
 <f7f1e537-ed14-5ed9-4274-ab60f18dce60@grimberg.me>
 <e5225486-6fd9-2bdf-3aa5-540e7e3fa429@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5225486-6fd9-2bdf-3aa5-540e7e3fa429@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_083804_446364_BA9CAB4A 
X-CRM114-Status: GOOD (  11.28  )
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

On Thu, Apr 07, 2022 at 04:51:28PM +0200, Hannes Reinecke wrote:
> Not all connected ports. All ports which have the _same_ discovery 
> subsystem configured.

That makes a lot more sense.  Please add that information (maybe
including the ASCII art) to the commit log for the next version.

