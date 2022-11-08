Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CF8C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 15:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0z7ojg2bOYUFaJvnVY6Dwx2Zi3D0RXrhMvdv/LTVeec=; b=JPfjcIjsdeBHQIeYTG5ZMOVUKL
	5y4dgRcro2X9GsjgKaP0Ntwr3kgI59MHl5h9FPHiw58SaY1zLlOC7DLlqEV6oIknq3ptuhM6otHoa
	p63IEtOt39w+dcGxonGfrDhL73OOZ1iaINYMCZMxmNO6YW2yowKgVohXg3zRY++gg9j14vLlRvGR3
	EzYzuU0V4aiovnrZg5Xc7UF+cy2ObNbSJPwu0vblS1kmtVaSB0QshZm7xJmKcb3vQCoX/ph5S0u1x
	EC3glKFJcIFUnQHE3RY6pfi6CB75B1SU0yl5tAsQ8WM6yU8vqyVYt6kbdrafaH9hvP1MpF/zz7pqK
	9mWB6X6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQnn-006Tu7-Es; Tue, 08 Nov 2022 15:46:15 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQnh-006TtL-HY
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 15:46:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0C4A3B81B4D;
	Tue,  8 Nov 2022 15:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA77C433C1;
	Tue,  8 Nov 2022 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667922366;
	bh=DZsjrJI0/NXHowKMtK9SYTyubsi9Lc1SR872ceeBNU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqxQDRy5bGuQgAuXXCGJcdX85KKTp8Q8RzXYVTmmQpXCz7DjZXcaqcG0JAXIUznMa
	 eBtdRyLhgzsCcKhw0n+gfMiVN0E9GxzILMJD6f3BNJ0Cbn15NFsexe8HAB5o67cHZf
	 DxzJpycPhig+vI5bADAn5MSoYKTZDmhu/850Isz8/phlCgeQ1lkio0FMvDeiL5zA5a
	 ClUOW8u08P0BvMBLLa1sx70MMAFDyy/4xNCV6+e4tkL1D3cNogZfsInooH1B04pcFs
	 vj/8IZGkIY99oO8efAlllg0wdmebiSvYmp/yQ04VolzXFWvTOk4fAQPjsKkuote4mo
	 uY7i/cUlQudmQ==
Date: Tue, 8 Nov 2022 08:46:03 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Message-ID: <Y2p5u8N+Hou/5v53@kbusch-mbp>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
 <7a14c467-e67e-eede-4ebc-d8105cc3bcd5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a14c467-e67e-eede-4ebc-d8105cc3bcd5@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_074609_742734_3FAF2943 
X-CRM114-Status: GOOD (  12.60  )
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

On Tue, Nov 08, 2022 at 03:50:33AM +0000, Chaitanya Kulkarni wrote:
> On 11/7/22 09:28, Gerd Bayer wrote:
> 
> > We believe this to be a race-condition somewhere, since this sequence does not produce the panic
> > when executed interactively.
> > 
> 
> You can try and bisect the code to point out at exact commit.

Bisect doesn't work without a known good commit point.

