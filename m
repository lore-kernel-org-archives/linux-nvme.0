Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F8DFC54E71
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 15:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mva0IcLiubaL9SAQ03ptwyV0HxSLjqpLKCYwAHGj1n0=; b=waGRCzpn7JuRe8E6aJ0XpM4qdt
	hIKnbDH9gPrJwn0/qCPUj+lM8czuAisjXgfa90WvrmxrS0/sSWJJn6pFqNKNGtKKXBNh7dRIXdKIy
	Vh/5OjxQgY5fpC46mqTeGMEwFg85UVHD3oXBIgqWoQCTwSEWbiT3TXonnclcgd4vA2hNAvhx+EhJ5
	JTBYxgFgHIQF0T/3xrzbmyu3M57Z1G6kbp9qISHl/XEt1YA5YmQp+xiwDteKNvDZADspOt9ZbhyDY
	/bipF6i+DIbdeRf2JRPoGC63lsNBheQN2DuB9bsq5xVfZ0+IVcC5w1uHEnMIhxtMOThpKYcQVvEsb
	wURHzgdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOrk-0000000DKtY-07dh;
	Tue, 20 May 2025 15:26:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHOjg-0000000DJ4h-1RFo
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:18:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 039325C56C3;
	Tue, 20 May 2025 15:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A749C4CEEA;
	Tue, 20 May 2025 15:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747754310;
	bh=gOcAH/YL5VciW2jCfOJM+RDZl3zKyoeTRxoKCucXQKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIkvmAtt5TOeMvCDGBbPJgB4JjBBPqqSvNUUZs5g4513rRX5RxJkhlFPLNQkiiSyC
	 kEEBnlMGbFy/UU2efYx4TS3uT1GkmLUB264f5DqVEAa1qu5AO0ZRlBcHoeOMvtBA6A
	 dlCY/nTm3or20KEx0j9YfHik5x+PVGGk4VLjiEfUS3XV41Kx+8Mm28DQSJyEUF+vYJ
	 OZB17ZWCrXlQ1JSY2UVx+PS5QsvjVLI4un1blQBMuTIzblz8vEuUEAWl+bbvgzxDeR
	 +cE1X4cBIWWYk68/zYN0cY9FKSUESNiQcbeSYO/YpWyDDzCytghiSikW029Z+g86CS
	 Ha7+ngUMOWpVw==
Date: Tue, 20 May 2025 08:18:17 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
Message-ID: <20250520151817.GA1249@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20250520131841.GH7435@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520131841.GH7435@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_081832_430296_D9BD4AE9 
X-CRM114-Status: GOOD (  12.72  )
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

On Tue, May 20, 2025 at 04:18:41PM +0300, Leon Romanovsky wrote:
> On Mon, May 19, 2025 at 09:04:04AM +0000, Bernard Metzler wrote:
> > 
> 
> <...>
> 
> > > 
> > 
> > Thanks Eric!
> > Works fine. Correct checksum tested against siw and cxgb4 peers.
> > 
> > Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> 
> This patch should go through RDMA repository, Please resend it.
> 
> Thanks

It depends on patches 1-2, and patches 6-7 depend on this one.  So your proposal
would require that we drag this out over 3 cycles (patches 1-3,5,8-10 in net in
6.16, patch 4 in RDMA in 6.17, patches 6-7 in net in 6.18).  Can we please just
take the whole series through net in 6.16?  There aren't any conflicts.

- Eric

