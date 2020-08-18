Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C7DC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:59:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0587206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kax7qS14";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acv0kch/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0587206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=iAIbHlWMU2HI2qHVaVBpkWEdFcFLXazg9Zqfjjlt9ms=; b=Kax7qS14svKPaJg4OOfae+5B6
	e45uAz6ZXWDxqA2R0Xbb90QuL+50VqxXrPa4opos8ekZxxG/oADz2VoZc2kBW4rKyO0/UV76dmJuW
	Wl9IuK3vz8/kVf4p1/biy6T8JPutNCptSnpM2n9DoP0cc5aEaBiXmLmoaTfCNy6t6OQiwrwe5Aqbf
	33GIQ7pRTUy63I5bBFF718bD1G7ClKhWn1kaOQ9D2QvNth/D1n+KbyHsMw4yUC5/rRCjkt/pE3zG8
	CSGycVzFP/vzwbSA+MOUHW+q+TlfCP1ZbIGmsyQOGQIA0LCluhmEqLP15p4GzyZsNHTCfY6ckdAUz
	1CYTpxJvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k86p6-0006Hd-Ji; Tue, 18 Aug 2020 18:59:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k86p4-0006Gc-33
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 18:59:03 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C45C1206B5;
 Tue, 18 Aug 2020 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597777141;
 bh=zotkWN8H+0Z7VnNI/OJDQxmrxWjS0kq2TXf5YjfuFss=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Acv0kch/4R/Ja/nNvHcUfa0cBFg/V6iNuWbK2WC0WAwDTlit8AEA/7J5Fw94hHm//
 7M5PNWeqMNiVYEVoli9MIWjekQZ2p0M99B7QQfrRLsgnfY81gHdmPLhA1bDSG/Qw/t
 fGkfU1A3czxlrrMeBplLYXSBurFXQBFWCIFg9WBI=
Date: Tue, 18 Aug 2020 11:58:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: fix PRP pool size
Message-ID: <20200818185859.GA3147270@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200818175159.1727735-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818175159.1727735-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_145902_195915_E2693019 
X-CRM114-Status: GOOD (  12.12  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 18, 2020 at 07:51:59PM +0200, Christoph Hellwig wrote:
> All operations are based on the controller, not the host page size.
> Switch the dma pool to use the controller page size as well to avoid
> massive overallocations on large page size systems.

Oof, we've been over-allocating for a while.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
