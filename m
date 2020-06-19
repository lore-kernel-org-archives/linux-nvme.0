Return-Path: <SRS0=ohfr=AA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BAEC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:22:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201152100A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2020 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cK42svUz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhwZqNrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201152100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RYS5pNDo56oh7fZ0admqdaTu0G1fyrqTUGOafIB/iX0=; b=cK42svUzSp7WKP
	RtmRMZB0cB1tXgGByaZzoPCeyBTL9OHOnlVBXdne9MlmyLG13+JM/4GJKPpafw/ZQpbqxSxBebbbz
	qrFHnEFAhqUnC8zsOxxndDuqqB0orHd+rjjWK3Z+YLxY8h6QYyTVBO8o1gpo/5MZCKVToJmB0YQjS
	oxJRbLRqJIQ7HsrenMmScTv38NRQFVvbmHGMAYi8YmbaFGKUfXIjj9uF1AXBYYCS+yFfUXyfeI3FW
	jpdIMxymcksfl0+aAeG/x8/PjUsDW2iw0d2MZ/jTbEZfjXL3WT0wQDvsCj9I+OFotyNl/72f1FXFO
	a68MhQpj5y+WeXF3N4fQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jmLec-0003Ea-Hp; Fri, 19 Jun 2020 18:22:18 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jmLeZ-0003EE-Oc
 for linux-nvme@lists.infradead.org; Fri, 19 Jun 2020 18:22:16 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 445772100A;
 Fri, 19 Jun 2020 18:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592590935;
 bh=sO1tNhh3e+H0Mph8Xj5gmDOr9peS5JMM3LsxxuGWdHs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OhwZqNrXmVPcl9l3tUlzhvoTPOGuE6xy/V6Kv+l93pn4bhcykz5y8z89z2wn4XPj4
 EADVGAlGvMEMTASS2c3tU+h91Y9HN2Qh9beiUOB2owj875nPHW3GmkdaW3w6F+NZbz
 rFOfXzHRRfPlo8PfcwwlxxKIu8s3eT11TYAOpiZ4=
Date: Fri, 19 Jun 2020 11:22:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Heiner Litz <hlitz@ucsc.edu>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200619182212.GA1284056@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
 <20200618211945.GA2347@C02WT3WMHTD6>
 <CAJbgVnVxtfs3m6HKJOQw4E1sqTQBmtF_P-D4aAZ5zsz4rQUXNA@mail.gmail.com>
 <MN2PR04MB62234880B3FDBD7F9B2229CCF1980@MN2PR04MB6223.namprd04.prod.outlook.com>
 <CAJbgVnUd3U3G=RjpcCuWO+HT9pBP3zasdQfG7h-+PEk0=n4npw@mail.gmail.com>
 <20200619181024.GA1284046@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJbgVnWru+wRRsJ4KB2DiVPRNfMV39uYNSCi2Y=6d+_GOQO8iw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200619_112215_820912_9F969FBF 
X-CRM114-Status: GOOD (  15.08  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
 Judy Brock <judy.brock@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 19, 2020 at 11:17:02AM -0700, Heiner Litz wrote:
> > On Fri, Jun 19, 2020 at 11:08:26AM -0700, Heiner Litz wrote:
> > > Hi Matias,
> > > no, I am rather saying that the Linux kernel has a deficit or at least
> > > is not a good fit for ZNS because it cannot enforce in-order delivery.
> >
> > FYI, the nvme protocol can't even enforce in-order delivery, so calling
> > out linux for this is a moot point.
> 
> How does it work in SPDK then? I had understood that SPDK supported
> QD>1 for ZNS devices.
> I am not saying that Linux is the only problem. The fact remains that
> out of order delivery is not a good fit for an interface that requires
> sequential writes.

The nvme protocol is absoltely clear that multiple commands outstanding
simultaneosly can be executed in any order. This is further made
difficult if you're dispatching these commands across multiple queues.
If SPDK is dispatching multiple commands and expecting them to execute
in order, then they're doing it wrong.

Further, you're not even guranteed the first write in a sequence will be
successful. If you've already dispatched a subsequent write, and the
first one fails, the second one may also fail when it's not at the wrong
write pointer.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
