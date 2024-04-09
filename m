Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C78CD1296
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Apr 2024 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=41R75mjug60zIxdOIF+66Wlfhx
	JKRWDTj6xjOQYN71J0/H4lzKlRRBp4NVlAABEumMU94O0GzSag9xhckdv7xh06aw3qiAELUHLpUjL
	lKNEMfhFj2Vs6/PK67WloEuW1/0inVHLqaZy/AWNGvE7AXxGRqJOosTc9Z050Axd/9yAEp8/adggB
	dGkV0B+mBqflSpuRzu+aj6z4+7r3nJ1Q+Ak1iSgnwXbUe3dlFkc74ISJilqHCbnpw6feLi7F4sEgY
	gwz9Kkjg8vRcESeRSc+1idcpRiTtQ6+tBXN7fQlq8J2qPum6oLBqTCauVlxMu72d+KYIyXkwgN4LP
	upfwDIMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruC2Q-00000002JCk-2JgA;
	Tue, 09 Apr 2024 14:01:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruC2L-00000002J8K-1Hpx
	for linux-nvme@lists.infradead.org;
	Tue, 09 Apr 2024 14:01:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 71AFF68D09; Tue,  9 Apr 2024 16:01:18 +0200 (CEST)
Date: Tue, 9 Apr 2024 16:01:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/6] nvme-fc: use nvme_ctrl_reconnect to decide
 reconnect attempts
Message-ID: <20240409140117.GD20883@lst.de>
References: <20240409093510.12321-1-dwagner@suse.de> <20240409093510.12321-6-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409093510.12321-6-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_070121_585964_68432C6F 
X-CRM114-Status: GOOD (  10.35  )
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

