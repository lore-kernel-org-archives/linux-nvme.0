Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A22C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 17:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FtgkLEIejSTa4i//gw/iNgp7VtklTSCl+8lC6ULi138=; b=tKZRStcCXoLxBMdvMmGfI6CI+d
	nrZrmCiKKzYEJS1tOqnHloOHYssSNhyVX/q1pCqfNs2WDRetcyEM0nV9J4bkwaCymTOk/jzTMcHC3
	55kXWU/hiChL3mOnpYqjy2/SNt2d9dhtx+5uxj0gyUEFdiVzllloe22UAhpNunxtQliKEqZdVHEWO
	l767GEqZo/KNdmrgFP76Sk/kEuK9VZBX+iV+HYHCqG4V4Qm4BCVuRgcZbnxCdD7eLFUfkviZeJlAD
	6s1rD0fOb3ldsOimPhfa7OYdYWVhR9SjSZ1RqKEqopaai2eik/9suGXE1bfervUlxpTIc0p9iXXJ4
	kuzWDyLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWLXS-008XL5-T8; Mon, 21 Mar 2022 17:09:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWLPa-008UXl-S9; Mon, 21 Mar 2022 17:01:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 571C961452;
 Mon, 21 Mar 2022 17:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A43BC340E8;
 Mon, 21 Mar 2022 17:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647882101;
 bh=z74tmM91Um9X1h7Fhx54Fbs7WMs3ywKR9k3rFYogmiA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p4DM2ufydUB+hlToCdfm9R6miNisFSTGqpnrdwux16BgmTvTDhbfRvFmzM5L6vW1v
 ayIg+HMlsnwDpVZxQTp1Hl2/u0BCRxVQF6g+6BdlnqYMpfhg5GHtleX+McUaKIbjaC
 mQrv/1pa8VWuzusofQFkwlRX9tyvINDCzaRiJ5ouiWwH6/osxtCmhdwclNWV3Ypz1d
 uDSngg5GD5fQUJgAGSdxQhsb2AmQokTUSxCyIUWMnFUfigRdEHSV79eNouy/TE/wsp
 /p71KygkDPu0CUEGzDomV89Q+nuLH7PQ7H2yf4hvCBoI+Kib69tr+h2SEioxROAzNm
 DoWkvMr02pTSA==
Date: Mon, 21 Mar 2022 11:01:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <Yjivcz4BlCMfJBkM@C02CK6Q3MD6M>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-7-sven@svenpeter.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_100142_989215_F1552563 
X-CRM114-Status: GOOD (  14.67  )
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

On Mon, Mar 21, 2022 at 05:50:46PM +0100, Sven Peter wrote:
> +static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
> +			       struct io_comp_batch *iob)
> +{
> +	bool found = false;
> +
> +	while (apple_nvme_cqe_pending(q)) {
> +		found = true;
> +
> +		/*
> +		 * load-load control dependency between phase and the rest of
> +		 * the cqe requires a full read memory barrier
> +		 */
> +		dma_rmb();
> +		apple_nvme_handle_cqe(q, iob, q->cq_head);
> +		apple_nvme_update_cq_head(q);
> +	}
> +
> +	if (found)
> +		writel_relaxed(q->cq_head, q->cq_db);

Doesn't a relaxed write mean that a subsequent write can bypass the previous?
If so, that sounds like it can corrupt the cq head.

