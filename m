Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F69C636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 16:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaqDnWHWADLQrnj+HwK+l3tPnjDqZid49DlSOoJbSD4=; b=QzBCb90DOSobxP0Vu1rSwRxBHJ
	zBMnmIPegkJJlNHF/8W+uyXgooYlLhzFTKbnnpwJwAv+Xr9g9jdYa2otHOvZ9w4so1d3atqGlcSgZ
	N62DKcwyP6qUxC9hLwOFTqkgS+mmAfZtWZV5CS8vfjVuikIgStIBCQRFUgbN15eb+DFdWICEG/bjj
	PocQeKTzk6cbXxkw16xI1lZBvYH9QzjiGI/AFh3e+b9iPFgQdLqVRAnq0o/xcy55ud3YAYlUSl2Zl
	vcbO7jeMW50tSn0SWNLdA268XxHAKgo3gFkbrSeBuu8NuGwmz/FjMQKJ5oKqtcSXLSYGu2i+1CGTP
	zwbojaRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRc9K-00FbFA-Q1; Mon, 13 Feb 2023 16:57:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRc9H-00FbEO-Il
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 16:57:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E8221611E3;
	Mon, 13 Feb 2023 16:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD930C433D2;
	Mon, 13 Feb 2023 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676307470;
	bh=UR7BLhxzxj6i6OmgbH5PXqLQzCAqASbsiOTn+MKHOB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtkoZIf84NYDce1SvfhrWZlg6JgdiM/Mh+zRfdsJdFGHl630lf8ya2iI5QNt3sIoX
	 z5M2ydUVAQJ8XO48hiDrK7rHDtHePgtuSm1CXeyuenRqd+cK+5WHEECnrHNFQkdPmn
	 aP/Nfcbn5hyMzAOJgppysWY1gu2PeWaaQHJDD50EbXfA/Jo2kGiAHkmxXQAK649l7j
	 /2ohGw6u+p1BiXD5svZKW0MOKYCQJbHJ8nAp5LmHrgn5ZRWAbGEgsBsqZrqbFmHakG
	 +4Qa0S6O5v++dj/bn6xnzr6s0qPgPvQGKvVjP3RwKs38X0nsvYTMkLljT9cE+CtgrF
	 jCdbs1qIsSY9A==
Date: Mon, 13 Feb 2023 09:57:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Daniel Gomez <dagmcr@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: max_hw_sectors error caused by recent NVMe driver commit
Message-ID: <Y+psCbPTfF9JkW2c@kbusch-mbp>
References: <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <CAPsT6hnbAA_uCiVjST8VaPgb6TyfBq9nO2S7OPqJX3=YhzBD9g@mail.gmail.com>
 <BYAPR21MB16882541DC2DA7AB91E58A03D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16882541DC2DA7AB91E58A03D7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_085751_699440_C0AF15B5 
X-CRM114-Status: GOOD (  13.27  )
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

On Mon, Feb 13, 2023 at 04:42:31PM +0000, Michael Kelley (LINUX) wrote:
> Ideally, to support
> 512 Kbyte transfers, you would want 129 segments (to allow for starting in
> the middle of a page as describe above).  But the value of max_segments
> is limited by the NVME driver itself using the value of NVME_MAX_SEGS
> defined in drivers/nvme/host/pci.c.  The value of 127 is chosen to make
> sure that the data structure containing the scatterlist fits in a single page.
> See nvme_pci_alloc_iod_mempool().

Should be 128 possible segements now in -next, but yeah, 129 would be ideal.

The limit confuses many because sometimes user space can sometimes get 512kib
IO to work and other times the same program fails, and all because of physical
memory continuity that user space isn't always aware of. A sure-fire way to
never hit that limit is to allocate hugepages.

