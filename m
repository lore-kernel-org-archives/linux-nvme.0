Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E75D3B7E3
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 07:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OadlEV0TMkE39+P9+jq4mMzu/vXpex1iZ1Fpu+hCu6k=; b=NABhi3cl4rkJcggdtL/DaYH2tf
	HtLoUpsqydO0penRQMsxqp66drxtzFyxizm21t/VeXHf7DtnQrIhBaYBZjLsA6Bssjq3lU4bYxQGc
	2vc4OmxWCNJgP6ykWk/74f0X4BBfZuZ258E16cXjwV9t/Uud3OczbEHPqirir67LYdTc+2Z8IqwAG
	+ds10GVqa4NIkJBMC0Lpdibtkw01T9lqsvbzzmpGEKNWAgTsTvEfWtF+A6opU71uIWYe9v45wN3hZ
	/uEgCDjR8rViJ+mWEgTG5Ce6cYsBq46Bd+XkKoc3ofvb8f/qUh6Jbjdh1PH1grb7lU4rNLrEIFi5e
	MrL4riPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTS1-00000007EzN-15dH;
	Mon, 25 Nov 2024 07:24:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTRy-00000007EyK-3WJZ
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 07:24:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54DF668D09; Mon, 25 Nov 2024 08:24:00 +0100 (CET)
Date: Mon, 25 Nov 2024 08:24:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Message-ID: <20241125072400.GD15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_232403_016498_9BE79B7D 
X-CRM114-Status: GOOD (  12.12  )
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

On Sat, Nov 23, 2024 at 09:37:40PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now maybe we can remove nvme_tcp_destroy_io_queues() to simplify
> the code and avoid unnecessary call of nvme_tcp_stop_io_queues().

Please split the behavior change from the cleanup, and explain why
the behavior change is fine and desirable.


