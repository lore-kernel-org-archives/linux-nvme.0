Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC26BC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Re1RnRUT4FBjDMUBBPk5apu8Mb+b0GtENlE8kQZow4A=; b=OSWZ3hfOZvdLKVhAeVca96/Ve2
	HpX1CTDj8JZ2UgvlDhXpPBYmDZhzUB8okkZt9JEH99apqPTKWpv856XWava6LOvXonGw5KXvGpEfr
	1qR5R6dZlfybPbrwgT9vQBlu5drDlWQrYYHkLLaAfmg2Kq+Nhw0qKm9DFss4cmUxqvfZM1w1yInd5
	QeJ5A5VbB/pqhKsTC3eNEfe3DdHfTNI88qdwtNTBauSUY+3wmJGJBYnIibAaDGxF/Jy3vc8OHwkN9
	GZ5+76rcuhTzKlm+QqeT3YyPZ3NuuZN1fly1fOrEfzDhWvbAujI2cY3vHOyLDNanhu34ZW2LTevNI
	s5+DWUiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YVJ-00CSD2-2V; Wed, 29 Jun 2022 14:17:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YVG-00CSBm-F7
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 14:17:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B10AD68BFE; Wed, 29 Jun 2022 16:17:11 +0200 (CEST)
Date: Wed, 29 Jun 2022 16:17:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet-tcp: fix regression in data_digest calculation
Message-ID: <20220629141710.GD16855@lst.de>
References: <20220623214953.1347335-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623214953.1347335-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_071714_670274_AA23153A 
X-CRM114-Status: UNSURE (   8.79  )
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

