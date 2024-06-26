Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C083DC30658
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKtI+y2Q67v+J6B8eigkRZZhyEdOkyPaBxiQu2onFgw=; b=NNFy3HN1L/5X/NLYs6ZpfxNDEx
	kh9p32S4Pv+n3vfsvuVTJkQQ1vf8MOJHalSHadPXIjxg4K9IK05REST+/GkJzT9cI4hxr3SQYzqL2
	b6ncTg9q21eZiIbR5fu0IlMRdBgr6QA08bj6W5TB4J5+0Y/RlUlPXMn+yGo7w12YJZ5Z6zSGgH0qR
	mPXLtAP75+h2ghURxkEvuJda4CekLcUkvFQz0/hLK5MOuP9ABzlo0d2cak9Pr8PdJ1SHqqyamBXSx
	t05NcTFb3JL4unfdWOTt62w8nWrN8kiKWPyEMWuqutiM9471Soi8D9XJtBbYVBMmx79gSDVE5JrdB
	GnWcBpYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYmW-000000088Gy-31sc;
	Wed, 26 Jun 2024 19:58:16 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMYmU-000000088GF-0l2o
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 19:58:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C12FDCE2C7E;
	Wed, 26 Jun 2024 19:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E954BC116B1;
	Wed, 26 Jun 2024 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719431891;
	bh=uA79vWCUyRgJech9KT2AJEAWRSx6HJIuO/RUTPWht9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e02XvyJequFk3LPbd7xtl6Nlx2Eg/Tc2KkpkeqOcB/DM9yrbmkcAJnI7/Q7xC4Egb
	 Fq2MWjqeO7fgFtk/sWmaxYg8y6OQw5G51ZYYB38bke98sfPPenQa9ni58z5jwYIllw
	 SPb+idVTNBv4VVqx+YtmMUUlE2xphx2xIEbFzReMkqVGSrBvzXySMO/c8SysD2KItm
	 rZAp5gbb2pOa4Ej27fTmJwmK/csDrdYeGFvROTlZzl1vDK61OttYyg8YgWaWS9H0hW
	 AGbLd47cq3KxR899pu1cEqDlCj+up2ChEqti/g4EMSP+h6neVfW00Vk7zJbhUgd54n
	 iAYCSva84eEdg==
Date: Wed, 26 Jun 2024 13:58:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 0/4] shut down devices asynchronously
Message-ID: <ZnxyzyPIHlgH8eyQ@kbusch-mbp.dhcp.thefacebook.com>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_125814_424449_FE5E1EF1 
X-CRM114-Status: GOOD (  12.07  )
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

On Wed, Jun 26, 2024 at 02:46:46PM -0500, Stuart Hayes wrote:
> This adds the ability for the kernel to shutdown devices asynchronously.
> 
> Only devices with drivers that enable it are shut down asynchronously,
> and this driver setting can be changed in sysfs.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

Looks good to me. For the series:

Reviewed-by: Keith Busch <kbusch@kernel.org>

Thanks!

