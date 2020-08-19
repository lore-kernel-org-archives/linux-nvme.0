Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8794C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:44:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8026F206DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 10:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NTz7muOs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8026F206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bTyt++ZoB6qzYwky5HYUbWYzKURbqrfMR+Qvse/10Zg=; b=NTz7muOsmwYPHNbLolL+Yzj5c
	BnP/i0wIo9uZxw3QbNErGN82YxpE7+GdUaZbGRv7kmOKDJVEVufwBaOR/EQFUPTCSYCLQcjjiyw5a
	a7Kf9AbIdSozVJOU0YuHhQrCo3Ctf9632SCksTvZyAdzDODygcgP1S//7b/+qJzElDryP8dK433e+
	9BpdN55vLYAfiVoiDnkMb98DXt3hEMrJ/ccgkba40rjneW3ZsXTUqot72gxzJ4ki6/A+pLC60NyKk
	ILJgxT/2O6zpSTD1GCoCEb/UQCGAXR6hcE3fEg9SL9t6ER9Z2P+vu5ofQQEMeUVO2K2kCuXPW7NNm
	s98H2lEzg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8LZV-00022s-7z; Wed, 19 Aug 2020 10:43:57 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8LZR-00021f-AM
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 10:43:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F273367357; Wed, 19 Aug 2020 12:43:49 +0200 (CEST)
Date: Wed, 19 Aug 2020 12:43:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200819104349.GA2697@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <20200818155004.GA26688@lst.de>
 <20200818180428.obipue6adpqqpwjj@MacBook-Pro.localdomain>
 <20200819074035.GA21991@lst.de>
 <20200819083353.rwblagiesocfcq7i@mpHalley.local>
 <CY4PR04MB3751DE6CEB9C233BF7C9D86AE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751DE6CEB9C233BF7C9D86AE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_064353_486710_E9780A16 
X-CRM114-Status: GOOD (  15.77  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Javier Gonzalez <javier@javigon.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 09:14:13AM +0000, Damien Le Moal wrote:
> While defining a zone append command for SCSI/ZBC is possible (using sense data
> for returning the written offset), there is no way to define zone append for
> SATA/ZAC without entirely breaking the ATA command model. This is why we went
> after an emulation implementation instead of trying to standardized native
> commands. That implementation does not have any performance impact over regular
> writes *and* zone write locking does not in general degrade HDD write
> performance (only a few corner cases suffer from it). Comparing things equally,
> the same could be said of NVMe drives that do not have zone append native
> support: performance will be essentially the same using regular writes and
> emulated zone append. But mq-deadline and zone write locking will significantly
> lower performance for emulated zone append compared to a native zone append
> support by the drive.

And to summarize the most important point - Zone Append doesn't exist
in ZAC/ABC.  For people that spent the last years trying to make zoned
storage work, the lack of such a primite has been the major pain point.
That's why I came up with the Zone Append design in response to a
request for such an operation from another company that is now heavily
involved in both Linux development and hosting Linux VMs.  For ZAC and
ZBC the best we can do is to emulate the approach in the driver, but
for NVMe we can do it.  ZNS until just before the release had Zone
Append mandatory, and it did so for a very good reason.  While making
it optional allows OEMs to request drives without it, I fundamentally
think we should not support that in Linux and request vendors do
implement writes to zones the right way.

And just as some OEMs can request certain TPs or optional features to
be implemented, so can Linux.  Just to give an example from the zone
world - Linux requires uniform and power of two zone sizes, which in
ZAC and ZBC are not required.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
