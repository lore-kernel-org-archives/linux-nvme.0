Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C180FC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ymH1sAXMjlAwmN5bCVDEM4on2OF/O3KdyHnxIe3aHyg=; b=3X0xDi3GFmjofYWi7qUhf3yNKK
	63kPIacSI4u326Nvn91xqRUBEj/L6Z7Lyo27m2foXAJVQAXqP6wAJrw4J0FCE/VtA6KD/qk2ULdvS
	awWNKxkJOGUlqvtph94I80bKxLBhAOTdc2ANmaZiSDyPvP1g7BP9WRGqxXblzfGwEsJOgA+VAYJE/
	G6zgiCSTlUJ2bfUq6yOhVmD1FxISHjLKnL0vhV5dkg5GvBrZ0J7b6hRSvyXRs/kjcU6p/bgsl8Iyv
	RwLfhJU8bgtlKti1ODTxvK/NU45p/yk8U7EFPGsK/faZ4gRdRSA13Rmujvt3pvqJm5Powje+FQyCT
	BTd1JV/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaif-00HKcJ-Rv; Wed, 28 Sep 2022 17:19:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odaid-00HKal-1D
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:19:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4630F68BEB; Wed, 28 Sep 2022 19:19:32 +0200 (CEST)
Date: Wed, 28 Sep 2022 19:19:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 4/7] nvme: refactor nvme_alloc_request
Message-ID: <20220928171932.GB17153@lst.de>
References: <20220927173610.7794-1-joshi.k@samsung.com> <CGME20220927174633epcas5p4d492bdebde981e2c019e30c47cf00869@epcas5p4.samsung.com> <20220927173610.7794-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173610.7794-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_101935_247919_B02EBE17 
X-CRM114-Status: GOOD (  12.65  )
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

> +	if (!vec)
> +		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
> +			GFP_KERNEL);
> +	else {
> +		struct iovec fast_iov[UIO_FASTIOV];
> +		struct iovec *iov = fast_iov;
> +		struct iov_iter iter;
> +
> +		ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
> +				UIO_FASTIOV, &iov, &iter);
> +		if (ret < 0)
>  			goto out;
> +
> +		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
> +		kfree(iov);
> +	}

As mentioned before this is something that should got into blk-map.c
as a separate helper, and scsi_ioctl.c and sg.c should be switched to
use it as well.

Otherwise this looks good.

