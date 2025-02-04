Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77468C02196
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2025 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iSieiNU1mB3UrWEllId3FCWR15
	CPIFVBQVM/gx37+XHOpPgWzHtwxjl4ddh44kNBCcFaCwVwH1Ylb1gEzu/azC2FTjjonvExIi0BIRt
	nNmpRjquFbD3uaO3hJZNTAL0JetBFBU1zCiB7/Da464eWta5JtmK+ZYfoYI+psfEIyq44L3xsVTry
	sJfNjR99252NfPpW7OCREMHSBwdj6gjcjlzu95QG13ooHpPqNBLV882j2O6BQzo7kDaugpPSEzg5t
	T8h09tDj+G0lNzhROs3xFyTjQb3VrQPU7IQoX8QDndmTzykhj6fc6L+BXKLY42dBUyNJNJgWF1heT
	K+MYYzBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBzE-0000000HJk6-13Ks;
	Tue, 04 Feb 2025 06:00:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tfBzA-0000000HJjg-3PS8
	for linux-nvme@lists.infradead.org;
	Tue, 04 Feb 2025 06:00:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 03DF668AFE; Tue,  4 Feb 2025 07:00:31 +0100 (CET)
Date: Tue, 4 Feb 2025 07:00:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	asml.silence@gmail.com, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCHv2 06/11] io_uring: enable per-io write streams
Message-ID: <20250204060031.GA29177@lst.de>
References: <20250203184129.1829324-1-kbusch@meta.com> <20250203184129.1829324-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203184129.1829324-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_220036_997261_426CEF31 
X-CRM114-Status: UNSURE (   8.53  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


