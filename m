Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB6C3ABC6
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gyT6JM1jxj/JZWTjLXED0iojnYMKuKvfJ1n7w1zYYwM=; b=SweE07nQbbkREaA/ZmGpU6NzVv
	hU9zrUWJjpKxC16Fco/mcdwCOhsNMheI+xWbDD3mVp/XmS5wDHSWdjoG8fXlmTDm71baZ2RWH0F33
	DBjrFi8bADC4L/XK7SuSEuDIuBZThQXC2Vc99tTY4Y5b4+B+RIrI6E/vUmh+V/s0JiEUcQPtgNKRP
	5SHzuZoFodRCcNWEZ2QN2YvCBXV09eyStmsah+DKkLHk0zgrxk90CSYdorn8mku+c/PWZQJ/1joA0
	XlJlsJ/xUv8uuXteN4rSYPdM2pCp4VdGxDoAOCg3NkU7xQJSZBvCmzELq/qL10h8WGGs9k7UivRGf
	yYtZan8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCa0l-0000000Ei7w-1x5M;
	Wed, 07 May 2025 08:20:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZ8r-0000000EVwZ-0UFO
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:24:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D607268B05; Wed,  7 May 2025 09:24:29 +0200 (CEST)
Date: Wed, 7 May 2025 09:24:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/12] nvme-auth: modify nvme_auth_transform_key() to
 return status
Message-ID: <20250507072429.GA2347@lst.de>
References: <20250425094927.102656-1-hare@kernel.org> <20250425094927.102656-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425094927.102656-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_002433_304947_E361F26D 
X-CRM114-Status: GOOD (  12.32  )
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

On Fri, Apr 25, 2025 at 11:49:16AM +0200, Hannes Reinecke wrote:
> Modify nvme_auth_transform_key() to return a status and provide
> the transformed data as argument on the command line as raw data.

Well, it's pretty obvious that you do this from the code changes.

But why do you change it?


