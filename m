Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E1BC3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 07:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1KSnxV8E5tXXWxKDGB7gBUeCXSko2BGWxnALWyX/09c=; b=YReKtk14uOZezowJux65j9ctPs
	oWjBrKi+GmhPWn3N3iFWJV1oZyrSqX4QYc99oVN5d+vTOaDIOvkfbS/BB4LluW++5ry0eama+fpQq
	7tXR21sgbbpvoBGgUGgE2RajTdjJbgVqPTdkNKI1Cd6MQ/0085fyT4vSdYcQXnxAIMSuVmSsqkapQ
	sq7rC2al3OnD8i1w24lJrkK8NM30DW37iyep+P4gbhSAMn0xBgDi9mohh9Mf2+q4OyBd65J50HXcB
	vN9XYFvj6CKfVpzosoUpZTZQnEOnzPpJGCg2lbWmr7eMdyFYFoC3WluhqtwzR10dcP6PwyRFAI2gV
	faFbThxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBWU-0000000CTEK-3emn;
	Wed, 28 May 2025 07:48:26 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBVx-0000000CTBu-0Fk5;
	Wed, 28 May 2025 07:47:53 +0000
Date: Wed, 28 May 2025 00:47:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDa_qVKA0uuamxKY@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
 <aDBuQbsBRVjOc5wU@infradead.org>
 <aDB3lSQRLxjDHTSE@kbusch-mbp>
 <aDB6Hdp9ZQ1gX5gr@infradead.org>
 <aDYvjGcswPkbHlR7@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDYvjGcswPkbHlR7@kbusch-mbp>
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

On Tue, May 27, 2025 at 03:33:00PM -0600, Keith Busch wrote:
> >  - copy also needs to be handled by the zoned write plugs
> 
> This is about emulating "copy append" behavior for sequential zones? In
> case it gets split, we can't safely dispatch multiple copy operations
> targeting the same destination zone, right?

No, it's just about ensuring there is no multiple copies outatanding
that the HBA could reorder.  i.e.g just serialization.  The only thing
that should be needed is adding REQ_OP_COPY to the switch statement
in blk_zone_plug_bio and make it go into the blk_zone_wplug_handle_write
case.

