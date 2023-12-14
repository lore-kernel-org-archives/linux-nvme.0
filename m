Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD3AC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Dec 2023 01:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yea0NFt9MO5hPr1/WrkhFyA3OXVNRnjm3vZ9sUIVSSk=; b=hSb5wdQ4up3IrnCfgxOtXC+Sq8
	+GX6LPPwnw3y4bDtVglYpIE2p+6JfuwKa9SYPq399nWcz/Mus/CNwq+Lv6AiBa6kS/wPaz5Rjw7+6
	q4APpyygf8Yb973D+3334tOLS44H5qp9aSTC8YEes6/RgNsvgTJbDUjjtzvnXVqnQBJtD3og2Z0Vs
	n6zRTNF6xtcMS8FLoDWZvrXU1FrvTBF2tA3nsYVcZSMbvM+yMp9LZpSpkL4TeWt+K0wyLI1NbnSe5
	RZhmh1CqCJGKwM06vtVZcU0ahjEl+CIkgM7PYRfwOcm1n/yk4Wc1FMufcikbRu8PwmuwKG96+Z1Fh
	3MOtxKOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDaGC-00GOsr-2l;
	Thu, 14 Dec 2023 01:11:32 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDaG9-00GOq9-1n
	for linux-nvme@lists.infradead.org;
	Thu, 14 Dec 2023 01:11:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 04A5FB8200E;
	Thu, 14 Dec 2023 01:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6B2C433C8;
	Thu, 14 Dec 2023 01:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702516284;
	bh=XwoFjsJDwQ9a2+DWM4rjeegVkzh/lxFGbWD3rYfyGcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSq1uGLrFIRUTnVT3AS20PIwVXDWLgO8ozWsfsDZWaPJjk8n3u8l/eWwAv50O0EMd
	 u8lxxL9Y4sSkGifdgqH3/YI4+EmFlAIdAVSI/mgcQl9karZZTwtudxVBlp5VpjaMxu
	 SjagbjSDOcAhlUiBn/nkeM13SGJb/wwTwxfblLge9zGFRonPJ2SBordG8cRqdYFNpI
	 3vAf2yXumJqwsUhu2Qb2L2P3bTvd2tZKU5prXoqDMiIFx8b91cZLKRNAPDnqn2anJK
	 4lsRsLROKyVu60uG6cdSuihgOfEcCuT+ZirEHhGzdijeXu7TpvPoxov1wnMfqIDbmI
	 CMP4+mM/C2Qxg==
Date: Wed, 13 Dec 2023 17:11:21 -0800
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
	anuj1072538@gmail.com, gost.dev@samsung.com, mcgrof@kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v18 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <ZXpWOaxCRoF7dFis@kbusch-mbp>
References: <20231206100253.13100-1-joshi.k@samsung.com>
 <CGME20231206101050epcas5p2c8233030bbf74cef0166c7dfc0f41be7@epcas5p2.samsung.com>
 <20231206100253.13100-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206100253.13100-3-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_171129_755018_D4A8A63E 
X-CRM114-Status: GOOD (  13.60  )
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

On Wed, Dec 06, 2023 at 03:32:34PM +0530, Kanchan Joshi wrote:
>  static inline bool bio_has_data(struct bio *bio)
>  {
> -	if (bio &&
> -	    bio->bi_iter.bi_size &&
> -	    bio_op(bio) != REQ_OP_DISCARD &&
> -	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
> -	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
> +	if (bio && (bio_op(bio) == REQ_OP_READ || bio_op(bio) == REQ_OP_WRITE))
>  		return true;

There are other ops besides READ and WRITE that have data, but this is
might be fine by the fact that other ops with data currently don't call
this function.

> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 7c2316c91cbd..bd821eaa7a02 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -393,6 +393,10 @@ enum req_op {
>  	/* reset all the zone present on the device */
>  	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
>  
> +	/* copy offload dst and src operation */
> +	REQ_OP_COPY_SRC		= (__force blk_opf_t)19,

Should this be an even numbered OP? The odd ones are for data
WRITEs.

> +	REQ_OP_COPY_DST		= (__force blk_opf_t)21,

