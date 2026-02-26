Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB818FD8FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLrO+i9Umf/1eHAiZPbw5v6US9kqRivxOPnXGKSnEZ4=; b=2wK+s09ZdTWsJ9wh9h1jyqfhCK
	y5KpqocUu3euVTLZnDpVfXXCBARzKrCRA8kByj3gr70RuJ3fp9I/5E3uIJ2cEYGjKd9QtzF3qVr62
	hvYeyV10Ly+U/q/Fhf98oOhtcz7OjAPXugenuyXHt3ljHXssr5w7cEXgR/PU9G1f23wBVZL2NpNQI
	RecjnGYeIjMv0jhGAzqFIKtw5TCJfXdSRQQyvx+MSyzJMvuNV7E0KAGvzFpE4v8f3mHOUfUlpwCtH
	T0dHCNhrJxEsa9bGL3RKLXGwfM58t3vkT3RFY/Ym+xbz9CjOMCeh/sSzKDxzAThvw1Hl5cM7DIYq+
	lWWxGWvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdOc-00000006Wae-1xb4;
	Thu, 26 Feb 2026 15:35:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvdOa-00000006WZr-0kYC
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 15:35:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F61E68C4E; Thu, 26 Feb 2026 16:35:18 +0100 (CET)
Date: Thu, 26 Feb 2026 16:35:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvme-multipath: fix leak on try_module_get failure
Message-ID: <20260226153518.GA31615@lst.de>
References: <20260225202109.447144-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225202109.447144-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_073520_367084_36D8DD68 
X-CRM114-Status: GOOD (  12.98  )
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

On Wed, Feb 25, 2026 at 12:21:08PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We need to fall back to the synchronous removal if we can't get a
> reference on the module needed for the deferred removal.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But this should probably have a Fixes tag?


