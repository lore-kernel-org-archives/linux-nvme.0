Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C72CC001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=slRe+YcmSjVv8ZknucHmwHHcyukV15brRp38+hWMYPA=; b=BOsPhcZdBMa3Qk4Q/yIliC4k2G
	+Nnkv86y7joXWvwkbMGSQdWEB84HT/BRJuQi/Kt2SRieE4+QFJqXNpWYMmG+wArHqtSpsL3eDn9oP
	G6F2v81I5Et7P907YMHbJixISrb/TGn2aRJFUWsuOg2cuhuJa5qXkkNk7ZcSA5bo1XIp6T5zLsK2Y
	cosxK61GUYzDShPDQn6QC4l93v2TZm6JwNpIg+V+I2fQ8/00SbqpZrP5+tUu3ha6vYGQ6hO3t65l5
	zkAVbNDMIZMUdwCqTcyMX/bGc4KOLmWymSzsSaxHr+dN6kU68FXxp/RsTgHJn2fHNXBoVCw15fOYm
	oLW/B2hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPfx-002zUK-19;
	Tue, 08 Aug 2023 16:35:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTPfu-002zT4-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 16:35:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D2DD261072;
	Tue,  8 Aug 2023 16:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B2AC433CC;
	Tue,  8 Aug 2023 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691512512;
	bh=slRe+YcmSjVv8ZknucHmwHHcyukV15brRp38+hWMYPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oL3b/v7HvDx5OsvmMW/AdrdKlmDTNbBfQ+peRkwbgc5jgfHNYfoBSsgHXUMuJNcWM
	 gIcweqPc1H7XCUZItGu7/ZOh5novUh3aPTekz6KsAwQtjJHD/Sn2fJLHRXcbSqhEkz
	 DTtjtYba92WkVTEicSVgdjG1kp3Wlcbxckxw+54F+tPxHe9PuDqXfFcmmCgiqnQZQV
	 nwiq5LkP57BSrfqHRIMJ2UemP/vZkyxiwFIyRjWQRT9ejE9hCNgX1zjNObLW6xwgAx
	 CEYoHnQUGoToiYtU7S9SgnevS1DMaUtoa+BOqP71JgvNlq6yT295a8Cw1/oijFTym8
	 tC8/JUoaPTPGg==
Date: Tue, 8 Aug 2023 10:35:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZNJuvTvD4jhMGDdp@kbusch-mbp>
References: <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
 <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
 <mafs08rb28o4u.fsf_-_@amazon.de>
 <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
 <mafs0tttn7vs3.fsf_-_@amazon.de>
 <ZMQYURrKPqIyTkG7@kbusch-mbp.dhcp.thefacebook.com>
 <mafs0350y7tg7.fsf@amazon.de>
 <ZM0XEUw0xKgzXvi+@kbusch-mbp>
 <mafs0y1il5y8q.fsf_-_@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0y1il5y8q.fsf_-_@amazon.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_093514_279334_F6009D5C 
X-CRM114-Status: GOOD (  12.49  )
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

On Tue, Aug 08, 2023 at 05:51:01PM +0200, Pratyush Yadav wrote:
> BTW, do you think I should re-send the patch with updated reasoning,
> since Cristoph thinks we should do this regardless of the performance
> reasons [0]?

Thanks for the investigation and finding the cause!

Yeah, we should go with your original patch as-is, just with an updated
changelog. While that may work around your immediate issue, I hope your
xen patches from this analysis will be considered for upstream as well :)

