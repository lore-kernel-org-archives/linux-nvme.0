Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DDEF357B2
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ycNZwipHtdS5xkDqo4y0z4kq9MAco7LD8RddfprPqmk=; b=gRi/cy0jDpNy6k32fxASlyX0M0
	Nlw16FCSESD0ySKEVnXCSlePHUrlKYbGkIm0E9xsfCEolS2oZ8ozQv1BQzWGD0F6yYW76bp9M8Qny
	J6TZ3hXrqjWAuXwZezmDAXzfFOZqX9ogqC3k1ky4GJQorLPIdjk73BBsXMvEoTtHZLKtRks9MX5gE
	6wDVQhz+BYzBkIdzHGJKShIb+Qz6u6tNv3mvWMNGqp7C1tEnuULor52L+QnbNau/Iv5C3f/IOchTZ
	dyXm8b+s7VeciACzisafee4eX22MXEjIz6P3aXE6Fm10CJ+6dKAVNLYJwPfPCf7eLKKEnQGMjMiav
	pe0AiRaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutQz-00000002DXn-2QNO;
	Tue, 24 Feb 2026 14:30:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vutQx-00000002DUq-0fCX
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 14:30:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F99D68C7B; Tue, 24 Feb 2026 15:30:40 +0100 (CET)
Date: Tue, 24 Feb 2026 15:30:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] nvme: update nvme_id_ns OPTPERF constants
Message-ID: <20260224143040.GB11710@lst.de>
References: <20260221033302.1451669-1-csander@purestorage.com> <20260221033302.1451669-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221033302.1451669-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_063043_354465_2009D3EB 
X-CRM114-Status: GOOD (  11.14  )
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

> In NVMe verson 2.0 and below, OPTPERF comprises only bit 4 of NSFEAT in
> the Identify Namespace structure. Since version 2.1, OPTPERF includes
> both bits 4 and 5 of NSFEAT. Replace the NVME_NS_FEAT_IO_OPT constant
> with NVME_NS_FEAT_OPTPERF_SHIFT, NVME_NS_FEAT_OPTPERF_MASK, and
> NVME_NS_FEAT_OPTPERF_MASK_2_1, representing the first bit, pre-2.1 bit
> width, and post-2.1 bit width of OPTPERF.

Please add this in a comment in the code.


