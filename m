Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8A8C77B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 19:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DgxHhxGSOqk7/F4ZYb7xhjpNoEwH1U0mLixQqgnCkPM=; b=xNKO3ey7jFFzHiPv8mC+zcZsG0
	Mwj+Lq4a9TbWkJVsF4LK2avsiF2MBU3kq2UDuz5m4VCJutS/0KyHqq+3i27aT6IOxhlmG9ibkOZ66
	lWauvjvno1DIsj4MSbZ6gAFIbHALFmww/K19yWlUksmvEpRo6M9Rv77xvqS2rnB+7VhjzNVTvA/qA
	9MSla0xItn+XeWYR/ZYvmTvzL0JyVoUuRwKEpSLYAsLSzqpvZreG9DjW9v3lgC7APAG0S8KP+VfS3
	oGRCwp8KSJ2krnpLM+8C4mFTucojrXEPEXx4zU8tUog+q3pOobSjS5D4VqwEEkrtsJwH10YajUkcv
	pgoLcv3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTn3Q-00000003pBL-1el7;
	Mon, 23 Jun 2025 19:42:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjKg-00000003Hb9-06cp
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 15:43:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5CE91A51EF8;
	Mon, 23 Jun 2025 15:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6ADC4CEEA;
	Mon, 23 Jun 2025 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750693421;
	bh=DgxHhxGSOqk7/F4ZYb7xhjpNoEwH1U0mLixQqgnCkPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzdrUO8ObmqmFHgl/QwuHHYxp0KwSPu/8D4bnAiH5r7BjuVDyceoxRQ6jviRJvPp+
	 yimXdrXJcNKbpwVrlMz5MozoCzfyb6P74DtNHzsJKSU4Uw4bVS1LjFXdk078lpUApI
	 d1yUIUDTqJe2dhZS2/NF1p5sVG9vnXo3nDu+vgEw9pzeUQ+ZDfH5JoWPmapdT3jAjm
	 A9DZsStfZtuv06tOPnv6wi+YRGL1tppXWYpoEAIF6Aqxac+nA4oDUogDVAsL7FZXxc
	 iGiZfUIRcyfTsooT1BHKG34Z0UjBbb7+F+6ylBCrukru98iQ5Nl5Q5ioI+yn5lYsbh
	 q0bPVT0XD4gdA==
Date: Mon, 23 Jun 2025 09:43:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Leon Romanovsky <leon@kernel.org>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/8] nvme-pci: merge the simple PRP and SGL setup into a
 common helper
Message-ID: <aFl2Ktb7gioMLEl_@kbusch-mbp>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623141259.76767-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_084342_135727_3E0F882F 
X-CRM114-Status: UNSURE (   9.06  )
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

On Mon, Jun 23, 2025 at 04:12:26PM +0200, Christoph Hellwig wrote:
> nvme_setup_prp_simple and nvme_setup_sgl_simple share a lot of logic.
> Merge them into a single helper that makes use of the previously added
> use_sgl tristate.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

