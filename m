Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4731BFCA16A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2026 18:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rMDT3xt3chDO+X/2d3cdcaDMrE3gn/lQ5Xd6ppqP7to=; b=eQSCjcf3f2fWb7UfEDPgG2yTmb
	CDKCkTtIeRIyJkip3Zhb242jPF1uy8zheIvKXO9BJ6cusqmSdGgw/R+AJ0YB73X2SYC19auqlvyJo
	Jn+syEQD54TlSYRNJiT4V5ej+DzJ1U1rg29Z+Bng8F2wqLDytdR/AUat5B14o6ZU9Au7S2YT2+AFD
	P8U4IrXqQ84xxF9Fh+KA9V9dsaEFw0ZSsvjSaDdqWAVzPfze2loUxN7ee1XXVAxacwXfphqUd+HgA
	4R5AFMHeGNUm5RZpZRdON827cRmaC4Hmg62aI2IsNxJa3boV/eq91zIJ2QcACDxueIWkWCiLDQPB8
	9/BT11kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzf45-00000007sh6-3oza;
	Mon, 09 Mar 2026 18:10:49 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzf44-00000007sgk-1C39
	for linux-nvme@lists.infradead.org;
	Mon, 09 Mar 2026 18:10:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 44FE34070F;
	Mon,  9 Mar 2026 18:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADEAC2BCAF;
	Mon,  9 Mar 2026 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773079847;
	bh=WhckETqNPKHMxehnm56w4T3fFTBC/dfjqWC6vUsBJuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZ0/3kkAidyR8HjNg7KlZV8dE8sTsNB3suGsCEt4H9SCF2oF1wZJ4eSCZTxeeu82l
	 aI18bRihKQqbCnT8qHYNvjkAHNZ0eDkE0t9KGaBadmu2Gn4/FD0nUxpwyZY4mftseo
	 vpEOMs8666dkfLtYUObeO7AbzFhUi/FUUfcBSYxxMPTP1xE6fxTnrxWnoXBDgLXhSG
	 eFMukCMEs9hrTtd4UpI95mYADxDEx03NHdiHwsxu3hQpwHNehSZlgBbilUw4oos8Lr
	 +fQhJdX5yED3g7vF8x8k2V4dhgFyiupoPrHgQFVldA0CuL5W9t0lmHtzi59hCNEzev
	 9bPWZWoG0KCwA==
Date: Mon, 9 Mar 2026 12:10:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Minwoo Im <minwoo.im.dev@gmail.com>, Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix slab-out-of-bounds in nvme_dbbuf_set
Message-ID: <aa8NIy759W9hHsj3@kbusch-mbp>
References: <20260308182059.2415316-2-iam@sung-woo.kim>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260308182059.2415316-2-iam@sung-woo.kim>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_111048_344813_2D0B26A6 
X-CRM114-Status: GOOD (  11.17  )
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

On Sun, Mar 08, 2026 at 02:20:59PM -0400, Sungwoo Kim wrote:
> dev->online_queues is a count incremented in nvme_init_queue.
> Thus, valid indices are 0 through dev->online_queues - 1.
> 
> This patch fixes the loop condition to ensure the index stays
> within the valid range.
> Index 0 is excluded because it is the admin queue.

Thanks, applied with some modifications to the changelog. The commit
subject should start with 'nvme-pci:' for this subsystem, and you can go
to 72 characters before wrapping the commit message.

