Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2BCC54E60
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Mar 2024 20:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=gjRmqlxsTxd+eHz8+Pu554HCSu
	oSQJ1RIagSXlQKDia4B4pHyJ+oLPBeKATkkgosh75M72jVwLotuoQKGZnwBk4D/zY82wuNCC5B6bs
	/KbUj5pd4Lsd8kNFBHs2/bPKcuKQ/8cJnGl3IYzOlgJpLuDWzLOz38MbtAhopbO1lNXqnbBDsgLB2
	K52l5YCVqV0fE7jewz3GwBMQcrfvzFHM44GtEbP3yS7f6foS8PyAG7l37wQfAAaQ4KVt860jEmUGU
	bt7LADH809bwLFFOD6FcKuh0wPVLOwacFAXDenAFe3li81FV8Ss3hDL7bv8AUL2dK9iQEal1Nnp9C
	qv1d90nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlx2M-00000006LUI-0DoS;
	Sun, 17 Mar 2024 20:23:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlx2H-00000006LSb-2uc4
	for linux-nvme@lists.infradead.org;
	Sun, 17 Mar 2024 20:23:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D3FA67373; Sun, 17 Mar 2024 21:23:01 +0100 (CET)
Date: Sun, 17 Mar 2024 21:23:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: iBug <i@ibugone.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:2262
Message-ID: <20240317202300.GA5593@lst.de>
References: <20240315192747.1749119-3-i@ibugone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315192747.1749119-3-i@ibugone.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240317_132313_964405_CC1F9414 
X-CRM114-Status: UNSURE (   8.68  )
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

