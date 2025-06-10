Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18511C5B543
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+bPk3x3WGQxRhqiRu3H5xTaTOaOBisGT6vj831O8oD8=; b=Bd+D357hmxyFsANXycK6VJf3jE
	MDSO1NsrjF30tbmOslaDGTZy44ddcI6wOlZ4Ywpv12fhKspEXEAWJ+ZJfF7h/3jmelB5elLi0Fx5g
	K76iI52AYHvTf3hgKwnWBrGT/fSpm/Hzn+VwVOSMuFKT7ypqq3x7sq1u7OKIajWtHFNDrmx57u/oS
	OP05aS5o+PTI8atTryRUat1h3BJ0u86fCqy43yL7/z4Lxy0ThY02CpInWxfh1YN3YkX2EXhNHmnMj
	WJikRppR/hccUppB8Blhg6CB+Dkxre7TvPf7r5gR+3xpwIuoUr+9d93ZDIv4HiVmMa+wy+0g99PIx
	cR9DjdGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP1S6-00000007PHX-2INr;
	Tue, 10 Jun 2025 16:03:54 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOytn-00000006wHI-1Kbi
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 13:20:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 84791A512DC;
	Tue, 10 Jun 2025 13:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88410C4CEED;
	Tue, 10 Jun 2025 13:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561618;
	bh=cyz4Q7V5s/h6THVop6oSMlps3g7tfgbA8Q0ScJkllSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNWcAeezOrk7UcMXq5T3efkzGkdJUVHyKsdlRWhDEZDdC8bpoOCdiA10tFUNyJ7Kk
	 NswjNg649rAhMkwICZrpTPke+QUMa0c75o4NC4D1obuL7P4/3A8e2hn2hxIqH5kxTg
	 0/gv3yOaJ/8LxxQnJhBawEEqdg9cIA4SUyas7kR5o0r0wuQcfCvaBFg/DDEI4gBlXY
	 Slbq6SAA+GexgpTkjCChOpKTzxXPrDTrUV8mJLJH0gQ+kdpzTmbApwoD+sloSuGsPP
	 5KYy5LzoRmp8cvWbEAlgltppsIEOj5BcHR90MSe9OMMA/I5vjfT+tVfFDCOyAcTIFz
	 aouMid3e0J70g==
Date: Tue, 10 Jun 2025 16:20:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 8/9] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
Message-ID: <20250610132013.GJ10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-9-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_062019_415615_277D0BBD 
X-CRM114-Status: GOOD (  12.46  )
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

On Tue, Jun 10, 2025 at 07:06:46AM +0200, Christoph Hellwig wrote:
> Having a define in kiB units is a bit weird.  Also update the
> comment now that there is not scatterlist limit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

