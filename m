Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA00C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 06:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dUiIiMcRNV0/EisTLoCzK1N0eHx3Feg8TOv1fCz87j4=; b=wtsf4Wp1Qr8JMRbtLPKM6jq6pg
	RZ1wb02pKZ2P0l87DW+ljm7ERohXjred5xoH7Aw6cNq+DQ1rTwluu72gk3Qve2JmcX1E9uslMCM2q
	+jRIuhmVDdChTVaGb0XdsuiM/OfaKCyBzOfmVAznB9sRQ14J/+uJOg/W2x0rcyHv3IR5EnxhJTwPL
	AE+PhvO0gGJNTHUryUC5z1Ub8Z5/ZbvaEnH2Lfi1PV+5ijDigRdB9RF6nwKiw5sgXXt4HpCWmRLVb
	+QAsrHwbZjAR9UROuaakzi4MwQ+wN8fSBbAPGMZ+GNE9V0aX3CYZTb61bIkAYk+lzp7DZkUWpaehY
	GR1IuX3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE328-0017Bv-Mp; Wed, 20 Jul 2022 06:18:08 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE326-00176O-LJ; Wed, 20 Jul 2022 06:18:06 +0000
Date: Tue, 19 Jul 2022 23:18:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/tcp triggered WARNING at
 kernel/workqueue.c:2628 check_flush_dependency+0x110/0x14c
Message-ID: <YteeHq8TJBncRvZu@infradead.org>
References: <CAHj4cs86Dm577NK-C+bW6=+mv2V3KOpQCG0Vg6xZrSGzNijX4g@mail.gmail.com>
 <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ce566fd-f871-48dc-1cb7-30b745c58f05@grimberg.me>
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

On Sun, Jul 10, 2022 at 12:41:33PM +0300, Sagi Grimberg wrote:
> 
> > Hello
> > 
> > I reproduced this issue on the linux-block/for-next, pls help check
> > it, feel free to let me know if you need info/test, thanks.
> 
> 
> These reports are making me tired... Should we just remove
> MEM_RECLAIM from all nvme/nvmet workqueues are be done with
> it?
> 
> The only downside is that nvme reset/error-recovery will
> also be susceptible for low-memory situation...

We can't just do that.  We need to sort out the dependency chains
properly.

