Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF428C531DC
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Aug 2024 08:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Vwuk/iogYCkADfBCww804JbMUy
	alCCL2XRfkk9z10xk2q23BxVnsE6J+KjQUAg8Hz3xmPAOneuZwEkReLHWMl/Ce8GG86SP9wOCx/ZW
	3EjQH6RIxCYYdfdxj4JCnaCrIWMD9WMJ8hf0sTNAIstNZbnkY0xNFkqQl2YUBoHu7EQEML3ZQXNzo
	C+uAJPhW5CiqMrG3EJ2Oz5xMGEI6Mn28ikQBzeIScyg2LcKFJTuEDD2fQi91XeNiAJ9meoqpCO3BH
	rObzp61cSkVqeaWF0ufco6BQNqwMrkDaa2jYlVTm4CheKa5mokBNlII7L7RkvapifNuOtBKIWPbCo
	5mzk4JPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQRP-0000000HHNo-0BOg;
	Mon, 12 Aug 2024 08:30:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdQRM-0000000HHMs-0EIM
	for linux-nvme@lists.infradead.org;
	Mon, 12 Aug 2024 08:30:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AFEDE68AA6; Mon, 12 Aug 2024 10:29:58 +0200 (CEST)
Date: Mon, 12 Aug 2024 10:29:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Mark O'Donovan <shiftee@posteo.net>,
	Changhui Zhong <czhong@redhat.com>
Subject: Re: [PATCH] nvme: move stopping keep-alive into nvme_uninit_ctrl()
Message-ID: <20240812082958.GA3338@lst.de>
References: <20240809135427.378953-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809135427.378953-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240812_013008_246147_98413FD0 
X-CRM114-Status: GOOD (  11.28  )
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


