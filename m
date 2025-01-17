Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65138C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 19:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4Z+vJuKnU4GlEOjyqrEx84mvHpKtInDLQXPsH5ObNA=; b=XudpK0HZ+q3akj7m966vr6ggJD
	JF2JxrFEQQRkWZ4Q0/ULVeyHgUKWbNAKsjuvnh7l+z94GcNXG5DvgODoxfq/p3C3sx/ukhUjQ47rk
	jy0YNLHkTUTLBFOqTrqbJiLNUvWuEagHxRzCfiao5Ho1rV95SUiRRj2lt4DGenUKXC0iW7PDudVDT
	NJp4pxWhB55OCsQCg59qF9IUGO/DOaUazuP2JokmQ99iBVJt4/0ZaxXkXyPhNBonE0NkQRMCw72IX
	TzFPrTRdUxis6rOTujjTDsuAMmLxntfNqHZmzG4BYkhLvrTkuNq8IbnCyjcrx53HPkAeK1EcB5f2i
	7BSJwvSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYrwI-00000001EFU-3jwU;
	Fri, 17 Jan 2025 19:23:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYrvn-00000001EAv-3Gc3
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 19:23:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 33D815C63FB;
	Fri, 17 Jan 2025 19:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D826DC4CEDD;
	Fri, 17 Jan 2025 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737141778;
	bh=e7GcBqFlxXe3uIjaNFw7sK4kENoaY0vZMP9aXtDbxSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQ6aMNuiYRrWYt/vigGP5KCv8tRP7RznN3eYHvZziELsXXDEMLdrPP5k0fY3ZBqmz
	 ne89KNAfE5xGRE3Ae/OwULRA7BFO5/lVOtmpd4XFJC5VaTr/QJBdQqwn4ZhtfTWEII
	 u2VJ0HtajOPLf1K3aCQ2KhQwjbBZhQLYPbXaGVVhhirwuVpmi84FbvKDI8AkKN6xu/
	 fx0YWyIDw1ChJAYCPfY4Lo7w4ZZT7SvIEeQ7ZaIp1RRQAfwaYipDD3TL7jc47s7FCW
	 C0rSRBTU/I5vVuurfWTq37L7EzPAQBKApCFJ4Qlk1Hu2rqGFUzjdF7MWQ2E0kF4VS5
	 m21yl7vnnLyVg==
Date: Fri, 17 Jan 2025 12:22:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: francis.p@samsung.com
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com,
	d.palani@samsung.com, sathya.m@samsung.com
Subject: Re: [PATCH] nvme-pci: remove redundant dma frees in hmb
Message-ID: <Z4quEDL5kKfEMDA-@kbusch-mbp>
References: <CGME20250117050925epcas5p1ef46267e6d7dc83ea9d0aa51af934921@epcas5p1.samsung.com>
 <20250116234209.51347-1-francis.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116234209.51347-1-francis.p@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_112259_878600_8B1CE9DD 
X-CRM114-Status: UNSURE (   7.85  )
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

On Fri, Jan 17, 2025 at 05:12:09AM +0530, francis.p@samsung.com wrote:
> From: Francis Pravin <francis.p@samsung.com>
> 
> The value of size is 0 when there is no dma buffer allocated. The value
> of i also remains 0. So, no need to free the dma buffer in out_free_bufs.
> Hence, remove the redundant dma frees.

THanks, applied to nvme-6.14.

