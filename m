Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2987EC54F47
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fr8JPeShHXPfFDLwMg1ZtfV7+Rknd8f+6FTSiLcXSKM=; b=hdd6nOem9IXuzaXrD9l9H1qS9n
	w84HhmbUmBAXeSZ+e7PdwzIWeOAVTvFa7fLFDyFx+17nQ1VxjzLYGxhJB6cfMqoU8324oeoa3mgWY
	AfCzsHnqrmXlzJfqH627UF/xWGG2KlDIPIyTqqjDwYFiGmTZO0SkT/jzoWneRtz9Oqpby3raZgx/V
	eEiR/LhgfjqORYlzmymYVOQZyTWAXYy8EGQ18EDKEI1UADmi1SHS9UaoTpJxYOFlk4zTBUUs2OTvK
	IzD2LophZSmGJX6caR0wpwc2x5L0D+pvdyK3Jhe0UfYOXwPApuaMVj2XxSmZEIr1lZV5UcZyGqvTJ
	G9tGKThw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIS1p-00000003slf-2MKb;
	Fri, 23 May 2025 13:01:37 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRqQ-00000003qzD-3Edr;
	Fri, 23 May 2025 12:49:50 +0000
Date: Fri, 23 May 2025 05:49:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aDBu7i4T4AZ5nBnI@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com>
 <aC6Ymfrn1cZablbE@kbusch-mbp>
 <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
 <aC6oR90OFDSITndh@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC6oR90OFDSITndh@kbusch-mbp>
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

On Wed, May 21, 2025 at 10:29:59PM -0600, Keith Busch wrote:
> On Wed, May 21, 2025 at 08:41:40PM -0700, Caleb Sander Mateos wrote:
> > For the record, that change broke Linux hosts sending DSM commands to
> > our NVMe controller, which was validating that the SGL length exactly
> > matches the number of data bytes implied by the command. I'm sure
> > we're in the minority of NVMe controller vendors in aggressively
> > validating the NVMe command parameters, but it was unfortunate to
> > discover this change in Linux's behavior.
> 
> This is a fabrics target you're talking about? I assume so because pci
> would use PRP for a 4k payload, which doesn't encode transfer lengths.
> All the offending controllers were pci, so maybe we could have
> constrained the DSM over-allocation to that transport if we knew this
> was causing problems for fabrics.

Or constrain the workaround to PRPs which never encode the actual
length anyway (which probably is the source of the bugs).

The fact that NVMe went with this stupid PRP scheme instead of SGLs
still makes me angry..

