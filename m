Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0A3C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8VNUdsmE5iVNHFVkfe71qnoPIFxwWmamZYLBB+qA860=; b=mR+OH3Lu0WS5XP8fi3dg9P9PvW
	LifvkN0k4CNGz4PRL+4przPINtnTEj4AldRb4y8eUo0q0g1/vM5Q/MRDadMG6HuK+EglI9uAHVNPe
	+VCCi13FJnddElDnADYVLGhRi9AOPrxv2ivwjra9mM5Q0auLcZ0rzt/RgeS4coED6XTfkUjFy+6S/
	zQmOWKSPb37LZyMhc7IqSJdK5rFn9Ubgrb4F7jpTuKFVwXSUMmIvfNQLkJPTuA52UatsaPgLoTqNC
	US93yGpOPuFphEN76rUFuzp39hW3HB8cfbD87QCPeRSQmNDbCQ8K/QMd4/AjvQZSXsc8gNepkthXd
	shlvZkFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseYM-00B8M9-GR; Wed, 09 Nov 2022 06:27:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oseY9-00B7zl-Uy; Wed, 09 Nov 2022 06:27:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6BC9C68AFE; Wed,  9 Nov 2022 07:26:57 +0100 (CET)
Date: Wed, 9 Nov 2022 07:26:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 01/12] nvme-pci: don't call nvme_init_ctrl_finish from
 nvme_passthru_end
Message-ID: <20221109062657.GD10528@lst.de>
References: <20221108150252.2123727-1-hch@lst.de> <20221108150252.2123727-2-hch@lst.de> <6f12b92c-a117-9c27-cd67-8c9fd9571a06@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f12b92c-a117-9c27-cd67-8c9fd9571a06@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_222702_161611_3C88B38F 
X-CRM114-Status: GOOD (  15.00  )
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

[note to self: the subject should say nvme instead of nvme-pci]

On Wed, Nov 09, 2022 at 04:55:47AM +0200, Sagi Grimberg wrote:
>> nvme_passthrough_end can race with a reset, so we should not call
>> nvme_init_ctrl_finish from here.  Instead just log that the controller
>> capabilities might have changed.
>
> Can you explain here what is the problem caused by calling this from
> here?

I'll add it to the next version:

 - stores to the cels xarray can race
 - the new opal initialization can race

and in general it just updates random controller fields without
a reset, which I'm worried about hitting completely untested code.

