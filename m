Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7F2D2F7FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sWASB65LEtfKe9GLr4vczb/iF4+8bLZW8p8NWVk21WQ=; b=4tUlqiqJ20XYwyyADK3Hhnhs87
	ZVYXhc1lJVo0gggZQPiXlQ1Qfo5onYfBIR0ayofHtxJ0HIjPnw3A++cOM7pXhMn9ddwfKsIp+KbkB
	eMTpPM9ILIwBhsHR5x0rDZJb0rCJovu6h2MSvnA26a9vPrR1nKKVpIac+KUVx2eBMZbVNNBoHMmEE
	r8VhmIHBEvbwudXUNpOoO8sZxV2x2Wi+8fLDTv7t6RdYnqScZ8+4DTE0Aug8U2RmPYGodBQ3Itofn
	DQkkB8LZSD4DoCbNj6Sa1oQNv6/dg3pR7INpJ3CpPmQc/s956iAJCLMFJPpSndvOQ8DPxh3TKMjEa
	xGoJ5/VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lfn-0000000E8B3-0lxl;
	Thu, 17 Oct 2024 08:15:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LfE-0000000E7nk-0Lhu
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:15:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE633227A87; Thu, 17 Oct 2024 10:15:15 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:15:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com
Subject: Re: [PATCH v4 11/11] scsi: add support for user-meta interface
Message-ID: <20241017081514.GD27241@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113757epcas5p42b95123c857e5d92d9cdec55e190ce4e@epcas5p4.samsung.com> <20241016112912.63542-12-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-12-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_011520_289061_C008E355 
X-CRM114-Status: GOOD (  11.50  )
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

On Wed, Oct 16, 2024 at 04:59:12PM +0530, Anuj Gupta wrote:
> Add support for sending user-meta buffer. Set tags to be checked
> using flags specified by user/block-layer user and underlying DIF/DIX
> configuration.

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

again this should move to before the user is added.

But we still seem to lack an interface to tell the userspace application
what flags are actually supported.  Just failing the I/O down in the
sd driver still feels suboptimal.


