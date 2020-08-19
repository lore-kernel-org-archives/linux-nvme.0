Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0CFC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 19:12:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2865207DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 19:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V1T1/eYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2865207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DU495ATNps3aNpqAaTk+RBQ7bxQiy2VL5tg/pnUQ2Z0=; b=V1T1/eYBXy7XwDA1UBUkc5RWFm
	d4ohKxSUztkW2Sekjd9zPlmCJgb74aVGlD/2M+gYx8aQ5GKWSBSefTeuUOEwt6VmUlzqAUcOH+LyN
	zBXi83SyynqFbyGpXNvQ600do9Jr5oTvTdNfleAhlkDdt53bUlZN/yE3PiFr4sXN+lxYrmJr+RTZa
	mec+sK3mNlbTL2ZA9473KPmbVqMJC+mT4ucZ2oj+5LtEQz+FsddpbrBYltrK2zXfZ8m+tKC/XPMfX
	KANkhkNHDhGggv+h7yCj2OYYGTLY1svu0MJNY0P9S4FRcXTKmxO9cmtKO4rf4jabhtHqSOR3ZvOf9
	mzh2qLuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8TVG-0003Yb-2I; Wed, 19 Aug 2020 19:12:06 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8TVB-0003XO-UI
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 19:12:03 +0000
IronPort-SDR: euZnHOCr5kJZvZUQ7Gku59MGPj2XUaI/Rl7NrcpYz6+hqxh2UGBqlTL3M39JIlvEJ7DbK2Xapt
 jefxV6hssWcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="152791684"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="152791684"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 12:11:59 -0700
IronPort-SDR: OZiP4TSX2CGzEbsrbEbgO/L1SigWcyMus4uNFG7SuZdnuwRJsPsI4raA3IUk/XZm6VABXHYSE6
 5evmasYNJRDA==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="278408392"
Received: from dfugate-mobl1.amr.corp.intel.com (HELO dwf-u18040)
 ([10.212.117.189])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 12:11:59 -0700
Message-ID: <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
From: David Fugate <david.fugate@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Date: Wed, 19 Aug 2020 13:11:58 -0600
In-Reply-To: <20200818071249.GB2544@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
Organization: Intel
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_151202_143217_84A78C46 
X-CRM114-Status: GOOD (  18.74  )
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
Reply-To: david.fugate@linux.intel.com
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, 2020-08-18 at 07:12 +0000, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
> > If drive does not support zone-append natively, enable emulation
> > using
> > regular write.
> > Make emulated zone-append cmd write-lock the zone, preventing
> > concurrent append/write on the same zone.
> 
> I really don't think we should add this.  ZNS and the Linux support
> were all designed with Zone Append in mind, and then your company did
> the nastiest possible move violating the normal NVMe procedures to
> make
> it optional.  But that doesn't change the fact the Linux should keep
> requiring it, especially with the amount of code added here and how
> it
> hooks in the fast path.

Intel does not support making *optional* NVMe spec features *required*
by the NVMe driver. 

It's forgivable WDC's accepted contribution didn't work with other
vendors' devices choosing not to implement the optional Zone Append,
but it's not OK to reject contributions remedying this.  Provided
there's no glaring technical issues, Samsung's contribution should be
accepted to maintain both spec compliance as well as vendor neutrality.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
