Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E120BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 06:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ODiIi7s5TiHuocYZUzH1ZX7oYP
	qvEkp6cIAXlM+uv2b6XpiWqpqjUXX2QCbVB1lnuEOepoF8hcLeErip3ndBQ7QzXiOXBuHGnXs8Ugk
	5VljvsyH7i9WTLBA/iKiGlTZOgB/GDXR8nnjtfOLCvjNJiBe1SO/tXpzxxRhUosjVM7kXKHJ1R0Gq
	kUKHVv7PhGJh7KDyy9C1tZlBDvIX4g3nQM+Gi98BRXVxIrVx/Kgm8WMUWqXztro79wXXFTqxzcloK
	eNaCYQiJSwtsoDJZpm4x0lTarif+U8SmEGFvPl4TYlxcIoOhQSDY98kYHEPVxp3coalPr79D4rGPw
	YUF34BEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osI0E-003Anq-O3; Tue, 08 Nov 2022 06:22:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osI04-003AkV-5Y
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 06:22:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB2CD67373; Tue,  8 Nov 2022 07:22:09 +0100 (CET)
Date: Tue, 8 Nov 2022 07:22:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@fb.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Sagi Grimberg <sagi@grimberg.me>,
	Scott Bauer <scott.bauer@intel.com>,
	Rafael Antognolli <Rafael.Antognolli@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] block: sed-opal: kmalloc the cmd/resp buffers
Message-ID: <20221108062209.GA19929@lst.de>
References: <20220929224648.8997-4-Sergey.Semin@baikalelectronics.ru> <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107203944.31686-1-Sergey.Semin@baikalelectronics.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_222220_417412_3018BE3D 
X-CRM114-Status: GOOD (  10.29  )
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

