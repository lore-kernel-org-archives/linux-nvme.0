Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12862CD98D0
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 20:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VIyLS42qOIPgbAl+g85RFFHDxN6iYSGrqionhuMIQ4U=; b=c1Phyg0ztCy6REYdZm4yKN2ZoN
	B/M6V4mnO1WD+Yvkq0uELCB0YRLxjOG5OShrWt+D2aq0BOT+xPrfN93I7a8b/NywL/WSTWKkNn7UK
	DbhtQTo5kcY19KFgEgbaOAGPecTQxkxmoO6nXfCwkppkuVsUXyt6i3oB5bFsXSDkrGr5w0+gNYc5a
	bK3t/OIf2uSzkY65pq0YdUGIudOJ6AsfFdYj9lvguzBdk63+NUa/fJ8QvL/4ApcJLRvcGRuEh3dq/
	rJQ/aOUHWrg29d/mffWFWRpCcSJ3T5zj4ON4H3Ajq3Z7OyQ1Cjs+jFMF1QHn/UES/TEjDNCmoI2tw
	UW2PuITg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdXm-0000000B3dJ-3QCO;
	Thu, 13 Nov 2025 20:03:46 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJdXk-0000000B3d1-26L9
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 20:03:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E4CF143E18;
	Thu, 13 Nov 2025 20:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03A2C4CEF5;
	Thu, 13 Nov 2025 20:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763064223;
	bh=VIyLS42qOIPgbAl+g85RFFHDxN6iYSGrqionhuMIQ4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ca0g4caxtzKZ02bma6BpHfrhKpEFzRSLqtvL9987Imx7HhuGqao/TltL2duV4X4i+
	 ccQsQBEHEZTh30kdwuTwCJ4C2oEJtd4v/QvVFJw6mzbBjjjMG9ocjRtEbxNhYsH0V7
	 ifFXw0DSAxBQEaWD6nnvooKN4W2nYLGbmsETf2beBoxlUR+S9zF3OFO21J20bHzUDx
	 3m2pM6CISksTcmIfQrSEE74jqAlsHr7Ohio9r5fEZaNhdxPe4AWCmOnDPaVaLe8i9Y
	 JCWe6CqAPdenbn71OWVvWr70dqupWd9iCwIKB7TBngjUXaJ/mJ0YRbQFAThZBWr1Fm
	 zmtt9bOgtTEZw==
Date: Thu, 13 Nov 2025 15:03:40 -0500
From: Keith Busch <kbusch@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
Message-ID: <aRY5nCvNnQk4mMCT@kbusch-mbp>
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113195008.GA111768@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_120344_576985_9EC1DE70 
X-CRM114-Status: UNSURE (   9.08  )
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

On Thu, Nov 13, 2025 at 09:50:08PM +0200, Leon Romanovsky wrote:
> Can you please squash this fixup instead?

I think you should change pci_p2pdma_state() to always initialize the
map type instead of making the caller do it.

