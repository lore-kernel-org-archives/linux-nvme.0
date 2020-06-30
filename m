Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF91C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:08:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDCD2072D
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 14:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p+6iRmCn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xPEECGY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDCD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Yjl5evdDCp2d36xB1PNReaaFxEFDN+Ah8vxwvZ2rCmc=; b=p+6iRmCnRby78UamMCXhDWda1
	LliSbK80omA3wiBKxF0nEt87ZYHwePGH11RJMidSnWmTz6jvoESP8i1WCGJH+RjOeNwJ4yIZW0lZL
	xOI9o5r3XViZHG2aj9SOTGeRkeb1um3BSX42ygJ4Yi1A4ttqGBgN/rqqO0l2IAcB8p+hXFA0n4gBl
	tfXByTtYbsy+vbG188EcCu/iN5l2KBa59zJJIXl6K3KIuXDQuXHvYnBxrcBO/eeBuNYGPws0xxnpO
	M+tvFMnWtY1NNJImOs+97H1ND2wxGSXZ5CVNv1CskeUY+UxzmrQ5iD4Q8lKF1Yz342awb/ROy94cQ
	C2lBq1VHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqGwN-0000xh-Na; Tue, 30 Jun 2020 14:08:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqGwL-0000wu-Fl
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 14:08:50 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 564562072D;
 Tue, 30 Jun 2020 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593526127;
 bh=Bir2/g52+uKiDFsLqGocRSdaGam+HlMfWXbv0m+pQTQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xPEECGY0ZlkfbVu8+/j9jkZcaX0C2kOSAHGXacxSdFt9J8gIYxRvW7wHdzyn/pE1X
 zVD5xi+yzQAdu6qncSpabQ6z+OnBQy1TYoy4WYvEula16bQGttes3jHQo1Mca0Ra2v
 VOO7tM+zk8gtePRfyFMNIQRgZN5HG+Mcr18CIYKk=
Date: Tue, 30 Jun 2020 07:08:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maximilian Heyne <mheyne@amazon.de>
Subject: Re: [PATCH] nvme: validate cntlid's only for nvme >= 1.1.0
Message-ID: <20200630140845.GA1987534@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200630122923.70282-1-mheyne@amazon.de>
 <20200630133358.GA20602@lst.de> <20200630133609.GA20809@lst.de>
 <b3b621d9-b653-45c4-4164-f5a492cabd6a@amazon.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b3b621d9-b653-45c4-4164-f5a492cabd6a@amazon.de>
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 stable@vger.kernel.org, Amit Shah <aams@amazon.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 30, 2020 at 04:01:45PM +0200, Maximilian Heyne wrote:
> On 6/30/20 3:36 PM, Christoph Hellwig wrote:
> > And actually - 1.0 did not have the concept of a subsystem.  So having
> > a duplicate serial number for a 1.0 controller actually is a pretty
> > nasty bug.  Can you point me to this broken controller?  Do you think
> > the OEM could fix it up to report a proper version number and controller
> > ID?
> > 
> 
> I meant that the VF NVMe controllers will all land in the same subsystem from
> the kernel's point of view, because, as you said, there was no idea of different
> subsystems in the 1.0 spec.

Each controller should have landed in its own subsystem in this case
rather than the same subsystem.

> It's an older in-house controller. Seems to set the same serial number for all
> VF's. Should the firmware set unique serials for the VF's instead?

Yes, the driver shouldn't be finding duplicate serial numbers.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
