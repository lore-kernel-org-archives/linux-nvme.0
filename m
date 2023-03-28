Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EADC6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 00:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/t2Exh1aNgD7H1RvfNVbm59IjLguJZslXVJO1ueVkU=; b=4z7NLUT1XUs9SfoTnK6yIFa+IZ
	RQL4cqZyRfIwnyjZ5Y6WODmLCL55DpwX3xt9ZaXikEdd7R3m/OH7dv6e5YxRObcMWU7xrOg9oELZE
	U5E/PPcIfbr0atCT4YDXKGqq1z0vwnz/GJRKM7QQ5AYgyo3b5z0J2vk7g9uv+K+Og3sC8LZ2Zp7ld
	lc90aiKlvrNOx7y19N+pcCdQ3Qd6Ph03NuJuVmtDopkZDV4P24A03ykUqlJbmI6SscO0CE6kLa3jL
	he89hJPZ4u7mtFJGG3wOZ+0Bf0+jzoTSWMTxq8/TGM+3litoDGhcqnHhW0wcJ6AKM5NXHQHZoNwD5
	1rh3NagA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxPw-00CjQJ-2d;
	Tue, 28 Mar 2023 00:42:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxPt-00CjPr-2f
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 00:42:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27E4E68AA6; Tue, 28 Mar 2023 02:42:23 +0200 (CEST)
Date: Tue, 28 Mar 2023 02:42:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, hare@suse.de
Subject: Re: [PATCH V2 4/8] nvme-core: use normal pattern
Message-ID: <20230328004222.GB21054@lst.de>
References: <20230327060418.86655-1-kch@nvidia.com> <20230327060418.86655-5-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327060418.86655-5-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_174226_008703_C40BA00C 
X-CRM114-Status: GOOD (  13.60  )
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

On Sun, Mar 26, 2023 at 11:04:14PM -0700, Chaitanya Kulkarni wrote:
> Although return is allowed in the switch ... case when function is
> returing void, it creates confusion for future code which is desirable
> pattern to use for switch ... case. Repalce return in the switch with
> break that is standard pattern for the switch ... case.

I don't really see any point in doing that.  An early return makes it
clear what is going on here, and the logic is so that we really
should never have code after the switch as the calls inside the
switch statement "dispose" of the command, so anything done there
would cause use after free issues.

