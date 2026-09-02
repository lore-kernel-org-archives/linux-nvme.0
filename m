Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF29C624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ug5DRSiuwcvphkzISJgKVkViXapq6RtvUaKRTqCOjNM=; b=bpdiQERRfGEvdgVLUv7ykQ7kF0
	UolduJusAL/V+ndecPojHHyK1qw+gCdQZWuugOjc30k8OtaQKURcnMjWCXhQLiCP03GAo7QNixZD5
	dWkWc4O4mw0D3hcxBqZXrnsB8ngEjE7736/gTyLKr/RkS02NdvUt+po/FQwv5eoD1r1bDpaIJytrn
	P3/K0oeAS+fCWAGupTbDeh0BRBgrpZZRPRygcWMSRCcsnKTXi1qRfpS6HXAWhqPVM+d90yom6e/2i
	T3EpZQ6xz5e4IhxtN51U7ZEDemaFOHAJj/ImIVnVTdHT3zdtMAvmgY87dd6u50ofPDlLhEJy+QQSh
	DFDeJsEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1l3g-0000000EoRq-2LQa;
	Wed, 02 Sep 2026 13:31:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1l3Z-0000000EoPL-3cUi
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:31:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 004466732A; Wed,  2 Sep 2026 15:31:04 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:31:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
	hch@lst.de, axboe@fb.com, john.g.garry@oracle.com,
	wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
Message-ID: <20260902133104.GA20945@lst.de>
References: <20260831152006.819471-1-nilay@linux.ibm.com> <20260831152006.819471-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831152006.819471-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_063114_048578_5FF2D2B9 
X-CRM114-Status: GOOD (  15.22  )
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

On Mon, Aug 31, 2026 at 08:49:54PM +0530, Nilay Shroff wrote:
> When a user opens an NVMe multipath head node, we take a reference to
> the head node, but this does not prevent the transport module backing
> its paths from being unloaded. This can result in the multipath head
> remaining open while its underlying transport module is unloaded.

Which makes sense.  Different paths can use different transports, but
even when all paths go away, the head can stick around.

> Fix this by taking a reference to the transport module for each active
> path when the multipath head node is opened. Keep track of the number
> of active head node openers so that dynamically added paths acquire the
> same number of transport module references.

I'm not sure this is correct.  Unloading the layer below should be
just fine.

What practical problem do you want to solve with this?


