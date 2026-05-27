Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFE4CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ij8u7pyfVjUVU2OEJX2SrcQA+w4j7poGXV5G5THQcsQ=; b=t3awsWSkXywV2+qYRJy9ADxXT9
	HHrd9Q8ShRlXT/DfdPjAP0JQkNhdLmGpsdDtdRcg2FZtN+NslXz01bHQT6YVKJkf7jlAFQwKEywqk
	TgpDwYC1kmOXB8AeuBI4qk+XWmkNdEWM9RIlWProNDLcVaZeK6B9RxfJpjKBjE7kyKS62O8+N5wwJ
	WfzgxU8awAdRD7pN6UXKvgROmREqiyFIs98nVwkztQ82lrac4Z4fdNHn165CNxT5GIpkHTyfsThQ8
	BU+swp96zMozKTjgbOasVNF2ztZjf/1K3ctUBvWFjJillvkAjGQT6NvTKKROYGZnTQnbc/3p+V2Mo
	uY1HtnRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEMn-00000004CKt-2s0E;
	Wed, 27 May 2026 13:32:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEMk-00000004CKI-416k
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:32:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3BE668BEB; Wed, 27 May 2026 15:32:05 +0200 (CEST)
Date: Wed, 27 May 2026 15:32:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: liuxixin <gliuxen@gmail.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: fix FDP configuration log parsing
Message-ID: <20260527133205.GA12042@lst.de>
References: <ahWw_09BJkQi9zQe@kbusch-mbp> <a989258938de2d1fb01e70fd5ea2e50185cc6899.1779848573.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a989258938de2d1fb01e70fd5ea2e50185cc6899.1779848573.git.gliuxen@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_063211_142175_AF520FF0 
X-CRM114-Status: GOOD (  13.15  )
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

On Wed, May 27, 2026 at 10:29:45AM +0800, liuxixin wrote:
> 	<cover.1779848573.git.gliuxen@gmail.com>
> From: liuxixin <gliuxen@gmail.com>
> Date: Wed, 27 May 2026 10:22:32 +0800
> Subject: [PATCH v2 1/1] nvme: fix FDP configuration log parsing
> 
> The fdpcidx bounds check sets n = NUMFDPC + 1 but used > instead of >=,
> incorrectly accepting fdp_idx when it equals n (i.e. NUMFDPC + 1).

Looks good.

> 
> Also validate descriptor sizes while walking the list so dsze == 0 or a
> descriptor past the log end cannot cause unbounded iteration or reads past
> the buffer.

Also looks good, although I would have split that into a separate
patch.

> Fixes: 30b5f20bb2ddab013035399e5c7e6577da49320a ("nvme: register fdp parameters with the block layer")

Please shorten the sha id to 12 characters, i.e:

Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")


