Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C934D374A2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8v60+T+PiTl80BJhmxp8rk1Zg72EvidAAreVU/qGzgU=; b=XLxfn9ONni6IslWWImxPzNPATX
	HW0RnJkHvxzzhlZ/ncgm3gt3fSMHbn64Fv0AaCrF52kUVOaWRBKq8dNw9Y5lAsHhahNkZH8TY1uCU
	xHr7iksGdh++EGpHBeRnTN+AnystCpypm/naOXi9iiZwNR2fIHMvJwkqyyRWkMhJq9YdpLPSwVwTj
	33InGgoFIyAvz8EnCMbXRpLy69xm0gpH4vMHdMRu7qsGLqiTIDFSYbnnAsUEJjxhQ377TVnLXanMm
	sUHJNtOB0gbdcmXhXtB7Om/i3pCaOyHnMxLCxHTeTN6l3zbtwB/LtNRrUcxH0GgPvr5eCbYIjP0WJ
	JMbYgtjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Rcj-0000000F8or-3Aov;
	Thu, 17 Oct 2024 14:37:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Rcf-0000000F8mk-1pNj
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 14:37:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E4BB227AAA; Thu, 17 Oct 2024 16:37:02 +0200 (CEST)
Date: Thu, 17 Oct 2024 16:37:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 08/11] block: introduce
 BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags
Message-ID: <20241017143701.GB21905@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113750epcas5p2089e395ca764de023be64519da9b0982@epcas5p2.samsung.com> <20241016112912.63542-9-anuj20.g@samsung.com> <20241017081223.GB27241@lst.de> <20241017104613.GB1885@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017104613.GB1885@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_073705_642379_AF6BEF7B 
X-CRM114-Status: GOOD (  20.44  )
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

On Thu, Oct 17, 2024 at 04:16:13PM +0530, Anuj Gupta wrote:
> On Thu, Oct 17, 2024 at 10:12:23AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 16, 2024 at 04:59:09PM +0530, Anuj Gupta wrote:
> > > This patch introduces BIP_CHECK_GUARD/REFTAG/APPTAG bip_flags which
> > > indicate how the hardware should check the integrity payload. The
> > > driver can now just rely on block layer flags, and doesn't need to
> > > know the integrity source. Submitter of PI decides which tags to check.
> > > This would also give us a unified interface for user and kernel
> > > generated integrity.
> > 
> > The conversion of the existing logic looks good, but the BIP_CHECK_APPTAG
> > flag is completely unreferenced.
> 
> It's being used by the nvme and scsi patch later. Should I introduce this
> flag later in either nvme or scsi patch where we actually use it.

Maybe a separate one?  Or at least very clearly state that the other two
are conversion of the existing semantics, while this one is new.


