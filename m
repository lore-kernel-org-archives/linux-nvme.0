Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720C9606D81E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wqRsDMUw;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EL3/zERs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xfM3oTZbA9GZfIiLkeTZfWkJk5oDQ4tBo9T8XwJOZPU=; b=wqRsDMUwWxjcR+PZlyJ6PRW19/
	oyTO5TGF2FuT2Rn1S3R4DEMc4qH1uH+ZDqDnuk/CEK+U/YSLxE4saAU5mX0Q/xyoIWhHYBiE4rO9x
	+XK88u8CZsk8juk0NQ3VLMa7avp7enXpdUeF8CZy7Dyq/wFX35zJBidaX1L+6/qewyAhvuiBlfeOh
	opnYZ+V4Lgvg/Tr3R36SIBNWOH0ATOUcwUJaksnyEr9SZF6PC/SqUmXLy57/VJGD/bgIyNvRqvt2o
	tAxB4R12+zkVHIENQshdbbpz6+JmyZKQcme97M6/N24bYiNePm1pTb+PXrjnJdW1kk0mlpQMcJbs5
	f4CorwqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP56d-0000000Akbr-3FDs;
	Thu, 05 Nov 2026 21:34:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP56d-0000000AkbV-0QyZ
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 21:34:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4525F605D7;
	Thu,  5 Nov 2026 21:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896461F008A3;
	Thu,  5 Nov 2026 21:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914486;
	bh=xfM3oTZbA9GZfIiLkeTZfWkJk5oDQ4tBo9T8XwJOZPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EL3/zERsH+cbk7IV/pDuFDuqpTebsPKLJGaF5sFwfHJ2pqeVL98PBgNHgWNyA84u/
	 ECLQx00rP21PC3k2HGylRrt7lO0S6DluhRxAS+z9wYF0qMl4mGLKyAf/WMRv7VcLUS
	 n9RUd/Qv92d924lZUTbrtjeRSw1vlasbgnYveeTzeDEFcFyEJhg+X+m96p9sFJYq77
	 y5Tbn7sPUBKGk2eB1KMVHCZ9phZtsQwN9V9xOLTNRM7a3ApQyE4G+6jQcBgQcJkB4n
	 T/5LUXvkwtzW0808JaKfNJ/uukppKrBy+VksxTsQCYbyOFSTIpsg+FkPpoUgoxMRTV
	 oCAYZbG9eqZ4w==
Date: Thu, 5 Nov 2026 14:34:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, tglx@kernel.org, bhelgaas@google.com,
	maz@kernel.org, lrizzo@google.com, hch@lst.de,
	changfengnan@bytedance.com, namjain@linux.microsoft.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI/MSI: Implement irq_mask_noflush() for MSI-x
Message-ID: <auz2dGjVIBgiMNBS@kbusch-mbp>
References: <20261105182706.3700908-3-kbusch@meta.com>
 <20261105194116.GA1553387@bhelgaas>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105194116.GA1553387@bhelgaas>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 01:41:16PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 05, 2026 at 10:27:06AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Skip the read-back that flushes the MSI-x mask write. Parent domains
> > that mask on behalf of PCI/MSI keep using their own irq_mask().
> 
> When you respin it,
> 
> s/MSI-x/MSI-X/ to match spec usage

Oh, sorry, the messages crosses on the wire so the v2 retains the MSI-x
syntax. I can respin it, but don't want to rapid fire another version.

