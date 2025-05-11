Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B45DC3ABCB
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j05ufgCRTBywcfpa2gjsTlesPknyJhWtmE7m1Zcza5k=; b=G6wl5KUTScHHwW+klk78rV1G/W
	s7IVEa1R1Gl98TryKRogDrju/jLoa0MizFyNuOC7cw1EdtRv6gwD/Hp+gZdzZ/dFQwvlhPpg1YhJg
	r6WFJKZ7caQDpPjnpa+64nmZQk0Lap4jWKLusT2/te1wRdh1oDDUo/oB8sbZ5V7fe9jLOB9iTLNOA
	Jh/3wo2rAs7rDJktNs9w6K+RhO+B4NBkbIY28ye5gdSfO4U4qNbZMPnoGy4fiAaDw9N2iTavFL1XX
	WoxoH+bLi9uQaAJOjIjhxgpYyo1kLp/MqZG82LES9FZX757roEmlWVHWwSDgV1Qn6UgXW8TmFh+u/
	DtWYD34A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uE9ZQ-00000007Vq5-24P4;
	Sun, 11 May 2025 16:30:32 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uE9ZN-00000007Vpc-3rmf
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 16:30:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j05ufgCRTBywcfpa2gjsTlesPknyJhWtmE7m1Zcza5k=; b=jUFhMOOpXtt4/9SFb4okUCh1DI
	Z70wp1ljdZM3lK26U+VSa+gVeAfy9DN6IF7iNsK9Nlqrbl2fAOZEO85v6DXslIPQN0udj+AkT6eiv
	CWDhFneAVMLgpmaYSxaxXDQoyW/E9Bz2Iygeuf4BzPyAbM5LeOmYCGbeHJSi16BsrKVI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uE9ZJ-00CGFF-El; Sun, 11 May 2025 18:30:25 +0200
Date: Sun, 11 May 2025 18:30:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
References: <20250511004110.145171-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_093029_958942_BC14C062 
X-CRM114-Status: UNSURE (   6.60  )
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

On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> Update networking code that computes the CRC32C of packets to just call
> crc32c() without unnecessary abstraction layers.  The result is faster
> and simpler code.

Hi Eric

Do you have some benchmarks for these changes?

	Andrew

