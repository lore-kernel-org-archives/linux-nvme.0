Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8902C46467
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Dec 2022 16:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v+zCI39HBXe8fAnCmdwTKj9dxUz+pCzmRDrsowY8QLQ=; b=GAhMl3hNSTeaQ5GX4l+y4nclzT
	HFLoDEz7hhLzQagnB6ufooINcH50FiXxKl3BrkC11aOEe/By23idbZi+ZHAH43CBKbmoEV9b/NbbX
	ZIVpdCKUT4D8YPCTVDN7PJCDuhujgLbQpvlX9vUxvqwtthIzaiW1N4DPLNrk7kpMtUJh18aL4R+qI
	gb9dgoKgPpjBno0JUlnd+XVf27Y/pJAqNdaRGtkNxFVagDcC+zhhG/qPB6iJeQaz1Deak2SHPShqf
	bqFG0ZyIEYm7qF6c4jU+HiZpoc5L4thq3uuX06alcsf0YijHDp8wPSReP61IuKyuT1TZzZSbW84Uo
	XoGZTvYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAYwF-006CDk-Ja; Wed, 28 Dec 2022 16:05:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAYwD-006CBF-4a
	for linux-nvme@lists.infradead.org; Wed, 28 Dec 2022 16:05:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B50B668C7B; Wed, 28 Dec 2022 17:05:49 +0100 (CET)
Date: Wed, 28 Dec 2022 17:05:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: only allow unprivileged passthrough for commands without
 effects v4
Message-ID: <20221228160549.GA788@lst.de>
References: <20221223071814.43564-1-hch@lst.de> <Y6xpDBVGXljBWNsP@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6xpDBVGXljBWNsP@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_080553_352188_9BBEF2CE 
X-CRM114-Status: GOOD (  13.56  )
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

On Wed, Dec 28, 2022 at 09:04:28AM -0700, Keith Busch wrote:
> Series looks good to go.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> Unless you're already on it, I'd be happy to take a shot at the
> improvements we discussed earlier for the next merge window.

I still have the current versions of those stashed away from the
last iteration, but as they'd need a rebase anyway I'll happily leave
that to you.

