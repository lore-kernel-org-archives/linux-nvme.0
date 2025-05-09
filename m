Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3B3C3ABC3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 04:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MIfmR1ReUaQ1hWijiBUGEnbISMTlpf/ux4QB3JBZR+M=; b=UcX10alKwIEFEN4Jar15V7tSpO
	xUJHZZT5J29Lost3Ms6n9U5F3961K9UiI64566zAxOIYTzpKaXvyWYnPk3g6xaAoJ8gI1Wmjkbn7J
	S678TVOlWiDwe9YF8uNYrLUOCKA8lKBsmLoG8dQboeLzUP/m7LhOuAB1FU1qzuLdMlOJVjg70DarM
	dpWGPaSCvRdQvjqh2tcE5/bksLFbjIP1YrrVlNn12qMSiBvgbJOJBqMjF/xAYRDYJyk9VdOFN50HW
	IZR3yo/SlZm6yY0yKgoFNuxpKtgho/mMignFPag00sHlZUGJqo4e/tJ5Y0YPpS9LEKUSB4tymVVMH
	fiuQn+Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFDI-00000002Qkl-0z5Q;
	Fri, 09 May 2025 04:19:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDFDF-00000002QkM-36R8
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 04:19:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 816F467373; Fri,  9 May 2025 06:19:49 +0200 (CEST)
Date: Fri, 9 May 2025 06:19:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, hch@lst.de,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] block: always allocate integrity buffer when required
Message-ID: <20250509041949.GA28563@lst.de>
References: <20250508175814.1176459-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508175814.1176459-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_211953_918265_0E46787B 
X-CRM114-Status: GOOD (  12.16  )
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

On Thu, May 08, 2025 at 10:58:14AM -0700, Keith Busch wrote:
> Add a new blk_integrity flag to indicate if the disk format requires an
> integrity buffer. When this flag is set, provide an unchecked buffer if
> the sysfs attributes disabled verify or generation. This fixes the
> following nvme warning:

Do we even need the flag?  I think we could just deduce it from
tag_size < tuple_size, which feels more robust.

Otherwise this looks good to me.


