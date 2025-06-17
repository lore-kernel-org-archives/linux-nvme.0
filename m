Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B8AC71157
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 23:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hMpAPP/jY/tk1Rc6nsEwsCXYoQtskUf4KgjHTyxBL1w=; b=zwcQB6hqydVHhU9m21HlcUkQlL
	SBkBhcUv4UD9UbXXgdTQxCZrtdG4BYlYbCHOq7XCgM4Rjd35aYaIyf9K7PNTVYtuuy7M+vWa8G7pV
	eM+kVsEq/6V73P4NyDs/OhgxsTqodUXjSMUbGbXYMPt7tIfL+cfajFM5pJ5xAuNoswtLZPrvbHkBf
	aPwiMlem7pGVNjzATrJD8/06jVbAVaTazBvhkARRGZ7FXu7IAuBBzgVhUA2t0qrLBKR7RJq9s3WLI
	4aw5k2QAELdf7V/0uO+wmg+W5z3nwjkpQx4Ihkw2sS5ZaVnHvoooAb9TLeznZaaTBtuxhVW0hWCFe
	aTXkUfng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRfg3-00000008c8G-1B02;
	Tue, 17 Jun 2025 23:25:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRfg2-00000008c8A-1xMl
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 23:25:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B2E861166;
	Tue, 17 Jun 2025 23:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641ABC4CEE3;
	Tue, 17 Jun 2025 23:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750202713;
	bh=qqFswnpIxhYZQgewi5QxadeBTH00J2KIIOkErfxrV+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i86wVHcgdAqNEzrlwzGF2mkErWaNlK1OhryWPWbZ71omd+6A7vevw/Dn2hz850Rdk
	 vHyQlXwtxpRVzENHvJeqxUJvJyAbPs6imrPnx9GdAgolw4mGOSrLtVJqUIJYfsK2ru
	 WjsSUWs6QkgHvRJVuoNCuSkhYQ1EjDi4WtYwahj+mB2QNXbUGGtBpzaR3suOWDVANL
	 xSqK/ZbvtRsJHIl6rsGFgs6K0NjoQzizqEU2tI+nfIpUP2tiBXDmnZ6O9TaA0I2JNn
	 MNEz4P3N32uiTq+vNfhDoN9jFIariP8Rcr95ObyCND02D1ahf+mmUEEJOwAaigcFVh
	 W0K9pD2KkhC0w==
Date: Tue, 17 Jun 2025 17:25:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 7/9] nvme-pci: convert the data mapping blk_rq_dma_map
Message-ID: <aFH5VXKwoWE3Eq5V@kbusch-mbp>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-8-hch@lst.de>
 <5c4f1a7f-b56f-4a97-a32e-fa2ded52922a@kernel.org>
 <20250612050256.GH12863@lst.de>
 <4af8a37c-68ca-4098-8572-27e4b8b35649@kernel.org>
 <20250616113355.GA21945@lst.de>
 <500dedd7-4e66-49d2-8c63-91d6a07f2e43@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500dedd7-4e66-49d2-8c63-91d6a07f2e43@kernel.org>
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

On Tue, Jun 17, 2025 at 07:33:46PM +0200, Daniel Gomez wrote:
> On 16/06/2025 13.33, Christoph Hellwig wrote:
> > On Mon, Jun 16, 2025 at 09:41:15AM +0200, Daniel Gomez wrote:
> >> Also, if host segments are between 4k and 16k, PRPs would be able to support it
> >> but this limit prevents that use case. I guess the question is if you see any
> >> blocker to enable this path?
> > 
> > Well, if you think it's worth it give it a spin on a wide variety of
> > hardware.
> 
> I'm not sure if I understand this. Can you clarify why hardware evaluation would
> be required? What exactly?

This is about chaining SGL's so I think the request is benchmarking if
that's faster than splitting commands. Splitting hand been quicker for
much hardware because they could process SQE's in parallel easier than
walking a single command's SG List.

On a slightly related topic, NVMe SGL's don't need the
"virt_boundary_mask". So for devices are optimized for SGL, then that
queue limit could go away, and I've recently heard use cases for the
passthrough interface where that would be useful on avoiding kernel copy
bounce buffers (sorry for the digression).

