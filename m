Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F32DC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 08:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jyITHcMFITmw5Cna3GrDdC2HlC7k0Rr7t2c0UgUkLH8=; b=T4ZsCOpYam/IDxJ/dtAAOFywVB
	bdLYTVpfghZA+YyUcNEfkIqUpn9VWM5wpFi0CfbZgA6ToauQvDz+lHLULxV0ARLUWCME3q2BSbglX
	HOyt0YmRE147s5OKuiEAKIpzdwuyIOkwlfrV8JyLMHtRjQJtRdrXuc6whiAcfTM4PxPkrCabQZn9u
	WEnLmuK68SPHA7gG1sklcGYSac8YDZ++o+FUPtr3bX3x/CZmbcdfdUhaAxOYyivelYoQN31ly7PXu
	X0zhphssRGCI9USpYWL8K+BD7PuPOT/efWgyHjxK2wUQPclezBqCEkTcD1dBxrGDNaZkwzjZpuk5L
	4CaLzEDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3gu-00ECkf-9v; Sun, 30 Oct 2022 08:29:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op3gq-00ECjQ-S7
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 08:29:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC0B268AFE; Sun, 30 Oct 2022 09:29:05 +0100 (CET)
Date: Sun, 30 Oct 2022 09:29:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Aleksandr Miloserdov <a.miloserdov@yadro.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, linux@yadro.com,
	Dmitriy Bogdanov <d.bogdanov@yadro.com>
Subject: Re: [PATCH 2/3] nvmet: expose IEEE OUI to configfs
Message-ID: <20221030082905.GC4949@lst.de>
References: <20221026083135.77125-1-a.miloserdov@yadro.com> <20221026083135.77125-3-a.miloserdov@yadro.com> <6f630727-72bc-6ae8-e23f-dece692c31e7@grimberg.me> <Y1u+D80ohMF8bbPJ@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1u+D80ohMF8bbPJ@yadro.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_012909_074686_C377DA34 
X-CRM114-Status: GOOD (  12.78  )
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

On Fri, Oct 28, 2022 at 02:33:35PM +0300, Konstantin Shelekhin wrote:
> While there: we have a little internal bikeshedding on how to actually
> name the ConfigFS parameter :D
> 
> Weirdly in this part of the spec it's called IEEE instead of OUI,
> however in other parts (like EUI64 generation) it's referenced as OUI.
> To the end user it makes more sense to call it simply OUI. So basically
> we have:
> 
>   attr_ieee
>   attr_oui
>   attr_ieee_oui
> 
> Purely a style nitpicking, but what's your stance?

The NVMe naming is indeed rather odd.  I'd be tempted to just follow
it anyway.

