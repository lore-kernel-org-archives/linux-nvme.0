Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39074C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oVOJrZAYpy0C7qBgdH064DbcZxOL4mbJ6RxgTcad2l4=; b=e//zrzzjh1wfsRJCM/QDMAW7Xo
	BmYEWUX6XFSD9vqGqH1X80oggIPrPdQ6YMN0VokysNVSKJWdho0MU4TJatH03fYnPJ4knIeRadpga
	qPdk+E9hOlmCmlc6LOy2pAJj6d5lEtEuvRL2rlbXvuqbb2+w5mKpq9cLl9whAamgtngm4P4brX8Nw
	ry8bx7HFVnfQ1rhqDYA7IkLX9mIQbzmPxTJKSKPC2K5LRK3SbgrtwX5BAAnijep52DK81OWiTcz+E
	Eoyg7a3k5avorLTCnhG43/c6TrbghQ0A/nh6pJzlG9RA5YcxTvhcEjmYQdupbP/Q7XW1LeUhf5vDq
	ChszNDeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSE11-00Bs6n-7x; Thu, 10 Mar 2022 08:19:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSE0y-00Bs5Z-KS
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 08:19:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BE3BB68BFE; Thu, 10 Mar 2022 09:19:08 +0100 (CET)
Date: Thu, 10 Mar 2022 09:19:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mingbao Sun <sunmingbao@tom.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: Re: [PATCH v2 2/2] nvme-tcp: support specifying the congestion-control
Message-ID: <20220310081908.GA26477@lst.de>
References: <20220308151606.2563-1-sunmingbao@tom.com>
 <20220309061442.GA31316@lst.de> <20220309153136.000048e1@tom.com>
 <20220309212852.00007828@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220309212852.00007828@tom.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_001916_837663_6C7AFDFB 
X-CRM114-Status: GOOD (  15.62  )
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

On Wed, Mar 09, 2022 at 09:41:59PM +0800, Mingbao Sun wrote:
> So I tried with 'tcp_set_congestion_control'.
> But then I found this symbol is not exported yet.
> Then I applied ‘EXPORT_SYMBOL_GPL(tcp_set_congestion_control);’
> in my local source, and it works well in the testing.
> 
> Then what should I do with this?

Add the export in a separate, clearly documented, patch, and Cc the
netdev list and maintainers to get their opinion on all list.

