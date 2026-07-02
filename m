Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FE6C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2026 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=3IaaNMO0SVpZM3gwGza+R0TKgd
	wzdv4vLNYmqktdD4u5+3l5M8KlFL+XvAz9RFk0j3qkyRcLXTQ0TaKARCrjhvvMh3X8M8TKRT5HBZJ
	Gy3tp96MIh2ZqnVrvKYjf3HLseBJCK0yuZ8wQeRW/VPvPPuYG0wtjWyb1kp9wwCh5r/k2gIO/1SNH
	QdN71w2Wu3dJ4hkJWSnSoFbv83OVFyMlQzVQPfySfIm1LfRtz0neIbtB/Anu85WWOe1xeaCze/EBc
	3qF/t8plyWwdV2nk2P3C9salTi+CLQUqayJdnnHflcvK1ByPcPf/ThsQdQoeS3lOE0AF2vQSkf3lP
	j67G/9JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfIAQ-00000004bl8-0vB9;
	Thu, 02 Jul 2026 14:13:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfIAN-00000004bit-3hKT
	for linux-nvme@lists.infradead.org;
	Thu, 02 Jul 2026 14:13:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9221F68CFE; Thu,  2 Jul 2026 16:13:17 +0200 (CEST)
Date: Thu, 2 Jul 2026 16:13:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] nvme-auth: use crypto_memneq for DH-HMAC-CHAP
 response comparison
Message-ID: <20260702141317.GA23046@lst.de>
References: <cover.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn> <0001.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0001.nvme-auth-memneq.1781751816.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260702_071324_069921_6651A874 
X-CRM114-Status: UNSURE (   9.21  )
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


