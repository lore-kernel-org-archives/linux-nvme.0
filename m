Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0EFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 21:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BkXdjgokUjPYj6UT3eis0Sb9h1b+5BkOuw/H29rGJ5I=; b=bxjVABn5e8BrQrhH2fRE1WNR6j
	C0VMo+gFPNY1pERYvBNNOi8x4dDwLMXzRS8IH1Sj0iVSsgpRJvEsCtVsUk1S36Plm/LRIxjkMks0/
	Fj36lx7eLdYV7Epox3FgI6uyDoRwNF9Qnc5DoXijDvIoU3+e8HM5L2tA4wBl0mlSuVAX/c2e6EbFO
	QBZeHc7WAJPK8PRKU1XDKOnw1vUcUE7hg2K7bgUI0FEVd/TIgEbS4EvQ/g2DQjhRyAv3YnpZ5SqQL
	SKBqkeq8Q2QE1Wjb/oYtLWPzE7Iaj4tWJP/pPzWyndv5U1oTQ3hzHbqqj3z4LIsrKMMbS7HCF5Lss
	W09n2QPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njSIL-00GFof-1d; Tue, 26 Apr 2022 21:00:25 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njSI8-00GFkk-Ai; Tue, 26 Apr 2022 21:00:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2E112B82353;
 Tue, 26 Apr 2022 21:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C432DC385A0;
 Tue, 26 Apr 2022 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651006808;
 bh=QxPQiDVyvyboQhb7hQg8egZCDBIE9qPfnk2lOel1mkA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hHfywpbDKaiIA+fVMnwKtNcMVk1eg8P8ocioCAYf46wZZ6qFH46Nr4JMwaMpjxbhI
 59zSmCUibSb6RUX46rByC1vS5y147UwUI9gtevvehdbPKze2VpZJTnpu1yEunlWzr8
 uMJlquUantp3QdT6iaRubNfhDNaOJgpkdI2DvYEI9B762H8XmbZZPU+kBkiR6Gcg44
 7h/CRMLmpP1EUIzXExSw0A7OB0mggP/e5NMvEp7yGkVIFXtjXX+V5p/B6NLSVam9sk
 gXPzTX+EZ3x3ooShAyIzTqU8Koo5mSbB9su7vgkZL4aT1iWdp5N6k4hmkw0TvI77Np
 iyPC0Regq0J2A==
Date: Tue, 26 Apr 2022 15:00:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 Janne Grunau <j@jannau.net>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <YmhdVJgd6DGRHPXd@kbusch-mbp.dhcp.thefacebook.com>
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <20220426201539.12829-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426201539.12829-7-sven@svenpeter.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_140012_561658_04C3E848 
X-CRM114-Status: GOOD (  19.12  )
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

On Tue, Apr 26, 2022 at 10:15:39PM +0200, Sven Peter wrote:
> +static enum blk_eh_timer_return apple_nvme_timeout(struct request *req,
> +						   bool reserved)
> +{
> +	struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct apple_nvme_queue *q = iod->q;
> +	struct apple_nvme *anv = queue_to_apple_nvme(q);
> +	unsigned long flags;
> +	u32 csts = readl(anv->mmio_nvme + NVME_REG_CSTS);
> +
> +	if (anv->ctrl.state != NVME_CTRL_LIVE) {
> +		/*
> +		 * From rdma.c:
> +		 * If we are resetting, connecting or deleting we should
> +		 * complete immediately because we may block controller
> +		 * teardown or setup sequence
> +		 * - ctrl disable/shutdown fabrics requests
> +		 * - connect requests
> +		 * - initialization admin requests
> +		 * - I/O requests that entered after unquiescing and
> +		 *   the controller stopped responding
> +		 *
> +		 * All other requests should be cancelled by the error
> +		 * recovery work, so it's fine that we fail it here.
> +		 */
> +		dev_warn(anv->dev,
> +			 "I/O %d(aq:%d) timeout while not in live state\n",
> +			 req->tag, q->is_adminq);
> +		if (blk_mq_request_started(req) &&
> +		    !blk_mq_request_completed(req)) {
> +			nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> +			blk_mq_complete_request(req);

I think you need a 'nvme_req(req)->flags |= NVME_REQ_CANCELLED' here to get the
expected -EINTR for any admin command timeouts during a reset. Without it, the
resetting task is going to think it got a real response from the controller.

Other than that, this looks good.

