Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B927C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=16flwnJOLHk2cA9kmZHVVcS9bSnf9tyI8d8bncmaE+0=; b=SjonEb6BMxuQZu1UeYje9VtzvF
	w7ifQq0BcM1dRnhhQzZZ05lvau3GLsmE8ddfksg2pVtHwGNi2b1cuO450qCQLyKV9pS9GqQJ0uENH
	AAeIRfOYQ1IfcOsVVoCZz3QMbylA3g4c56I7/rjMQJsC1yH+NfQWjBZ32ybhPqRfatLD3USuOQChb
	Na46TH8gVgdr6nHdp1Ag9gyH/ABNrgFUX2FT2XuMoi6gjwUFMoUgIAmaIfojEatLDbayBLg1bKmYd
	Lewo92foT/R9HYOzUswhBUN15of5+wzsJvyCag6d5ZLcmojPzvzT6saQUZpKFDow+mWmhQoae3M1u
	RcxOX8nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1QeP-00E03j-Ld; Wed, 15 Jun 2022 10:53:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1QeL-00Dzzr-PY
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 10:53:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2919A68AA6; Wed, 15 Jun 2022 12:53:17 +0200 (CEST)
Date: Wed, 15 Jun 2022 12:53:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvme: Report model,sn,fw,pci device information
 during init
Message-ID: <20220615105316.GA7911@lst.de>
References: <20220614210902.744318-1-e.velu@criteo.com> <20220614210902.744318-2-e.velu@criteo.com> <Yqj94JXMwjrdSbqG@kbusch-mbp.dhcp.thefacebook.com> <20220615053729.GA21858@lst.de> <CAL2JzuwnZhMgaVQ0=LAYfe6pWnxGLgR_b4xdF_==F3vL_Hh=gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL2JzuwnZhMgaVQ0=LAYfe6pWnxGLgR_b4xdF_==F3vL_Hh=gw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_035326_029691_29090882 
X-CRM114-Status: GOOD (  16.02  )
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

On Wed, Jun 15, 2022 at 09:57:05AM +0200, Erwan Velu wrote:
> > I would much prefer to not print it all.  The Linux boot is way to spammy
> > to start with and this doesn't add any real value.
> >
> 
> I know the boot is a bit spammy but when systems crash because of nvme
> drives, that's very handy to get a trace showing who was the culprit and
> what drive is installed (including the fw version which is usually a major
> source of troubles).

Well, usually they are all the same or a very small set of different
SKUs compared to the total number of drives.

