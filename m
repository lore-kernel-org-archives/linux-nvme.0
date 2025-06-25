Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03075C77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m5dQzTuvbbtJR8qBze1MieINz4Shsgq0Ke6bwVMXZXc=; b=xDJx8ab1+qyH8lHjjpGn0Zm7mF
	DZXJ+e/q0gTtiOAwvlcHOQlTm6FNP0TWsNK2teZ0UGeVkciaD+7gR0XS7q0GWTqThGlm9NesJ7336
	Le1HdQeefMmpkNsFkzTfoU2rFeJcb1zNRjmawT0/sdAXIHMsjiUmafM+AQf1ZrNPrznwSS9gYC2yn
	8wo6D5lB2QWRl3dewch2SFy+1Nmj9SGrOqq0xVyPviamZE43DlUGJItB7ww1QAINg9c9EYqLXooup
	+BuTjE9I5VHKRDlMlxZ72fvkgLlo4uuY/y+6UbXGe0/3w9m03Xo+hUcEkuyq1YPc8KVK5l/Cd0lhQ
	S1YVhsrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUY7V-0000000A1G3-2hEp;
	Wed, 25 Jun 2025 21:57:29 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUXVe-00000009xBd-2Hzh
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 21:18:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 93B10A52E78;
	Wed, 25 Jun 2025 21:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA48FC4CEEA;
	Wed, 25 Jun 2025 21:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750886301;
	bh=m5dQzTuvbbtJR8qBze1MieINz4Shsgq0Ke6bwVMXZXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvlapTToZQxcbDnOyv9k9jp1u5tVw0L2Q3WnZ6SwsIe0JdvJ4UQetIj1AQVl4Pc7B
	 ZawU90p4NVsBN3VzCwlanCBJI+k29ukaw2GnjrWcRJMCsKzHshDg3pZwgSgprnuDr3
	 TAcfB3NT1ggDzQwv9Xr3FDQxK2I6ed8bcPBba2yed753IB2S0eFR4Hinf15Q7eKC8W
	 sLvOHwa+vvo+mx6dVYh3gKwYCal94jHMbmKON1iIkSX1NTiEnwf5PyJbNnNUw6hEnY
	 jTBBlViOfaOW+QVV2KQy3jFa7qRy6QRt+nHN2iZtncuUb9wnaUGkHp5I7L2VZIdjO7
	 jAuywK4s40VmA==
Date: Wed, 25 Jun 2025 15:18:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, leon@kernel.org, joshi.k@samsung.com,
	sagi@grimberg.me
Subject: Re: [PATCH 2/2] nvme: convert metadata mapping to dma iter
Message-ID: <aFxnm0MX0G7Knzcg@kbusch-mbp>
References: <20250625204445.1802483-1-kbusch@meta.com>
 <20250625204445.1802483-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_141822_649042_D22C1204 
X-CRM114-Status: UNSURE (   8.40  )
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

On Wed, Jun 25, 2025 at 01:44:45PM -0700, Keith Busch wrote:
> Aligns data and metadata to the similar dma mapping scheme and removes
> one more user of the scatter-gather dma mapping.

One thing missing from this patch, it should have removed all the iod
mempool's since we're not using them anymore after this.

