Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F27CC25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 19:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DX4jCOclDHQIr/NfrQ4W+rbfPQDWPjHCjMBaY7jrqjs=; b=i6CuwWK2zJ/IG7DldMbrAVYY2B
	Ghd5IfL4DlV5K5Sm1ED23VGd2IMpnWGiGH+6Bj34JJF2gdJ/FOOPdRV+/C9syNqJpUXjxVTgv5y1b
	fng9AcVWoDtvJLEiaYv6yR6sModayxBSR59BOTDkW5QxMmC8Woxo5XUqLboyhSOHD5AY4CYUBJTiT
	BC3zFEPof3PJnnQO6KHOUlSbY46OR2v9Fgw12fRQLmWeBO9mfxGX1Un45O82vYjOYYpPS4LOgm7vA
	/+Xv8DBWAWHPo8wapKsa4Ep7k7GHXeIwa3dR2flannpDlYbd29fF0O/qDp4ip+uJpfjJz1+Yh++HC
	fqZTmJ+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9VKL-00000000vhp-1eb4;
	Tue, 21 May 2024 19:39:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9VKH-00000000vfi-40ki
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 19:39:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 26D4268C7B; Tue, 21 May 2024 21:39:07 +0200 (CEST)
Date: Tue, 21 May 2024 21:39:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: fix ns enable/disable possible hang
Message-ID: <20240521193906.GA30536@lst.de>
References: <20240521085623.87681-1-sagi@grimberg.me> <20240521085623.87681-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521085623.87681-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_123910_249771_ED54E4BB 
X-CRM114-Status: GOOD (  16.59  )
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

On Tue, May 21, 2024 at 11:56:23AM +0300, Sagi Grimberg wrote:
> When disabling an nvmet namespace, there is a period where
> the subsys->lock is released, as the ns disable waits for
> backend IO to complete, and the ns percpu ref to be properly
> killed. The original intent was to avoid taking the subsystem
> lock for a prolong period as other processes may need to acquire
> it (for example new incoming connections).
> 
> However, it opens up a window where another process may come in
> and enable the ns, (re)intiailizing the ns percpu_ref, causing
> the disable sequence to hang.
> 
> Solve this by taking the global nvmet_config_sem over the entire
> configfs enable/disable sequence.

Can you use up all 73 characters for the commit log and add a little
comment to the code on why nvmet_config_sem is taken to the code?

With that this looks good to me.


