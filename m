Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB91D65C42
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 05:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8RIgfJXdcezjVhsy2WiwXloZpCAYOIy/ZpCoQw78/p8=; b=t6CZButKqY5u++eEuF3nfOS3mJ
	hIFDL/qQTRM7T2yUeqNszh83xs+T8P0MFNRtr8OnBKEz/Q5iaOVo0k71WWU80Ez3xfXkch0mamQFv
	bao+JEPLjdjixm/+1ioLVA+6ZdEe9AAGhBbbbt5GL8DBAWSMtZNaFvzuIMeeRIbxLyI25+v4PsUsk
	YXtshgPB8djfrJqDBfrmitAud1IPR3evNNjd0J6WwzrdEhdFMykjh3/6GIRMODFrciHi9f7etQmxx
	N/dpNr8frX6lK6xe0RD70A7RrAWVOXx8/RqvGuevSWLTji4txZ7hdMn9UG7OfpUtv+hgBCZCsEzaq
	jSUjS61A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSqX-00000008uI8-0VZg;
	Thu, 14 Nov 2024 05:56:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBSqT-00000008uHS-3akY
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 05:56:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5E31568C7B; Thu, 14 Nov 2024 06:56:43 +0100 (CET)
Date: Thu, 14 Nov 2024 06:56:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 2/2] nvme-pci: use sgls for all user requests if
 possible
Message-ID: <20241114055642.GB10948@lst.de>
References: <20241112210620.2650523-1-kbusch@meta.com> <20241112210620.2650523-3-kbusch@meta.com> <20241113045859.GC20379@lst.de> <ZzTKORM566PReqHI@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzTKORM566PReqHI@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_215646_060602_FF3CC3CC 
X-CRM114-Status: GOOD (  18.39  )
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

On Wed, Nov 13, 2024 at 08:48:09AM -0700, Keith Busch wrote:
> > > For controllers that support SGL data mode, this is a viable mitigation
> > > to CVE-2023-6238.
> > 
> > The patch itself looks fine, but instead of the handwaivy mitigation,
> > maybe just disable passthrough without SGL support by default to actually
> > fix and not just mitigate the CVE?
> 
> SGL is an optional feature that many devices don't implement. Even fewer
> do it for metadata. Disabling it entirely is "breaking userspace" for
> users I need to support.

Well, if that usage creates exploitable behavior we'll need to fix it
and not just paper over it.  Although this probably only really matters
for the non-privileged passthrough.

