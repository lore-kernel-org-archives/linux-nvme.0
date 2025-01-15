Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC4BC02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 22:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OqYNcIWQR8FFNKz2xg/NCL6UHqFVPuGhHWZh13eOCC4=; b=GqUNN2m7A7OTGY5mROt4ck0pXx
	lt0UnqPYg42S+dxe8jkQOtGmamZb8mOF9NeMW74cGxAC6VvjJG38b3ABlIg/gEuGF/3ZjOnYEvYyg
	OAK1egiXI1k651zRyiOe59JG62qYyeYRHntcJPbvx7+PrTtO0w5w/R6Ut9Y9u6Q/9G7JO4Ej4J5gt
	WGLgOWCtIuM0pKGFVVH7OXMZKqrB2s45+jKa4EwSeYwSxA7V8gOi1ZuPDSgfjeeY2jCLlyT7vNXuI
	n9t5M2I7dIFqycOEhxYs8c/UFN4JGhTYe/I7dh2d3CLrcxVJmX+ZHy2sqv3m15VMGO3pyzaSPWup6
	r3T+56ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBxV-0000000DFqQ-2y97;
	Wed, 15 Jan 2025 22:33:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYBxT-0000000DFpw-1iEk
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 22:33:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8D8835C53B7;
	Wed, 15 Jan 2025 22:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B238C4CED1;
	Wed, 15 Jan 2025 22:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736980434;
	bh=OqYNcIWQR8FFNKz2xg/NCL6UHqFVPuGhHWZh13eOCC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulMcwpEOxKd7HJfPhR6oMhysgx5wJpsvnOCKbUW8sT6GCabYb2fCnM/S4KxUGw0FQ
	 EsS45A16BDJocBVmJCFUJmSJcTLy4O5VAOC3fvaF0iPebXKGocFLTQe93dgYgx+Q/9
	 RbA//RpPPNkW/TUtT+LqFjkXlJyM0eM6cJw6pMCtW6zRbjpWpZWHnwy0mEqQ5anvvi
	 2VWQTEx0rV0W40q3OWfKIFkIOPT8Hq2+D/3W13MpVbKheliBGsaZUfhngxeDJQzDck
	 2lbGtcKDGdw0/25x0oPjqOdhV7g1h5MjjU0T3B9TEvOZCaKV7M8uM6g2kM4qpYlb4e
	 4SwbDuYluiIXA==
Date: Wed, 15 Jan 2025 15:33:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, dlemoal@kernel.org,
	bvanassche@acm.org
Subject: Re: [PATCH V2] nvmet: fix compilation errors
Message-ID: <Z4g3z8GWgoCQd8Kh@kbusch-mbp>
References: <20250115221703.62861-1-kch@nvidia.com>
 <6ca7f59b-f232-4bf0-984e-a4439e22b9ba@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca7f59b-f232-4bf0-984e-a4439e22b9ba@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_143355_490363_53676CDD 
X-CRM114-Status: UNSURE (   8.27  )
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

On Wed, Jan 15, 2025 at 03:22:05PM -0700, Jens Axboe wrote:
> What is this against? There's been no changes in the nvme tree since I
> pulled it, and it doesn't apply here at all to my for-6.14/block branch.

It looks like its against the merge result of the secure concatenation
series, which as you know has been withdrawn. So this patch isn't
necessary.

