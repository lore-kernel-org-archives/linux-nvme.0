Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CD4C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 06:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MrqAzkXpq3cndeLpWKbbqkfJTVbaQB+8B6LPFhuBzuA=; b=KCmtPB+bMVEVjEaXCXTYal/Wru
	IfHUQJtjjHEFFCYNNQzdrDTEloLlMsI2LSVtcQ56hqSder/TpNbYQJJ4gAHtorY3o+q2wJv8NBf1E
	GMtf63ntscQ9EZbhkAo+Y4HZ2I0IwuWyXuh5ves9v33LZLWKDwW6O4L8Rld9No4Ocr8u6TnWyBbZB
	A8SIKRYhnExD3+rRys9KdA8n4Tdr/dh+AAswRwOgOTAhditIC6rvlwaSsB5W/vAPkZy7oEQLH8M5+
	Faq6TaoEr6ldBd5VKfStfOseGAbqyadqShZj53bqhblGpN13e6J77lY52PQKs8Y38EFYgPZexsuFA
	iX8bhkRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXGZQ-00FjWK-UD; Thu, 24 Mar 2022 06:03:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXGZO-00FjVi-Ax
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 06:03:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 690E868BEB; Thu, 24 Mar 2022 07:03:34 +0100 (CET)
Date: Thu, 24 Mar 2022 07:03:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com, Anton Eidelman <anton@lightbitslabs.com>,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/2] nvme: fix build error: nvme_mpath_update stub
 without static
Message-ID: <20220324060334.GA12261@lst.de>
References: <20220324003008.1588225-3-anton@lightbitslabs.com>
 <20220324003900.1589124-1-anton@lightbitslabs.com>
 <20220324003900.1589124-2-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324003900.1589124-2-anton@lightbitslabs.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_230338_557933_6DB80FE2 
X-CRM114-Status: GOOD (  11.02  )
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

On Wed, Mar 23, 2022 at 06:38:59PM -0600, Anton Eidelman wrote:
> Fix multiple definition of nvme_mpath_update() on
> builds with CONFIG_NVME_MULTIPATH disabled:
> the stub function is missing "static inline".

Please just resend a new patch.  I've dropped the old one from
the nvme-5.18 branch for now.

