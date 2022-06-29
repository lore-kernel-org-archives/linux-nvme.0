Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BC3C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 14:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Re1RnRUT4FBjDMUBBPk5apu8Mb+b0GtENlE8kQZow4A=; b=JDwyzf540eD3NGDyT/l/T9j3IQ
	ApXeR7OcF5PA13oJVg9xwjTWM+7cV4s2zwL7gayAuaosKjcAxUXwqNs3ADY6B7CHVynFUHk0o2Yoh
	b3KbBW7u9chLXzeMSyrLl0Zml+3TXUtbIFDeiyAAfJo9wR8puTPUsdlHm1wSoW7ftzn65Q6ih+AmG
	jFNr/Wd58uQxV+gvGsONFG5tFAeivI342fvq21DDxTaEopn23XoFEXvpLUxgnDitaowszfLg3iYbY
	Rh3EF+tHDC3zuMQSQo2GIkFmwoBWQfrSIJutjy4b/7FDfUINVwp2L+onolZFkWZ0V7kcxd0Jxkuqq
	Lr3qCxpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YUh-00CRx8-Ft; Wed, 29 Jun 2022 14:16:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6YUf-00CRwd-BC
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 14:16:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0623068AA6; Wed, 29 Jun 2022 16:16:33 +0200 (CEST)
Date: Wed, 29 Jun 2022 16:16:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] nvme-tcp: always fail a request when sending it failed
Message-ID: <20220629141632.GB16855@lst.de>
References: <20220626092451.32694-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626092451.32694-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_071637_572090_C7260C06 
X-CRM114-Status: UNSURE (   9.23  )
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


