Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6F4C27C54
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 13:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T0pXIfa3ELiqj1PX10MhaXn5eMdxq4r2GX65pdA4Xkg=; b=B4h3I+jtiu6UMohalwmX6epP7F
	uQyJEiTOsVWVT0vvdkFQbJMCIt3oG+6k9EuWnZsNUvVuK/HI7EqF2IXb+162iKgAuty0r+BnF0djH
	YxnbR7GvNBYZRjFbvjrSC6wHYgESJlZRUWBx6f7Wmkx5X334xHEecaXsvCT0GER2SP1kvP/hcbSTw
	7AmwR4XBkW96Vd7tlDpAoU0A/X99BXOCXjr2EJLstMbsa9nYEPZpKQXuSxlQjYGUDOXtCNQlm1B0Y
	I1t84gR3n37mjctQUVuKp0EZrtv5hTFp7t1Jupn5jfw7K61A4dNexC05cPJfcNp5oKiKaz+af2aLS
	ukq7H/8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFCrI-00000009nbe-35wI;
	Thu, 06 Jun 2024 13:08:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFCrE-00000009naW-22jV
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jun 2024 13:08:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 77ABA68D08; Thu,  6 Jun 2024 15:08:32 +0200 (CEST)
Date: Thu, 6 Jun 2024 15:08:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ofir Gal <ofir.gal@volumez.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	davem@davemloft.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org, dhowells@redhat.com,
	edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org,
	axboe@kernel.dk, philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
	idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 1/4] net: introduce helper sendpages_ok()
Message-ID: <20240606130832.GA5925@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com> <20240530142417.146696-2-ofir.gal@volumez.com> <8d0c198f-9c15-4a8f-957a-2e4aecddd2e5@grimberg.me> <23821101-adf0-4e38-a894-fb05a19cb9c3@volumez.com> <86e60615-9286-4c9c-bffc-72304bd3cc1f@grimberg.me> <20240604042738.GA28853@lst.de> <62c2b8cd-ce6a-4e13-a58c-a6b30a0dcf17@grimberg.me> <ef7ea4a8-c0e4-4fd9-9abb-42ae95090fc8@grimberg.me> <b13305d7-35c8-432e-bea1-616410a9da15@volumez.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b13305d7-35c8-432e-bea1-616410a9da15@volumez.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240606_060844_715285_417558A8 
X-CRM114-Status: GOOD (  11.62  )
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

On Thu, Jun 06, 2024 at 03:57:25PM +0300, Ofir Gal wrote:
> The slab pages aren't allocated by the md-bitmap, they are pages that
> happens to be after the allocated pages. I'm applying a patch to the md
> subsystem asap.

Similar cases could happen by other means as well.  E.g. if you write
to the last blocks in an XFS allocation group while also writing something
to superblock copy at the beginnig of the next one and the two writes get
merged.  Probably not easy to reproduce but entirely possible.  Just as
as lot of other scenarious could happen due to merges.


