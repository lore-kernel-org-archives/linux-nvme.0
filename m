Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871C4F53D6F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GEc4cvny1g/hhQemYNfJ6RRD+KDKNUOs4ZpgR7kT5oE=; b=mFI3f+/IZBvsun8+Hxi5c9cbEr
	aXKmuSXdqTrxEJOBL6/AVGitupohU2JIqu3Id+QuojFkqdJtvM1NWx8PAfhp2Mf3vPbw+LeYZNtRK
	VNlwbC57VaOW42JMkRjVyEFE3mLbu9ZaeaT/ihxqPX1yIKji2a34WP+otaFLmghwWB/pUL5njWdVS
	mDCQxhwf1yji+p3/muertqRh2iwlJlhmVDQYdfWy8W6i1jnnqXnQj99/5wquRX0VOYDSL7qSs5eTq
	wsg/KgXZQR4Df8Bwf4rCxeYf/2el0uUFa69n5c1KNj89qY9rSNuciZ8yPCoFa+nYEvU5DldBwJ1P+
	be6eHlFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Aak-00000004QPd-42Gb;
	Mon, 16 Mar 2026 16:14:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Aaj-00000004QP2-3hUX
	for linux-nvme@bombadil.infradead.org;
	Mon, 16 Mar 2026 16:14:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GEc4cvny1g/hhQemYNfJ6RRD+KDKNUOs4ZpgR7kT5oE=; b=NVhNzSVmB4mIosoUApUFO4W5Hm
	V5O9FGT4/i7qRasdJXrU115Byy9JDA25DExXK3TgSq6dbyeootk/2ruyIigHXry2GK0KI8AdnVQyX
	BrOY+AUNGOTp6RN0DxxTBN9zaQJBxvfY9gc45NtKFICIz6LZc606PmNfT6MMqg0T1oUJKBc3Olafp
	KBddoTYXGCBXSRY9itYCawseJJbk6yd2jBZgmEU9pHpKwPMLqUQAMMwBYh0dqf2i0JdDw4Ylk6XLG
	4jreEw4lvXs/cWWcQ61aE7ujs3O2flMOmkZ06SGwCx08CqhdKS+7losX144T/Scp3/7qtqeKQnsCS
	WvlBulVA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Aae-00000007B7F-1KzL
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 16:14:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E957D68BFE; Mon, 16 Mar 2026 17:14:41 +0100 (CET)
Date: Mon, 16 Mar 2026 17:14:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp.h: drop kernel-doc comments, fix a few
 descriptions
Message-ID: <20260316161441.GA21005@lst.de>
References: <20260314040421.1499586-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314040421.1499586-1-rdunlap@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_161448_717487_7450292D 
X-CRM114-Status: GOOD (  15.12  )
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

On Fri, Mar 13, 2026 at 09:04:21PM -0700, Randy Dunlap wrote:
> Expand @fei into @feil and @feih because the field was split due to it
> not being 32-bit aligned.
> 
> Struct member @hdr was described twice in struct nvme_tcp_rsp_pdu, so
> drop one of them.
> 
> These structs are defined in a spec outside of the kernel, so kernel-doc
> comments for them aren't needed here as well.
> 
> This avoids kernel-doc warnings:

I would have just dropped the comment entirely except for a reference
to the spec, but let's get the warning fixed instead of bikeshedding
for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>


