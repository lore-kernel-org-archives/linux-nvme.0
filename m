Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A8EC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:31:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8078620748
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 16:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1aQTRJR2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRmklHtz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8078620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:In-Reply-To:MIME-Version:References:Message-ID:Subject:To:From:Date:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bHUH5oyd9VbJxd8Rkh01KVJyRytB/ZI4k8k+uGJrcTE=; b=1aQTRJR2sK0X1T5zH/ya5lxyAD
	sNZvFD8Pe0gQSf/oopim5D81I/FAkksCw49TtEJlNEglmkYDdoTfGQOViGLmBEmQvb12Bx7GFtN5v
	c9IYOBBkDc4jK8GtjXkXVqGxQNMMARA5GOjTZJasKVyo6yLoIEbOzLuO84jvSh8P3eXrfy6j+0FVW
	sj8IdVX7pdSdrzbwepHlDB5959jr3J1vi/FWXbkfkygn4igNs/l3MO3xy+CzbUE5V+iCbIVBrNrPA
	JUfbYKsR9sbvDhknK5O2tyIo9Qf7jwyFWK5qTo92JPvW5zLJ8+EV9n+a25nkkeISyl7QC9LAbnBmC
	rdFmF1jA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k45Gs-0004eL-AZ; Fri, 07 Aug 2020 16:31:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k45Gp-0004d8-Dg
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 16:31:04 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6A1E720748;
 Fri,  7 Aug 2020 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596817862;
 bh=pWQHhlMPVYhsGGr1UAp6e2SDDKNabA3kcdG7+EpOFs4=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=LRmklHtzlTqHxCMXiliS3jLcJZmwNhT8/DVUWbu6mQT/E+pORsaCrbZG262ihNCSo
 Ppbc1Wg0VBlwfGxaeYW5V1NrVLtXYSj0zggTYQChNU3pFjllYXHP6lT6io66tq1XF5
 gPlmqe5l1RHxwGnD7eCnLtfcBXYCajs/8Jdvj2Js=
Date: Fri, 7 Aug 2020 09:31:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme: skip noiob for zoned devices
Message-ID: <20200807163100.GA4155602@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200807162907.4155487-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807162907.4155487-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_123103_555317_839E9A2D 
X-CRM114-Status: UNSURE (   8.85  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 07, 2020 at 09:29:07AM -0700, Keith Busch wrote:
> -	if (iob)
> +	if (iob && blk_queue_is_zoned(ns->queue))

Err, that should have been !blk_queue_is_zoned(). Resending...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
