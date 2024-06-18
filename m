Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EA2C2BA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 06:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MR6JHa3aJjyUXaoux0HBH3y5TK
	rUfpPwQLgrgnGSIom0UrQhPQ1aeg0Rzu9AndK3K/zp2wYBmtDwhpFjMumG8x2bVx9N18Xd6hRZ9mX
	1TahjAL+airr6me2HmbdlFzsFcw02kC1TfuFh7j91os8IC1eavYXablkmUh+ROPAhxFhE3/bXuEOC
	oO5psAeK5/SrOSxm8zPODkRBnoLiZ7nINMj5l6R/5UfMMORvSIEEgrgBp5lrIV4hmBjj0P0OcsQEg
	SskGo1BH+moQ2SsuMkm2sJICkO7KUTR2ljrf8U0CSKir2Zq8aHZ5D+PpGexr3q3goBRhWNNRmB1ey
	/O/QEkvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSbL-0000000Dr5y-1Om7;
	Tue, 18 Jun 2024 06:45:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJSbH-0000000Dr5U-3qq1
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 06:45:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5AC9E67373; Tue, 18 Jun 2024 08:45:41 +0200 (CEST)
Date: Tue, 18 Jun 2024 08:45:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/3] nvme: fixup comment for nvme RDMA Provider Type
Message-ID: <20240618064540.GA28906@lst.de>
References: <20240617072728.134728-1-hare@kernel.org> <20240617072728.134728-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617072728.134728-3-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_234552_113552_F3C3BB02 
X-CRM114-Status: UNSURE (   8.71  )
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


