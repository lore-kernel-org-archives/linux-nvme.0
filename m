Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C2EC4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RYf8+tqeX3IUwBxD0UySznuzapx40R7CguL98JU9as=; b=TL+mi14WtUEZs+omik5uYh2z29
	HctTzE9NCdi2xMUqOQrC4aShLZX+oAs/Qdz/F7vnyqSW08pH4MBifXFFjZchmjB3ATGgD8QVLFiHw
	1OuQnGkwEub/QIQJj/oVbLkpcszZwgH7Ui3EaZ/J497Hew1wcQq11TJRVvDNIlfrEL4ic5dqjjqHK
	sv52mI9lVYPy7HGUYwAAg+JyeRkEazgx1HnatVVSO4QMC+1jYXil/hB/2P74Lto2UzTMUCB/uhKJ/
	+NqCGdNbbKOtrRqfuWrfBCvs14tjwnN7eO/jkk8jfC/v5yJ2qqlIZc7X+DGTj09iSpFv1cz9ly97U
	eojCwhxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAo8q-009XuA-1R;
	Wed, 06 Dec 2023 09:24:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAo8o-009Xt9-0b
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 09:24:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B04CF227AA8; Wed,  6 Dec 2023 10:24:20 +0100 (CET)
Date: Wed, 6 Dec 2023 10:24:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Kingston drives
Message-ID: <20231206092420.GA27348@lst.de>
References: <20230920085210.22573-1-wse@tuxedocomputers.com> <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12d32e8e-e20b-4023-8299-39d2a69c0cd9@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_012426_364107_EEB14DAA 
X-CRM114-Status: GOOD (  10.31  )
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

What does save a lot of power mean, and why does it only apply to
some platforms?  I suspect the more likely case is that APST is
simply completely broken on this device?


