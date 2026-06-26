Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3391CDE010
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 04:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ZWKIhA9HFh3QqWBZJpxvSVDKMH
	AVTeQy6y+u9PM3UGmOPqGVSVDoyKRg40AIJBZUHgdl8SaHM7/Fnh2pFaGpLk2AjLK4oSb31VzgbhT
	/4w+U7a88LrDUyZ3/qfI+EvtfHBOiQF5f3+excLQ303tOljkN7ojB+AhYElERMGZYcSXwA4Qtr+S6
	BYFJCuDgLGKsdZ/4MggE5d4a6ql/dHlYTnxe8h4QxRJjD9KBZ3eMYC8Y7tfNWKp813Ajw8IGqvDnh
	/TI6vQxTt5IpMODW0NMrqHcdYb5rMl05brMCu14KqnXNUUR9dKYs50Y7NlufZRNYr+hbgMU2UxM2Q
	rv8RXwNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyVo-0000000AU6p-2UCw;
	Fri, 26 Jun 2026 04:49:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyVm-0000000AU6S-2jx5
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 04:49:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92F4568B05; Fri, 26 Jun 2026 06:49:49 +0200 (CEST)
Date: Fri, 26 Jun 2026 06:49:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme: zns: cap zone report nr_zones by DMA
 buffer size
Message-ID: <20260626044949.GA8613@lst.de>
References: <cover.1782280420.git.liuxixin@kylinos.cn> <cover.v2.1782280600.git.liuxixin@kylinos.cn> <8ed1b6a33454.v2.1782280600.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed1b6a33454.v2.1782280600.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_214954_860914_502EACA4 
X-CRM114-Status: UNSURE (   8.36  )
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


