Return-Path: <SRS0=NjBy=W6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC43C3A5A2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 16:48:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55462053B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Sep 2019 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E+diGmnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E55462053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qEQMqHRZaj4B9j8rY4LP4APeC6XLnTvUU1yi19EeB1Y=; b=E+diGmnT1EWUbq
	LbWwi9qs+a7dcieOB3Cd328wFQJqpVoZ6mW6p/MSXlOudbDTy5L7XxU+X2MlZjDjF7/ynkIKGIqqz
	M4RDGPRkp8A9XzgEHRNaU9QU2h6sPOdxzBZlcHEtpHA9gm3Y/5M+lKPr1h00ilAdrh3mzD4HGDtC7
	Vo7G5XghteQw9aogzkC2SLwCuHpjdqa8SQJMp5e8H26Fh6o2hSgAsyB4iMY+cHOwi6lQba74U1Yq8
	ygzRwwsz4xm1vxURl0ONEB/1rPvEm5RMErtxrMrOjyWkeWwHbRPC6qS249/sqziSG4PPlbdCuLRCy
	JgNO5PM4fQSqScb23zrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5ByI-00014V-IP; Tue, 03 Sep 2019 16:47:58 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5ByF-00011q-VU
 for linux-nvme@lists.infradead.org; Tue, 03 Sep 2019 16:47:57 +0000
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Sep 2019 09:47:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; d="scan'208";a="207151406"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
 by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2019 09:47:53 -0700
Date: Tue, 3 Sep 2019 10:46:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
Message-ID: <20190903164620.GA20847@localhost.localdomain>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190903_094756_030040_B64B90B4 
X-CRM114-Status: GOOD (  15.20  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 03, 2019 at 10:08:01AM -0600, Logan Gunthorpe wrote:
> On 2019-08-31 9:29 a.m., Keith Busch wrote:
> > On Fri, Aug 30, 2019 at 06:01:39PM -0600, Logan Gunthorpe wrote:
> >> To fix this, assign the subsystem's instance based on the instance
> >> number of the controller's instance that first created it. There should
> >> always be fewer subsystems than controllers so the should not be a need
> >> to create extra subsystems that overlap existing controllers.
> > 
> > The subsystem's lifetime is not tied to the controller's. When the
> > controller is removed and releases its instance, the next controller
> > to take that available instance will create naming collisions with the
> > subsystem still using it.
> > 
> 
> Hmm, yes, ok.
> 
> So perhaps we can just make the subsystem prefer the ctrl's instance
> when allocating the ID? Then at least, in the common case, the
> controller numbers will match the subsystem numbers. Only when there's
> random hot-plugs would the numbers get out of sync.

I really don't know about a patch that works only on static
configurations. Connects and disconnects do happen on live systems,
so the numerals will inevitably get out of sync.

Could we possibly make /dev/nvmeX be a subsystem handle without causing
trouble for anyone? This would essentially be the same thing as today
for non-CMIC controllers with a device-per-controller and only affects
the CMIC ones.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
