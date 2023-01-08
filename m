Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7932BC63797
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lsy9K5NFAda7MQAC4/uMyCagRtBadcZcXPFHN+mvW3U=; b=h9jL5FjnzURf6MfPznnlZh93/Z
	jIuR1kXrMnrc9w3Ljujrr/GFICei1ZzSgPju34ECtaJY5t882rqXw3B8A5lnR4DVIC3/jRNk7rCJr
	nS9kvYMagCXw3U+7ZRQ2kQuGLvR2vQzpq27M1hqBDrmWVTDHUHsEt1TxYxXCf7LXPdPCR/u1hd04e
	zoTGOKTxEMwfTmSDpcK6w7c5hnx85LOAn8aTqQDZfISeSa2mAWBXlGhcOfjiQ9xAi45pZymqnLdAS
	z2fIPQAgQskTtDC+7UgX9/pR9MKYf0AvqGG77wDIvhjPVs80lMWGAbgB55XQVqJEfboCaEjfwyjIv
	0oWwAkaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEaCa-00F36H-NB; Sun, 08 Jan 2023 18:15:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEaCX-00F2s9-Io
	for linux-nvme@lists.infradead.org; Sun, 08 Jan 2023 18:15:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47DF168AA6; Sun,  8 Jan 2023 19:15:16 +0100 (CET)
Date: Sun, 8 Jan 2023 19:15:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tong Zhang <ztong0001@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, t.zhang2@samsung.com
Subject: Re: [PATCH v2] nvme-pci: fix error handling in nvme_pci_enable()
Message-ID: <20230108181515.GA25141@lst.de>
References: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com> <20221229183731.4013056-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229183731.4013056-1-ztong0001@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_101521_783025_CD59B121 
X-CRM114-Status: UNSURE (   8.73  )
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

applied to nvme-6.2.

