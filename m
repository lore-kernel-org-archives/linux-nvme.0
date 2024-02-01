Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B017C47258
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Feb 2024 00:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=; b=d+HWRPbiPG353mRDFBfkQ8Mcgb
	33k27sgW2fiq0+/1z3tm5hsYTJsdRFnh8Z6t98zPWJbUaXppI4LDGziGDC95ImU7Ha+opnodA+wTo
	fuJz11vtiS6hadio/hHaWdvb6sEmGIkegm2pNJE1lA51RdtZCgAKVcKYlHHOgxhQa5zRrQhxHe46o
	gPgQTKxJSqXnoTYZso7WMTkBaE6X+wBL8lzJ28XN2kq+wO3CvieuUWkj+nWLFW7WVjZcRS+VI4YDJ
	jEcebxDcApC2D7jaPQtpbV7AMhgDDMUP8xk1n+eOmnZIplgWNFkcVfqHyHUkYVbmBhcCHGLsLBI5a
	x1GcPevQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKwO-0000000651e-2mW0;
	Thu, 01 Feb 2024 00:28:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVKwL-0000000651E-16ue
	for linux-nvme@lists.infradead.org;
	Thu, 01 Feb 2024 00:28:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 86CD761B2F;
	Thu,  1 Feb 2024 00:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD64C433F1;
	Thu,  1 Feb 2024 00:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706747303;
	bh=gz+nsKjWk8Nf+ei6d5uAUW8VaFlVj2RhKbdd6i4rq2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWkHsY81RlzxHJllxHiO0tQP4G2mrmMfTXDkXtfV2ViLtM4bFeHhTZU2wir+NHRTG
	 q9p9gn+l/HolJ4/UIYlLOCFrUidf+CU/r2S8Hg0zfYyqih0govx3qZJ3beRT/IHHMO
	 pG2GfnYQAHq8IoK+W1DPojY1DqbYfv6TlIb6q5zPOxIaljtbgV+pdN29yXT5uoPklM
	 ZPaioQG7+J1+O2jo7ddixw4dFzkMOiRLRJA9fB0czx7/A0vFF/pnYyje97uWrF3UJe
	 tjBdh1kts7kcloCBSD8jeAlhchFN7qkeOoT5JkHcFm6wL4hu13GqMIp8kIaZi5hpHH
	 TnN0Q7OhLbneQ==
Date: Wed, 31 Jan 2024 17:28:20 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Nitin U. Yewale" <nyewale@redhat.com>
Cc: chaitanyak@nvidia.com, linux-nvme@lists.infradead.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, jmeneghi@redhat.com,
	loberman@redhat.com
Subject: Re: [PATCHv2 1/3] nvme-tcp: show hostnqn when connecting to tcp
 target
Message-ID: <ZbrlpFPKP8HiX5Nq@kbusch-mbp.dhcp.thefacebook.com>
References: <20240129110639.45542-1-nyewale@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129110639.45542-1-nyewale@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_162825_364161_6093003E 
X-CRM114-Status: UNSURE (   5.21  )
X-CRM114-Notice: Please train this message.
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

Thanks, applied to nvme-6.8.

