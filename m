Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EA5C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4y0EK42c0xOdZd7uGjT8s/te2h9RKUxLnuqXte/W46w=; b=mfXbqIaN1ZpGWDfJSNvws/bHgl
	mD2xhDqTZD7QivJhmooXT+kABiNx4U7HgvpHIursDTtTEFDnuhj70biQ0K31j9vxsUOv1WGppV4D1
	ypFxziU+YccU7UXFQuaV2/Pcdcu30U1Pg33HMFkkppP/pUOZSCDsg8flNo9/GGfYSasLQC76zgZvb
	To7yZB9Seh3a9m+eNQmS3vhWi1HW+Gg35wvfqrDhIiagG2mHYURG8JSWfQCCciMx54+mdORsrbgKZ
	XbCfgxYiMRdlul0xrGMNofmIANRJDZD0rubKTmcKgA2+zq/Kkma3WwjGD4YoZgwdTOFGVSQIS/k0t
	xfDf802A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9opm-00000003Wzt-3yBe;
	Wed, 22 May 2024 16:28:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9oph-00000003WzQ-3vcw
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 16:28:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 175AC68BEB; Wed, 22 May 2024 18:28:46 +0200 (CEST)
Date: Wed, 22 May 2024 18:28:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Message-ID: <20240522162845.GA16783@lst.de>
References: <20240522091534.472449-1-sagi@grimberg.me> <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm> <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_092855_533653_4CCA1754 
X-CRM114-Status: GOOD (  12.00  )
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

On Wed, May 22, 2024 at 10:12:19AM -0600, Keith Busch wrote:
> > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> This is not desireable, but I give up trying to appease lockdep for this
> one.

lockdep_off is a cure that's worth than the desease.  If we can't
explain the "can't happen" using lockdep classes I don't see how
we could actually be sure that it can't happen.

