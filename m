Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFC2CD342F
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=joNNGsTGKudvIiq0ugRZYRBIAVXU6ybvfC5Uo0UrLCE=; b=Aagr7Wew1kLt3omDjmgLbXpzBR
	kN1Me6rEWErQIe3pGYOYiClNg5lYhM9PMrP3Cka+5m94l8fwgCT8lsRT51QZ3QH0wXxvUoJ4hnpKk
	JcLTwxp8DOaODrHhFZ8JjFv04Zi7TzKbixxKWznAjo2BSlTng9y0IHT/F3xeE7bxfn69ZGhqzqhUm
	ANlMFjgZk0TW86LU4OGsBRlNgYwFv14GaBQxr+tXX5E2ZRtHc+KX0urFDwuyb1ravDe6J/Z6cPApx
	wMpU5GHbESddPP1HwKOpg9Q5JkdDnkwaWy7ELBc1xz7ZFKmpe5FU1uV1vjWhqozAOHoUwck22o5n+
	4hSkj6iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLH8R-000000064BN-30wk;
	Fri, 08 May 2026 09:04:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLH8O-0000000649c-10xq
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 09:04:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66EF968BFE; Fri,  8 May 2026 11:04:27 +0200 (CEST)
Date: Fri, 8 May 2026 11:04:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Maurizio Lombardi <mlombard@arkamax.eu>, Chao Shi <coshi036@gmail.com>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
Message-ID: <20260508090427.GA20593@lst.de>
References: <20260428022911.1288485-1-coshi036@gmail.com> <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de> <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu> <afBgs0f8Et3jqijM@kbusch-mbp.client.m3-hotspots.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afBgs0f8Et3jqijM@kbusch-mbp.client.m3-hotspots.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_020436_527307_F5E28B81 
X-CRM114-Status: GOOD (  14.94  )
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

On Tue, Apr 28, 2026 at 08:24:35AM +0100, Keith Busch wrote:
> > This field specifies the timeout value for the Keep Alive feature in
> > milliseconds.  [...]
> > The default value for this field is 0h for NVMe transports that do not require use of the Keep Alive
> > feature (e.g., NVMe over PCIe). For NVMe transports that require use of the Keep Alive feature
> > (e.g., RDMA and TCP), the default value for this field is 1D4C0h "
> > 
> > To me, it sounds like for nvme-pci, keep alive isn't required, but could
> > be activated.
> 
> The spec says the support is subject to the Transport binding
> specification, which does not exist in the PCIe transport spec.

My memories from the fabrics working group back in the day is that we
explicitly intended to support it in PCIe.  The wording in the spec
referring to transport specs I can find is:

The NVMe Transport binding specification for the associated NVMe Transport
defines:

 o the minimum Keep Alive Timeout value, if any;
 o the maximum Keep Alive Timeout value, if any; and
 o if the Keep Alive Timer feature is required to be supported and enabled.

which does not read to me like there is any required language in the
transport spec to require keep alive.

