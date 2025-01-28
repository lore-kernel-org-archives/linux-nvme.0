Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA96C0218A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jan 2025 09:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFdjOqr3hL6rPe597bjLcy5yUgqPHS66g04pqJNSGm4=; b=ET3oqc5/lMrdV7QKmV77CQdCrF
	4QIV0Osc1VBW3sm36nCvJqsLTQyCE6cJqWJh16yNHV4g1JOXM2SxklFpzGQX/DaHU6vjOyObJ0jsB
	/XA9pmeWnxRf+0QgquiABQUABlLQvsYVyaXh5eao7SC+ftmGmLEug0jN1IQAaXKsbhipusKv9wNEM
	IffB5Rf8/tALK0UJV8tTGpEbyH0gTR3RsAxdEsIwVDQZ2R8cAfTUFuuJdIOBcnWdmFHG54gFHRw8S
	NkuKtXYeDvPeohru79ROM/njgVC1XmRcFD4t3CTJyxPPZ/jswhZisI6gbzzSawbJpBDf77D63j7oo
	Ue3INuXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tchTv-00000004RmO-126r;
	Tue, 28 Jan 2025 09:02:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tchTt-00000004RlM-0zDl
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jan 2025 09:02:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3132568C4E; Tue, 28 Jan 2025 10:01:57 +0100 (CET)
Date: Tue, 28 Jan 2025 10:01:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 06/10] nvme: always include <linux/key.h>
Message-ID: <20250128090156.GE25760@lst.de>
References: <20250122165829.11603-1-hare@kernel.org> <20250122165829.11603-7-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122165829.11603-7-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250128_010201_418244_8239FEC7 
X-CRM114-Status: GOOD (  12.86  )
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

On Wed, Jan 22, 2025 at 05:58:25PM +0100, Hannes Reinecke wrote:
> To avoid build errors when NVME_KEYRING is not set.

So do the previous patches created these errors?  Or following ones?
This commit message doesn't seem particularly useful.  I'd expected it
to be folded into the patch that would create the build failure.


