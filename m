Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3148FC83F0F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c80Z82VuPNOAT87JcG7dwxSi0yfpOqZhsZwb+WoKV0g=; b=CmkX+Z1gJhCVtmONnCn4T5u+3E
	foxv9x/blVjmrlhNXxM8RoIqyIPapbiRMnXK+foN0OF7qtY5YhTIYxSYxVcthhitacZZrBXFyWVLa
	ljDhGLOavyPYgezzAwxm6nuJUPmsFP1N++GFwfvAZkp7z1bjjlxTpREPiO/nEiVet5KgPEa03GRei
	gpABd+R6bAy6Hkj81STcaBupTNzm7AUaUVGY7uD49UkI/MR8XNZAeB3GMZygmv9cVO1/7Mz6MLGU6
	j3zasjRaN43gm45kt8sWPNxisqwx/HuAq39BiEjqj5jjLTFhWxUU/NbYN5sTEH5wPMDi8+pBK4OkC
	kfjL/Umw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYngr-00000002qNh-0jqA;
	Mon, 07 Jul 2025 15:23:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnX2-00000002pCm-19O6
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 15:13:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BA8CD46350;
	Mon,  7 Jul 2025 15:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1BDC4CEE3;
	Mon,  7 Jul 2025 15:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751901203;
	bh=mp5jA2iGXeOxyKviqtC+9eLHu4JEDEMD2R4myXHhrwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+b1QmqVimJOFoZZvhcYArSv3nlj5kxA68W9/fsXU6fS592pTkTnmkoA3iXe5BzWZ
	 QSaGqVs7jiQwNbp1fWb+Q02MaBkiGosgZphh+ds8f6K4fzvZWKP7FwvwDAXM55cbES
	 eFEJ4J26Tma/3D1CWRGgLjR9E6WqAJYb8rQd5F5f4gqAIckQoIqkhNRUs1B8kedEMv
	 zzpSEPlKKMzbZtRaJrGqSM5tG4k7ETDvEQhWi8CVInISO3L1mO3Jl+steqKBW8uuUs
	 /azbyYPIMViesARI26/azAq3uNGVMLoo8ZvV0HyGhfiZYuPLGrU0+RA5dbcJzCb6VI
	 sMC++qo5tvYdQ==
Date: Mon, 7 Jul 2025 09:13:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, ben.copeland@linaro.org,
	leon@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <aGvkEcvMykZkx3MB@kbusch-mbp>
References: <20250707125223.3022531-1-hch@lst.de>
 <aGvZ5Xk5L66sNWJL@kbusch-mbp>
 <20250707150116.GA1939@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707150116.GA1939@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_081324_333530_E24A121A 
X-CRM114-Status: GOOD (  14.46  )
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

On Mon, Jul 07, 2025 at 05:01:16PM +0200, Christoph Hellwig wrote:
> This looks a lot less complex than I feared.  I still don't think having
> to allocate DMA memory for storing the ranges is all that great, mostly
> because this is exactly the path we're going to hit for non-coherent
> attachment where the DMA coherent memory will have a performance impact
> because it is marked uncachable.

Okay. I was hoping to avoid bringing back a mempool, but yes, I can see
how abusing the dma pool allocation to hold the driver's sgl (that won't
be DMA'd) may be harmful on non-coherent machines. Let's go with your
patch now; we can always continue improving on this if needed later.

