Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557CAFF8875
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Apr 2026 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M+gVySjyJbUTSLW/MNoSWcg/GGChfg99AOPdIoCSR9I=; b=cb2oWN40IH8beWrZyufbFobSOd
	2kF9XrhtC78+V4Yi5IReZ7fQ9Ef+2v+ONmcN+b5vqUV06/tsgSlkd+BG0fMwZRB292vKSpFoln+Qx
	DS3L8az/9oOwb/rO2DdWtFDuBeQj40o7VBwIV4/m6dYrvOQs5tXQviZL69VdxpNKlqjaLww+CoxtQ
	8bDLDqAeaZS1wl8lxs9LHxac5e2I7MoglvG8LYMn9PPU1zRA+Y+mKuQ36c7XydfX4K7g3EajKNm+X
	6dyAXUfcslH88UmMg92Z1/mLpdiOzsS12Z3Io1VDCk3o4liyAdiH/gOMTdBHpKqlMOBsKa51NswFX
	RBUsnkGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIPHr-00000005K02-41Ss;
	Thu, 30 Apr 2026 11:10:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIPHl-00000005JpW-0DmS
	for linux-nvme@lists.infradead.org;
	Thu, 30 Apr 2026 11:10:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 18FD26057A;
	Thu, 30 Apr 2026 11:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BEEC2BCB4;
	Thu, 30 Apr 2026 11:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777547422;
	bh=M+gVySjyJbUTSLW/MNoSWcg/GGChfg99AOPdIoCSR9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNOEjUkI+b2dSq/zNcgw/LPZTq/C6GqykdakQ2VHSXtyRyWE1qOVeH5J8ZHnwMq9s
	 L82W0eJscbpJfC/3z/1ahV4nrWeTCaqsIUYvh0z48pFGPL8awFGPRDbVWcPhFb8zXo
	 s4vY2PC5mPOgphXJ6b7Y/WpO42l0NzHv0/IjucQHykF5kWHhxuVoQkdEQUfeIPt5EZ
	 0WJjyfZWjGuwLR3NQ6ixamvdfr5ulJs0+sluNua1p22YSuJhAXD4mvFJMWMRyM/oV8
	 O2YhJrnNorBkDE5luavHIfBi7WDUGkCtxkmjjHR/iub5mqV+3vvMlxXrDq1aKrh0E/
	 E8dVYygRA2K6A==
Date: Thu, 30 Apr 2026 12:10:15 +0100
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Cc: kernel test robot <lkp@intel.com>, "hch@lst.de" <hch@lst.de>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v6] nvme: Skip trace complete_rq on host path error
Message-ID: <afM4lwLRimijbmS8@kbusch-mbp>
References: <202604300750.YpUGtmek-lkp@intel.com>
 <20260416010713epcms2p78575bd400f93f6edb7fe3f3ead5bf930@epcms2p7>
 <CGME20260430051839epcas2p20fce5951dc4a04138033e5943f1acdbf@epcms2p8>
 <20260430053401epcms2p88c3cac0c3b817015d718cc0f4914532b@epcms2p8>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260430053401epcms2p88c3cac0c3b817015d718cc0f4914532b@epcms2p8>
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

On Thu, Apr 30, 2026 at 02:34:01PM +0900, 전민식 wrote:
> Are you planning to apply your local fix directly?

It's already committed to the block tree and should land upstream this
week.

