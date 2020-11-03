Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E17C388F7
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 09:07:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B973322275
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 09:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fz9eL3jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B973322275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sUeUU2Qepu5RmkVWYVhjXF3ihX+24TwdQB0fYHzq4a8=; b=Fz9eL3jDgBN+HUhwGlgO34w/3
	/s/Gs0YJszKlmOHiZYMTZKqoSlbAgFwB3A5mSFHddTbP8wMsdFg1nDSblfsV0JNFzNKOeUJ/R+YMq
	mdUtYO8QBA2tcUrUavUr/ngdruAIqquh2BD8k5FcqVNu+e1yhwJOt3I5UMmn6N85uof4Bw6a8V4x1
	6++MjoPJL05aiXSbCdgHI5pX9qPxIN7GIjSLgf4xEGQrTInMntsqWJ4kcYqg1mgjJbCRVJsSXuFaP
	2NwAmkyvFb6CQLRUTXQs8kWHbi3ZYN8TTbaEbu+MJDAIpT3x/5Bop+CTWHZWubkm7Uadq+rd8OPIn
	Ocbk4jWLg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZsHM-0002F0-E3; Tue, 03 Nov 2020 09:07:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZsGt-00022Y-AS
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 09:06:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7146968B02; Tue,  3 Nov 2020 10:06:28 +0100 (CET)
Date: Tue, 3 Nov 2020 10:06:28 +0100
From: "hch@lst.de" <hch@lst.de>
To: Javier Gonzalez <javier@javigon.com>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201103090628.GA15656@lst.de>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102212405.j43m47ewg65v4k5k@MacBook-Pro.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_040633_624572_F5470929 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 02, 2020 at 10:24:05PM +0100, Javier Gonzalez wrote:
> If I understand correctly, the model would be that a namespace will
> always have (i) a character device associated where I/O is always allowed
> through user formed commands, and if the namespace has full support in
> the kernel (ii) a block device where I/O is as it is today. In case of
> (ii) both interfaces can be used for I/O.

Yes.

> While we work on iterations for c), do you believe it is reasonable to
> merge a version of the current path that follows the PI convention for
> unsupported command sets and features? I would assume that we will have
> to convert PI to this model too when it is available.

I'm rather torn.  I think the model of the zero capacity block device
is a really, really bad one and we should haver never added it.  That
being said, for a ZNS namespace that does not support Zone Append I
can think of a model that actually makes sense:  expose it as a read-only
block device, as we can actually read from it perfectly fine, and that
would also allow ioctl access.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
