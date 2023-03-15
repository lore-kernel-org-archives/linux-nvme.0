Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54941C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=ZE5sbtSJU2B+YtIvA71n+OblTw
	MxyjUacG4k+Qf6BLeUPF0uIYQ0evLzUcmQM/y0Egu0ctGadp7sFvB+HH+iVrtg9u7qR0XvJFROIg7
	8RHSSor4DD1D6Kj5wQYzdyGQ+f4TEI/YPSHQ7JcgsByCTrTuwomDtJ6hmo5618XD8p1NHjbvh1cYG
	gRUpC5TOW5vBrb7MhzzTRGtq4/sOaxvMdNZmlOURf0xlrwYc9WYc4fapy1ON6pyvFuFMwl0DWpnMf
	ox4DFdbdoo/Ef8PoXU+JbWHXitHHwNDy7spENyH++ivD5OfleS4lYtAH6sWUpHx2dIwT/8/HX3Tid
	oEnE3aQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRfq-00DXz6-33;
	Wed, 15 Mar 2023 14:00:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRfn-00DXxx-1T
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 14:00:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A374C67373; Wed, 15 Mar 2023 15:00:08 +0100 (CET)
Date: Wed, 15 Mar 2023 15:00:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Philipp Geulen <p.geulen@js-elektronik.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620
Message-ID: <20230315140007.GC26951@lst.de>
References: <20230313101150.18146-1-p.geulen@js-elektronik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313101150.18146-1-p.geulen@js-elektronik.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_070011_636531_B8AE3AF8 
X-CRM114-Status: UNSURE (   8.72  )
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

Thanks,

applied to nvme-6.3.

