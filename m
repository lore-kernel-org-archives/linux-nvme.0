Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539DCC83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cO1mBIACdPX5nm0QteMyyrTG+5K+DIEd5gmeCRx6BGg=; b=uDurY7CQe338vtpUkRYXqYm37h
	StlZuwjN34uMLMQkHHa5TFPEw23Dd+URpmgxcYCEme5DvtkFujvLUmUGss6AZXp6o/kpzYo3IV9m9
	7ZD3xhzBM0Pb2H4BKZYcE1+6+sArOtZID/oaDDmhJ6p8HXA+3s5Jlu1wdGwNZbEpzy5JLxfTAerNU
	vL05xuBy2d+t1TWVs3QcxC+KjMCOoLdADz5Ze2q8A08exEIfnZIp1cOorYGCyfOqjWRpBET56Jlr9
	8I8cOXrFg82gL4K1Agt3uvMqMFCMnoIjBXS1fgajZcAHrKSR35pQSHWu1VCaGufellvXifh7HtDPU
	Fi1lfBAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubatf-00000004V05-1HVt;
	Tue, 15 Jul 2025 08:20:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubajo-00000004SrD-0Ooz
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 08:10:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D7E268AFE; Tue, 15 Jul 2025 10:09:58 +0200 (CEST)
Date: Tue, 15 Jul 2025 10:09:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, gost.dev@samsung.com,
	nitheshshetty@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Add support for FDP devices in fabrics passthru
 path
Message-ID: <20250715080958.GA20790@lst.de>
References: <CGME20250715061856epcas5p196a0b67fe58b71e1f81f98a903e429c0@epcas5p1.samsung.com> <20250715061804.1954522-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715061804.1954522-1-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_011008_284973_3E793614 
X-CRM114-Status: GOOD (  11.68  )
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

On Tue, Jul 15, 2025 at 11:48:04AM +0530, Nitesh Shetty wrote:
> In nvmet passthru path FDP is disabled, because of failure of
> admin_get_features FDP(0x1d) feature command.
> Supporting this through nvmet_setup_passthru_command enables FDP.

I don't think this is safe - the feature has endurance group scope
and thus can affect other controllers not passed through as well.


