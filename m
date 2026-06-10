Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9B4CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 05:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=VItLdrXQpbfOTbWzex0iEjK4z7
	6Sf9KhP80nXPTuOF7lrc7r8XQpifqgpYqBuZzKBe5//ll3xBd0q+12du+BImRfHUOByCLr99fn8Wf
	keH8i/fyNDNrLF4BK5jNlAs3UqfOaxLXFOtAlUIZUYLZ89DMY8cjluJDNx6yJLhsr9f+5fmTM8JvA
	Cj9em3DnJN9Uj9U3AiGbqFs4QxwkAE4p4hYlIbK479cCnxZC0QhvJ3/RvroMAHYfC6SYxbRlW3AlW
	2g3EAHIqW7XkVhYNmBAoimjIevYcCGkn83B3G53jF9QL5YHoot95w9mzl7wcromR3mMrqysqkveO0
	KOAdSfRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBBi-00000006oCG-2SO8;
	Wed, 10 Jun 2026 05:09:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBBg-00000006oBd-1Ilz
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 05:09:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B390F68BFE; Wed, 10 Jun 2026 07:09:01 +0200 (CEST)
Date: Wed, 10 Jun 2026 07:09:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, dlemoal@kernel.org, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2] nvme-multipath: revalidate zones for namespace heads
Message-ID: <20260610050901.GA534@lst.de>
References: <20260610032846.54044-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610032846.54044-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_220912_498342_AFD7922C 
X-CRM114-Status: UNSURE (   8.41  )
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

