Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD79C282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60BB20678
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 15:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H+1L10JU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60BB20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g/dgEIJq5BX8u0DC0vJD4YJSikAElE7464BUgVsDCo4=; b=H+1L10JUBq+2yj
	d+Yut6Cv2kb1Kf8nUydEKENdrgesH/YC4DLZ+lTEo86HXWsyQgzmPIWVcBeewGOi94MoYuOFC+Ihy
	sZY4uk2hejlcFJNM6leP9xonPnIuA0io4YTJkd6PgC+3M3PfkgpFpRsL3l9k5l9uoKw83144hGdxd
	xbm1wgVz91Q64KcHBDeCinKR0HncU3LsOtiGYrdOlVyDdAWJ1lJPqkW+g6lLzVOt6SgeepCugYdq/
	TKoQoxVIu1eSKsAPsOwcoCUGGbCiVtpxzGW0A9Rs/LsqXvy7rekHMIus+2mtyR/jGFXsrReVXljam
	BXdaEOzmaOj5+2YdNcIA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipCtC-000749-5P; Wed, 08 Jan 2020 15:04:54 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipCt8-00072Q-0Y
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 15:04:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 27CE368BFE; Wed,  8 Jan 2020 16:04:48 +0100 (CET)
Date: Wed, 8 Jan 2020 16:04:47 +0100
From: "hch@lst.de" <hch@lst.de>
To: "Singh, Balbir" <sblbir@amazon.com>
Subject: Re: [resend v1 4/5] drivers/nvme/host/core.c: Convert to use
 disk_set_capacity
Message-ID: <20200108150447.GC10975@lst.de>
References: <20200102075315.22652-1-sblbir@amazon.com>
 <20200102075315.22652-5-sblbir@amazon.com>
 <BYAPR04MB57490FFCC025A88F4D97D40A86220@BYAPR04MB5749.namprd04.prod.outlook.com>
 <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1b88bedc6d5435fa7154f3356fa3f1a3e6888ded.camel@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_070450_215083_2D0E2587 
X-CRM114-Status: GOOD (  12.89  )
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
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "mst@redhat.com" <mst@redhat.com>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Sangaraju,
 Someswarudu" <ssomesh@amazon.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 06, 2020 at 12:46:26AM +0000, Singh, Balbir wrote:
> On Sat, 2020-01-04 at 22:27 +0000, Chaitanya Kulkarni wrote:
> > Quick question here if user executes nvme ns-rescan /dev/nvme1
> > will following code result in triggering uevent(s) for
> > the namespace(s( for which there is no change in the size ?
> > 
> > If so is that an expected behavior ?
> > 
> 
> My old code had a check to see if old_capacity != new_capacity as well.
> I can redo those bits if needed.
> 
> The expected behaviour is not clear, but the functionality is not broken, user
> space should be able to deal with a resize event where the previous capacity
> == new capacity IMHO.

I think it makes sense to not bother with a notification unless there
is an actual change.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
