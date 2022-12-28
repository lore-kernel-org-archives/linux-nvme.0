Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EE6C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 16:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I/QY2nHhU3TsiR2pNU3KT3szDsE0OyIpouyujg4X2wY=; b=nxDHe8SKhBQ8LuhAGtPkM7rBUu
	Y7JO6efgiOd7DsBFBkQUrNaV8azyZ0cIz5RPxt6vQRuQ0FRltNXHUL5u6jTZquqe/EvmJJ8M1Uggg
	HGpSzgd7AzrOXtp1BJEYogkq8NgWo0LTv4bPF1lJj9dTiSvD4KRp8BPNH1PDob/qBXzWW8Dk0ODSW
	PTkhDVtNu6WA4RPnEuUe1UtQnhXFkWYQlVyE4Xy9V3myhNhN3XQwqPZCYrf9EZiZrySAmCP0gYWbb
	oBdEKIycsc2zS0cyuaRhoMJsytU2LiusPX8h0ZPtAe5/YV672bSz4AtltKRFFrf/hxG5m5+zi9aMw
	61bWQntg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAYux-006Ba5-Vb; Wed, 28 Dec 2022 16:04:36 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAYuu-006BXJ-G0
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 16:04:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EB11D61560;
	Wed, 28 Dec 2022 16:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50864C433F0;
	Wed, 28 Dec 2022 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672243471;
	bh=I/QY2nHhU3TsiR2pNU3KT3szDsE0OyIpouyujg4X2wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSP01mQJZlopC2NPErqcqQ5yo1Z1YaiUk2ANRJmXPK0NaQb4bz0Nqetle7WCp0pbK
	 HldnbazNOtpXYk72+JRX2Ui+ufxJVwqj/l6pDMckfLtl7TtRiGbtDgreMqYZQXa3LR
	 3yRuHjJ8Lz7etwaO41eVysg8m2w7VvIqWxShHvuJRCrwxR1TSFNiyP7rsK1v9pvYBh
	 Yk0LiC/70LSaEc7j3vy3TTZn46yNwco2lSTQ+CdQhoYu2QZan5Yh5oW4CgchjbzIyB
	 0Sbiw9AVI5sN+790Vr0GgfBodbFwT7bmfdZ5h+vlf1iYxBlMEvaqJwRSE/lOxSj0RK
	 BrvFWrrpFV+0w==
Date: Wed, 28 Dec 2022 09:04:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: only allow unprivileged passthrough for commands without effects
 v4
Message-ID: <Y6xpDBVGXljBWNsP@kbusch-mbp>
References: <20221223071814.43564-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223071814.43564-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_080432_655538_8E53C52B 
X-CRM114-Status: UNSURE (   8.56  )
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

Series looks good to go.

Reviewed-by: Keith Busch <kbusch@kernel.org>

Unless you're already on it, I'd be happy to take a shot at the
improvements we discussed earlier for the next merge window.

