Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE86C369D7
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 08:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=RtPG+I6dZP9575ERz5xZXer4RB
	gXugWVBliZ7Q91/YZUOEgFtgoUUA53protxIHokb+ChNaV9BOWrtaRnWE86aRV3vXFUnesqjctOX5
	ddqTOYuSf9fI/UNJesfGmzVisc16gMdRY6cWRRaRo4qZNyedJHNsLQMf/eqXEndXWpI4uA6btuupt
	vaA0RJ5cRWsfSx7OfLFds+oXrEFVkmdmrjaklZUriyqbWeXZUjZn4peyEWpLVpdhSc74disWfcR1E
	3XD4+Qp8MWHj7Q8N/7aZYcfpu/I1U8tNOt8OSMVB49lcaYP4UPf4w4PQS30fnoqrAT2wFEaUxoNkl
	oIDWyLbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u79BX-00000006O4X-0sAB;
	Tue, 22 Apr 2025 08:40:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u78Yn-00000006DU6-0mby
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 08:00:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 241E768AA6; Tue, 22 Apr 2025 10:00:49 +0200 (CEST)
Date: Tue, 22 Apr 2025 10:00:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] nvme-tcp: remove redundant check to ctrl->opts
Message-ID: <20250422080048.GA32564@lst.de>
References: <20250415060021.16472-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415060021.16472-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_010053_358938_EA15BD58 
X-CRM114-Status: UNSURE (   8.49  )
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

applied to nvme-6.16.


