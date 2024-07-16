Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8936AC3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jul 2024 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVxmfR/2uZRFsnymAkFVDgRkJiZq19G9W6cmYbzTXmU=; b=bMU94CvUHcc+a/Wkx0kCstVNPn
	sDIba5mrX4P1OgbA28AmSXcrfeWL7uVlz1J3LPUgBW5ZMO9G2ee2k8eFColCm3HzpEJZZp4NlzxJM
	Hn8GRK+VMvlbSQscdyQNVD52CEwkIkoUqfSBTRX8uAA8lBOevUtO6TXX/WkMvmcUUMA/+4h1murl+
	BukHOhALC3jroOYXivbbA9RejGEwG9BNxz44cpSefPv1bcpQuoj3DTME0LVCf+qElXYZlV+hTMUhl
	R/iwwLPGQKog8mgsXV7YodSoQfxJx7kwxkjEiKiHI8MguMtPiwapBOAo0LMEFIQzUSRYv2+n3BRSi
	a2HxkoQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTjc2-0000000ApLA-0t04;
	Tue, 16 Jul 2024 14:57:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTjc0-0000000ApKn-1S43
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jul 2024 14:57:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B432760B9F;
	Tue, 16 Jul 2024 14:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68381C116B1;
	Tue, 16 Jul 2024 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721141823;
	bh=JUoL0/E3G+YTSY6tOf90Zhx/TYIE7PSJj4ukJjuaua4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkfaA86AFkfsz+G6flXK31Cd3pJGyZ40vSA1e4G7ojbDPleIcRMXVDkyqcyyKZ0RF
	 4LisPm/k2TleOCOKc0mpmNeqwCQI03aNa39DldJOH7tC/1A/WaVOIFru5/RLnRHtMJ
	 yDj4ZoqhyAlHimxhFMI9h2EaVKd4Wl00g44NOGdUQsJWD9P9iqSOuGwja3NTakllga
	 GxfCR6XcbvNWfV/4+TeVIp/BEZilOiKyjgdic0mg84mbvn2S4W7iH1TG2aSeWA+M4W
	 WgltuY58h3OWG6VG5uP0D7pGLUBhj+LGgwSh1EiHcj+7aVB1b2/dhSWyPzhBSD5kwf
	 fwNmM9kZZ5LbA==
Date: Tue, 16 Jul 2024 08:56:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: francis.p@samsung.com
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, anshul@samsung.com,
	jg123.choi@samsung.com, prakash.bv@samsung.com,
	d.palani@samsung.com, sathya.m@samsung.com
Subject: Re: [PATCH] nvme-core: choose PIF from QPIF if QPIFS supports and
 PIF is QTYPE
Message-ID: <ZpaKO8QSgvOMWAiB@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240715063116epcas5p1d5653ed4b1f71c1a4542f9315a62b6db@epcas5p1.samsung.com>
 <20240715010157.2909958-1-francis.p@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715010157.2909958-1-francis.p@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240716_075704_459407_08444DDA 
X-CRM114-Status: UNSURE (   8.99  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jul 15, 2024 at 06:31:57AM +0530, francis.p@samsung.com wrote:
> From: Francis Pravin <francis.p@samsung.com>
> 
> As per TP4141a:
> "If the Qualified Protection Information Format Support(QPIFS) bit is
> set to 1 and the Protection Information Format(PIF) field is set to 11b
> (i.e., Qualified Type), then the pif is as defined in the Qualified
> Protection Information Format (QPIF) field."
> So, choose PIF from QPIF if QPIFS supports and PIF is QTYPE.

Thanks, applied to nvme-6.11.

