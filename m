Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2ED4C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q1NQkMsGLSvVtV7zTq0JGexD+LOLB1PMTg5Rjsb78I8=; b=pjYKxr9vQOSOZSQgS2PN4ys2mQ
	lPGW/+pE7Gi6n1D2grs7PzgWojZbo5XnakF91EHJo2Nx1r4yCnuB5m66H9RiHoDzK7r5B3nHHYO/9
	xXbNiw5Eg6idRF6ztPh+1VMaRz9Kqqovn9xI62Gm3/hs9wo2SA5UXuHBNtIVwV8zSQIrjeyLNLIxs
	CDD0vTVsrhLZleosmNfKtgZZeGSIlsBu6veay0DjnJY+Iqi46bugWW7HgVT+3aAKv8ifzSXVjDLzn
	mSPqg1Lu1WgQxYbE0zfnUcAYoJQxMN1oPe7c6UB3bJ6Igha4ZFZBiCQezyOSXqltAy5dh2ZEnrbu9
	KW54h4jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnVO-000000058o0-10py;
	Tue, 28 Jan 2025 15:27:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcnVL-000000058lc-2JVR
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 15:27:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B7E168D05; Tue, 28 Jan 2025 16:27:47 +0100 (CET)
Date: Tue, 28 Jan 2025 16:27:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: make nvme_tls_attrs_group static
Message-ID: <20250128152746.GA26292@lst.de>
References: <20250128152512.771115-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128152512.771115-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_072755_730474_6CC68822 
X-CRM114-Status: GOOD (  10.39  )
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

On Tue, Jan 28, 2025 at 07:25:12AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> To suppress the compiler "warning: symbol 'nvme_tls_attrs_group' was not
> declared. Should it be static?"

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


