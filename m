Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A451ECAAD3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=yAfWYotOu8Eh/IUWgzj5dzVtD1
	gtmY6e9BcScP6Zf8tkDVgpaktzmRrCExp39ESwnXtz9D9MNK1Djr5CAIfqXhxbSCROy0Fz6C3L5mF
	9fv2pOUxG9OFqhm+2OtOaE8RvqNhLPYbXW8y6IpdK3jxopqm4CyVVh6h+MbckFlU0SzbvoBG9/9yY
	yEDjdQUp8jWtSaBmG3TNkbL8nKUZu2PB308Zhl1Dmjz5vJ5uzLKMs7iqXdp3WF43Rwuy7NaVFd2rY
	allEMgsKFXH/uP/q6CUZktKuddSHjd0GQwDjMSmEhIRYp7VKBMJNBf7+Fws40j0ds/sclf50pvXon
	eM5htn8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVosP-003MPO-1Q; Wed, 07 Sep 2022 06:49:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVoiO-003IAY-2U
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 06:39:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E38567373; Wed,  7 Sep 2022 08:39:08 +0200 (CEST)
Date: Wed, 7 Sep 2022 08:39:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>
Cc: linux-nvme@lists.infradead.org, Niklas Cassel <niklas.cassel@wdc.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <damien.lemoal@wdc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvmet: fix mar and mor off-by-one errors
Message-ID: <20220907063908.GA21581@lst.de>
References: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_233912_584657_296ED9DE 
X-CRM114-Status: UNSURE (   8.43  )
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

applied to nvme-6.0.

