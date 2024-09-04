Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B139ACD4F24
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTvq2wzkHgovEMksq5HHVcC0RoSVPG8mE9Xn3eBGGhg=; b=q+xO8YSOP7slE2ficSmcisrfcx
	W66+98Zjt9O0dt0Hs9G++NxnOQPqqLtLiCwVyBA5NAvbUxxQcwRUvqplrHNyroJP9q79C2mNS+NK+
	/Dz766yBMcoU8bV7kA/aPMw56b5skAmQWqMrbWESInUm4HJ9lmmmqC1aFmkrqelMf5WdatKROKnFR
	iwJZ41cccQDYYxwCVw2A+Xn3qEq9rpAdjEzCybjE1B1U/WY9dYGFQ02CW4cFLvQ/Lr3xCCoVpVTT3
	W2P1CPW4p3jol+dC8m09TW9+CHgF7LncjXvfyd1bs9dCDtI7vtAf0DOBDKeutuT3C6YIiuaTHKqeL
	IQRdFQoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slvbo-00000005n9L-1J3Z;
	Wed, 04 Sep 2024 19:24:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slvbl-00000005n8p-1r7E
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 19:24:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6ED5DA448E9;
	Wed,  4 Sep 2024 19:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E903BC4CEC2;
	Wed,  4 Sep 2024 19:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725477840;
	bh=XkSlUOk8rwFXKQ3AQ6CAWNR0kWpJR4aU8O/2cGQlij8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ2XumGjuHeZshsD2I006HpvhVP4nXgrbuqhnx7KG7OnMvZFHuF5aCic4QJjy71uK
	 IXHqkeWqoF5T21jLErWTrP2tdPJX9oKhnebKnpYXB/Q2zSOfes/IaTd3gkwHt2dv4M
	 xQpDdYSjJu1hoCz6Y7CSPSK+zpCHQbLg2Sc4gttTtuUiHvtlue6qHR9IJ+WJtQu23T
	 EjsvRSxsWlSi6O4hL/1wZCD/h9dWhYuq17Ai6dQzZlc0O82eocPuTCRnsfTi9CHin2
	 Po5O2iCYNZcNTzvsksOUjOAIvIe20PAch7nLiixWLaWjDBtUP1fFPrKWcRKHgOOw1g
	 7hKWa5j/v2k/w==
Date: Wed, 4 Sep 2024 13:23:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH-part-2 9/9] nvme: force sgls on user passthrough if
 possible
Message-ID: <ZtizzqB9a7UBCs1M@kbusch-mbp>
References: <20240904183818.713941-1-kbusch@meta.com>
 <20240904183818.713941-10-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904183818.713941-10-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_122401_562952_E16ACB88 
X-CRM114-Status: GOOD (  11.40  )
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

On Wed, Sep 04, 2024 at 11:38:17AM -0700, Keith Busch wrote:
> @@ -146,6 +156,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
>  	if (bdev) {
>  		bio_set_dev(bio, bdev);
>  		if (meta_buffer && meta_len) {
> +			if (nvme_ctrl_meta_sgl_supported(ctrl)) {
> +				nvme_req(req)->flags |= NVME_REQ_USE_META_SGLS;
> +			} else {
> +				dev_warn_once(ctrl->device,
> +					      "using unchecked meta buffer\n");
> +				add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +			}
>  			ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
>  						     meta_seed);
>  			if (ret)

This actually needs to add this line on successful:

	req->nr_integrity_segments = bio_integrity(bio)->bip_vcnt;

But it think it would be even better to introce a request helper,
blk_integrity_map_user() that takes a struct instead of a bio so it can
handle updating the request state appropriately.

