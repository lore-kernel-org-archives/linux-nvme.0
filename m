Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EFFC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 14:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZqqpe28dRRjtcj8paJMydLgJAN/mQEWo2K+PUXeBAc=; b=C5/g9dlxmctBh4CowCkQEG+krZ
	RQwTHIMYvtYrP2yxTBZfcRsgWgQoOnDcgxJ8z7bmc1WChrGXx55wBVdRV05PJ1GcIPvw32ZTphW6W
	eNmRo+osHMCd6Of95INRFdyVFHjyIL0/yDQUd3xVPBtHCWiGwtkXmmIfvfIvH4sqrOB9RwiSd5tgn
	XzeeotxTg1usL0b+sO88ThubCkSeoIGcp0bp7Hcf/iBpXF7W4SN786BAWe5QUr0o3VDA+3AaJap9e
	6AFWWGWthFfKKDkc58T1h1itEaAMnHcRIEr/bcnxsh2o3vE0QgGqKwf4K14rNAkpyLf6k0knlNz9w
	tAzkjL9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oknuP-007NYQ-17; Tue, 18 Oct 2022 14:49:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oknuM-007NXC-Im
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 14:49:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 660A068C4E; Tue, 18 Oct 2022 16:49:25 +0200 (CEST)
Date: Tue, 18 Oct 2022 16:49:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Serge Semin <Sergey.Semin@baikalelectronics.ru>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Guenter Roeck <linux@roeck-us.net>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] nvme-hwmon: Kmalloc the NVME SMART log buffer
Message-ID: <20221018144924.GB20131@lst.de>
References: <20220929224648.8997-1-Sergey.Semin@baikalelectronics.ru> <20220929224648.8997-3-Sergey.Semin@baikalelectronics.ru> <20221017071832.GB30661@lst.de> <20221017161656.hzmsgqpuvqpmriqs@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017161656.hzmsgqpuvqpmriqs@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_074930_787812_7B72A5DE 
X-CRM114-Status: GOOD (  15.29  )
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

On Mon, Oct 17, 2022 at 07:16:56PM +0300, Serge Semin wrote:
> Please note the applied patch doesn't comply with the Keith' notes
> Link: https://lore.kernel.org/linux-nvme/YzxueNRODpry8L0%2F@kbusch-mbp.dhcp.thefacebook.com/
> Meanwhile without patch #1 (having only the accepted by you patch
> applied) the NVME hwmon init now seems contradicting: it ignores one
> kmalloc failure (returns zero) but fails on another one (returns
> -ENOMEM). I asked you to have a look at the patches #1 and #2 of the
> series
> Link: https://lore.kernel.org/linux-nvme/20221007100134.faaekmuqyd5vy34m@mobilestation/
> and give your opinion whether the re-spin was required: take the
> Keith' notes or keep the patches as is. Could you please clarify the
> situation?

I'll fix this patch up to follow the recommendation from Keith, I somehow
thought this was already done.

