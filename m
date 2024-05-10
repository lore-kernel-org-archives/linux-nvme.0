Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73280C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mDWdy40phobtDo1EYqidBkOvRKcJzKGMzhog4C78HJY=; b=2Brvw4rR7GyKYnqJ43qb99ftGN
	CRLpwqyjQmiaG7xC8xsvJVvPLt/rE85eY+cDQCi8WKOcq6RtgtAEM4fM2J/vVcRUfN/efWmAPyTyW
	gEjmKyuWc3oFSUGuxXuExVYftIbhkikaUtgTKH1HLPvPcTyoeI4gzK55Ld03WtH81Bk8enUybXJsn
	KBGcsYYuVe3uWU7KpNKnUNEqdARoJuTr2BhgVv3Dei28jRLJD9wNFdsKDQzee1VfHVhP+sogvl7cQ
	lN0x2PZ+rHrhHUkexBuu692WzdhMI6ljjVazdp2UuLVRVOVAxNBW50n07hPrHnnJOiI9b+kmYk7NE
	QGJM5qtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Ygl-00000006elJ-1mri;
	Fri, 10 May 2024 22:26:03 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Ygk-00000006el1-09cN
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 May 2024 22:26:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mDWdy40phobtDo1EYqidBkOvRKcJzKGMzhog4C78HJY=; b=MHxa5dB+sqNtijGkFw4AHM8W4V
	Ddagdkvy3FPcGX2jB4RsXpDirYH5okbQr+z4gYtCZy4iANrrAJFQZM2ZzA+pUL0tPEyDI0XFMZCDr
	/l/jaaJCIMuzMCGjtTa2Ta+kMs0dW2Xnx1gLUrsKWwbkv231ptMD9MxDwPvVEHPNRpqXI2+0qOblU
	oMWecHC92bU5Z22yYjnp+T5RMFK9FPQVqjZ38tsCf1xCPdJp8N2Z1DgQoKXwvlzdFHrr/x7asCSyL
	WjKmtHp6qxkw0EztiB/HY8yKqaqNw3EZ+Thstfbgw/kns3PFDllJkj9zk+XdZ/TyIXOOB8TF7A7Kv
	y48RNoCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Ygh-000000044WW-2w7P;
	Fri, 10 May 2024 22:25:59 +0000
Date: Fri, 10 May 2024 23:25:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Message-ID: <Zj6e95dncIn-Zrlh@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-4-hare@kernel.org>
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

On Fri, May 10, 2024 at 12:29:04PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> We now can support blocksizes larger than PAGE_SIZE, so lift
> the restriction.

Do we need to make this conditional on a CONFIG option?  Not all
architectures support THP yet ... which means they don't support
large folios.  We should fix that, but it is well below the cutoff line
on my todo list.

