Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD02C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Re1RnRUT4FBjDMUBBPk5apu8Mb+b0GtENlE8kQZow4A=; b=uFA9JUwpQEZIY3AgKoEUBGWHpv
	MMe1UITa1GewMU/d8LktyOLephFKJ2XtjQXHM4Lg3QwQkp6XOc/yDIYkXXViLogpwDmil+SExJpvd
	+S+D8txHc6rht1aXzsnIA0emeXAgKs/nQjQffLXjCJiwyaWliYV83S8E2YZJcwnWNeSGmt8SNhr/3
	aWAxiKfLqBXIoY61KEQzdQRNU/oU6oNJbQPKVoKfPDStPlgNuPP0OJWdz9ZP+pjKWnymkmtXZ3KDU
	qw0w027j2ArrD9ntYvWNdeRcffi9SWw70RMEtmeobIdllKuKMu/+FlZoOwGQpEwC+98gX/hlo1eXE
	kF11yq7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YUr-00CS18-Cs; Wed, 29 Jun 2022 14:16:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YUo-00CS09-QF
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 14:16:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FB8868AA6; Wed, 29 Jun 2022 16:16:44 +0200 (CEST)
Date: Wed, 29 Jun 2022 16:16:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pablo Greco <pgreco@centosproject.org>
Cc: stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG
 SX6000LNP (AKA SPECTRIX S40G)
Message-ID: <20220629141643.GC16855@lst.de>
References: <20220625121502.9092-1-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625121502.9092-1-pgreco@centosproject.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_071647_036638_25E4437D 
X-CRM114-Status: UNSURE (   8.73  )
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

Thanks,

added to nvme-5.19.

