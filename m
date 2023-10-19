Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FF9CDB465
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8fttauXB0DWyyzh3FfOygTYe1PiF3DownFkL6fcO5U4=; b=xcXBp3jgtXGTK10VnIQDtWTUPg
	uKiUxV6EAKTZ7ozguwjt30e5tilKnr19LBS+EK3AzRUuwiP9d7dp20AXQn1UycUMMKnJ2E1X8ofVn
	U1P7iRciQAoxPIHyDGOlSPmxZ/LX73//+ygGuFm4sT5LpnuBw7yCdDJUWnPqOa6UCKDi+1oHUymzx
	1GCCkDx7dkM2TxaHXHxccN9ohJUBkBZ9XWXFLHTM/WqQuR9ZMqWCgVaazYMOKWgaECYWLwr8hfHW3
	YcN95W09Cj+LmZ0ml7u7HWu1kDwpGGBmTZcZHK8ZFIvoE+kvWIzLLdZAvKtIQyurlxPalJle9HMtt
	XV6NlarQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLCi-00GK3j-2j;
	Thu, 19 Oct 2023 05:04:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLCg-00GK2w-1d
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:04:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8758C67373; Thu, 19 Oct 2023 07:04:11 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:04:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, vincentfu@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove unprivileged passthrough support
Message-ID: <20231019050411.GA14044@lst.de>
References: <CGME20231016061151epcas5p1a0e18162b362ffbea754157e99f88995@epcas5p1.samsung.com> <20231016060519.231880-1-joshi.k@samsung.com> <ZS2D4VixIYfMQMwg@kbusch-mbp.dhcp.thefacebook.com> <ZTBNfDzxD3D8loMm@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTBNfDzxD3D8loMm@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_220414_709156_90707384 
X-CRM114-Status: GOOD (  11.36  )
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

On Wed, Oct 18, 2023 at 03:26:20PM -0600, Keith Busch wrote:
> On further consideration and some offline chats, I believe this large
> change is a bit too late for 6.6. I think this should wait for 6.7 (and
> stable), hopefully preserving non-root access in some sane capacity.
> It's backed out now, and current nvme-6.6 PR does not include this
> patch.

Umm, what are the offlist discussions?  We leave an exploitable hole
in, so I don't think waiting any longer is an option.

