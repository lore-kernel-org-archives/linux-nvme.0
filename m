Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2F5CCFA1E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Vt9JXSyKoyDyYMT0BDpym//Pu91lXv+ubItkD6uWus=; b=13Yh8s2p4SDtG2NWOQ2Wc1pX4o
	K1w1M1o9fHusAHeuvBaV0+VHe+QEmNd0n1jO/IdzApO+xcmeQejmPMcJzWbmPeYnNME/n+MhWkD3L
	U5KSK+OvCpS1+xGrm3pU94yHCJi16pgNTuYGlW/ohaVAcdjBORUnUlwzdW72Zao/R7m8k7B+hKUI5
	IX+Wo9FXtFQLhGXx43tTE7gdcaNuGor3xed+FLMuVNUPevlS1EB/0jmwELFb0Vqax46bhuXthGAjc
	J0oVJhejdsl/YDuA+aBf6xazHVodc3ITeY8Glcwbe5Hmxzx88zx1/CG0KchLqNWnSMiiFBIuzx3Rd
	UmKVFpWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIosy-00000007H3v-2Ade;
	Tue, 11 Nov 2025 13:58:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIosw-00000007H3Z-36Vh
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 13:58:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 196DE227AAA; Tue, 11 Nov 2025 14:58:10 +0100 (CET)
Date: Tue, 11 Nov 2025 14:58:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Yu Kuai <yukuai@fnnas.com>,
	Matthew Wilcox <willy@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251111135809.GA2096@lst.de>
References: <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com> <20251111093903.GB14438@lst.de> <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com> <aRM5UoApKZ9_V7PV@kbusch-mbp> <20251111134001.GA708@lst.de> <aRNALUnnxzIuyHng@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRNALUnnxzIuyHng@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_055814_943444_DB7FDEDE 
X-CRM114-Status: GOOD (  15.71  )
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

On Tue, Nov 11, 2025 at 08:54:53AM -0500, Keith Busch wrote:
> On Tue, Nov 11, 2025 at 02:40:01PM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 11, 2025 at 08:25:38AM -0500, Keith Busch wrote:
> > > Ah, so we're merging a discard for a device that doesn't support
> > > vectored discard. I think we still want to be able to front/back merge
> > > such requests, though.
> > 
> > Yes, but purely based on bi_sector/bi_size, not based on the payload.
> 
> This should do it:

Yes, that looks sensible.

