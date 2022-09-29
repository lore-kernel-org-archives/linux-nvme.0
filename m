Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B6FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 13:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ZmYJL0Ziwt6ES9JIpqW9iPzXBfgVP93+BjsFUeivcQ=; b=OURxhomvz/3xtdughS9gMAgoLB
	Pq7UivILyBY2QCsLwkNE8bMVqo2OuPpUsEbzcmHm3kBhQn1jSiAa0Ooohhpq+wTU+eAhK7PE2QURD
	29zoYO87nqAcH/VkiviTl4k+sSCG1RHKk7Tm44Jy2mduKkgPL2pDEmUhvQ6/jZmZiLtnY+SM+jwpO
	y+Ms0oUtCf2eKkTueKFqatTWx0bPuaSGtJ7zD8ZnzlvYFjVMUTHnkoUi1vnMemFVWwm/6ydz6s4kZ
	lwSdpyb/nKAJ2WELUqQlxvvNiu665/8AA6P1YK+nsXr29cikQ4d3v4DlHCiI/eWq3Br0ZEYctPN5J
	nlRjzCew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtXy-003GQv-Kt; Thu, 29 Sep 2022 13:25:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtXv-003GOz-KH
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 13:25:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B78D268BFE; Thu, 29 Sep 2022 15:25:38 +0200 (CEST)
Date: Thu, 29 Sep 2022 15:25:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH for-next v11 04/13] nvme: refactor nvme_alloc_request
Message-ID: <20220929132538.GA27768@lst.de>
References: <20220929120632.64749-1-anuj20.g@samsung.com> <CGME20220929121643epcas5p4c58f6ebb794bde58981272cd33c69f9f@epcas5p4.samsung.com> <20220929120632.64749-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929120632.64749-5-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_062547_826470_9EACD324 
X-CRM114-Status: GOOD (  10.79  )
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

On Thu, Sep 29, 2022 at 05:36:23PM +0530, Anuj Gupta wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> nvme_alloc_request expects a large number of parameters.
> Split this out into two functions to reduce number of parameters.
> First one retains the name nvme_alloc_request, while second one is
> named nvme_map_user_request.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

