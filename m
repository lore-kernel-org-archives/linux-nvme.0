Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0EBC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 08:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5mgtYMFr+krTPOonno8ucwV6vF6C+vjaXqtlXSMy40=; b=p7jNcMzsHLfUJ85r+Y7uoyRr+x
	8dFJ25lA/XM54eN6MPpofcUhd6sDWqX8JzTNR2vS6+6Ti4HA/vjR4IMTvp/IlUiNc8eemCQFe5AHI
	0NpbF9JzyfNvY/7hcQ1+fl6/2SSVE1rqyCDStlUfpOWCL9F7NUuCiClKY7ABc+5NcppGDvcTEvFmX
	I/APCPgedFNW5RsL/Qt5O8HAUWwMCqJ8wH2jv7CeSP/jGysErqm0VE4WqTMVfyEmgvUhYeOYvn2Nt
	EQKQBMqbhW6HIAJ0kEMRdmDzUv2nlv9ArMOZ0rbG8r4tjTPildvxdw4/WbYF2uVjB9p94h4PcVD18
	xaWrISdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEoAe-00BSCw-IO; Tue, 01 Feb 2022 08:05:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEoAb-00BSC1-GB
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 08:05:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2218068BEB; Tue,  1 Feb 2022 09:05:42 +0100 (CET)
Date: Tue, 1 Feb 2022 09:05:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH V2 2/2] nvmet: allow bdev in buffered_io mode
Message-ID: <20220201080541.GA29678@lst.de>
References: <20220128085148.11638-1-chaitanyak@nvidia.com>
 <20220128085148.11638-3-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128085148.11638-3-chaitanyak@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_000545_711657_FEBFF009 
X-CRM114-Status: GOOD (  10.99  )
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

On Fri, Jan 28, 2022 at 12:51:48AM -0800, Chaitanya Kulkarni wrote:
> +	if (ns->buffered_io)
> +		return -ENOTBLK;

Maybe add a comment here that we want to force a fallback to the file
backend for buffered I/O here as this check on it's own isn't totally
obvious.

Otherwise the series looks good to me.

