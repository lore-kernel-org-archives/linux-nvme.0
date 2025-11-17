Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA5DCEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 16:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C1nbYL7TWVHeDkdwt0nly5SbQVAFq6MEBCyqm0+Z+x0=; b=tKNL/JlQrKjKIvTczTCd/rfE30
	gxMJf9LYm2K+6YqN3dXyvZDp44Nq/O/h9BSGEPZgtWxkSPjKvTnnUGzoUZ9V+CfbfaHZTBC5EaBVp
	m+5gDUILaanMy4r60Fvo0MitC1Q5wiFPSIi34oCEdaDaH9qmxCz64tTRX/K3EzqWMLHL1l4534chv
	I+IMF627qxl+dD77+3oYFMLxlBBUCJis8WcK3oikeFIWHSyhYAADdkuSSD24yZNXNTM5AkseJ1bUk
	7zk/u3ksHytL10uWvyOo0b4VfTdoTkAOxU4Z0a7CTxerRX6QxaSBmJKw9sD6DESWGHfWihEpIzO+0
	3UgDWMRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL1kF-0000000GN9Y-33Fe;
	Mon, 17 Nov 2025 16:06:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL1kD-0000000GN8s-2Yxj
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 16:06:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AC7F40406;
	Mon, 17 Nov 2025 16:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6CAC113D0;
	Mon, 17 Nov 2025 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395580;
	bh=b5BOGptpiRe/9KC7/lrPlrgkSCv7d74hQqIOtfkcccU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBocGp4o+5KNpR49mo4qUuo4alUCh8x4ZCfazoic0HYPWQFjQJN4nQKTY19EGC2vv
	 coHj3tBNNXe3d/3Ou9tMvnWuGuO7i/3zNjHM9pJy7XnhkRi71O+44wWRA2TwE8sQHY
	 q2Z6lDQ3A0PYb+6UQMJ+0SzcOL0Be90adVnJz4VucQ0kRuKCiOT+3vVJBm8Z7HFpsr
	 7sTni96I6VwvbsdCO8TLJEYnC7CmB+BnvpbfNtp72oJTRzON2fFCzDLu9PbBeX6SHc
	 Enzht9yU7/1GDfdkSVegcYJJUkZEm/fQF/Zziujt2wgHdA7DRx8CPzLWNVN/wZlxg3
	 r49ZgUIOUxW8g==
Date: Mon, 17 Nov 2025 09:06:18 -0700
From: Keith Busch <kbusch@kernel.org>
To: alistair23@gmail.com
Cc: hare@suse.de, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3] nvmet-auth: update sc_c in target host hash
 calculation
Message-ID: <aRtH-hALI2iZB7Ub@kbusch-mbp>
References: <20251106231711.3189836-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106231711.3189836-1-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_080621_665595_3CEE03B7 
X-CRM114-Status: GOOD (  10.64  )
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

On Fri, Nov 07, 2025 at 09:17:11AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host response.
> 
> This breaks secure concat connections with a Linux target as the target
> code wasn't updated at the same time. This patch fixes this by adding a
> new sc_c variable to the host hash calculations.

Thanks, applied to nvme-6.18.

