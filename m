Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FA6C369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lJFA4MFGA7mb+mAAVyzXlK6uUAOD7g4XoMsowQiiWMY=; b=i+V1KRcfIDD7f2tIbBdkQ7BJOo
	7GNCMDhT5O9l+vQoQ6OY3mehOxdIHImWjnPn3KwZCwaY6iqvnQaUwr3LS2T2ceeS2vz9pkccCJXD7
	miSJUvc1E7msAzAOkEVarXDPa9bTUUCfaUh24CYIpa5HBC9mJCxHhYIwCOD5PmcCRwTwfuuatkJR/
	HXcFZ3Woi7tKdokdw6PQUX/Bg7k3WV2XlQ2qiv6TktNzYmZatqim/ckkmURL1m+KLzRug2xmj3yHa
	Oq4RAWRwTXJorf7U9XrP9yIC4z9YZ5kMOWrZ/tZm/xmkdLtY3sdT673ocXvaxIz202qO5nvmttevK
	pF+pAiJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8JkN-0000000HNzx-2vcQ;
	Fri, 25 Apr 2025 14:09:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Ixy-0000000HFob-19lp
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 13:19:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2F6968B05; Fri, 25 Apr 2025 15:19:35 +0200 (CEST)
Date: Fri, 25 Apr 2025 15:19:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>,
	Dhankaran Singh Ajravat <dhankaran@meta.com>
Subject: Re: [PATCH] nvme-pci: fix queue unquiesce check on slot_reset
Message-ID: <20250425131935.GA5460@lst.de>
References: <20250424171801.2300390-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424171801.2300390-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_061942_455395_D8F04CF4 
X-CRM114-Status: GOOD (  11.55  )
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

On Thu, Apr 24, 2025 at 10:18:01AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A zero return means the reset was successfully scheduled. We don't want
> to unquiesce the queues while the reset_work is pending, as that will
> just flush out requeued requests to a failed completion.
> 
> Fixes: 71a5bb153be104 ("nvme: ensure disabling pairs with unquiesce")

Sounds like this code path isn't get teste all the much if this stuck
around for so long..


