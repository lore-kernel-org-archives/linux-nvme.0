Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18118C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 19:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JBVg7mizuBxOl6a2ishwmxoxtro78UC5qu8BSXa1jFU=; b=OHcp8Hz1SjnkT8eyLquF3P0yFr
	uyQW/ckSI3R9cSa56I/OE+ddvI5tdj/tlCA9m500toxmkf/s4IujGQcVVvX8rUu5Vtsadj+0vhXxI
	L2PCyxh1q9xqP5U1YrGQMzll6dmHvPLmNoBTjiX+oz74N3D5cs2IvfQFtbmGC9gOXiTrwRiqekAwe
	amIAt06hdmBjwKpM9cjFtHyDnAfbFTzFHv0PnmwH7z8JKaG4SZhSmwQ/OiFdHPqsfVSM9rFxan4MK
	MM908QGbwkJE3sEvlI11EI9xj3wIl8DwvTME0KpIy5XqsjdesdrqNtPeeX2DZpAh6rjG+qRRZp5Br
	2fYJVBZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYlW-00H94Z-2a;
	Mon, 31 Jul 2023 19:41:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYlT-00H93P-1z
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 19:41:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F64968AA6; Mon, 31 Jul 2023 21:41:07 +0200 (CEST)
Date: Mon, 31 Jul 2023 21:41:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
	git@augustwikerfors.se, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <20230731194107.GA13620@lst.de>
References: <20230731185103.18436-1-mario.limonciello@amd.com> <ZMgHE2wu4T4OfrTR@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_124111_799219_07FA35B2 
X-CRM114-Status: GOOD (  20.05  )
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

On Mon, Jul 31, 2023 at 01:10:11PM -0600, Keith Busch wrote:
> > As the check has been relaxed at startup for multiple disks with
> > duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
> > probe due to duplicate IDs for single-ported PCIe devices") also
> > relax the check that runs on resume for NSIDs and mark them bogus
> > if this occurs on resume.
> 
> How could the driver tell the difference between the device needing a
> quirk compared to a rapid delete-create-attach namespace sequence?
> Proceeding with the namespace now may get dirty writes intended for the
> previous namespace, corrupting the new one.
> 
> The commit you mentioned tries to constrain allowing duplication where
> we can reasonably assume the quirk is needed. If we need to do similiar
> for this condition, one possible constraint might be that the device
> doesn't report OACS bit 3 (Namespace Management).

Yes, this patch as-is looks really dangerous.  I don't think we should
just ignore the fact that IDs change when queried again.

