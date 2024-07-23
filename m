Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A60AC3DA63
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 14:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=qX75dlMGj3m7zwyhSC4W24izWp
	YFZXqx9Ln22yg2HGLFbz/lO8EdsJQ9VDi12sMozaTRr4YxR6k1+4lbgfG0kwqWte3fX4lOOHTaaZj
	btT82TXAJ0ZbiW715d6/m8ELPgJVO3QLd1ogoeWAH21SwoiDlSrKswtz5ZUEaXYqMbanK8M644uJK
	w6/SRgtlEPgFVK0zZGanP4fEVaPUkT1W/LJPxmqItlAV+eypd0Wt4lwDVlUBvoaAeszLezLQfTmXN
	8wswFq1RjabjCC0EBTC514XZNmdWK3xZlqpRzvkujlVQVkwtHnfL3fe/3msCjRWhTsYNWyIvliY6Q
	Dv2xFjkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGju-0000000Cl8S-1rqR;
	Tue, 23 Jul 2024 14:43:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWGjq-0000000Cl5l-3prN
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 14:43:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71C25227A88; Tue, 23 Jul 2024 16:43:35 +0200 (CEST)
Date: Tue, 23 Jul 2024 16:43:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/9] nvme-keyring: restrict match length for version
 '1' identifiers
Message-ID: <20240723144334.GA20994@lst.de>
References: <20240722120226.88737-1-hare@kernel.org> <20240722120226.88737-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722120226.88737-2-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_074339_121361_E8B518C0 
X-CRM114-Status: UNSURE (   9.34  )
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


