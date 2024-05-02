Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297ECC4345F
	for <linux-nvme@archiver.kernel.org>; Thu,  2 May 2024 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PTuuhBYy/fS//1rkY80Nj3qXhG
	Y4ZMC+czvbK/G23V/eOejyTLIIz0sSN76l9vmIj3mzNQM9U64eNAWI7qzfTVM96oQgH1dJFrZLXJz
	1blzsGHmKEgOShnkzFYZulRx9N05UkUEX0KGqQJ3PXNf0sqwEMcP9E67P5qDijdERGZx6oL/6VeNj
	cVUPy3lvk3PALU20QmPvxZykYfg0GfWCBHwaBKUvWHRbWqpjULFE03UqLY6pufsfVuPNq5oK1Kw68
	Jzu7+VL5FmF6GIWe/28rUz5yp5Rb3AgnFmwoyoZ/p6W4vE+lJ2ErMGq98nACIF+q7PsdgWvbItck7
	yDdxiRqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2QcU-0000000Blep-3Q1c;
	Thu, 02 May 2024 07:12:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2QcR-0000000Bldd-1dLA
	for linux-nvme@lists.infradead.org;
	Thu, 02 May 2024 07:12:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A216227A87; Thu,  2 May 2024 09:12:36 +0200 (CEST)
Date: Thu, 2 May 2024 09:12:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme: remove sgs and sws
Message-ID: <20240502071235.GB31379@lst.de>
References: <20240502063438.422046-1-joshi.k@samsung.com> <CGME20240502064150epcas5p3b6461ca0466650cd0296089d257ff861@epcas5p3.samsung.com> <20240502063438.422046-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502063438.422046-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_001239_587724_26FE1BF4 
X-CRM114-Status: UNSURE (   9.22  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

