Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1948C43217
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 16:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C24FPsgXXhsB/kKeYIS2rWeP3XRB7KW3Og9es5LRQ5g=; b=AylSaqPaCswtvHpO1ZzmjYc93X
	IU+UVM7r/LqZvk6QrItgvmU9pyiiNhqheBxzKCzxurce++d97esitCw25xY3aHH+2CvnBdzGDYeKQ
	DqJ8aSUk9/OoEkurb3vDwQ4dr+QQBrwqJEp223M3MPEfjkVf33AvODHN2qFXDgRRYQixozaUQOJ+M
	jdY1BZ4+vorCwJXZUaIGAbE0pKfrfBvNbZi7ebjyylXwLnU39FCEKj4XLGHnuyN+0MYPLWDlR7JKf
	9JhGcx61EdJLWpt6+8YOVCN8pgg62ds+PHTDKHtWb7zhS4rnUgcnJ+ViYmwP2aHFMhHbfo6pkvEJb
	yne4bM+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0m7q-008SJv-DI; Thu, 01 Dec 2022 16:09:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0m7n-008SH4-Ir
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 16:09:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A851968AFE; Thu,  1 Dec 2022 17:09:10 +0100 (CET)
Date: Thu, 1 Dec 2022 17:09:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: don't allow unprivileged Write Zeroes
 passthrough on read-only FDs
Message-ID: <20221201160910.GA25530@lst.de>
References: <20221129090016.1311006-1-hch@lst.de> <Y4jRSqY56zjjlVsx@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4jRSqY56zjjlVsx@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_080923_806931_83B2EF67 
X-CRM114-Status: GOOD (  16.15  )
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

On Thu, Dec 01, 2022 at 09:07:38AM -0700, Keith Busch wrote:
> On Tue, Nov 29, 2022 at 10:00:16AM +0100, Christoph Hellwig wrote:
> > -	if (nvme_is_write(c))
> > +	if (nvme_is_write(c) || c->common.opcode == nvme_cmd_write_zeroes)
> >  		return mode & FMODE_WRITE;
> 
> Write Uncorrectable should also be checked, and any future opcodes that
> can modify media. Maybe use Command Effects Log's LBCC field instead? We
> can preload known effects for older nvme's that don't support that log
> page.

Yes, that might be a better idea.  I'll try to find some time in
the next days to implement that.

