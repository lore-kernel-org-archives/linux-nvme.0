Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731DDCAC5AA
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qw5a7dOPyGOqy/hg+zUPka26R+b1vNOTeTt9G411pq0=; b=De38g00X3eqdHuPi0PsOVokSAO
	F9cwpOuhKhFxiOi6n5j3/wKx0mnhsTAvdidbWjToI2mJoEla4Geo8wSteslh1Hnr3RufTe+uqcTaF
	SxOGrbvXYQnntgWCTuqSa2/4l9D/KqmB3h+WRYuY+nfKtUpYa24y/J/tTSUJ5zw/rIf7JvVhIS6f4
	X+HoGhx4LNrh7Vo0LvSFfQABfQ8RaaqJ0aR/ChWLIu8wWoNpv+Hm16yRwelCEu0s1jukuG+WuUe4e
	MUSp/fwsuNZ4YgV1SIE2tHDAfhS+9YUYAUzzoGtHv6HSCZ42hb2vuleG0wzH3TfBf11Dg97NZbUlX
	IHw5aHxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0n5p-0000000BRQo-3RUX;
	Mon, 22 Sep 2025 20:25:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0n5o-0000000BRPv-3wxG
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 20:25:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 277DA60241;
	Mon, 22 Sep 2025 20:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DCBC4CEF5;
	Mon, 22 Sep 2025 20:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758572699;
	bh=zO7wcZweW0hfUMsG5KPbeixp8NkSspie/DK7GwdcPqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CfNqBSFu3YKIvpW3HK67r9QS+XNzJhf3qQCidNj2qKLlkQXAIAcGvF8/iPZBMBFbr
	 0pHsWb2bm7XYnDLqA8BlCoj7Su1bUHsPTtkKH85kEUOgUdz2zYqWJCmk/p80dqPb9r
	 HSXlNnL4ZZ2gP4kNtZ4RqTrPSL03YVo/TGlK7Tva2kMDBjE1wGadMDN3Wdqxy4Wjy+
	 RPfIfXMq1DOHD0HBFVc74U6dB9bEJfLDqH/1C6C/QVIPjNJ8xqkobEr3p/SLtMxN1F
	 ug3O6Tk+Fmc+EOnfQSxZJ4vN6DTWM+s5dSBVp4NSbDM0g4DtRPqkhP/CCiuPy9nNu8
	 fvpSWSrwmfLMA==
Date: Mon, 22 Sep 2025 14:24:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v2 1/1] nvmet: add safety check for subsys lock
Message-ID: <aNGwmaT7xMsvw_3j@kbusch-mbp>
References: <20250921124405.30432-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921124405.30432-1-mgurtovoy@nvidia.com>
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

On Sun, Sep 21, 2025 at 03:44:05PM +0300, Max Gurtovoy wrote:
> Replace comment about required lock with a lockdep_assert_held()
> check in the following functions:
>  - nvmet_p2pmem_ns_add_p2p()
>  - nvmet_setup_p2p_ns_map()
>  - nvmet_release_p2p_ns_map()
> 
> This ensures the subsystem lock is held at runtime.

Thanks, applied to nvme-6.18.

