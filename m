Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683A2C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 14:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=GwXtiE5p++PrQl8qp56Bc+qa2O
	kNjvl3h9WAm7GaSyIIsLv773WIt3Y3Y5S7UD15HTZOoyWMQw7vOUaq4UPdbLP4pk5BoymxKKs7koK
	whEN7CnOBSLdwK6Rj3R8E9OyyLUylLYGZsd+BayRLlIBX3PBGMyJwen5DDbNAWfNizakpTFTjs554
	BNYIjEIoUdwvP9COz7JlLBPCB/xULvJkClHOygyhH42CST2BeK5FCRDLKQ0v3dHgJqSX2s+9naCe9
	uu8pMN+qZcxFk3dBGUv7XieZpSAB50gdHk2og6gRD7Z0gFvLExHpERdwovE+00JfcTXhQK/jQdftV
	QbRCG5pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGkJ-0000000ClGN-3iv3;
	Tue, 23 Jul 2024 14:44:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGkG-0000000ClEo-1i30
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 14:44:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B7C468D05; Tue, 23 Jul 2024 16:44:00 +0200 (CEST)
Date: Tue, 23 Jul 2024 16:43:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/9] nvme-tcp: check for invalidated or revoked key
Message-ID: <20240723144359.GB20994@lst.de>
References: <20240722120226.88737-1-hare@kernel.org> <20240722120226.88737-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722120226.88737-4-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_074404_612442_DE03D05A 
X-CRM114-Status: UNSURE (   9.59  )
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


