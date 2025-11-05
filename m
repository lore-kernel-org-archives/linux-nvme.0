Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADDDCCFA0D
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 13:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rjlZHnRh8Tnhs0mrB1jDRBEt9xc9g+kABdf9ngaMcG0=; b=Y9awk56kTCQyyT+8pdCn89M21T
	6g93HfhEvYfOw3VZnHhWM6OwWFUD02aZ9+Rf3hsWnyw7tlZC8gpI9cETckPefgQyLiPJ/WHlE3Biz
	+9wyDhaWPEp3zp0ySVjk0GkoZGLqqp2DVtp3qfPJLK1HI7lTZp/9khanSTjMUvF8wZGC/mjMJFgdl
	4Bzz/V+D+/cLfCVODzjZpsIw0foQjXcbZcYleTHkTsrc+qPyixXPeL8BtdcW3meqHEeuyoZ3VM5B4
	kUjsPN2n0Fe1CnzKidRpZIP8ZEC7xyV4nqkdQQFBlIed1/gUlcB7oyN7fKdJyCWu7bkWKgqW0qWD9
	vprjYvNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdRB-0000000Dkym-0fOg;
	Wed, 05 Nov 2025 13:20:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGdR8-0000000DkyK-2mL8
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 13:20:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A727227AAA; Wed,  5 Nov 2025 14:20:24 +0100 (CET)
Date: Wed, 5 Nov 2025 14:20:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
Message-ID: <20251105132023.GC19044@lst.de>
References: <20251104231414.1150771-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104231414.1150771-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_052030_867253_4D264D71 
X-CRM114-Status: GOOD (  16.71  )
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

>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a01178caf15b..19980122d3d5 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -492,6 +492,7 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
>  	ret = crypto_shash_update(shash, buf, 2);
>  	if (ret)
>  		goto out;
> +	memset(buf, 0, sizeof(buf));
>  	*buf = chap->sc_c;
>  	ret = crypto_shash_update(shash, buf, 1);

I'm really confused about both the existing code and this fixup.

Why isn't chap->sc_c directly passed to crypto_shash_update here?
Why do we need to memset buf when only a single byte is passed to
crypto_shash_update?

>  	ret = crypto_shash_update(shash, buf, 2);
>  	if (ret)
>  		goto out;
> -	*buf = sc_c;
> +	*buf = req->sq->sc_c;
>  	ret = crypto_shash_update(shash, buf, 1);

Just pass it directly here?

>  	if (ret)
>  		goto out;
> @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
>  	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
>  	if (ret)
>  		goto out;
> +	memset(buf, 0, sizeof(buf));
>  	ret = crypto_shash_update(shash, buf, 1);

just have a

	sttic const u8 zero = 0;

and use that here instead of the memset?


