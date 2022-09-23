Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E8BC6FA82
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZiGSfOuqjgKOkE0d4Nz0aG6n0kWFrbNrtEAma4LspFw=; b=S61+eOBEqwMbsrhGqYwWNfmWZ2
	a1gQWmjLm804doFHXNv4GmiyxyKNLtfBsPezD2BxBdKYIIxxK5khFumfmfoaRk8I8e6Iy01IdYFZi
	9eKqqZB35e7HOvuoj6hm1TUowwWaE0lEa7Ap7AprpjehnKrb0g5IbZym26wXZ+E/Tk8H+CRq9f0Gt
	PM0As63hFC1gsoJ6zFxrTAfNURoxYa9Gwb038QodcIdwbYkylccTgGmro7WQIowuVjGdMpSfzYBqh
	COFMBXT0NTT4UAHNGMEQccIj5sQlTMeUKBqUJP9ZTvebb0VfpBYpgATDjB0D0ikymVeVEtXqoZypu
	kOb91dLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obknI-004qYx-Nk; Fri, 23 Sep 2022 15:40:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obknF-004qVs-PT
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 15:40:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4425467373; Fri, 23 Sep 2022 17:40:42 +0200 (CEST)
Date: Fri, 23 Sep 2022 17:40:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v8 5/5] nvme: wire up fixed buffer support for
 nvme passthrough
Message-ID: <20220923154041.GD21275@lst.de>
References: <20220923092854.5116-1-joshi.k@samsung.com> <CGME20220923093924epcas5p1e1723a3937cb3331c77e55bd1a785e57@epcas5p1.samsung.com> <20220923092854.5116-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923092854.5116-6-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_084045_983979_6AF2476E 
X-CRM114-Status: GOOD (  12.57  )
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

On Fri, Sep 23, 2022 at 02:58:54PM +0530, Kanchan Joshi wrote:
>  	if (!vec)
> +		if (!fixedbufs)
> +			ret = blk_rq_map_user(q, req, NULL,
> +					nvme_to_user_ptr(ubuffer), bufflen,
> +					GFP_KERNEL);
> +		else {
> +			struct iov_iter iter;
> +
> +			ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
> +					rq_data_dir(req), &iter, ioucmd);
> +			if (ret < 0)
> +				goto out;
> +			ret = blk_rq_map_user_bvec(req, &iter);
> +		}

Given that the fixedufs case doesn't handle the vec case we can
do with some untangling and a single level of indentation here.

Even with that a WARN_ON_ONCE() for that impossible case would be good
to have, though.

