Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A32CA1010
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T+ZSflSDtuv2vn6xoQd+7rrsdX4E+p+ug1hAD6qDjYs=; b=MLUFo6avy4/izLPUUIVBpCOomc
	HXoZT/60ujcP1SwvYEzJv5PGWFCnJPV+nQdVBELd3WT6MlOqVRnSj/aCFkKemN2K3dBWtrb13pm7R
	jNRvZnZ4dNGk+vRcWkUL3+czcwaUeQ25XSWo4cS7Ybm4CJSsjVkJXEjjGtoQ6hjbXrWAUjXQbk5sA
	3Nm8bxDsUQe+48M74ACwoCsQB78HTp8c2Ir/gBCxcZuUGPNXN+O0R26hVrFazFceeethEZFtYNV+Y
	050ypuprRQ81ouEeUtUEbqINZ6aLjcjQZgrSpaU+xujBPd+j4iP9FMwJaPPTO3Z4Cot4u6jR6KYxF
	1qo9Cx7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utk4E-00000005yLk-49SS;
	Wed, 03 Sep 2025 09:46:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utijL-00000005VYK-1KCt
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 08:20:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BB59560232;
	Wed,  3 Sep 2025 08:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC15BC4CEF0;
	Wed,  3 Sep 2025 08:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756887634;
	bh=4us/JiNGyyrs1E2mZPfotIPzzrOl7wDbBGjrnF20ulI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0/Oj2+L6B0v9fV5Bbt8gwblJ/pFlIqW+QAC0oqsd2a6T/covNIJza3ENaF87vAP2
	 6W+pKv8n/OLFSju4g8AxWnJtSeU3kxAB9FTpSQzzG8n38BncuGpZRfwdXubLVJ4ru4
	 SEx6WlSpeJaOuOJvtRYAalM5TWmQhGAItn1BfhA9yUGY1wCfH5I5ZBnFA1rlxvFeKX
	 iDP6DDKnwz1XyfktB+Pbpx+vMCucC9R2huAuoOUndFzcW13ZdzJ6pPVH1lZ+hHjem0
	 lvHEg21/Wi6uS6um6sTwNs7mAKP83LUwPi64NNqwYbyaUfgpSnTZw4DZH6eK+aNLZy
	 tWzmr7O5oP1mw==
Date: Wed, 3 Sep 2025 11:20:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250903082030.GA5608@unreal>
References: <20250902200121.3665600-1-kbusch@meta.com>
 <20250902200121.3665600-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902200121.3665600-3-kbusch@meta.com>
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

On Tue, Sep 02, 2025 at 01:01:21PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We need to consider data and metadata dma mapping types separately. The
> request and bio integrity payload have enough flag bits to internally
> track the mapping type for each. Use these so the caller doesn't need to
> track them, and provide separete request and integrity helpers to the
> common code. This will make it easier to scale new mappings, like the
> proposed MMIO attribute, without burdening the caller to track such
> things.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-mq-dma.c            |  4 ++++
>  drivers/nvme/host/pci.c       | 21 ++++-----------------
>  include/linux/bio-integrity.h |  1 +
>  include/linux/blk-integrity.h | 14 ++++++++++++++
>  include/linux/blk-mq-dma.h    | 11 +++++++++--
>  include/linux/blk_types.h     |  2 ++
>  6 files changed, 34 insertions(+), 19 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

