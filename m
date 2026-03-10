Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F3DEB105A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 14:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GOP/hOYafpu6PlKBqAfnruTjFGMJLr2fvFuUOLKXkX4=; b=2HPsYS2SXd97Y4XTpjHlVnKSCg
	3zVPslKAHc2qbhUbWq0M0OpVSBXt8VbK2JfQwsWHGoY5Bx6uiWLmIaJtXhpEz0iMCOswvmdYINQk7
	QXd7GColwPCpO8u74baMRNbmff47T/iE1D1/GbpMMPetWG0Ort8ZCI9Hc9/Eqq1zY848cjmliCV4E
	1sP4xHnpD4/yXnKmsET8Ovdtz/7Hh0Tafmw7vFOJidJ1sPa6E20DAvcE2Yy6zT8uEpMa89Tj9vTca
	RVvqiToz1485ICok+hNVLoUv9QY5qOkZMXACRGG4z6dZdjInI8H0hLsa6d7uTXZ0du00AWg4bVpTy
	KS4Eo+wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzyOA-00000009jFm-31tr;
	Tue, 10 Mar 2026 14:48:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzyO9-00000009jFT-0DBB
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 14:48:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 697A6402C9;
	Tue, 10 Mar 2026 14:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A7C19423;
	Tue, 10 Mar 2026 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773154128;
	bh=GOP/hOYafpu6PlKBqAfnruTjFGMJLr2fvFuUOLKXkX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPgiybm7vPguv1pxX5lCJU+ZRCMHMgM4rW8BCePv+jZ1xDgVi/iqjFv57C4bQdb4I
	 jKfqH04Ny50GrbCEcIjbkIzgFyUiqtv5Xm8DqM2zGtF6hDT3hT0BfwGwAY9XzK+ASA
	 uIAUcMtGIhJ44BfTV2qe/x2Hqy2FrmZoVnpOeCZ7IZpmfRd6QfHNAlW6Yu0uE2QG/5
	 v/Wt91pil/WX4vf0UjYvXn5uTtRUQCSS5fhl0qBfB1K2x30gX9QQdi3qirZTzQ2+/i
	 XYgQAoj7DOVifnzOImgKO8U0KbuAZ8JdZu5pckk4gPNv3kf5UggDsuNNMtQ2+t0WLN
	 le70mo+DUB17A==
Date: Tue, 10 Mar 2026 08:48:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme: Annotate struct nvme_dhchap_key with __counted_by
Message-ID: <abAvTZ-PC8zE6Tbj@kbusch-mbp>
References: <20260303213102.86585-1-thorsten.blum@linux.dev>
 <20260310142049.GA10134@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310142049.GA10134@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_074849_126142_DF6A423A 
X-CRM114-Status: UNSURE (   9.05  )
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

On Tue, Mar 10, 2026 at 03:20:49PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 10:31:01PM +0100, Thorsten Blum wrote:
> > Add the __counted_by() compiler attribute to the flexible array member
> > 'key' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.

Thanks, applied.

