Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405EFCD37B7
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 06:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LJya5+0DA+H1kHprN8jkf5NnMV
	eI7poDyO8iDJyxlz4xzO2QV7oRud3A9C8Sno2vLvDI2UXLuB2kMZeuyB8L7VNXO9gIQI4LQmw1rki
	qJs4Lpq5WYzyXImX6uoyN2nugcEbJk4DM0UQw66TLqix2xdHBzBu8IfsnEdeiZ4k0horqMlZELaXW
	kuOLaD2Mb5mjsigzNf2/NLbcsrJkqLkTLtgK+lxi1jufyHFQTY955Dp+adt4k2+H8bwQ+vYSXVZ3R
	/4GXX3qUzQvWmkrmkoO5YTimOSqKFaG+S+6koK22XItFbtIIAAdArY2lhhFoycfPv5/z+n1Hu23eD
	E0OO6FpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMK0f-0000000CTVg-3Pp4;
	Mon, 11 May 2026 06:20:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMK0d-0000000CTUM-2pzY
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 06:20:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75C7368BFE; Mon, 11 May 2026 08:20:52 +0200 (CEST)
Date: Mon, 11 May 2026 08:20:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	security@kernel.org
Subject: Re: [PATCH] nvmet-tcp: Fix potential UAF when ddgst mismatch
Message-ID: <20260511062052.GB25956@lst.de>
References: <20260510203029.119712-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510203029.119712-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_232055_858032_0099B8F4 
X-CRM114-Status: GOOD (  10.08  )
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

