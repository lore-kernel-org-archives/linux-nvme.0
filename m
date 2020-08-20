Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2123C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:29:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC882078D
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 05:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g5jMoFET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC882078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=txUSHSVyCTdc8Bm53ZosSAwFtQ4XNgJoflJJ2Zdh0Po=; b=g5jMoFETvE7l3VDt2hrBQFbsX
	JIuMyjs6UKTCPZuPTWr98gNfWgkPz310814R0iPSw4m2e1a55jPNTJQbCpCLneOempy/EnG3VyFpz
	pRuHMFBCpaNOpI2mftTGW1kVt5y0e20wWFXKbIyDiENkTvqxxCTIYR+BtzBYVyzJcSvqedfOqiczV
	f6sAwrqd4TDm7TVvn7HRqH2MjenJq7duME3FVxi+Ivp+748Jv6GmPescKTmeVjLTq5XlujRO0HZOn
	pzyG/ZCnbXV2QDkuoa2C5+zyrCTtwHHoZKY4VVJLvJt24wgwcb8Fdr2qRzfxxZejqUILkbyqi0Kpa
	lGCcpzf8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8d8g-0007tz-DV; Thu, 20 Aug 2020 05:29:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8d8e-0007tF-AI
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 05:29:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BC97B68BEB; Thu, 20 Aug 2020 07:29:21 +0200 (CEST)
Date: Thu, 20 Aug 2020 07:29:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200820052921.GA5391@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_012924_474881_F5D2B979 
X-CRM114-Status: GOOD (  19.30  )
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
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 01:11:58PM -0600, David Fugate wrote:
> On Tue, 2020-08-18 at 07:12 +0000, Christoph Hellwig wrote:
> > On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
> > > If drive does not support zone-append natively, enable emulation
> > > using
> > > regular write.
> > > Make emulated zone-append cmd write-lock the zone, preventing
> > > concurrent append/write on the same zone.
> > 
> > I really don't think we should add this.  ZNS and the Linux support
> > were all designed with Zone Append in mind, and then your company did
> > the nastiest possible move violating the normal NVMe procedures to
> > make
> > it optional.  But that doesn't change the fact the Linux should keep
> > requiring it, especially with the amount of code added here and how
> > it
> > hooks in the fast path.
> 
> Intel does not support making *optional* NVMe spec features *required*
> by the NVMe driver. 

That is a great demand, but please stop talking of companies here,
because companies simply don't matter for Linux development.  People
and use cases do, companies don't and your mail talking about companies
really can't be taken serious.

And I'm not sure why you think Linux is different from any other NVMe
host OS.  If random NVMe host A decided they need feature X they are
going to require it, because why not.  Especially if the developers of
host A helped to drive the development of feature X.  I'm pretty sure
with a little background in storage standards you've seen that play out
a lot before.  And it is no different here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
