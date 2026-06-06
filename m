Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2950CD8C88
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jun 2026 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3WzyYt48G4RQfAKtt5FczP1+tGEO7Yztn+HsGj1d6x4=; b=rrlD+36LvjKh3mgrbpN16VBi5o
	fQpxPCOP/9AkvGSHnITxk+M7zs1vC28NbsFxYImLfpPlzsTtMw92rqBal3us1JOi4214custEri7X
	vRzNTh7RxK0bGVSnE8K7iTHOcGmMmc+8utnQCkYiV0DG3ZvHISP2jwZ+HSLdU5QHmeXCtE/btJx0P
	8pSiV1PWHf0NqVFVkkpLJfC+PgZBqlO0yn+eK1/hyLjOLhO/IZFlVosq74vAvfjml8cYxQyOZoiqw
	2H1wCRr63N8UBukqBpP74jTNnYcyo6D+XRlzskz51grHijz/Kfj32VFXL95nO3gXpoiN9pZ6/sY1p
	KbIkjsnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVtdV-00000001hxN-2NRy;
	Sat, 06 Jun 2026 16:12:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVtdT-00000001hx9-0zUH;
	Sat, 06 Jun 2026 16:12:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A3F76600AE;
	Sat,  6 Jun 2026 16:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979411F00893;
	Sat,  6 Jun 2026 16:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780762353;
	bh=3WzyYt48G4RQfAKtt5FczP1+tGEO7Yztn+HsGj1d6x4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LZFx/r/wgFyEh7r0VkW0hzkrLcZCGzQoh7wlrQEcP4oQQ8eH9+FucJGz9h6g5VhtE
	 wcAX81orLf6vRq3n1wV0WzoH0cWF9nIPYHRrKc5fDPngfDJV50X2EbKi0uYKuJjT+O
	 /w9HMfhdNCWd3Z1YGQYHtPYnrBetTPo9BKog85Zb5MMIswkLqQmqn664cfQeXR5Wh5
	 31/bSK6ZuwuqQ+NDO0gCjuKMN3LmfleyH3yMITrCX37TSrF/99MyDbKcucA5uc3Hk9
	 AhEhWh1LwZu65s9LL8rhoEpP+9ZKImelmzLXOFTfznxyJPSGyjw54Xsg8ZzKQ1lSz4
	 Y7YlIZY6ogq0w==
Message-ID: <a0b0bea4-998e-4196-a2b0-9fcaf531d9f3@kernel.org>
Date: Sat, 6 Jun 2026 18:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-apple: Prevent tag collision across queues even
 if tag space is shared
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Yuriy Havrylyuk <yhavry@gmail.com>
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260606-prevent-tag-collision-t8015-v1-2-93ccf4eca550@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 06.06.26 15:25, Nick Chan wrote:
> From: Yuriy Havrylyuk <yhavry@gmail.com>
> 
> Apple NVMe controllers require tags of pending commands to not be shared
> across admin and IO queues. However, on Apple A11 without linear SQ, it is
> not possible for either queue to skip over some tags and must go from 0 to
> the configured maximum before wrapping around.
> 
> If a pending command tag is duplicated across queues, the firmware
> crashes with: "duplicate tag error for tag N", with N being the tag.
> 
> Instead of partitioning the tag space, which is not possible without
> linear SQ, 

Isn't that just what the pci.c driver does with NVME_QUIRK_SHARED_TAGS 
for the T2 macs or what we do in this driver with
	if (anv->hw->has_lsq_nvmmu)
		anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
?


Sven


