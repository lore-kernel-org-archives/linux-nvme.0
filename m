Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7012BC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 07:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qWN3TqdSXOCr4PWFLYrvUh6gqqfuzicVhlDx3EwPo4o=; b=AtKTcM0DZ+dUwTQeGjcYA8/f1M
	Ot39MkYtXhHtVuRVW12q9Z4yr+nvkqyFJ3DbxItW8hZAiMU55p1UJbWDVd+S0J9MP0biFvtQws1db
	Mb6aDMBTijeu/JZUK+Srso2c8I9OCMK6Yc9IqwXnD67XxRVrNaqiWyuvigJHUR8dsnbHeXH98zxMG
	6fq3+bC1wK4wP9zWQrSyJGOPk+9WAi7puMQv42GAGTUN1I9eaZw8hQF1uV/fgc8X6SxNn+qaE7gvv
	ZQM2gKUOZcIhGzDaBwXDAiq3kWyBAqyORRKkCUXQ56sgeT6iCJ4jFphI7ZQ7sMgSekStEiW+TO5Xp
	hGjC5l2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Mg3-00EMnc-Js; Wed, 14 Dec 2022 07:59:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Mg0-00EMmq-VV
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 07:59:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70F9767373; Wed, 14 Dec 2022 08:59:37 +0100 (CET)
Date: Wed, 14 Dec 2022 08:59:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/7] nvmet: allow async passthrough of commands that
 change logical block contents
Message-ID: <20221214075937.GB4250@lst.de>
References: <20221213162453.584965-1-hch@lst.de> <20221213162453.584965-4-hch@lst.de> <e80c7fdc-09b3-111f-d479-54ab49008679@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80c7fdc-09b3-111f-d479-54ab49008679@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_235941_175370_B6FB5DDF 
X-CRM114-Status: GOOD (  16.84  )
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

On Wed, Dec 14, 2022 at 04:52:47AM +0000, Chaitanya Kulkarni wrote:
> > -	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
> > -	if (req->p.use_workqueue || effects) {
> > +	if (nvme_command_effects(ctrl, ns, req->cmd->common.opcode) &
> > +	    ~NVME_CMD_EFFECTS_LBCC)
> > +		req->p.use_workqueue = true;
> > +
> 
> How about this instead of calling function in if which is much cleaner
> unless it has a bug ?
> 
> effect = nvme_command_effects(ctrl, ns, req->cmd->common.opcode); 
> 
> req->p.use_workqueue = effetcs & ~NVME_CMD_EFFECTS_LBCC;

This would clear the bit if it is already set.  The being said
I'm not a fan of how the use_workqueue flag is set, and I now have
an idea on how to remove it entirely.

