Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59768D2E9DD
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJfbr1SZ/Inwae4ZK8iFHZ+ZJ3YET+EzZJLV/zi/1Aw=; b=v5m0OjL5dRArMcF0BrWY0pXwGo
	bbRK+PrDIbhbEitOeVvAP0vKa2wMUg1lzEKUGmNNns/kKJ8K+u6lt6c6YbLnGvvfNzAH7A8Ohri0y
	xBAxAeVxHoW0QR29EVLQCL5caG5oWUVhlRIDgo6rCIXxFkXgmJzhBq+frXRo7Iyho4OQCiIo8K7Ep
	iX6WAvkXF1Nr3EfY4DT2e+1l0rPaENf2+cKK46up7rCVndAMd1A87gXY4iqXj/needmHSsgF49tPW
	K8pWPz331A7Ak/d7D9TEm0NZIzcbnnoZvSycPej3jrrXUmIpdC1h5ftU6uI3FBhQIxf7oMGksFud5
	2ZI2L4eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tASje-0000000HUEa-40tR;
	Mon, 11 Nov 2024 11:37:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAShx-0000000HTwN-1now
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 11:35:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F72368D07; Mon, 11 Nov 2024 12:35:43 +0100 (CET)
Date: Mon, 11 Nov 2024 12:35:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] nvmet: fix the error of point math issue
Message-ID: <20241111113542.GA30234@lst.de>
References: <20241111104035.31770-1-kanie@linux.alibaba.com> <f4ce4ae4-fb33-467b-937c-444a46eb6f02@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ce4ae4-fb33-467b-937c-444a46eb6f02@stanley.mountain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_033549_637407_7F00FDDC 
X-CRM114-Status: GOOD (  17.32  )
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

On Mon, Nov 11, 2024 at 01:48:57PM +0300, Dan Carpenter wrote:
> On Mon, Nov 11, 2024 at 06:40:35PM +0800, Guixin Liu wrote:
> > Fix the wrong place of parenthesis of ctrl_eds and data point in
> > nvmet_execute_pr_report(), switch to "void *" first and then do
> > the addtion.
> > 
> > Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> 
> This needs a Fixes tag so that the stable tools know not to apply it to old
> kernels.

We might still be able to fold it in as it's near the top of the
nvme tree not send upstream yet.

