Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC64D5E141
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 07:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cchLRetcQjGWprOKqXnNZ5uQDfopDM/m3FzGi8I9UrU=; b=YESSVN/8sOZPmK91DRqUeth++e
	TCs9qguWcQdkonogFaBF6nGOXyLXPeaJgv/8nifcI1yN67NEPbuw5XnxCWBmSNay3iuCEr6qso+lh
	eCIiaO80ljwC+y+dLZAtFZ/5SCbyUy3E9rZyl/wIiNVYafrquFRMCCZV0ZJUqF1srg9WxIZvb/KVR
	kQ79s6aFO+NpBlXIUasDbjRwi6Q2a/uMsL7yNXQdDkxQYKQ06++JBuPLJESeELNNvQXTclUoxhS5p
	TtKSdA64d03v9OOiu4PsaihdLr5c8oC/PLY7etQf0ZgW5bGhJYv6WXKw3TjDnhR8fp+qPcHKeFYzy
	UUdqiFkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9J6Z-00000009a9o-0j10;
	Fri, 08 Nov 2024 07:08:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9J6R-00000009a8G-44RX
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 07:08:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D2CC68AFE; Fri,  8 Nov 2024 08:08:07 +0100 (CET)
Date: Fri, 8 Nov 2024 08:08:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Bob Beckett <bob.beckett@collabora.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	kernel@collabora.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte dma pool segment quirk
Message-ID: <20241108070806.GA9216@lst.de>
References: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com> <20241107165131.3462171-1-bob.beckett@collabora.com> <Zyz2oiQ2pco15HHT@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyz2oiQ2pco15HHT@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_230820_174348_619996F5 
X-CRM114-Status: GOOD (  12.35  )
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

On Thu, Nov 07, 2024 at 10:19:30AM -0700, Keith Busch wrote:
> We have a constant expression currently, and this is changing it a full
> division in the IO path. :(

Yeah.  Given that the device is broken I'd just have it pay the price
and never use the small prp pool instead, which just adds a single
extra branch to the fast path.

