Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEB8D2127B
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9bIzrIihdcipzKF7iYz6VoA32I9H9GmU3Qk4oDZNZxE=; b=pf4D5i1u11LJL6LVBuxgkD/jkD
	uYhHQny6xoaxC/znO9vBjcitRhYr0LP4wObrf2hVgNgBgwS3upA5iRp4c13QemG/D50AC9vE3ECoN
	HC3HzoOKUG0PXfasQkroxV8wGGZAFeoJ5YwfEjAd938iAv3a/LUC7hKjI57p6XtyrnygtPoVaAJEq
	f6mQgJOMZVpMe35TR1ri5a+Sv5dtO7rrWUhLIkEhEMLRwKI+UtxSTxLp2I0clWdQRDNLdIJWsvpW6
	2xo20Mc0PUaZy+HiDP7Rkest3xzQtQFRm3hyWmQyX0d86jN6sr9kNowhk6YU7PjOW5edZf3Raf5vU
	EiIsGTEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1iwM-000000006yI-2r9s;
	Fri, 18 Oct 2024 09:06:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1it3-0000000060U-42VM
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 09:03:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6CE38227AB1; Fri, 18 Oct 2024 11:02:59 +0200 (CEST)
Date: Fri, 18 Oct 2024 11:02:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com
Subject: Re: [PATCH v4 11/11] scsi: add support for user-meta interface
Message-ID: <20241018090259.GA30253@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113757epcas5p42b95123c857e5d92d9cdec55e190ce4e@epcas5p4.samsung.com> <20241016112912.63542-12-anuj20.g@samsung.com> <20241017113923.GC1885@green245> <20241017143918.GC21905@lst.de> <20241018082648.GA32006@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018082648.GA32006@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241018_020310_163341_46E0E6C6 
X-CRM114-Status: GOOD (  16.87  )
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

On Fri, Oct 18, 2024 at 01:56:48PM +0530, Anuj Gupta wrote:
> > Just curious, do you have any user of the more fine grained checking
> > in NVMe?  If not we could support the SCSI semantics only and emulate
> > them using the fine grained NVMe semantics and have no portability
> > problems.
>  
> We can choose to support scsi semantics only and expose only the valid
> scsi combinations to userspace i.e.
> 
> 1. no check
> 2. guard check only
> 3. ref + app check only
> 4. guard + ref + app check
> 
> Something like this [*] on top of this series, untested though. Does
> this align with what you have in mind?

That is indeed what I had in mind.  But I'd really like to hear from
Martin on this as well.


