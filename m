Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B78CD3B7E1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 07:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uqookp7PrXQVHdXz3HrvdmUD2mAD3duX4BEvxt7WGgU=; b=NKvzpXIKbHzhbvBxj3QBGrL6I1
	ULekVNw1Wwjt5KpXpDu75f2QoZrCdeB7jp5YZsOd3faUx1OCpdZ0uIJu/Zfh0DHk2DBz4a3+bCK5x
	m4ac07FVFzdjZB+uIslfq6fjbFJdLkgX1CV1ZivmfRQZ5YlyjwRpaodUCw4Buq/u73Q3hBG5+701A
	QpEPTzEEGYf0nIuh/vkgtdKZfDNBDgeA2j6in7167U+GusoGckDQkAjgHaqwG2q7AV6UonXmykFEv
	dVjIqGeGKVSipypKLRW6Ql9BIuOH3sWdUO0DLkGuLDWVbVTxVrAeamMjUxQvqdWAOLSSMeaznwQBS
	Zy58JwjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTTX-00000007FEu-01NL;
	Mon, 25 Nov 2024 07:25:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTTU-00000007FEQ-1ojI
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 07:25:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB0B968D09; Mon, 25 Nov 2024 08:25:33 +0100 (CET)
Date: Mon, 25 Nov 2024 08:25:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvme-tcp: fix the memleak while create new ctrl
 failed
Message-ID: <20241125072533.GE15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <55fc0f971eccc72b7ff2b2ce176a7faa8828e487.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55fc0f971eccc72b7ff2b2ce176a7faa8828e487.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_232536_610210_E6898B25 
X-CRM114-Status: GOOD (  12.52  )
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

On Sat, Nov 23, 2024 at 09:37:41PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now while we create new ctrl failed, we have not free the
> tagset occupied by admin_q, here try to fix it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

but please add a Fixes tag and move it to the beginning of the series.


