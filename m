Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140ACCFC277
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 15:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KSLjkMnQ68QX+wSvGxJb8Ir4Y1JwL2GeXq8M4/rlK/s=; b=iAakK2NdJvz+oGDTxcFzfIapCF
	Rr3yQv+G3ocw4qPW6fmO0GTa/oA3eqrNxzUjV7+pf8UExOjGNMfQWf+kS/kn8yH3WKcsyFCGji7ZN
	6AwILp7NugOH9B5itaB/Okp9MTmbcILlArJLSQ4B78FgLj5m4BdYsn26w9tBMfP9tpyEGbVd4DfZx
	iAvdmQogkMlsx6jtvpWC9XHa25VNi2SYjBY037GnbMrcGG2cTSVsAGaru+n2z8lMtOYzj6GC+VkF4
	AxkLA+Nw/ozB/CEOB6G2D3II9W8OjqNJt8CK4lNLyBaaRRGC7uJfPHvQv3j39yRYQGQsJEmYTvVrE
	JdoMJuBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jIC-00000008fcJ-1n9f;
	Tue, 15 Oct 2024 15:17:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0jI9-00000008fbq-0x6D
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 15:16:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EBC8B227A8E; Tue, 15 Oct 2024 17:16:52 +0200 (CEST)
Date: Tue, 15 Oct 2024 17:16:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix cns check
Message-ID: <20241015151652.GA12532@lst.de>
References: <20241009214035.3851406-1-kbusch@meta.com> <20241010075633.GB7525@lst.de> <Zwfuqf_PAP06GG1-@kbusch-mbp> <20241011080925.GE2749@lst.de> <Zw5930diGlfHACzF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw5930diGlfHACzF@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_081657_429549_E4025955 
X-CRM114-Status: GOOD (  12.52  )
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

On Tue, Oct 15, 2024 at 08:36:15AM -0600, Keith Busch wrote:
> I like this idea, and the spec makes it seem safe enough to assume the
> tertiary version number is always 0 for 1.0 and 1.1 controllers. So
> yeah, this looks good to me.

Do you want to pick this up, or do you want me to send a patch?

