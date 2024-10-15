Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDDDD216B0
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 14:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2z+/Q2pV4fhwUsOvduNZhzWbwcN97mZzNm/Ih/Ov8N0=; b=HLCzRmTc5w+nxWvHqSkPj9f9gT
	aUTdfxbqSLfhyjrxAk07GmHZMU3kH4CAgMFVLzBNljig7D1S0DE2ej7hrszlDoalfbbe35pxzCQzT
	oMJ5Al6M6jUi9G1r8XN4Mz/5OySZ34/rKRKPGekbqUrRpZHrG9NsR7XFS9p0egyLHlcUC6zYpgCva
	Vgaunznjqi/z29tY9Izab35ORtyv6C7YkA8L/PMfw4eYfO9cOI9uTTR6g+oBAFam3LZsfIu339vv7
	lUlu8YLQCv4nVyS1GDNdq/YDhivjGde07i0XBxhDorSUYtGKzlEx/qSpIDRhhXqy9eEUsJl13jrDK
	m03VgLMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ifx-00000008XOV-1GZN;
	Tue, 15 Oct 2024 14:37:29 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ieo-00000008XJo-3wMg
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 14:36:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2F877A42573;
	Tue, 15 Oct 2024 14:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFBEC4CEC6;
	Tue, 15 Oct 2024 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729002977;
	bh=AwUXDDWUqmFx6SrB6U2XIlBdSMzpakLojsAbv+DpT80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMxFW8Oh9Et2pdcu2dMLnBHhacSuvzIpG0FXxwyCSfey6EJzZB0DXcFHvleK3g7uf
	 mCVbwWGQThJbQFHEQ1HK+qhPQdlP7v6pPTFXd+byuTyQRyqg11tHTMLbS7aekX2ERq
	 rne9bkvtycNIgMs5EDTIvkCPz9O0x3YcCufDHfMyuqHv0UXHLSoHlrAlSZko9TuTZt
	 aMdkoRtwZ/M8V6+WVVAm+LZE6+HbgqDYNloN59pZjTxDZrRwtQk601+y01T6Vw+9pR
	 v2lj2a03/cuXGoFPbBxHsHjhyxK6eEbOHdvGlxlf7cOy/ceYqr4PZpRrGfMwhHD/UQ
	 mGqp7qnYCnwQQ==
Date: Tue, 15 Oct 2024 08:36:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix cns check
Message-ID: <Zw5930diGlfHACzF@kbusch-mbp>
References: <20241009214035.3851406-1-kbusch@meta.com>
 <20241010075633.GB7525@lst.de>
 <Zwfuqf_PAP06GG1-@kbusch-mbp>
 <20241011080925.GE2749@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011080925.GE2749@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_073619_068796_D73AB189 
X-CRM114-Status: GOOD (  17.21  )
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

On Fri, Oct 11, 2024 at 10:09:25AM +0200, Christoph Hellwig wrote:
> So yes, something like this is probably fine.  But maybe we'll want to
> struture it in a way that is easier to read instead of having two
> helpers to decide which CNS value is supported.  Maybe something
> like:
> 
> static bool nvme_identify_cns_allowed(struct nvme_ctrl *ctrl, u8 cns)
> {
> 	switch (ctrl->vs) {
> 	default:
> 		/*
> 		 * Starting with NVMe 1.2 the CNS field occupies a full
> 		 * byte.
> 		 */
> 		return true;
> 	case NVME_VS(1, 1, 0):
> 		/*
> 		 * NVMe 1.1 expanded the CNS value to two bytes, which
> 		 * means values larger than that could get truncated
> 		 * and treated as an incorrect value.
> 		 *
> 		 * Qemu implemented 1.0 behavior for controllers claiming
> 		 * 1.1 compliance, so they need to be quirked here.
> 		 */
> 		if (!(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS))
> 			return !(cns & ~0x02);
> 		fallthrough;
> 	case NVME_VS(1, 0, 0):
> 		/*
> 		 * NVMe 1.0 only used a single for the CNS value.
> 		 * (That's where the name comes from:
> 		 *  Controller or Namespace Structure)
> 		 */
> 		return !(cns & ~0x01);
> 	}
> }

I like this idea, and the spec makes it seem safe enough to assume the
tertiary version number is always 0 for 1.0 and 1.1 controllers. So
yeah, this looks good to me.

