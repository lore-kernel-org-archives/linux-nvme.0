Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D59CDB483
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 05:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FWBNH/jaZnUohfaYr2FDuxsh9C/kmyaSWDV2l4QtWMQ=; b=QiC1/IBuwrxcHkDN44tu2NfFpK
	/8w9doBAevQmlm1j3dfrc1sJIBluqxwm8wsARLi5xnYyHpyWh14KG/rSCVvBu0ntNNQZDSOzMShHg
	FGyFZ5Rsgk4iUC95GtxJbooFBw9kKyPnPtSPqmjV7txmW3X0CAI7+kfODDpkQQkOtF3JPUJVIIw6N
	3dJT+IOorqpt/GPBX7PY7FNqVqsGCmHDkObfXKAqCk3QdWrXcsTJUvrzu6RNdMjhtLwIV/x9YzJ15
	+7xMrkSnebkExAXJy0FoU+5jVdCqxaHXYD+0RoRXMXBNhEsq8xz1qRA7jnTnhLrGM/j0O/tuXm4K7
	ZFi/7LZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrAgm-002Vsa-0F;
	Fri, 13 Oct 2023 05:26:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrAgj-002VsH-2C
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 05:26:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB4C967373; Fri, 13 Oct 2023 07:26:12 +0200 (CEST)
Date: Fri, 13 Oct 2023 07:26:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, vincentfu@gmail.com,
	ankit.kumar@samsung.com, joshiiitr@gmail.com,
	stable@vger.kernel.org, Vincent Fu <vincent.fu@samsung.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
Message-ID: <20231013052612.GA6423@lst.de>
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com> <20231013051458.39987-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013051458.39987-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_222617_884471_93EDEB3D 
X-CRM114-Status: UNSURE (   8.79  )
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

On Fri, Oct 13, 2023 at 10:44:58AM +0530, Kanchan Joshi wrote:
> Changes since v3:
> - Block only unprivileged user

That's not really what at least I had in mind.  I'd much rather
completely disable unprivileged passthrough for now as an easy
backportable patch.  And then only re-enable it later in a way
where it does require using SGLs for all data transfers.


