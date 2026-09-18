Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF597C982DC
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MYQ6x2uJNgmL4CbYDw1x6fEi2hNOkJDsllF6XhAxeBo=; b=wc8Hzwwq8VBv2ly9zjiOZ8Bdjs
	lMgAEPpwILc/uyl90G/pdxMQ/VSr9rFJZLmZcYRBVPMLGHa4f26THjqT3JvP/2DN5ypIvrct10Ml2
	fGC7Ad9HSPdWRkABggwNp/7FgkJBsFYQBrgTsw8w1i/bPF9cGZcecFXSb54cjs6DEdniaUtlT3iR/
	YMBUmvWnZ1ugBhGtxUnukrJtAKdKM6em7ij396HgM+lMm0NgfT3l07xnVrDC4MTsUzqiTaK2SSQr3
	UvEtkOdit7nCfHR9edjPSMsyPDpZA9ZHjnuG3zP3UKF8T/I3OEf1a6PsExVmSubB2vFyHrcdW+Zsm
	Ipfjikmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XOL-0000000EKVN-1stX;
	Fri, 18 Sep 2026 12:08:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7XOI-0000000EKTi-2nd5
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 12:08:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D0ED68BEB; Fri, 18 Sep 2026 14:08:26 +0200 (CEST)
Date: Fri, 18 Sep 2026 14:08:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/2] nvmet: defer setting ns->enabled to false in
 nvmet_ns_disable()
Message-ID: <20260918120825.GA16547@lst.de>
References: <20260916151012.3702896-1-nilay@linux.ibm.com> <20260916151012.3702896-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916151012.3702896-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_050830_931226_130DCEC6 
X-CRM114-Status: GOOD (  14.01  )
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

On Wed, Sep 16, 2026 at 08:39:59PM +0530, Nilay Shroff wrote:
> In nvmet_ns_disable(), keep ns->enabled set while existing namespace
> references are being drained, so namespace configuration remains blocked
> until all in-flight I/O has completed. Set ns->enabled to false only
> after the namespace references have been drained and the namespace
> device has been disabled.
> 
> Since setting ns->enabled to false is deferred in nvmet_ns_disable(),
> use the NVMET_NS_ENABLED XArray mark in nvmet_req_find_ns() to
> determine whether a namespace can accept new I/O.
> 
> Similarly, use the NVMET_NS_ENABLED XArray mark in nvmet_ns_disable()
> to prevent concurrent callers from starting namespace disable.

This does look sane, but have you looked at profiles if getting the
xarray tag might touch a lot more cache lines vs the flag?  It might
make sense to turn enabled into an atomic bit mask and just have two
flags in there.

