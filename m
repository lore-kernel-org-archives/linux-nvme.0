Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD360C2D0CD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bk7tvwavIclXyCKbFNCKA4xCvwf6Fov0y4cImC+1LRM=; b=cbje+ae76Gl4WtzBvqkR4uAie3
	C2hxxrbH6ItGu2tz2wdYr42jV3VTX3hCWyulCI/K0GREeo3Yaf0T0gXwS7DyavdvsnBf5veHDqMB7
	sTtjVvk1jDgaisNn4dLq/FeIM9UY6QArmXFeSnEiyMp7FDbd0CwKCb7vqzWFdCk2G08rSvkASoT56
	7+TaCH6r7RZ1yz4P+MekVmqLGyLEHluANw5VR27y0jP0O+DNyNao5bXcEyGNQof9pj1uZqAXIxbfr
	EoewOAodZNBb7jNhfEZxTVz6BgV2Zl4uLrb1I0zRzXjb1APBohgfUzLp16rVg0RMW2N/x1dOh0fRK
	8pXQIYWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFd2K-00000001Vgy-1F45;
	Thu, 15 May 2025 18:10:28 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFd2I-00000001VgT-0LY0
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 18:10:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 59223A4E3B9;
	Thu, 15 May 2025 18:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FD6C4CEEB;
	Thu, 15 May 2025 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747332625;
	bh=+q0X30a1JXnygoSjEGexR26gtccDj34Q4azIccOlqBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkYjEZJlZEldthfWrYfv6v7KumXOQyzWyA484sg2McJi61TpH7VaKvV9eFEhRxPeM
	 eK3cEWQXGTPOfBGVwLVKh/m6whN2XGhFzSGzzITRV41sw1ITYLl2VXi/0KHNZ0ULgx
	 E2/jM1xGeiLCssinUabngwJ5wK5AS4dSpfP0PAgjK4LR/hWkqqD0StsisJ0TCQIIZs
	 gxDd8cert5lUrKYN5kziNDdNjZxmf+GaXJucFFVRDeFtChiZKhZrCiaXgjumsE1gya
	 61oYw5kzYHH+SPbhlz3oZMaeyklSSe+DxkpPKA7NKpm8NWvYZmENclBIPFQ5j4lrT7
	 8K3M9QaXSVp4Q==
Date: Thu, 15 May 2025 11:10:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250515181022.GB1411@quark>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250513144018.18770280@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513144018.18770280@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_111026_184053_AED5E486 
X-CRM114-Status: GOOD (  10.45  )
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

On Tue, May 13, 2025 at 02:40:18PM -0700, Jakub Kicinski wrote:
> On Sat, 10 May 2025 17:41:00 -0700 Eric Biggers wrote:
> > I'm proposing that this series be taken through net-next for 6.16, but
> > patch 9 could use an ack from the NVME maintainers.
> 
> And patch 4 from RDMA. Please repost once those were collected and with
> the benchmarks you shared on Andrew's request. From networking PoV this
> looks good.
> -- 
> pw-bot: defer

Thanks.  linux-nvme and linux-rdma are both Cc'ed on this patchset.

- Eric

