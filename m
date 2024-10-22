Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5F0D1CDA1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 07:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l6TVX7d4tIJYvy7TegVVtN6Z6JSO2dQYPZsi91HgRII=; b=2vgPN7R0+J13RpK8CGFvjz+YcR
	N+pGQVmeKUHZ9If05v7Lr2+AHzn2OnmAztEkJADmePat6HsfgtcGFSW3z6dfu33aOOEel0Lu8PFDi
	vzUQ1zGjLT6IbE/a6KimjwaaXQ49RNb8h6EX5A+xNGIbLD6nCOoyA9zaMVqHH6HhXDkTLPCux+cxA
	g9yxELEvgFo/q64Z/Ew8RszXqF5VM1L4z1Qo3fUZSxWXY9vNtZaUKXQYw8qyzwESd9ypcUi8NDNhL
	pvYHQqaDQtrf7fAzCfIAT0FMISCiK6kToGU0g7IhhT88kcZS1IRC7LDnaPCK65aXGy+JnrDKLtboT
	dIylxfxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t38uz-00000009uK1-0WP9;
	Tue, 22 Oct 2024 07:03:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t38ux-00000009uJZ-15bZ
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 07:03:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 072C4227AA8; Tue, 22 Oct 2024 09:02:53 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:02:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvme-loop: set blocking flag
Message-ID: <20241022070252.GA11389@lst.de>
References: <20241017172052.2603389-1-kbusch@meta.com> <7846e57b-fb03-42ed-af8e-0df88cc566a4@kernel.dk> <ZxFRpdU-GI76uetA@kbusch-mbp.dhcp.thefacebook.com> <20241018051056.GC19831@lst.de> <64f4d599-3261-4544-90c2-4cb3e1ad96fb@grimberg.me> <20241022062810.GC10573@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022062810.GC10573@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_000259_460068_BE1BC28A 
X-CRM114-Status: GOOD (  17.63  )
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

On Tue, Oct 22, 2024 at 08:28:10AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 21, 2024 at 12:35:17AM +0300, Sagi Grimberg wrote:
> >> Let me see what I can do.
> >
> > Note, the search is ONLY in the error case, i.e. when nsid is not found in
> > subsys->namespaces.
> 
> Which kinda makes it worse as we use an unusual context just from
> that rare error path.

I just took a very quick look, and inserting the namespace into the
xarray when created and only removing it when it is deleted, and
instead checking an enabled flag during lookup should do the work.

Do we have a good test case for commit 505363957fad ?

> 
---end quoted text---

