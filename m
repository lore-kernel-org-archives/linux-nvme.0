Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7623DC44524
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 08:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=NYmXa01+8xYxDvj4WIYvTRj+5l
	tjX0I78OI0O8KrRYuOmqHRc67nFL41LsT/n7HytdGaRVNMtu8h/NJA+SvMg2YI8RtIXktTaPr4kqk
	9HeEN4g7w1WhgiIM/LkJkSGjwNmhaU0V4lQFkzxdqXwhEF5WBFTxli8GGG4oghwYtKuNbWT7AZrr3
	2KJoAMH8ZzX8ai97LdcMgopLQvqnWKbanHUSaZFy8Ml6um0kzT0yfIBb0IxqFZxmHTKQ5j2pll/+i
	Zndgz3f7cCpCugnDVaGPYm87sxRiAjUV8tf8Xc/Gr48BnvS3OJG1jC5Xw0XHio9t4l5b06bgwQTiG
	+qWcgyxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wljKT-00000006BsN-04BQ;
	Mon, 20 Jul 2026 08:26:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wljKQ-00000006BrW-1aix;
	Mon, 20 Jul 2026 08:26:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8D4968C7B; Mon, 20 Jul 2026 10:26:16 +0200 (CEST)
Date: Mon, 20 Jul 2026 10:26:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pan Chuang <panchuang@vivo.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"open list:ARM/APPLE MACHINE SUPPORT" <asahi@lists.linux.dev>,
	"moderated list:ARM/APPLE MACHINE SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-apple: Remove redundant dev_err_probe()
Message-ID: <20260720082616.GA20679@lst.de>
References: <20260716033301.212797-1-panchuang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716033301.212797-1-panchuang@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_012622_560708_110369AF 
X-CRM114-Status: UNSURE (   8.86  )
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


