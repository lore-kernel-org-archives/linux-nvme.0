Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF308C77B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 19:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEOM+TmvTrIf3suVRJrtlnqs3mGM92+thLmftKDH/8Y=; b=k6L6bMCJQbnHFYnGOegCPSsrNO
	tgCxM3IWtlqURnuoBf2XD5GJJtXB4UzvXpiz1rrXVMbXYZk4W3BZfL9vMT8lgUcxjpEFWrS9t6P3o
	TPBMsLqxMG+RRVlvAMc4ihVQvpQfpPBQKWvOmh25iyHePxl6YVCLzvt4JiKhbL4EUyt9u5qgT5JLx
	ugJOnyGNquAWOFPE1Hn08HrC1rUgfuozSqY+nul9i3/NYHaUdcxvlXHriQj0wvQsNnML8Oxgl0uky
	vCVxXsSQhUSAnEXt7ULYzwCkRtIYSjwMB4cyTKDOHT/Y2tyTTqOpo2NYsbvo8aaWaei0npmJ8A+h4
	e3YVkkJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTn3U-00000003pIk-3dBn;
	Mon, 23 Jun 2025 19:42:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjLU-00000003HrW-3tPF
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 15:44:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 48C48A51E9F;
	Mon, 23 Jun 2025 15:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A2AC4CEEA;
	Mon, 23 Jun 2025 15:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693471;
	bh=wEOM+TmvTrIf3suVRJrtlnqs3mGM92+thLmftKDH/8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUMvRJey8q/fv3kBiwWAMs95nc7+muqAcGgcngXOLgVe0ZOHkbN+nKtu+J7TusPxw
	 aWjq8MMEKeDiqhtWWIqI6Kk+RUuoT9Z5wk3iSgERnkJwkDz5JKnegZZblVhVSU4f0J
	 THyyTxU1B7PxtAGLus6Hj4AzC7umFTg8cbO/KC4tx7RhlQf/smd+7A/zxGiZPxLUDN
	 dPrLd9GYfffEvRRK+Db5C8GaIW+D3gJ/PQ4bQn694Etd1KUy3o1/cl8s1yCGDH78G6
	 LAkoBAZBIHYNTt6V6JbvolwSAE2QqKFLxST8s+9MZr9CrlX1iHi/fnDqLvFSqO5s88
	 y3n3z126nCPZA==
Date: Mon, 23 Jun 2025 09:44:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Daniel Gomez <da.gomez@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 8/8] nvme-pci: rework the build time assert for
 NVME_MAX_NR_DESCRIPTORS
Message-ID: <aFl2XTGwBbPSiU9p@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-9-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_084433_031920_0BF2E5B1 
X-CRM114-Status: GOOD (  10.16  )
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

On Mon, Jun 23, 2025 at 04:12:30PM +0200, Christoph Hellwig wrote:
> The current use of an always_inline helper is a bit convoluted.
> Instead use macros that represent the arithmetics used for building
> up the PRP chain.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

