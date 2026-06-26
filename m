Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B26CD4F26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 04:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dlYDuPOUIP5Fm/6XAmo0jwWCwPvSjNhrx8uDJ0U/ccs=; b=MJK71KWKoOFX6MIqLyR8edc/6e
	S476G50YmykbJ8Zn/gUPEYk6s3PTyfNaZ1Hs2vB9hxvNd4lBb8GtWzLDUM05lkKFpK9v8fLnsyeE7
	NXVzoXzi4sWS6KlRUBzGS3teQc56douQW8mEUGLzKk1hGbJtRFg9VsH47njVxHInwkSiS8X88XwV1
	ZJ8vnDXnhZE/+FKi2SekekV668F8zI3DUo+tb7ov+rPgBbMhNKHovsy0TXjDldeO/xT+/QjIqHS+C
	SApXO9B1bujVyrXaGbaLjeo0A9uagzgB54+RYWwSUvQ14iEYLLUk9vjqdU9acGObzEz9PXRmbsj6a
	BwxNK5Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcy5m-0000000AT3J-2IXl;
	Fri, 26 Jun 2026 04:23:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcy5j-0000000AT2v-2cAj
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 04:23:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66F5568B05; Fri, 26 Jun 2026 06:22:52 +0200 (CEST)
Date: Fri, 26 Jun 2026 06:22:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, Vitaly Vul <vitaly.vul@partner.samsung.com>
Subject: Re: [PATCH] mempool: optimize mempool resizing
Message-ID: <20260626042252.GA7997@lst.de>
References: <20260625194915.387663-1-vitaly.wool@konsulko.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625194915.387663-1-vitaly.wool@konsulko.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_212259_811993_673C3A76 
X-CRM114-Status: GOOD (  13.61  )
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

On Thu, Jun 25, 2026 at 09:49:15PM +0200, Vitaly Wool wrote:
> From: Vitaly Vul <vitaly.vul@partner.samsung.com>
> 
> Resizing mempool to a bigger size currently requires a new allocation and a
> data copy to a new larger elements array which doesn't go well with the
> idea of having a fast and deadlock free memory allocations during exreme VM
> load.

mempool_resize already is a very rare operations, and none of the
existing callers knowns the upper bound.  

So what is the use case of doing this under predictable I/O load
where we can't stay at the old pool size?

And if you care about it, why don't you size the mempool to the max
from the start?

