Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F64D36121
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43sIt7aid0FqwkgMe32OIEUl6ANQ1N13l0uEGLPJQvI=; b=Z9+8aQ0u5o8tt3iJiYCfK2ReSa
	oImamuTS3jm9pVGLsH+pZ4uSPMVi47hpc/0tjX1za3VLhkC6SdWXfOThXncTTGfNKMDn3s65gTo/I
	oVR2WKPl/MLsFnYYgzZdURkhzypOl6qc28qZ0xCFOSfJ6Tp9rBQszM/Ie+caY7iBAh0PG3+MRRiPL
	aftCbm6Z0Xd7Eq6JZ1MQ9DzD+Q/s8Gvu7kkudqXxrUGjMW8otKq+MU1QAVwCLWe0jJ4Jz+qGFaIYf
	LIvrbnCczlVmu1o2kIqZ9sm6LslhGwDXsUOUtSJ5cl5rdTgLEYktyzDOeWrzHpR2rIenmwJUoSscS
	Gr7j8Xlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ppw-00000000fdn-0xCD;
	Tue, 05 Nov 2024 20:07:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8PmS-00000000eLp-3is9
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 20:04:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 84BE45C2768;
	Tue,  5 Nov 2024 20:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240EEC4CED1;
	Tue,  5 Nov 2024 20:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730837038;
	bh=QDeJENVUw92sRiNxy5r2btFdEBS61GYI60EPE1gcMSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OmGbnszhvSEp7Qjv9vltf1esQRRpDuLnlAItY7b5O2NpryLQfYq9hxShWj891E2X0
	 EJnn4VW21O8dxUqN2fC/4vY8XSHDAWBNNzb7DAE/aNriXrsV5l1tnbj1qpCBkUBlDU
	 2FCA4umnaJgTcg8IU06JbhqpULB1eqGzqkLgKeNlfLlpT6+/Jh/MEe3R/TDmbcKRUG
	 Xee258tdT2ZLP40HYTLyWpCukoc75J5KyC3tzbeGokz/kEIGPSMFOhgmKOltEiA7qq
	 Ab6tHsIREBwxhCkuxDvTY94KTCEQx0PA/xzasvfRUgzuVKf3UHBzoA5ef1xDoUhae5
	 iQ+92m9OuQLKQ==
Date: Tue, 5 Nov 2024 13:03:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Guixin Liu <kanie@linux.alibaba.com>, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH RFC 2/3] nvme: query independent identify ns by default
Message-ID: <Zyp6K5XER535YZRt@kbusch-mbp.dhcp.thefacebook.com>
References: <20241104085524.118221-1-kanie@linux.alibaba.com>
 <20241104085524.118221-3-kanie@linux.alibaba.com>
 <20241105111106.GA1993@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105111106.GA1993@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_120401_046410_C9494480 
X-CRM114-Status: GOOD (  14.41  )
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

On Tue, Nov 05, 2024 at 12:11:06PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 04, 2024 at 04:55:01PM +0800, Guixin Liu wrote:
> > Query independent identify ns by default, if returning fail,
> > go back to sending the "identify namespace data structure for the
> > specified NSID or the namespace capabilities for the NVM Command
> > Set(cns = 0)".
> 
> How is this related to the rest of the series?

Patch 3 provides target support for the VWCNP flag, but the host driver
wouldn't check it without this patch. I'm assuming that's why this patch
is included here: so both sides can be tested.

But if you have the time to review a different patchset, I would prefer
we get nvmet up to 2.1 compliance and restrict this identification to
2.0 and above where it's required.

