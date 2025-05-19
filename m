Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11846C3DA6D
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 07:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/ieNuF8Z4XSME9K3vHVBBaMpcCqftaAlfAn0AR3d5M=; b=ZDz3YiB3w7++ERvdu5sTRieEa+
	xunsqC/ty0KkCECjTdy3twl4xvqTgYHsNSyZ5dFX0yyaM39OZ/9C7dTenYDrpcNlGKll+ow/RfKlB
	Ne7MpoGx/JbphHMJWQapnUQUoJ7l63sgiVBoNKpND7I99poEkKBB8FTJJtwG++yAnlLKy2A3wzp6b
	Y1aB7PKI4bTstAAQH0LPqxk7JaCUO9Q4a+iMpb0BVDhNSO0alW2R2gSvsXQOXHC7ZfGdqYxKUT7LQ
	GbvwdsVJjG5+xxS/rG25b3dbzTC/CArkPu7AlKWN7tp8XOJevDjrHgcW5NQM2CAQahmRYscYXJIwJ
	k2nyJvnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGuq8-00000008Dam-07GN;
	Mon, 19 May 2025 07:23:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGuq6-00000008DaM-0Wvn
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 07:23:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 115CE68B05; Mon, 19 May 2025 09:23:04 +0200 (CEST)
Date: Mon, 19 May 2025 09:23:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: derive and better document max segments
 limits
Message-ID: <20250519072303.GB9120@lst.de>
References: <20250516072152.166131-1-hch@lst.de> <aCdXBS6wrnXDQKca@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCdXBS6wrnXDQKca@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_002310_303011_6BF9738A 
X-CRM114-Status: GOOD (  12.33  )
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

On Fri, May 16, 2025 at 09:17:26AM -0600, Keith Busch wrote:
> If your page size is >=8k, this should change the value of NVME_MAX_SEGS
> to 256. I don't think that's a bad thing, but the commit message doesn't
> reflect that.

Indeed.  I've update the commit log and pushed the changes to nvme-6.16.


