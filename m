Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEEAC87FC5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ndlNw8V+luZiyIU6ROnJU7vwnvFft9hRh6YVBcFW6I=; b=MXadp17zDpIB8Rc8bhoTJz9zD2
	QGfCqdH/dwn2sLbrkGfolixlpkRHRk5PG/ev9ubE7hTeCMcUKXaTzNPgkj9SDQfo17H18s7yE35hz
	RFEeJMIkoxv8IvO4NiO4brg4OlPbD64lHJ+wJye+/2tttwciITURtnGf3DsdltcKv+VMbvc5l7qdn
	T6SP7IsCrtQ8gPnVuERed2LDEusfdlZ3ev9Y9zoISdbL4mxxpOlOn/TUD5a1fyd2xkbOVui6TqwtO
	/6zltzjGv/PEREP0TT1Np3vNDpzT8aa1dulky3Y00g+ZWZQxgydZIIyaGx/3srbDPL5mWSJNTNZJ8
	M1oLK7xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udl9V-0000000GWHQ-42Sx;
	Mon, 21 Jul 2025 07:41:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udl7f-0000000GW3K-1VEq
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 07:39:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1131B68B05; Mon, 21 Jul 2025 09:39:40 +0200 (CEST)
Date: Mon, 21 Jul 2025 09:39:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, leonro@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 4/7] blk-mq: remove REQ_P2PDMA flag
Message-ID: <20250721073939.GD32034@lst.de>
References: <20250720184040.2402790-1-kbusch@meta.com> <20250720184040.2402790-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720184040.2402790-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_003943_536768_A20DBEDF 
X-CRM114-Status: GOOD (  10.23  )
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

On Sun, Jul 20, 2025 at 11:40:37AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> It's not serving any particular purpose anymore. pci_p2pdma_state()
> already has all the appropriate checks, so the flag isn't guarding
> anything.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


