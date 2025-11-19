Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ECCCF319B
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 11:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7FLgk/xdrWKd0c5twY++wW0h5bw/jIEwdGuG0O0wGo=; b=jYcl0//SBVTleUv7Usf2KopysI
	NhJhpguxAMH+cb5aFTBjZRffVggvRrEY8P6m1FGKaYMRGPZG3HZbq88mFADjnnAT5swrbbm5HK8MI
	8b8rCDOmB0CVA5YxKoRbCwvY8YXnYrIaK3xBKMdzic2emZOX4EcNDXuKBN5Uk6dxJqtO3fu5Y/jUD
	Uj+uCuctLrXg4idCaq8nC21iJvAuobNcHr00idi4N9/YqS/KG7QRY+BpMbmtxeC7qRG1kB0WLnpiV
	H/V1QKZmyfDj+FIhdu8Acxx7zy0bhdm4mRhNFX3rvl028p8QP6+9SV8rak3q7dHvEGZpRoh9XDmaW
	sk04cm8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLg1l-000000030Uw-37H5;
	Wed, 19 Nov 2025 11:07:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLg1j-000000030U9-1ZYB
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 11:07:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 84EBF44141;
	Wed, 19 Nov 2025 11:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E385C19422;
	Wed, 19 Nov 2025 11:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763550422;
	bh=S3zTVStBoLYGmYGmxZC0NIadrgUI21u3no3kP3JU4m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2oXOGb+nSFmMH/C3fHQdKnLwI+dzInHFjDWDiM9Y2GgvnvftKQCcFuAyKUirvzps
	 9vh779mzu/HLXKFzPlOHSHr4efcZMbp2dHAa+G1OCa3KpqQ8Mk+4QRvgIrnuUGUgSW
	 DjyECJHD1IL/sDvMXLtjOvlnxK2sIR+7MQkEHp6KZ6WQ/lBN8KsQbS/8dQg+fSePBd
	 q4LhLgHlFkt9y/fctoQ7oAXFSNR2oT4e82MLX5bUr3kW9+JBNzbs05xXjsDsVFGgrj
	 C4RWQYbz0re4CmM/BortuOyD27zlQtDCtH91QfGy/mkvkxw/nDGn6fBeRfCpiP5+Nl
	 RFNNSmrETZ2vA==
Date: Wed, 19 Nov 2025 13:06:55 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119110655.GB13783@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
 <20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
 <20251118050311.GA21569@lst.de>
 <20251119095516.GA13783@unreal>
 <20251119101048.GA26266@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119101048.GA26266@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_030707_435741_55A38FEA 
X-CRM114-Status: GOOD (  13.34  )
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

On Wed, Nov 19, 2025 at 11:10:48AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 19, 2025 at 11:55:16AM +0200, Leon Romanovsky wrote:
> > So what is the resolution? Should I drop this patch or not?
> 
> I think it should be dropped.  I don't think having to use one 96-bit
> structure per 4GB worth of memory should be a deal breaker.

No problem, will drop.

