Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFEECF07C2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fI1/PGqoFZRoLokt7e22zCT+wsdAO0wF2JzI/RmOhKw=; b=ub2CVN4Hyn3aX0i0jtnI5qp9xs
	hebea/3hM8WAvGznwc13h3Clpxjf+RiimyeO3BXt6X9MbiHflIpxUO372JtUCKRIj21GcrRSU6QEb
	5OU9rRyhabR53Oyr17S0au/ChEzoRgj8IKCrFOSg94L9oULIjN//PMWdiT12JMFwphZRFw8LtJQPP
	jclV9rS8vH6YHXnzs3sWYDolOQbv1qXf0HifO7J2VfJfjUq34Dn47D1OsdNR0x5LZ15LOJNPoQ1pQ
	QP8YkmQ6QJc1jPKMksYV9rWDDzwI3oocfM6xI7r9/BaPM1KTOeWZ5h6E+xffCzrAuoXB4btDgOaeU
	IT4f6WjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syoOA-0000000Bxfa-1pix;
	Thu, 10 Oct 2024 08:19:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syo2H-0000000Bt4N-2G4j
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 07:56:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 847C9227A8E; Thu, 10 Oct 2024 09:56:33 +0200 (CEST)
Date: Thu, 10 Oct 2024 09:56:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: fix cns check
Message-ID: <20241010075633.GB7525@lst.de>
References: <20241009214035.3851406-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009214035.3851406-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_005637_749695_98DF7F22 
X-CRM114-Status: GOOD (  13.71  )
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

On Wed, Oct 09, 2024 at 02:40:35PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The 1.1 spec defined two bits for the Identify CNS field, so such an
> implementation wouldn't be expected to check the full byte for a
> decoding it. Provide a different helper function to make these
> decisions as the existing check only separates the single-bit from the
> two-bit spec versions.

I don't really understand what this is trying to solve.  Is there a
controller in the wild reporting 1.1 compliance but reporting useful
information in the NVM Command Set specific Identify Controller data
structure?


