Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC5BCD6E55
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2026 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FoREvyDOk6vrpXisJB5b46mzFPhGv4BXyP5ttXjU7B4=; b=kqG18bphsyp6qDqOOjzVXOlZwL
	FLf2uC1zyUoCwDlFa+C2/8TBf+hKISUU3M9DIkw5LgH3VKBH/AxAzVnBXtEfipBPVbgzc07kgKB4G
	aYQb9GW8ri6FDgIU8wXeWlwUGhWqo+2QZ+aPZROAO1dVQkdQ+ohyS9Qu6GtCg6wY/XNVHjIDc88pF
	nXyjV2bx4YYviYVwxkuITqscue7gz22xNYiQwfbb41Cv5XTUO3jkBbphyyTw7BIZDRwFDLtYEY9y/
	f3toVYUkUnTuRR7w/zVws/J9kSaPm5iwZscq/JerBsjdXb11QQYPZ7xaAElbvAV6GqZfuYWT4d2eM
	Mkj69gTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUi7E-0000000EjPu-26EQ;
	Wed, 03 Jun 2026 09:42:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUi7D-0000000EjPf-3rz2
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jun 2026 09:42:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EDDE26008A;
	Wed,  3 Jun 2026 09:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D41D1F00893;
	Wed,  3 Jun 2026 09:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780479742;
	bh=FoREvyDOk6vrpXisJB5b46mzFPhGv4BXyP5ttXjU7B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fXcVOwdDp62maIsBSWn3OaoD/wly6yOpV0Kll/jT60KBPRG+CmGkoSWKbDd9ndqGL
	 9IgBjLxYPcpOStOADgAZEekzbkGpA3FzCiyBBb0JKeHhw5WTQ4sKy0uM8VjlxwSUwj
	 8Y1wXf65UR1QtP47XjK1NizvI6hRHRrx9qATN18+s5ajmwx5+TL7kaW+chn2/bvjUA
	 ym5Hzi4VfnPzbu0qUyUhmly19dreGFOeF1qi0XMzzPCBbIDAiUhvEn1qmZFgzYXzzv
	 gfsbrhA0V9HKHAZirI7FZQ9mdTqhN+/foxm5fYzaqiT7c4fpgsK4hHMx10s7Psdas+
	 cv0ZkHkMw9dDQ==
Date: Wed, 3 Jun 2026 10:42:16 +0100
From: Keith Busch <kbusch@kernel.org>
To: liuxixin <gliuxen@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, nj.shetty@samsung.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] nvme: validate FDP configuration descriptor sizes
Message-ID: <ah_2-OabJ4VNOYeE@kbusch-mbp>
References: <20260527133205.GA12042@lst.de>
 <cover.1779930057.git.gliuxen@gmail.com>
 <cover.1748418000.git.gliuxen@gmail.com>
 <b2f3e4d5c6b7a8901bcdef2345678901bcdef234.1748418000.git.gliuxen@gmail.com>
 <ah7KRIl3LNsbWLO4@kbusch-mbp>
 <cover.1748841600.git.gliuxen@gmail.com>
 <e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f.1748841600.git.gliuxen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f.1748841600.git.gliuxen@gmail.com>
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

On Tue, Jun 02, 2026 at 10:00:01PM +0800, liuxixin wrote:
> Validate descriptor sizes while walking the FDP configurations log so
> dsze == 0 or a descriptor past the log end cannot cause unbounded
> iteration or reads past the buffer.

Thanks, applied to nvme-7.2.

