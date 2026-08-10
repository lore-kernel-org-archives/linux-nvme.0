Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE36C5AD7B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 19:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0Ln4riyZAJg6pVIjg3cBPhSuBTlcqjUcsba8rs/6M8=; b=qEvkum9SuycvmZFgYBNQxXMi5c
	AOBR5AEZMWpI+kh0QYwBJjTtYno7wziiaLkgWKUFHgLlVWWCWfuFIXsGGXTAw5AfqX1bkI7ESjfak
	RZPr5LTCfDBiMiTuuhqvnomFDXBQqfmELY/bygOIJNcgKdyzuyFisxTsZtYQT/RoO2L8bRyO82LrK
	tk+4hNjyCBW0wApB5Uf7lnSOa5+5mQrUPjxtlwR4GFtzJAnhF8NQlV4RiBrUkIyfQZFZTRkUybST0
	ClFzWMEMBBsXUQsKo8tbBlMWhfi3fnZMcxDvDZMb266wxl1ndSMbHlZrfp4Vltx1tH7IKGADqbgHA
	Q077LCcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVYP-0000000CjZb-2Gqg;
	Mon, 10 Aug 2026 19:20:57 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVYO-0000000CjYy-1dP7
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 19:20:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9AE23600AE;
	Mon, 10 Aug 2026 19:20:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A02D1F000E9;
	Mon, 10 Aug 2026 19:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786389655;
	bh=Y0Ln4riyZAJg6pVIjg3cBPhSuBTlcqjUcsba8rs/6M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=om06GGl68B0OgnqR2vKe6EzENf2TVd5LvD0EQQoEaWtwFxuyNQ0JzNtgWaQgrAVG0
	 TCMRcx8S/hIrwuR3bq8baQEJJUmoJ8Nb6YBAM/wecVI7PRhVOVCNOP7OcfZ4+KR08E
	 nNB8lqANnSAVybeo/lHRXdfVfdTENI/agNxacJKZwS2VIcBQSiU1gm9JH6bY3P6/Qw
	 ghwEWOIu5i5dM4VF4/PEw8nz3/4/w2qYLazRB5l9HMtrlhxfYlazA/piCYxem2KonK
	 E6YFtvlrx+qjIsKTYCRiKJAJVa01P9o+DwjLAYl4G5H0GoOrNyvsIeurGkQO4X4BxR
	 jGdRCsZHhVESg==
Date: Mon, 10 Aug 2026 13:20:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, eduard@hasenleithner.at,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme: zero the discard fallback page
Message-ID: <anoklR7ptrDQwCtn@kbusch-mbp>
References: <20260730113624.1605213-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730113624.1605213-1-yhlee@isslab.korea.ac.kr>
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

On Thu, Jul 30, 2026 at 08:36:24PM +0900, Yehyeong Lee wrote:
> nvme_setup_discard() always maps sizeof(struct nvme_dsm_range) *
> NVME_DSM_MAX_RANGES = 4096 bytes as the DSM payload however many ranges
> the command declares, because some devices ignore the 'Number of Ranges'
> field - the Fixes: commit records two that read past the declared ranges.
> A single-range discard fills only the first 16 bytes.

Thanks, applied to nvme-7.3.

