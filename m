Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EA9C87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPBVF9gXYWaCT4O1U3lB8VjS6B3SPDI+qHyi0vXFWGo=; b=wfmbZNgXWGtBXnXMdcTkF10qdu
	UeXoiEsBQtKWm5hQgnJDnvErGbJAyR+/rHNIHUVVg9O1cQwsN8nztbdCJ+8LZ6PDuMO7LfXMnBEuZ
	uRJfTYLPAJZVGlGwFUeJR9koOuy9C6j/X9l50skyA44cHiTgbfmW2qQhlmiRVWwu7suIBtnMuiQfo
	XsOPxSIIt4fjYmDNJSthZ4tlP/UjoywSf+hrWnxTDd2zjHGYlLfS9/ZMi1wXHH1u0nIcFEEuEEiH8
	kQ9oMdEqzzhTA4cno6ZadtguYWRroe8qWI2Mazaayn2Yb+XvbffUYdLngQ53AwlOxYfxGjArqDlIo
	3on2ShnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugpVU-0000000HVaZ-39mR;
	Tue, 29 Jul 2025 18:57:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugpVS-0000000HVa6-0Ndv
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 18:56:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 25D925C5F63;
	Tue, 29 Jul 2025 18:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A909C4CEF6;
	Tue, 29 Jul 2025 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753815415;
	bh=CQGSkI20W+HN63X3iLtCJ1iKuS8FkLgWUNEb0f4fBRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2bPIs4iErYenC6ehlVME22t+EXDPAKi6PbUGgZ49jGWnTA52eUl3Ymt+ttQ1rLH+
	 tLK06bR82F46F4xAsasRbO+rlT3pxH+82vz79oF2LPW+M7oD+DyQ2FaAz0jOaU+F6s
	 NNK9M2nUiLiy4V4XTVo+6pYmyDzudIKHk+VYdnUzXWgcLmZKi4r1CeIihnk5o521fB
	 fiEbqrQodGpe01gVdQKIxFACGg3gwdcd5z7wpQqL2nvdUW4W/jI6U1qhx517jxjLRE
	 N4dQwqj6cwSM5iFVIYrVCQt+pbL5XS6AdZ4b8EyItEbu9YEwMnU5Lxk16mFvVJWV8X
	 By0RL8IXXEiFw==
Date: Tue, 29 Jul 2025 12:56:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv3 7/7] nvme: convert metadata mapping to dma iter
Message-ID: <aIkZdfFOKLtet-Kg@kbusch-mbp>
References: <20250729143442.2586575-1-kbusch@meta.com>
 <20250729143442.2586575-8-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729143442.2586575-8-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_115658_233006_3168C0A3 
X-CRM114-Status: UNSURE (   7.31  )
X-CRM114-Notice: Please train this message.
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

On Tue, Jul 29, 2025 at 07:34:42AM -0700, Keith Busch wrote:
> +static blk_status_t nvme_map_metadata(struct request *req)
>  {

...

> +	nvme_pci_sgl_set_seg(sg_list, sgl_dma, i);

This needs an error check and unmap if so, just like data prp/sgl setup:

	if (unlikely(iter->status))
		nvme_unmap_metadata(req);

> +	return iter.status;
>  }

