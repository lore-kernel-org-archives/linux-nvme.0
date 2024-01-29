Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D29D8C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 05:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=dFcoGQ4jEoxTd0gk8JtCNcbMn6
	CjffJIxZU8chzh1jIYL5iX/wgryzifeUhymgFouIWICkS0coQfjQRcqAhiW3TspBtJCj+/2kxWnA0
	NOCjKPJ17sgdR2NjGEcXcD7EopVna0cOrz8qBw1TMkZN1TiJMhl/jIoi1b1iEo66Uey3XL7ohcxAV
	okhNVGflkoVspvC7VPhXOJZ52YVu2mY2m4e7wQg22ARbFlr6Srr7HtaR+gv7X6+spHmnObpo4E7hl
	I2+IMO5S5/xCFx0Hu8HDVjFhXUs2gtooiGUYdy0REh2QHggR0QG0geqXtU2QuwOHN0ohwcPcDCGdv
	nBqLW2OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKf4-0000000BONn-2oVg;
	Mon, 29 Jan 2024 05:58:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUKf2-0000000BONH-0dlE
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 05:58:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D38468B05; Mon, 29 Jan 2024 06:58:15 +0100 (CET)
Date: Mon, 29 Jan 2024 06:58:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/3] nvme-auth: open-code single-use macros
Message-ID: <20240129055815.GA19136@lst.de>
References: <20240127093746.40246-1-hare@kernel.org> <20240127093746.40246-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240127093746.40246-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_215824_363557_5F259A4A 
X-CRM114-Status: GOOD (  10.18  )
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

