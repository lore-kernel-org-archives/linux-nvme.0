Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F81C05027
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Feb 2023 10:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f63LQtC4cHw2z29cI47feKvU6sh20Nz7t+u6mSN3sj4=; b=t6mJRUMvEADLtVuh7pGFQJrw3s
	BLMxhCOwZn/SgHEeBTGXmoJmBFvVWorJum/mwpaSlsLKnuFaI9/ZVq2mTdC/pmyIuiXkiXRLG3LOn
	xIIlXrv/uFlZeatCffN0EMjcSOs5T4JEJ3GdLLDTToHCPaPqRHS2g1ADQ10qtq/4ugJx0fPD9Sl6x
	tvDp8LJ1XXR6bBC8Y3ffF+TcFn55Nrkvlbvh8mkqGybYQlsbLVZoiG88wsDLS62Nbl9YavHJl5jUJ
	nTOXJ2DcdIGcSkZYsdSrMyU1gWdk0+aSdsd3IiwYktFs7YpjJzuxRy/FW3fX09aMAvwz0nzyRH5xu
	Qf9Yc4Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNWfm-00FLgJ-9d; Thu, 02 Feb 2023 10:18:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNWfi-00FLfe-Jb
	for linux-nvme@lists.infradead.org; Thu, 02 Feb 2023 10:18:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53F1168C7B; Thu,  2 Feb 2023 11:18:19 +0100 (CET)
Date: Thu, 2 Feb 2023 11:18:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <20230202101818.GB14931@lst.de>
References: <20230130101449.1772800-1-hch@lst.de> <Y9gN+FsDZQBcKJvk@kbusch-mbp.dhcp.thefacebook.com> <Y9gP0MvNpC/dgxQn@kbusch-mbp.dhcp.thefacebook.com> <20230131085828.GB3139@lst.de> <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com> <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230202_021826_806281_CF0DE094 
X-CRM114-Status: GOOD (  14.12  )
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

On Wed, Feb 01, 2023 at 10:58:40PM +0000, Grochowski, Maciej wrote:
> Hi Keith!
> 
> I updated kernel on my machine into 5.15.87 sources and I run same experiment with aer_inject tool.
> As a result I got followed error and nvme disappeared:
> 
> nvme 0000:02:00.0: can't change power state from D3cold to D0 (config space inaccessible)

I've been trying to look for this code in latest upstream and it has
changed entirely.  Any chance you could do a quick run with Linux 6.1?

