Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B0BD49207
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=LqacsLXkc+hF2ecrMZnMPe1W/2
	iFrnbVuJQTnHRYA/N2CZNjo8HpqhXvH0lX3gKGCUEiG/FuJJFyQKapvoT6EyT8DnJFNDKrkAjxGaN
	MYppZKcnmqXo0TeBKDGxp83bmsxkWFC3w7hCsR/raeBxMavkRAJR0jg4nxlqLp2rvCelWKxj4xOyl
	S+ReMvMTP2x9issQ8h+NjKpP5Dek77Jg3cSDdPX+pCWQNbIIZi+SWG25/AuTz8t1mo65FXwjElWi5
	6q86OPEt2AwtTujr6NumCSyVVSdqgbtKw/gq8u9KOzmIxxyY61Oyg0idy8clKSn41lq/nagHYR/aU
	ab3Mhm1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD4bX-0000000A3vQ-1uNA;
	Mon, 18 Nov 2024 16:27:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD4bV-0000000A3ux-2x52
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 16:27:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2EC768D12; Mon, 18 Nov 2024 17:27:51 +0100 (CET)
Date: Mon, 18 Nov 2024 17:27:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/3] nvme-pci: add support for sgl metadata
Message-ID: <20241118162751.GA12281@lst.de>
References: <20241118155738.2737423-1-kbusch@meta.com> <20241118155738.2737423-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118155738.2737423-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_082757_876442_4EA80AA4 
X-CRM114-Status: UNSURE (   9.26  )
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


