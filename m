Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F38C3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 14:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oq2/OA2leiujwk/EdsDxnaxkuMb8SCtuFQKu1MKbG9M=; b=igXtaPZm/okmd+FdPR6PQZSxrE
	POwZBMYI9nLq4Ryv0RsDfwrFZOWNDOoIELFGz2fo4jJME+nbZDg9Dz42V0Z5MLQCDG51GoiFHJISw
	GEVwhUZeb6McQm7o5fJ9bphOAPaTGc2w0XtDf6EZ5LDzzXDFExNTFQhBP2C/YPvWAGSH9Omclmzw0
	SU7kBofw0S6nPnvHOHVCOEC9WrLEY5ddHFIzCBADtneWyKCg6sUer3pVguFgpVf7tLvoI8We+7+36
	mVqkSJ5kPz2JCjn5OrGkhiVYuKALQfq+0AwkOW2VVg4KeBtM6HyYV0iHq1ePiD/UndTJK6GE1QWpR
	Yo4Reibw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzAi-00000001CZX-1VtM;
	Thu, 25 Jul 2024 14:10:20 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWzAh-00000001CZ8-0ux6;
	Thu, 25 Jul 2024 14:10:19 +0000
Date: Thu, 25 Jul 2024 07:10:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Wang Yugui <wangyugui@e16-tech.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC v2] nvme: basic RMEDIA support for host
Message-ID: <ZqJcyw9haCcDvK1r@infradead.org>
References: <20240723232419.19753-1-wangyugui@e16-tech.com>
 <20240724123052.49185-1-wangyugui@e16-tech.com>
 <6bb781f7-1895-4c8e-8501-dc21732c5e37@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bb781f7-1895-4c8e-8501-dc21732c5e37@kernel.org>
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

On Thu, Jul 25, 2024 at 09:43:45AM +0900, Damien Le Moal wrote:
> Why not do that now in another patch, at least for the loop target ?
> Given that they are not that many NVMe-HDD out there, that would be
> nice to have to test this.

The code would be in the bdev backend, so it applies to all transport
equally.  And yes, I'd love to see a patch for that to, but I don't
want to gate a simple flag check on it.


