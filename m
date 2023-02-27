Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC82C64ED8
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=NU3Lxsl4orCqLu5Xrv9gWYCFkr
	3QSC7mwYH+xVfpRjHEil+ksknDyWd4Olwwz4oXROW5vMEb7k9Ix7dKmGTCs8HsGY2K+HtGgzEdjuj
	Rm26TCBF0P0jl4mir3XQVEECUa7bnPpGEvBqjHSXwRL5jcgjpXrU1fZTN2SnncvG3Cejb1CEtN6Jf
	53dFcFPCsuctQTfomt4ul23GEqkTz6rTMhfU5p8Jlg5gDxvRH/baaWzb3lbHvYDJE4EAkUpzDVKQ5
	nnlvdu/VGQ1ZIOkXsP8fAh81lOsPaQItWOTHjT9YrRJwxHWSTiw5ALBx29cJFbSBt15BDft7F1FXV
	xcPjWggw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWe8m-009tpr-Pr; Mon, 27 Feb 2023 14:06:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWe8g-009tnY-BK
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 14:06:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 05CA567373; Mon, 27 Feb 2023 15:05:53 +0100 (CET)
Date: Mon, 27 Feb 2023 15:05:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <error27@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: fix an error code in
 nvme_auth_process_dhchap_challenge()
Message-ID: <20230227140552.GA18487@lst.de>
References: <Y+4eOa57zTdCZ56P@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+4eOa57zTdCZ56P@kili>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_060602_565001_C968ADD2 
X-CRM114-Status: UNSURE (   9.40  )
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

applied to nvme-6.3.

