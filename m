Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E7DEB64DD
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DxBjJM6wq3Bz0U5DPjG1Nb66fTpTzeZjtgOj0R9EGMc=; b=bbY52SIxzg2S8/JmvPDzjrxKWL
	pN16Dloeseeg0im0rHop9sONJV0wOtayYdI6CsMtma/2OQyyTT5yKyj6vrX8S84x/7NIdPkdhUH6a
	kF5Xtp+9LWD6qpJpUSljQsPyvFnqjBVj+pqHmYOWYzKu7adlTFGJTyNq37Qy69xiOUWSetFd/syET
	gk+uLTZ9u1vmo5CiiGqaN5phW2lworqmZ/rOfqWP4ZE62LUu0MWYUacaMGJ0K59aMUbJIAax2ZBlw
	WgIpF8GA11YqbJBV8iNk2MBC1lzEV6K2qJ30CHzT/PsAjgPzHyv1PnzvCzFBKxWFaHS4YpBEqUS+o
	r3jxgB0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUVSM-00BAjQ-1Q;
	Fri, 11 Aug 2023 16:57:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUVSJ-00BAhp-0K
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 16:57:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7B5A3654E1;
	Fri, 11 Aug 2023 16:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC7C433C7;
	Fri, 11 Aug 2023 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691773058;
	bh=h9uqWymXuU3DRYBhWzUCgG2mYSZvxOo3nA+b+2GK+h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FYnzX0Ibz5WpuqMhmcjUJCFlEACcaZ880I6AWS/7Cf4cVjqsUoo4vPCTp/7XEas7D
	 M/zsyBsn0//cjeWuOJzy50Pdi16xG7IX42NI2DeGNVLW8CBBr3Xayzh8zAKCWpzhLK
	 ukPfr9GnNFnaPc4w8EZnqlcxAK9kR/b6Bp5J7vqB74dFVssHIsI5A3jP3GCPpPVLYm
	 fSlRvntEZiGTLHXV8yenkVLfqO80RVS8zyUGhJu19C39qPtiP4r5qUeJT/HOOLYWpj
	 zvfkUAZBQnhKLH7pNgZThh3vQhWWXptgBSULAP1mp6Oyr42d0e6gSBhU6ujW1pTsGF
	 MqSl6+rL3OlYw==
Date: Fri, 11 Aug 2023 10:57:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com, gost.dev@samsung.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH 1/2] nvme: fix memory corruption for passthrough metadata
Message-ID: <ZNZogPZtHsxi1S10@kbusch-mbp.dhcp.thefacebook.com>
References: <20230811155906.15883-1-joshi.k@samsung.com>
 <CGME20230811160454epcas5p2635d208557749a2431b99c27b30a727f@epcas5p2.samsung.com>
 <20230811155906.15883-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811155906.15883-2-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_095743_206364_431AEBD1 
X-CRM114-Status: GOOD (  11.68  )
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

On Fri, Aug 11, 2023 at 09:29:05PM +0530, Kanchan Joshi wrote:
> +static bool nvme_validate_passthru_meta(struct nvme_ctrl *ctrl,
> +					struct nvme_ns *ns,
> +					struct nvme_command *c,
> +					__u64 meta, __u32 meta_len)
> +{
> +	/*
> +	 * User may specify smaller meta-buffer with a larger data-buffer.
> +	 * Driver allocated meta buffer will also be small.
> +	 * Device can do larger dma into that, overwriting unrelated kernel
> +	 * memory.
> +	 */
> +	if (ns && (meta_len || meta)) {
> +		u16 nlb = lower_16_bits(le32_to_cpu(c->common.cdw12));
> +
> +		if (meta_len != (nlb + 1) * ns->ms) {
> +			dev_err(ctrl->device,
> +			"%s: metadata length does not match!\n", current->comm);
> +			return false;
> +		}

Don't you need to check the command PRINFO PRACT bit to know if metadata
length is striped/generated on the controller side?

