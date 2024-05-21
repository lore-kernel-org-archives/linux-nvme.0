Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B05C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4z6FeJXe6g6fXhoAGy2VwB+toIrgERvgu8IX/nlkTbQ=; b=z4y6NWmh5e7yiToWmOcRFR0Vox
	BOtAC2mhmK9hRbsXYPyOU9XHY0xEEHJMPt6lUvP8zNTSm4leZ22Q7z+5dYeTnKvoZwQsEBCd2nRa6
	zCWoHdO39gUKuGQgT0k90t8m7NmMduy1UjuY12KT6OfXVyncTPC/PS0z4Clw2KIp/vBqWCpRI3NJi
	ygvBksMYOwN0tR8PlxMoc9QfgKnrkxOuiU929/dmZiOG4U21q+OyHncRFmlkWWwFoA7vcCFFr1kdd
	6FXmAy/tRV5qzVEEseVNFIP+2GugsVJjqE4NdxdDDZ/HPsQ9DT+N2g8+Qx7OvvmE9UNam4aYPqkde
	+oieq3rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Udt-00000000qFQ-0we5;
	Tue, 21 May 2024 18:55:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Udq-00000000qEk-0LHO
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 18:55:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A4B06242A;
	Tue, 21 May 2024 18:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F92C2BD11;
	Tue, 21 May 2024 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716317716;
	bh=uk2LQmJPFB3Q356VQEBG6xKscGLEEpDsQ6bIXvufMGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/To3eqNkCQ6uUQ4oDAHJRNW7I1rpB1BHbR329uyFQL+YP0KY7YtUCrda3YwciwF8
	 swlfDONq5oUzB18cnovMoS5grl9GAnofF3rOFgPRiJyaoWySvHpMyddb5Zl7GcYkon
	 1tFLVeY8+tv67ghTddo3g6CuO9IYBiI00nU3VxJCj6IeN0tc5ONKV8Wa3vYdKve1hd
	 xDJ2k/941lBfH6P6em89597cJm2qS2QTTI6H4a539iNUpIEH3RNW4xNRao7UnD6PVe
	 94Crnu6aUz3kuVa2I4Xk8ugLM+XqxJUX5/tNeFaLtZpUEb4WGuEk8CVhkVntcyua37
	 g/FOM1jV24bbw==
Date: Tue, 21 May 2024 12:55:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, nilay@linux.ibm.com
Subject: Re: [PATCH] nvme-multipath: fix io accounting on failover
Message-ID: <ZkzuEWLJws9yQy2C@kbusch-mbp.dhcp.thefacebook.com>
References: <20240521180712.2423165-1-kbusch@meta.com>
 <7fd93488-2c3c-472a-8560-7359b07c3870@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fd93488-2c3c-472a-8560-7359b07c3870@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_115518_186955_E21A8756 
X-CRM114-Status: GOOD (  10.50  )
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

On Tue, May 21, 2024 at 02:35:44PM -0400, John Meneghini wrote:
> Awesome. I've noticed that there is an iostat bug lurking someplace during
> my many days of io policy testing these last two weeks. I'll add this patch
> to my test build and let you know if it fixes the problem!

I was testing CMIC capable PCI devices. The nvme-pci driver is currently
the only one batching completions, and that had a different multipath
accounting bug. I had to fix that before I could validate this patch,
and this one has a dependency on that first fix, which is here:

  https://lore.kernel.org/linux-nvme/20240521170537.2029233-1-kbusch@meta.com/T/#u

