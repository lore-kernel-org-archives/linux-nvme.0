Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A0CEC5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ZSPxHikcVmGM+A8opSgNDqYx47
	tYZx0bBbHhN9hc5MoG//ZcS9yj8jA2ZtWzJ4q/JzEw7LIX6B+LFq0BpPxiE9ouABYKwcUPapAmu96
	2sG09HcnRP32oFipSVb27cTvYo2XSAORm2xeQ7Nu47artynhMP8YXbo7H4fimnvX4DReaiIJBRJY5
	56B4hbFa9/+GUp0d1uH7yK8Dd5EUGxhSw0gox1/PIOVY1VdIoFRXUvQVYkuM4eIICO2V3Vp2wqUNU
	l+P0lEXyDMk8zQo5jNA/Qem2OnaSMdg+uDK3WjoWBvu9vSTAHvMsLNiKYsozHB0tIvhO8MVIxfv37
	BzrB1xKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsZT-00000005eHo-1Pgz;
	Mon, 17 Aug 2026 08:19:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsZR-00000005eHK-0KqC
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 08:19:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96D8068CFE; Mon, 17 Aug 2026 10:19:44 +0200 (CEST)
Date: Mon, 17 Aug 2026 10:19:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add opcode filtering for fault injection
Message-ID: <20260817081944.GA22618@lst.de>
References: <20260811231152.1138761-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811231152.1138761-1-mkhalfella@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_011949_265358_17CE77E1 
X-CRM114-Status: GOOD (  10.25  )
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


