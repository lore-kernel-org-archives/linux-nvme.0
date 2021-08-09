Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD85C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 14:30:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD8C60BD3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 14:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BAD8C60BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K7SHUh4n9yXijCDuQ8JKWxBAhv66p7LBiwcFx/ELuAc=; b=sW7IBIS/vFPTKF
	1j9tgcW/qdaEAhm43vBjW7i1uetAQ4TpHWiuMghTVXwQBc465h5plP+jJlOCRkBRB84ZPfcpnOe/N
	rt/8SeQLl/JvRGylK401dE16M40d+RnWViESBhquxL0yNGXnVDOd3nblGHFK4pLh9+vZIzfhsS9p6
	f90h62E2TjOx0z9UPLr5j0w/au0V07mWZeaQ17NUiTU/ZwtsHWJ5UqzofSPCBs0WsL+0yEE/E/sPU
	TSyC9ZYhKDPljkXFfl9U2VplsFIb1HdI7ftQNf8bIYkrSnlZtuqZckDhR1gOF2SPIANOls/Y+e8fs
	oeC2Yk5nSxNsPo20zMRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD6IB-000uei-Qj; Mon, 09 Aug 2021 14:30:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD6IA-000udn-9W
 for linux-nvme@bombadil.infradead.org; Mon, 09 Aug 2021 14:30:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=/diI+imO+eRfM/L8BA7mg+BkYRGYazpCaAQkpgoDzjc=; b=ALztR8vZjA0F6bmwIOGmDsrhRG
 vOVHEqE+lel4seE/sWWylIYQ4Yu+FgfgC/cYs+zE0QWD8QVUgkxuNU8Uz35a5ueYhrBzGQoKkW/T7
 h9S4RNNHgfYKk2d+9ZC2AnZI0LzqkvL6OkA073CGXcvVX6BS4vc/xs0FPBExV8RQNtraYI4PHhM1a
 lcM8w/h0UWPsLQemNxvEeOrO49AUsCicLmw0h+RhEIJQVXY9/IwXAdygN/2s79RgWkQQ7BFKcmtbv
 2CDFeHctgY6jDqZtC2ND14dd0qVxdvdilrUnhZoz99/wXheA7n+odEwWEE5qxFMSyAPK4gJUP4ySF
 G32yJIJw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mD6HE-00B4b5-I8; Mon, 09 Aug 2021 14:29:25 +0000
Date: Mon, 9 Aug 2021 15:29:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>, Sven Peter <sven@svenpeter.dev>,
 linux-nvme@lists.infradead.org
Subject: Re: [asahilinux:nvme/dev 13/17] drivers/nvme/host/pci.c:2249:2-3:
 Unneeded semicolon
Message-ID: <YRE7vCyn9d1ClhRm@infradead.org>
References: <202108051646.vdMMUBea-lkp@intel.com>
 <YQ7GVu1TqpqbHZOb@infradead.org>
 <CAK8P3a2t8qAr1q6uf-wuer6rpZnmOmZ1LytO6vOGXKT1DR2OmA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK8P3a2t8qAr1q6uf-wuer6rpZnmOmZ1LytO6vOGXKT1DR2OmA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 09, 2021 at 12:02:55PM +0200, Arnd Bergmann wrote:
> Do you have any further suggestions? Should we just duplicate
> the driver and then simplify the platform version as much as possible
> as you suggested above, or try to share some of the code according
> to my original plan?

Yes, please duplicate it.  The tradeoff between absolute performance
requirements and various bits of broken consumer hardware already
is hard enough as-is that we don't need to support apples frankenchip
in the same codebase.

Note that I suspect you can probably drop a whole lot of the duplicate
code for the apple driver.  I doubt it supports things like CMB, HMB
T10 protection information, shadow doorbells, SGLs, etc.

Also given that it only supports a single I/O queue there is no need
to support read queues or poll queues or any kind of queue mapping.

Also can one of you look how PRPs are actually used by MacOS?  Given
that this device always seems to be behind a IOMMU creating one entry
per page seems rather weird given that the apple_nvmmu_tcb structure
already contains the full length.  Maybe it actually ignores all but
the first PRP?

So yes, duplicating the driver will probably look a little worse
from a pure LOC, but it will be much easier to maintain and to
understand.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
