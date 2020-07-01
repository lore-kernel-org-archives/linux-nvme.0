Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617CBC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 17:51:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEC220771
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 17:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oPocnfuF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq4BChlf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEC220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=70hH+kIdfY3UfXnsXSe49nnNDIWSPsMa5374m0meSb4=; b=oPocnfuFW1tu0VmCf1dyF9yoR
	4ZHjqwaNMu9+UlfIaraNbtRtdFeLC3+6CxwH2s6fHXLeK8nQqyLXgsSuvAOabNxNu9+Q2CuSgerPm
	LGyh/0tu6sSFWRinftOj0+VhST/6QZ2zuRrjoWB/My+lAd354yUlJfSUGfBXFIOuY9TNqQXzERfuK
	5qCGwYtHiF5meVpL9Lx5I08dEatyFoYlyj5QClBtnMQRosONOfRMMggfvYxYVGfvV7/htqpT2sSBY
	TNeh0fXVNJ7hcCSlLcpWc2Gf2FsT5TYHU3tr34OG+3TlXgKk+JPZa0JSFeLTiMdGTWqthYgcf4QTc
	TJ7Yb1bsQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqgt6-0003hn-2j; Wed, 01 Jul 2020 17:51:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqfqt-0003mt-M6
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 16:44:52 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C28E2085B;
 Wed,  1 Jul 2020 16:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593621890;
 bh=qpI2qMxFsvsDjFJ5PXvl317xEoZKjqiE34KDSQlx2I0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Yq4BChlfKhNFZxoGKgF8fSxG1R4bZ1Jhl6kWBPz/A+RQe5udpBrmIkiE+WI7igQqe
 C4hvkjSMgSKHkmZlEVwfUhU0MSr8/VyYLrUX8nBzWANT3f3YHRsvOFCOOtJLfTJ7nT
 5VdvSPrxGUN8XN0HMG/sFZegVdHDuNvT70z9rBmY=
Date: Wed, 1 Jul 2020 09:44:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/2] nvme-core: use xarray for ctrl ns tracking
Message-ID: <20200701164447.GC1988944@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701022517.6738-2-chaitanya.kulkarni@wdc.com>
 <20200701131235.GA17919@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200701131235.GA17919@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_124451_783968_71C1F1AC 
X-CRM114-Status: GOOD (  15.67  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Matthew Wilcox <willy@infradead.org>,
 sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 01, 2020 at 03:12:35PM +0200, Christoph Hellwig wrote:
> [willy: a comment/request on the xa_load API below]
> 
> On Tue, Jun 30, 2020 at 07:25:16PM -0700, Chaitanya Kulkarni wrote:
> >  
> > +	rcu_read_lock();
> > +	do {
> > +		ns = xas_load(&xas);
> > +		if (xa_is_zero(ns))
> > +			ns = NULL;
> > +	} while (xas_retry(&xas, ns));
> > +	ns = ns && kref_get_unless_zero(&ns->kref) ? ns : NULL;
> > +	rcu_read_unlock();
> 
> This looks pretty weird, but I think the problem is one in the xarray
> API, as for the typical lookup pattern we'd want an xa_load with
> external RCU locking:
> 
> 	rcu_read_lock();
> 	ns = xa_load_rcu(&ctrl->namespaces, nsid);
> 	if (ns && !kref_get_unless_zero(&ns->kref))
> 		ns = NULL;
> 	rcu_read_unlock();
> 
> instead of duplicating this fairly arcane loop in all kinds of callers.

Is it not safe to use external RCU locking with the existing xa_load()?
The rcu_read_lock() api says nested read-side critical sections are
fine.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
