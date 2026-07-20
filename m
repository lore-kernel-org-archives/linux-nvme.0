Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5A1C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 14:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=v1YBk6xFD4J8XCrq92CZZ/4ZVV
	ntPv1acFp90kgzZDDUkt6+D+5QS75Yq8Nbx5h/3PbJ6rPGkX6ttumpYTh0Txe9v9Xx7t7ECFUBzmO
	HxgIIYr/OO6Yj8dxlGf9s1rZIpPsN6AvtpPqxyclGowz/9mSgIHc7G8Me2Wz5j7wtrducE1VG6/fR
	+qBuolHS/fJ1xRmBBKfeoWMW2ul7r8EXwRT6lh/5JeP9v0gdou4qYdgxEEwSK3kRcARvvtmhs0r9L
	3XZAbks+hjsaN3Dr9htGNy8I7rXUw93uIcz3jUEWGidcAo4R4ouFT673pOxEt2x7rtYHoNOh2BC+H
	l9qVRcNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpCh-0000000712d-2ptQ;
	Mon, 20 Jul 2026 14:42:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlpCd-0000000711e-3rlu
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 14:42:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9171268C4E; Mon, 20 Jul 2026 16:42:39 +0200 (CEST)
Date: Mon, 20 Jul 2026 16:42:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 1/2] nvme: factor namespace-head queue-limit update
Message-ID: <20260720144239.GB16699@lst.de>
References: <20260720022205.1798805-1-sangyao@kylinos.cn> <20260720022205.1798805-2-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720022205.1798805-2-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_074244_106192_AEDEEC3A 
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


