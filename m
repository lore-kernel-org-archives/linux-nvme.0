Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58102C83F03
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HYwDaNASAhtNoJJtwuQQ8aeZIhiBnzY3MWXWmPtmkfE=; b=k/4Y1iOhTtUd7TvOeZQuztle5Q
	w0uzBlvB3Kv8PNPVZ9BQvOD8S3edpUFi5UCclxnG6posVSK4OOuaY3ZtAta1XivVgCOz9eBMNm3I2
	4LUrcZU0GeIJksj4k8eK+2fUSLM9zUK8qpJoxVXeXfJoCpUBhwrHrHiyCC0RgLjkxuAdx2FWTS9+v
	Yn7PKYTPjUkp1opvIpEN4qfwnQHGME2nyO4P2naYyBLZl2SOxcUZ2eGvBjDOwZsIVeL4sK2mraaf6
	4t/f8HMWJYmxnlQPcXoao1prQNeuykjycQ376Ho15jy5Gnx9n0RdQnrZ2AoK9yMcnOeAYi4sMKR/l
	7ZFUqXKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJRM-0000000BOnH-0mw5;
	Thu, 03 Jul 2025 12:53:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXIO8-0000000BCfr-3ixH
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 11:46:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8D7B667373; Thu,  3 Jul 2025 13:45:57 +0200 (CEST)
Date: Thu, 3 Jul 2025 13:45:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk
Message-ID: <20250703114557.GD17686@lst.de>
References: <20250701205630.64031-1-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701205630.64031-1-wse@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_044601_063450_EB607CD6 
X-CRM114-Status: GOOD (  13.63  )
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

On Tue, Jul 01, 2025 at 10:55:49PM +0200, Werner Sembach wrote:
> From: Georg Gottleuber <ggo@tuxedocomputers.com>
> 
> On the TUXEDO InfinityBook S Gen8, a Samsung 990 Evo NVMe leads to
> a high power consumption in s2idle sleep (3.5 watts).
> 
> This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
> a lower power consumption, typically around 1 watts.

Why do we keep getting more and more of these quirks instead of
getting the issue root caused and fixed?


