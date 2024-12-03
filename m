Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B538AE74AC3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fIK/RbYU/aXBlUMf+Ph2rtG19zfOgze0Dhfrd71BZZc=; b=hSQUGGDZmingawzioaFCwQT5I+
	DMB4WqROi47ecq0uGGzoZYvodCRmGAQoZzLfagRTf2J+hXjb8cedkpJ5P1FS5oaHOUpjOzkHUTeJd
	DiBjStcebz8KWJbzp6JG5hr7IRtcO5I/qwU4ICFgqchDj1a5VI/lt4NOFfkh81UCQ7tzJ2/u2f1NJ
	soe5rkgLMo+omHKZhLw2MJ9AV5TzAn+qhvkGwpSpxcqTNMMWAKnmqltvBjEgjPtY4/SycX3U3jg0M
	Na47hccygHEeg8o719SqJTnn7odvzxa3WuIUucf88gJSaxmHvPD9pfno78ZZjYDZrRcBOEWOvVL90
	5dvFWrXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIYAx-0000000AQqr-3cYS;
	Tue, 03 Dec 2024 19:03:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIYAv-0000000AQqC-00lu
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 19:03:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 74F735C668A;
	Tue,  3 Dec 2024 19:02:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C58C4CECF;
	Tue,  3 Dec 2024 19:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733252588;
	bh=r6PY5qRAnByAm7avPHzxx/5PJKv4Ib39Av3nvg7mr3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbVJTBdRo7gAFtRqj57j3XtKk2Ep9JVy3lV8mlehu6fhmm8KXBCKkCEpDat/DskVi
	 FCuoyPHKjuSKfvb+8L78SbqOLMteAsuYF/KyY4Coin2Ayj2UcWtoMPOn9GQxfzPeKO
	 9G9AMLPSV5rynrNs4Wj7GfC+7OjNdjYFISJMzTe5CoO5VulZuspkGisptZ05O742uZ
	 hebNGekOZW4TuMbbgG8NYDMjHo7koWC4GziSszEimd/PlWAw1qjZY5KnKgOSaZ02yF
	 1zXyDOpvae4azjkVa6W0l5BIpDHhLnsk3AQhuJAFnA/TKfcYSoPrcryTFgBgELsGQQ
	 ZeNa3zg1gZdpw==
Date: Tue, 3 Dec 2024 11:03:05 -0800
From: Keith Busch <kbusch@kernel.org>
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	visitorckw@gmail.com, jserv@ccns.ncku.edu.tw,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] nvmet: replace kmalloc + memset with kzalloc for data
 allocation
Message-ID: <Z09V6QHNxGS5FTyB@kbusch-mbp>
References: <20241130170258.103954-1-eleanor15x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130170258.103954-1-eleanor15x@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_110309_083716_C6D64BD8 
X-CRM114-Status: UNSURE (   9.36  )
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

On Sun, Dec 01, 2024 at 01:02:58AM +0800, Yu-Chun Lin wrote:
> cocci warnings: (new ones prefixed by >>)
> >> drivers/nvme/target/pr.c:831:8-15: WARNING: kzalloc should be used for data, instead of kmalloc/memset
> 
> The pattern of using 'kmalloc' followed by 'memset' is replaced with
> 'kzalloc', which is functionally equivalent to 'kmalloc' + 'memset',
> but more efficient. 'kzalloc' automatically zeroes the allocated
> memory, making it a faster and more streamlined solution.

Thanks, applied to nvme-6.13.

