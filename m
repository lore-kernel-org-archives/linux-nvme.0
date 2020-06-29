Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAB7C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 01:31:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B9D206BE
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 01:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q80SwV+T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnGgTB+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B9D206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Baq8ynzOxrI92oUsBjFLmuPapejOXXtgfWEMw+ZA7aM=; b=q80SwV+TO76kefe0yKDv9VtkG
	VNtu1yK0xmNWdllL0vOuXumB+Q/fJXpImQbuGq+uCFYIbgGt9Og6+juQXY3zOb0OuftZ0DxoG2vdh
	nuY5M930zuUt0t5UAQCh29zfGNQkbzjCRni3WyCMiNaM9yde44qZvREcRXbYqYhWO4WujykZnBsFI
	uxbvGZXVneC0EgVoZy361MFsrJi0MWTd7lGw4p1RC7GF0t2d6HZYmWLe6tXPTLsgHbHJbSuHGIZd5
	p10Bn2B2Z+KZbwYy46cvECI9XFY24e4ajRwKalVaqpZ+dwvsk8e8YnAjCxoigxcU6irtO+IaLxVwj
	zsowmsXIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpieE-0000LT-VS; Mon, 29 Jun 2020 01:31:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpieC-0000LH-BP
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 01:31:49 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CCE8320760;
 Mon, 29 Jun 2020 01:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593394306;
 bh=Ixv42zagfGZIEDNq4U3wKAFoD1bkkegEHSprOtjQStI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NnGgTB+CbTXjBK1BNyUZr413XjFoQwM5KfaBVDPtkFkCulbx/2B84Ta+2Bxed110K
 O5Zv5LFdlBWLRzGQ92/bVSE5HXIKs4FhG2u1kQOseqmVLTht6nlsFUz5SB8TLYXuk5
 j8tzwFrPCxT1RdyS9yV4hWloKGL/3fmSBF9l32A8=
Date: Sun, 28 Jun 2020 18:31:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [RFC PATCH] nvme-pci: Move the sg table allocation/free into
 init/exit_request
Message-ID: <20200629013143.GA1778220@dhcp-10-100-145-180.wdl.wdc.com>
References: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Jun 28, 2020 at 06:34:46PM +0800, Baolin Wang wrote:
> Move the sg table allocation and free into the init_request() and
> exit_request(), instead of allocating sg table when queuing requests,
> which can benefit the IO performance.

If you want to pre-allocate something per-request, you can add the size
to the tagset's cmd_size.

But this is adding almost 4k per request. Considering how many requests
we try to allocate, that's a bit too large to count on being available
or sequestor for this driver.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
