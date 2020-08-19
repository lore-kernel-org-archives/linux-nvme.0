Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A8C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 23:43:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E54520885
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 23:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lkG8N6do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E54520885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:Reply-To:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SRcXusESXbajsRKk83k/3ij6e12XpIrLx0a54XWJuck=; b=lkG8N6doP5JaygjFrCM62d9Vag
	kuMizA++0RtwknSwNIyQqwLhjCgH2puk9VabTYGSalKOuq4R5wkYd44R8gV1XgQquWq5WcpIPweai
	HMyAU1oy5qHhSRsQHIdiZ/sRgIn3/BGZIwbXUZELNyxOwVmmipva0AtKlXK28fZl+1GDIqR/WooNB
	Z9zw+Ns9jvo544wkqWNUFrDVQqnfzRC6ze9bB6gFHsoKi+QFkJYthM1xknc5gY6wpVIWsFVVxFqGC
	Bn/epqAZWI/5di4KPVIf16ZrVoc6UyQPWM2K4q+I9ed7k0ao8G3yn0gRGL05OyNQ8SiW24iTPdBoy
	3TsszYJg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Xk2-0007FZ-6V; Wed, 19 Aug 2020 23:43:38 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Xjw-0007Dv-HR
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 23:43:33 +0000
IronPort-SDR: fosgGY8qDDEEc/fcFsEtPqqUlgabSnfuoJ6qiGMjMREx/4Ej5X//64RrGJ5Od8Kt7MBFmYIiZh
 f9G3IYO8WOWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="143027547"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="143027547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 16:43:30 -0700
IronPort-SDR: O5tYOSNL62+SuASdmhJb8445k2uVVEXg0Cat/zdHSQN6aLC25N3+dLbxQfsJ3rnL525bEGHKbu
 /ck8bJ7GJjnA==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="497412099"
Received: from dfugate-mobl1.amr.corp.intel.com (HELO dwf-u18040)
 ([10.212.117.189])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 16:43:29 -0700
Message-ID: <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
From: David Fugate <david.fugate@linux.intel.com>
To: Keith Busch <kbusch@kernel.org>
Date: Wed, 19 Aug 2020 17:43:29 -0600
In-Reply-To: <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
 <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
 <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
 <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
Organization: Intel
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_194332_722255_507D64E0 
X-CRM114-Status: GOOD (  15.93  )
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, david.fugate@intel.com,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 2020-08-19 at 15:10 -0700, Keith Busch wrote:
> You're the one who left that thread dangling. You offered to have
> your
> firmware accommodate the Intel sponsored feature that makes your
> patch
> unnecessary in the first place. Your follow up made no sense and you
> have not responded to the queries about it.

There were queries? My key takeaways were a maintainer NAK followed by
instructions to make the Intel drive align with the driver by
implementing NOIOB. While I disagree with the rejection as it appeared
to be based entirely on politics, I can accept it as the quirk wasn't
in the spec.

It's not fair to make this same "your drive should align with the
driver" demand of Samsung because we *are* talking about a spec'ed
feature here. Technical critques of their patches and real performance
degrades observed are fair game and objective; "your company did
the nastiest possible move violating the normal NVMe procedures to make
it optional" is not.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
