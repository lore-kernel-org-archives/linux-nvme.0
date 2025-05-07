Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A4AC3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 08:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Aie/5cJM7Kji27BjuCeP5/UnbSqKuXco2iiQZ4M0e80=; b=z0sElS2864/7axBmBD5M5CnDHG
	KHP7M5XEVkhMvJ4fl92kbpNwdTh9ewnZe2mK1bpwrRrWoPfI3I5pw5C00pqSDtyc+q/QyzBBnfU55
	WebkTInxG9vAJHnhQJOMUXVCLW/tV4vGRH95XupIy2xL/f7u5tW/1k7aOTKL5OHAGB0FcfY8dNSL1
	mGYcdTwbxP9gU7lKCOw7LBdKHM+wk6oPAlWilHWgSxlqXOuRTMvbnWjh5HcokTgO5GaCDKq+C8r98
	pl1psL8YyZQbK0oUCG9tPVGESuScHaJ5Hn9EaA9xkG+kYFKj6EX1+bQlN+q6W8dm9O5qtgKwbd9Zv
	45YGWZsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCZuy-0000000EgTf-2TwL;
	Wed, 07 May 2025 08:14:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCYzr-0000000ETt2-2zpM
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 07:15:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95D4668BFE; Wed,  7 May 2025 09:15:09 +0200 (CEST)
Date: Wed, 7 May 2025 09:15:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: mm review needed, was: Re: [PATCH v6 1/3] dmapool: add NUMA
 affinity support
Message-ID: <20250507071509.GA1413@lst.de>
References: <20250426020636.34355-1-csander@purestorage.com> <20250426020636.34355-2-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426020636.34355-2-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_001515_890883_3F9027EC 
X-CRM114-Status: UNSURE (   9.25  )
X-CRM114-Notice: Please train this message.
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

Can I get a mm review for this and an ACK to pick it up through the
nvme tree?  I'll also fix up the minor coding style issues.


