Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6264CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 11:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bRSDvwwt1tsvshJaYKwltjqT0n
	w5l6Ir0sq5k5RsVhq8I/5c4kdzVbSGW3eQpNY5wnAQ4sBi3uEdlwb+Y0SDnaKSMn6FvxBLgRlIgsg
	lE6qvEtwwx/jBRncldaGpB9X3k3R+knE2JPlQZPuRaZ/hzDf1FwqNDdqPrK35nUgwquQ72Lg4/do+
	/uLJL0BMH5fO+I/2nZvK2Lye1IFC3quuMvyf1D+7mRZJaE9+FlsXtxssnCok9kSmElEVQc1X9L0ig
	oFZiDw/ogLPyqPslmGQZAbylBblKmB4VoeOXtnhaGJeBHXkZLBkmXoS6BL9czdw5GdoywvkPQuPdL
	lPzUR+aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHZq-00000007bQx-24FR;
	Wed, 10 Jun 2026 11:58:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXHZo-00000007bP7-1T14
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 11:58:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E80968BFE; Wed, 10 Jun 2026 13:58:29 +0200 (CEST)
Date: Wed, 10 Jun 2026 13:58:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, mlombard@redhat.com
Subject: Re: [PATCH] nvme: make nvme_add_ns{_head}_cdev return void
Message-ID: <20260610115828.GB19624@lst.de>
References: <20260610111608.3252988-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610111608.3252988-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_045832_540354_0611D4E5 
X-CRM114-Status: UNSURE (   8.40  )
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


