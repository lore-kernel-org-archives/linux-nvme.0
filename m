Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCF1C83F07
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jul 2025 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OkGWukTawOKjcMpM/H2nYyxZVkEP9zx+EAwcXCayvQg=; b=kh/9QriNZwKxDc4uUR/H8L5R1G
	axkQvZM1dPFwotm/TtKY0ZRxcBciu/RArveJ7UtsFZ087vv7MJA8rIOZFvuIZNWtHKS/aXqrM4Ul6
	2inT+vaCOJn7HPi+CNUJZUBQiL+gTMulIQdSGDAvFqY147Ri/+HtKbSHA+/xMEmxnfNnezimjbJL3
	DTmgvnBq6MfyeEIsjCnj5+ZHbgM0jJMGCpsJFeYxFqEA0GEFlYt7MyR77BUlVOUelNZRvzaZH0BCs
	j/fl0BTJwo1y5yf8IODEpc0yiChjSdhuqNQY/cui42pz6AVRZ/AHfJuwQETCaG6Rz44oJDBZuP8RO
	FmJE5SkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnLc-00000002n6Z-3wut;
	Mon, 07 Jul 2025 15:01:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uYnLT-00000002mzn-14m1
	for linux-nvme@lists.infradead.org;
	Mon, 07 Jul 2025 15:01:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B54C68C7B; Mon,  7 Jul 2025 17:01:17 +0200 (CEST)
Date: Mon, 7 Jul 2025 17:01:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	ben.copeland@linaro.org, leon@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix dma unmapping when using PRPs and not
 using the IOVA mapping
Message-ID: <20250707150116.GA1939@lst.de>
References: <20250707125223.3022531-1-hch@lst.de> <aGvZ5Xk5L66sNWJL@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGvZ5Xk5L66sNWJL@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250707_080127_450932_42CA150A 
X-CRM114-Status: GOOD (  17.78  )
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

On Mon, Jul 07, 2025 at 08:29:57AM -0600, Keith Busch wrote:
> Given it works fine for SGL, how do you feel about unconditionally
> creating an NVMe SGL, and then call some "nvme_sgl_to_prp()" helper only
> when needed? This means we only have one teardown path that matches the
> setup.

I briefly thought about it and discard it because:

  1) I thought it was too complex
  2) the need to allocate relatively expensive data dma coherent
     memory for something that is never DMAed to.

> This is something I hacked up over the weekend. It's only lightly
> tested, and I know there's a bug somewhere here with the chainging, but
> it's a start.

This looks a lot less complex than I feared.  I still don't think having
to allocate DMA memory for storing the ranges is all that great, mostly
because this is exactly the path we're going to hit for non-coherent
attachment where the DMA coherent memory will have a performance impact
because it is marked uncachable.


