Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE037C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=qJTfMyphCvOKD8bITUBqtU+Jrh
	m7YN4XsFeYfVJKEzOQli+hC7fLrOLIUToS3TiG9f8jycqO3rF9Sfv39vo+g69OFsO3pcIGhzEENpD
	ZDvTWEm3f3hBPTTCRcjw6eRCf2FDkU+jrExpcXg7xDMf6paS3AwJkYHx+Q2Xb05ogXQ1bVcu15HBb
	U+ipWeviOwb7ZtpzQ9uyRNgthrrLaxHMdbYQkQAOeJ17D1W6+c7gSh0vfG0BFBwsev2Tw2L7aRILq
	jXAsl/dfL/Cv/OchuJdr+h4TazUXIFCHXncwEOa0lbWikU9L4cb0p/7k0pNlvzpc/q6VcZy9GStwu
	zsrYh3TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paCnN-008s48-Fc; Thu, 09 Mar 2023 09:42:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paCnL-008s2g-DC
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 09:42:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC30C67373; Thu,  9 Mar 2023 10:42:40 +0100 (CET)
Date: Thu, 9 Mar 2023 10:42:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Elmer Miroslav Mosher Golovin <miroslav@mishamosher.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV3000
Message-ID: <20230309094240.GD24868@lst.de>
References: <20230308161929.18446-1-miroslav@mishamosher.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308161929.18446-1-miroslav@mishamosher.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_014243_598356_B2CA144E 
X-CRM114-Status: UNSURE (   8.99  )
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

Thanks,

applied to nvme-6.3.

