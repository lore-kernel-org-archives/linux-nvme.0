Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276A3CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 04:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EqeZ0WK3U0aEaT7Lqxd2frQwlO
	JR80GHYy8Oa48P5fqcdeSj1yvlJvCPmhDJm+FjqHaiUbBCshqB4Iu55iljJFpBN4WPNdZv2MWccs3
	hayfaEtqn/cJns2LR/7VYpQquP3wOmXua2OoIy3G+y6uIeYJ+r/qCkUj4wou3TeKIT0ZH/+TgZ5fh
	jSi3MpBvnrIsNLRworXnVCr5jw0dbPs6Krhc28BUbgz8zpGmE+K0EhJ679yJIg81rTfXPT4HCXh80
	wId4k4YlOBKrijFY+E68A4MY+DVrTmzBuU7QGIoXYQ08n6msF7VggkazDeqKtKGu+CM7xIt66FVaS
	8ghF7mbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsbWV-00BCYn-2g;
	Tue, 17 Oct 2023 04:17:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsbWR-00BCXM-26
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 04:17:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D336B67373; Tue, 17 Oct 2023 06:17:25 +0200 (CEST)
Date: Tue, 17 Oct 2023 06:17:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: sanitize metadata bounce buffer for reads
Message-ID: <20231017041725.GA6260@lst.de>
References: <20231016230625.3792823-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016230625.3792823-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_211735_843502_81ECAAA7 
X-CRM114-Status: UNSURE (   8.28  )
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

