Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02889CD5828
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Q1OaeuH+0alqvDMjc+PFhK90uoK87BRJOuP1WxGkq0=; b=EGMRLpuL+/EKNqDemMHzZA2Sbo
	ZR1F9Y4qSaQogoNnEFZO922BVwGOM1GbZIn2YcBiVCwSDmic2AHaXCtXCt1pk+26hSqQHK6eRcGDP
	1FOEvnq/haOe66cWOmmauZtUUDpwwtyRnqUpbvLIKp7DSqI15HhbhVZm3WSOlYnzea2B88vBvv4bO
	mnNhKINJP4UNVceJ1AimLZ/lpbzct49Yi35QFPV3Did2Hgk7V9Dclb9AYr/oiaGqb3JFH5xLy4YQl
	tSmAOH7j5PKNKuWBtRtY5qLkQ5IdcusIBs14vyiDGfpcDRKxI9/kcI3fXrtEiOj6RjJK1SNYO0RdN
	5xVPNa+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQTp-0000000Eedr-24yc;
	Wed, 07 Jan 2026 10:09:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdQTm-0000000Eed0-224K
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 10:09:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BF6616732A; Wed,  7 Jan 2026 11:09:20 +0100 (CET)
Date: Wed, 7 Jan 2026 11:09:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] nvme/host: fixup some typos
Message-ID: <20260107100920.GA26943@lst.de>
References: <20260105040829.732046-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105040829.732046-2-wilfred.opensource@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_020926_665537_4721FF9C 
X-CRM114-Status: GOOD (  14.21  )
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

Bit: the subject prefix is we usually use is just "nvme: ".

>  	/*
>  	 * Handle ioctls that apply to the controller instead of the namespace
> -	 * separately and drop the ns SRCU reference early.  This avoids a
> +	 * separately and drop the ns SRCU reference early. This avoids a

I don't see a typo here, just a reformatting to a different comment
style not very commonly used in the nvme code.

> -/* Define the socket priority to use for connections were it is desirable
> +/* Define the socket priority to use for connections where it is desirable

The change looks good, but if you touch this, you might as well fix up
the comment style to match the normal kernel style:

/*
 * Define the socket priority to use for connections where it is desirable


