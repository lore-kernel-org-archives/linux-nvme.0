Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5561FC3ABD4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OyrrI5kNfjLOB0GOmtoIrdX0KX6rKa+qKOZx+H3nFE=; b=KZAP1v83Dmy64BOz9fFzma3VlD
	WSX3UqQ5Ckp3T51HzvxGBYX/SdgDyiko+K2YrvvEF1tOwIsHjUuT4Z11rKZIcN6UsfG+GCL63ohPW
	gslYEL0txpAhfKLHajiR6sTDOMXb5y50Qce9h/EXTzHLybZAd2OhryDugg1nWbCKXjg3donQBGp/T
	T0PvIs6EuO2c/XBLuPbnfAGgYaiYifnx9xUQwfnUvVOGM32hQ98fUvy9OERRBfqJO8Gx3bWeFns9D
	6Nq64fIHFg1EMSq5ZkqyAywscHHFOd4et1GVNZ7966x/2e/geOK6ZXOoDuvhyxF4iF2LtJ32LaH+2
	OMnjnfIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEUGc-00000009kii-4BDi;
	Mon, 12 May 2025 14:36:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uETvs-00000009giR-48Sj
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 14:15:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EC92268B05; Mon, 12 May 2025 16:14:56 +0200 (CEST)
Date: Mon, 12 May 2025 16:14:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] nvme/pci: PRP list DMA pool partitioning
Message-ID: <20250512141456.GA3822@lst.de>
References: <20250426020636.34355-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426020636.34355-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_071505_166530_48B67059 
X-CRM114-Status: UNSURE (   9.91  )
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

As it's been impossible to get any MM feedback even with multiple pings,
so I've tentatively queued it up in nvme-6.16.  If anyone in MM land
doesn't like this please scream now and I'll drop it ASAP.


