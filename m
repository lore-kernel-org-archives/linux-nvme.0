Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE34C7115B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 05:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N40QC5So83rB/6WLXPMiNJLeHTV9mbB3EpCgLUC629U=; b=cb4MfIN04hLOQWmLe7FLn4DmOW
	TJtoiHTePHgyWWdu7CL1HxquYkdtmKUZnHPz9xV502YaPi3M/e0newQxut2ey9XkLdWRJr8QIz2nu
	ouKFtjiwMyWWypCusVo61YCD+8E+e+WZzqtfEMt2zuC16M0n1B8vxQEpy+epbu5uDhtPLZm+WLRi/
	hE+p9AqSzcEL/DMie3sCSMScay6ZVOBrcf+MC83pvWPq+kFrIBkO+EvaiqqbZsDGJqCFl6+VQFOiB
	jNm+C6lUkF9Z6Te5z4sJUGRONvqAk//qrOTZWayc0RQWACOGf4FAjKMePAPDBBSsjeV1DXvEu0V5g
	hVgChYVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZkO-00000001ca1-1mCi;
	Mon, 23 Jun 2025 05:29:36 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZkL-00000001cZS-19uQ;
	Mon, 23 Jun 2025 05:29:33 +0000
Date: Sun, 22 Jun 2025 22:29:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v4 1/4] block: rename tuple_size field in
 blk_integrity to metadata_size
Message-ID: <aFjmPan6bmE8Vh1b@infradead.org>
References: <20250618055153.48823-1-anuj20.g@samsung.com>
 <CGME20250618055213epcas5p32ccbe13f8ed11ffa0beddaddb9a51595@epcas5p3.samsung.com>
 <20250618055153.48823-2-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618055153.48823-2-anuj20.g@samsung.com>
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

On Wed, Jun 18, 2025 at 11:21:50AM +0530, Anuj Gupta wrote:
> @@ -299,7 +299,7 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
>  static void ext_pi_type1_prepare(struct request *rq)
>  {
>  	struct blk_integrity *bi = &rq->q->limits.integrity;
> -	const int tuple_sz = bi->tuple_size;
> +	const int tuple_sz = bi->metadata_size;

I guess keeping tuple here is fine because we're deep into PI code.

The rest looks good as well:

Reviewed-by: Christoph Hellwig <hch@lst.de>

