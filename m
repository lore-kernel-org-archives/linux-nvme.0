Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C351C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:54:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13B7207DE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 21:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rLKTaNKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13B7207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LFcCUXOxHlK7TqCQVFAxJ5+o0q+ol2rxc02B2pIp+m4=; b=rLKTaNKVGglrhIBGMX0rHPA6qY
	Q/AS5puvAWPLSkans9VGuvoPBCy58rOZJFs+CGti2TjlYxA1E6x8vi2GAhkeCI5OmBmoE1QXLwQUn
	c8T/gh78Ml9uKiBsQLKKGkDq2bIa4oUnktREdJcS27/Maf9eNGrOznDmMlZlALhihHpmzGJnRdM6F
	2MPn/lClDeSmGaZU/5DW0bj9OyW/ctAfZsPp/L3P6yEH5oDY4LnUv3FIyrsU7qkD8icsrSsu5b4Ai
	L210oAtGRQ4LYqJL+QwgQeIrVkW7zz5dXz8JfHs6D//VnmBhN3kDZzrec1dd8BKvR0GyvPdOqLAJu
	SapaSnKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8W2M-0005VA-U3; Wed, 19 Aug 2020 21:54:26 +0000
Received: from mga18.intel.com ([134.134.136.126])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8W2K-0005UQ-30
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 21:54:25 +0000
IronPort-SDR: n4aeQItBSgsk8oDtntYFjfwUUNLg/YNeroyq9gisNVI/dob6qDEGsQ6RlJptsRnR7wReg53pk/
 UuF+n7CgYGog==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142834770"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="142834770"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 14:54:23 -0700
IronPort-SDR: EPHC1e33LTT3gT4GgA80qhUot5SVvDl5NGvbT5WbDqviAf46e1Hb4EpvWlqK0JbMJ1z0LQuukP
 iueiYbdhLoCA==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="327217882"
Received: from dfugate-mobl1.amr.corp.intel.com (HELO dwf-u18040)
 ([10.212.117.189])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 14:54:21 -0700
Message-ID: <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
From: David Fugate <david.fugate@linux.intel.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Kanchan
 Joshi <joshi.k@samsung.com>
Date: Wed, 19 Aug 2020 15:54:20 -0600
In-Reply-To: <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
Organization: Intel
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_175424_275226_68D91BAF 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 david.fugate@intel.com, "kbusch@kernel.org" <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-08-19 at 13:25 -0600, Jens Axboe wrote:
> It's not required, the driver will function quite fine without it. If
> you
> want to use ZNS it's required. 

The NVMe spec does not require Zone Append for ZNS; a *vendor-neutral*
Linux driver should not either. 

> The Linux driver thankfully doesn't need
> any vendor to sign off on what it can or cannot do, or what features
> are acceptable.

The problem is the driver needs one *particular* vendor to sign off.
Existing driver behavior aligns with WDC drives instead of the spec,
giving WDC an unfair advantage. Couple this with NVMe maintainer(s?)
working for WDC, and there's a conflict of interest.

> It's *always* ok to reject contributions, if those contributions
> cause
> maintainability issues, unacceptable slowdowns, or whatever other
> issue
> that the maintainers of said driver don't want to deal with. Any
> contribution should be judged on merit, not based on political
> decisions
> or opinions.

Agreed, but this standard needs to be applied equally to everyone.
E.g., harmless contributions such as 
https://lore.kernel.org/linux-nvme/20200611054156.GB3518@lst.de/ get
rejected yet clear spec violations from maintainers are accepted? This
type of behavior encourages forking, vendor-specific drivers, etc.
which is somewhere I hope none of us want to go.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
