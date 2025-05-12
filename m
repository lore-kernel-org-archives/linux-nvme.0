Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ACCC3ABBC
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 05:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+OAWNU/dmVNIt0GSxZPkuthMKkbjHnqnnawkKBfekMU=; b=Ey3wuDoFi43d5nB1Djv3trDLDi
	oBMwXcJbO20Xo40oGQn2MSKto3XOl+qCzi7TbD1VvahXhyH9/P3bUxiT1lb8tUJyUXODqnqONQPa4
	FtdZ+eFI/+n1CDnC7TzWLj5r8X+wmE2ObGA/PxAia7fnTbwxewUctQCZvlRq9bVC3w+6ybemt3dgW
	iwTJqd3kXbwK3/fjIgpN6UoFyz+QbcxV18KYmPFnxWkPuOLdqNYdA3pSJR4ngAEMUkkySULACZmYs
	+YiqloFdk11p6HWTpnUwiZiM1cjXVZaz+SMPnMBkeWkNuPwzKVL63W8jlUZProOcJ7R047jZkyZbX
	Ss68HFDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uELff-00000008Phs-0PFz;
	Mon, 12 May 2025 05:25:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uELen-00000008PZK-0c5v
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 05:24:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 41D6F68AA6; Mon, 12 May 2025 07:24:44 +0200 (CEST)
Date: Mon, 12 May 2025 07:24:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: nvmet_sq_init(): fix use of uninitialized
 variable
Message-ID: <20250512052443.GA1869@lst.de>
References: <20250509235904.915626-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509235904.915626-2-wilfred.opensource@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_222453_325886_611D5A76 
X-CRM114-Status: UNSURE (   8.41  )
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

Thanks,

I've folded this into the original commit.


