Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A344E9D837
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 05:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PAcFX8eV8wz3NdGTpj32GcMrJOpNLknTvCObp5xQB7g=; b=1VJ0suFqv3hsEaq/7hqp4xLenj
	pzb2f+5rzjYwBO0Wh5DOWVLKiMCaDNE0degQJITIpn702FNVhdmrRLoPuaEMU615Yq5CFFpcjf+cO
	5g3rqWLSIRxi2GtJ54ZKnFJDXA/CyBnL0OwNuR9ObMMERR8UuUrnYXXB5QT3+Ktff3GZcLcudO5c5
	aOG9zGsOzB4dXEKR3bpFp1lywIDqi7iRVFl7gDCL9SkxGBVzeS2u7Y7qD5HEoACpDEWu8X/cuQ9/k
	hw5Dya+yOC101v45q7bd7yAIjcdjjKxEPMXSzFmBoWQ6clgbr2YwMWhNLDghuxyVyoET7u6g+p2gO
	6+un0ZNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9ciL-00000004ojm-1RlT;
	Mon, 06 Apr 2026 05:41:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9ciH-00000004oio-2Hmq
	for linux-nvme@lists.infradead.org;
	Mon, 06 Apr 2026 05:41:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D17A868BFE; Mon,  6 Apr 2026 07:41:20 +0200 (CEST)
Date: Mon, 6 Apr 2026 07:41:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shivaji Kant <shivajikant@google.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pranjal Shrivastava <praan@google.com>
Subject: Re: [RFC PATCH v2] nvme: enable PCI P2PDMA support for RDMA
 transport
Message-ID: <20260406054120.GA16443@lst.de>
References: <20260402073001.2039625-1-shivajikant@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402073001.2039625-1-shivajikant@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260405_224129_731493_600314CA 
X-CRM114-Status: GOOD (  13.07  )
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

On Thu, Apr 02, 2026 at 07:30:01AM +0000, Shivaji Kant wrote:
> Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> RDMA controller supports it.

You can use up to 73 characters per line.
> 
> This patch depends on the PCI P2PDMA support added in this
> patch [1].

I don't think it actually does.  To support multi-path capable RDMA
controllers, and those the vast majority, you need the multipath
support.  But for non-multipath capable controllers your patch
just works.  So I'd suggest to drop this paragraph and reference
from the commit log.

Otherwise looks good.


