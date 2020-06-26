Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068FC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:52:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD54D20702
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OLSXHkbj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHJ4y1+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD54D20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7+ILb4YgfHGPz1p+zZBzaD6Xp0R/3C+PO+hNhiFKcjk=; b=OLSXHkbj8aYd1VFLYbRM8/FdO
	vceD3ZQzQSus6xLL18IQDa8fzACaYpg6oSV8rdfm36FTNPvnigG5G7eMpoxDps+0L7/YPtCoHZulJ
	Z9MtR0NasCgYL0M1VIO8NV2ZKpRNZVAfb1w6Dabzt/TbYo5VruzjMCqYGXox/sm5qjoZt7+MQxIi5
	gbhux0R+d2ZdR5HUb2eJR2cgpwBIllb49RqUwapD+O6/UHaLW6xLozihUSLDql8J0T9Em1laVV1Vc
	HgNcqqVKVpYeqIf9Brp6XtaMNI9oOZpfbQmOdMaubq+1JqSWy/Dwij8XqNGoOkoKO07GJfB39bXpP
	q81BMJkXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joqeX-0005OG-0e; Fri, 26 Jun 2020 15:52:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqeU-0005Mu-53
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 15:52:31 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D43D20702;
 Fri, 26 Jun 2020 15:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593186748;
 bh=tCnKt2gRQ2rQ2Ov2BBHApIbR6TvAVURZvumLSwQZKWU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tHJ4y1+R7Q1sW6c7bebGE90/JtBY775nTAWRP1sUg44HApyj20r35y1mnBeDnWEFj
 EVvZB/vUmhyCY4NUT1MpoF9EsdLTSbZ7Pb51w2DbI1VmCmkZy9/nRD75ScesaxXwCd
 GM9LJ8mujLnn7IpiVsMkc3gjI9qovXoDlcYcrMsk=
Date: Fri, 26 Jun 2020 08:52:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Message-ID: <20200626155225.GA1774486@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-5-javier@javigon.com>
 <6333b2f1-a4f1-166f-5e0d-03f47389458a@lightnvm.io>
 <20200625194248.44rwwestffgz4jks@MacBook-Pro.localdomain>
 <20200625202534.GA28784@redsun51.ssa.fujisawa.hgst.com>
 <20200626062828.cmt3ccowzifxn42g@mpHalley.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626062828.cmt3ccowzifxn42g@mpHalley.localdomain>
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 26, 2020 at 08:28:28AM +0200, Javier Gonz=E1lez wrote:
> On 26.06.2020 05:25, Keith Busch wrote:
> > On Thu, Jun 25, 2020 at 09:42:48PM +0200, Javier Gonz=E1lez wrote:
> > > We can use nvme passthru, but this bypasses the zoned block abstracti=
on.
> > > Why not representing ZNS features in the standard zoned block API?
> > =

> > This looks too nvme zns specific to want the block layer in the middle.
> > Just use the driver's passthrough interface.
> =

> Ok. Is it OK with you to expose them in sysfs as Damien suggested?

sysfs sounds fine to me for some attributes (ex: mar/mor), but I don't
think every zns property warrants exposing through this interface. I
just don't want to corner driver maintenance into chasing every spec
field. If applications really want every last detail, they can get it
directly from the device without any kernel dependencies.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
