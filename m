Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F4C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 21:19:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C842D208B8
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 21:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tZb7mGaW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8v11+M3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C842D208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6MgbVBkY9jWo+8kHSVDKsphDONSl4Ht8D/Pp1G5CfGE=; b=tZb7mGaWEYe10K
	uq8L9FOMPTMcvP9/VNb0KwStjk2nm/nhIIPVMKHFRdsPPZpedhxgcl0HVFtmfm7NyC0L5FLtjKmRb
	qLFBF1Sla785qI9X5GzNZSU1jg3UDiF044uILv9n8yG5aDgXofNkB8ce7BpXwuy6kONChgoQUIkD5
	LIz20+LgLF0TmemReZ5mcV1WJtSO+xknHjjzDtFDoglYE64IGC4Y35n6F7cQaufnjtgdtBLomLqi/
	1GVm04D9+P6M2E9P6WGI3yCH5m02QED0Wz3vyFblsrb0kOQ+RgbtS9nXYorYMWG8PSsN90zlcubEf
	pPCVv71/Pj0DIY78u6Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm1wt-0007z1-M2; Thu, 18 Jun 2020 21:19:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm1wq-0007yT-Vo
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 21:19:50 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 85FC1206B7;
 Thu, 18 Jun 2020 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592515188;
 bh=euvryYw2Su0+ZqEYxrZpDt2JMdrm52zn+shG4NDenjQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B8v11+M3nOCnCsVka3QDOITEDFPLK3/EkPgZXAGsuyLbszTOL51zY9RJzfNv36B3d
 V8gSb7Gte5yyz4w2O3iSEPtlHFiUlcYohQdeByeYJtREZ3Q6MoLncUZXMAeIG2nYAu
 wmdVY8ZaI5eE1Ow/hcTG771yZ5XwFohtBFYfg0uo=
Date: Thu, 18 Jun 2020 15:19:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Heiner Litz <hlitz@ucsc.edu>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200618211945.GA2347@C02WT3WMHTD6>
References: <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
 <20200617194013.3wlz2ajnb6iopd4k@mpHalley.local>
 <CAJbgVnVo53vLYHRixfQmukqFKKgzP5iPDwz87yanqKvSsYBvCg@mail.gmail.com>
 <20200618015526.GA1138429@dhcp-10-100-145-180.wdl.wdc.com>
 <CAJbgVnVKqDobpX8iwqRVeDqvmfdEd-uRzNFC2z5U03X9E3Pi_w@mail.gmail.com>
 <CY4PR04MB3751E6A6D6F04285CAB18514E79B0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJbgVnVnqGQiLx1PctDhAKkjLXRKFwr00tdTPJjkaXZDc+V6Bg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_141949_046830_344EE1C9 
X-CRM114-Status: GOOD (  10.19  )
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

On Thu, Jun 18, 2020 at 01:47:20PM -0700, Heiner Litz wrote:
> the striping explanation makes sense. In this case will rephase to: It
> is sufficient to support large enough un-splittable writes to achieve
> full per-zone bandwidth with a single writer/single QD.

This is subject to the capabilities of the device and software's memory
constraints. The maximum DMA size for a single request an nvme device can
handle often range anywhere from 64k to 4MB. The pci nvme driver maxes out at
4MB anyway because that's the most we can guarantee forward progress right now,
otherwise the scatter lists become to big to ensure we'll be able to allocate
one to dispatch a write command.

We do report the size and the alignment constraints so that it won't get split,
but we still have to work with applications that don't abide by those
constraints.
 
> My main point is: There is no fundamental reason for splitting up
> requests intermittently just to re-assemble them in the same form
> later.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
