Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CF5CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=P7Ie2qsizW3/ep5nj5Jy6qAlTu
	BieoJvpa6Ya5aqPdtTGVX6cX+CBcbIAFRm4oy3cVU72lVZ7nXVCRO88iKdSUT2seZKwsYlWjVVZNO
	8W57qszYAPR0wEedWpfO4xPjXDG8g4Iowqqib16yZUBH963E4Vq/m0zEJQzNhJxuKtuJAECldpWr1
	9xY+TV5wHJkQarXq4wuIjlcXFPrkKLTNd3Tw/zml66ojmv2hzB1HslxMuX6c91BX3PwTaqd+6Aq8k
	qqnrhayhLMeXvUdm9d9eRW+2WpSKPjVJMKLqCHYLqN+JOpe9PePEi9yyGZpPWy/6kYApbU4TebYEC
	X1zucx8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kaA-0000000BAaS-1ZSH;
	Mon, 22 Sep 2025 17:44:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0ka8-0000000BAZg-0zm1
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:44:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B237227AAF; Mon, 22 Sep 2025 19:44:03 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:44:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery
 connections
Message-ID: <20250922174403.GB14736@lst.de>
References: <20250902035211.2953174-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902035211.2953174-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_104408_415731_1B19E7BC 
X-CRM114-Status: UNSURE (   9.30  )
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


