Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F18CC6B16
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HkzX19gz3nMXt7TC/rXohZ7rVS
	wtFccBMDFvJ3C5IGU3b9zlRK/SZpizfYBSQ7DrCwTbWp0D5mLHF8Ce/prOyhwRgd+8cGDjRhOsMIY
	w1qua6vy4doIpnXrqTakZjWFU/oQ5eUqZBEg3AAfWoxFb2qH/Ud72pMGTyk0YuspMlDpOIqAFYsmc
	9eEveG+bPDOvD/jUPNvuQFA6ge/h4rnt7XQdSPivYLHmt9qqs454K++GkiwtaCuBazzQ2vBjU2wj2
	KHvDGJAOpYiVJBeLZ89PjeF8qmph5q11XP5rpCFBxehCD2WMaY6Gx820RatPJdFX3gj41UqigriCn
	8MvKZMKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdRC-0000000D5Az-1qRY;
	Tue, 13 Oct 2026 14:25:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdR9-0000000D5AH-1R8Z
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:25:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1A4D5227A88; Tue, 13 Oct 2026 16:24:59 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:24:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Palla Raghunath <raghunathpalla.0209@gmail.com>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+da94a51633758d13bd63@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvmet-fc: don't drop the last assoc reference in
 nvmet_fc_delete_ctrl()
Message-ID: <20261013142458.GB14759@lst.de>
References: <20261008191848.47066-1-raghunathpalla.0209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008191848.47066-1-raghunathpalla.0209@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_072503_527853_4927F82C 
X-CRM114-Status: UNSURE (   8.75  )
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


