Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B69AC61DB9
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 19:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8NRlw8mgX5Y5GcLyGQnNmSW02HpPrzPblnKZxDaYac=; b=JjlW9YEU0Tw4JD8JA9gyv9PzAG
	oPF8xElIHpo/ZgVXyKW2TFaxVlREgQeqGzr8b6C16wHkj0ic6W9ZJ8XVrxjVajzCxleO156TwwhdA
	PsJxS9rihfEuJ7lULjKoNf3tHPOpsb5mlTqaZUnmXuuoEASg8GnYgnXUYMVKtc6Rm5TO+imawI3FD
	BwlO0Y/4sOXmTIAO/3Rg1niy2Tp/nUtykSeEmiCtPVCEh4P3ck92HDy+Rx6ZRDcbumpnjvxRm00/j
	2jKvgLM/rh2cAw/eBxKk4bsH8LY20DRmpBzLDioOWszIAU9iMwgOQ0JSHE1pe9g+Tl8l/FckWPcvI
	fO9rb8wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wywNW-00000001Lp1-2LzO;
	Tue, 25 Aug 2026 19:00:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wywNV-00000001LoM-31ns
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 19:00:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A39D260053;
	Tue, 25 Aug 2026 19:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6911F000E9;
	Tue, 25 Aug 2026 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787684408;
	bh=Q8NRlw8mgX5Y5GcLyGQnNmSW02HpPrzPblnKZxDaYac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BjLaWUIfE1RQnPoXpD+zx7gZNFniGNX24P91ICPb9WE7SQNmxsmx/jy+uS3ei7iQt
	 acfJNV/PvgPcvfQj3bvkf5wjJSaKmY2yKZd+1eMumDdpsSXbGnEo++uw4okXcufVJH
	 zoTJRjPAXP2iOl++y3Ma9q2EpXbreh2kGGPY18w5Y8cx8BCXFlQSUHchrbdiNfJrz5
	 m3DxJmMfDVKKC90m0F9BrK0lmCgian1kE+cc+oMbGC5rS0fSce/WKs43ABW/tsVkD/
	 8F00dQwx1JWz0MNtkWLdaB0ANJ/8yBhGIkSg38C+g5aDMyWL9pcyCoEFaD481DAG5d
	 ySeSSEc8uWXIw==
Date: Tue, 25 Aug 2026 13:00:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, dwagner@suse.de, hare@suse.de,
	johannes.thumshirn@wdc.com, martin.petersen@oracle.com,
	javier.gonz@samsung.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: fix command effects log lifetime for multipath
 heads
Message-ID: <ao3mNp35Hg_0MDlR@kbusch-mbp>
References: <20260814070651.3973067-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814070651.3973067-1-sangyao@kylinos.cn>
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

On Fri, Aug 14, 2026 at 03:06:51PM +0800, Yao Sang wrote:
> @@ -4132,6 +4125,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  	}
>  
>  	mutex_lock(&ctrl->subsys->lock);
> +	ret = nvme_get_effects_log(ctrl, info->ids.csi, &ns->effects);
> +	if (ret) {
> +		if (ret > 0)
> +			ret = blk_status_to_errno(nvme_error_status(ret));
> +		goto out_unlock;
> +	}

The effects should be the same for every path, so it's a bit wasteful to
copy it for each one. Perhaps it should be just one effects log per
subsystem, per command set, and the head points to that.

