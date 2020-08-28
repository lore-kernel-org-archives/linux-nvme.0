Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDD7C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 15:52:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CA702075B
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 15:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ppVJLQxt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdcD+SDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA702075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I9a0LsJ2lsWiPgoJ0bs+xvkEZDY88r3rzQg4ww1bfQ4=; b=ppVJLQxtmjk3HmRO6crgfXkJ1
	5AfidrYv4WUt0HYus2oXtB+x/cOXjDZDwKbVUJ4mmvYXBD5V2RDdcotZQ6HM3Zx83Xq9TAWoVfDyB
	cR7CXjMd990x/pPFxlDWlv1DHfXrZneEwS6NrDi1KjmnLRD17nrI2oS652kQOS3jrEGhwHW0XrZdx
	a9xlUXIgWyscg1LTUqNpzguEDHXKj1aWDle0vnEe6ugxlFuOWL1QhvPvSWRlCriuAmxOI0PvcTwvL
	YToEfDFLS4rP+lSUwI5MpBXeMHXXtI8MyJxPnw55+Xw5GBibPlQWV2KmMZS8Rp2YclPBGawre8xqg
	mXP4RR9UQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBgfa-0006N3-3L; Fri, 28 Aug 2020 15:52:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBgfX-0006MC-KH
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 15:52:00 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 434F02075B;
 Fri, 28 Aug 2020 15:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598629917;
 bh=YQ07odnS6NgebrciQwQis3LqHHVgGAFER6PkRV66vR8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XdcD+SDPBZoJ8xCKvlABgms53TZQHy5kuKzHcRX9uYdNgLYs9qFIUa8ybGbQoM3es
 us4ywUkGYV8Wnf3ZIgaICTfPyCgcrCVbNd14zNZIOF+W4kisiLEBCiURwvD7jWUS3x
 g/y143nD0WlWCDDlzt53e1eelwX5mhstgn59h2s0=
Date: Fri, 28 Aug 2020 08:51:55 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH v2] nvme-pci: cancel nvme device request before disabling
Message-ID: <20200828155155.GA2826202@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
 <20200828141707.4124-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200828141707.4124-1-ztong0001@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_115159_742472_AE87537A 
X-CRM114-Status: GOOD (  12.82  )
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
Cc: axboe@fb.com, linux-kernel@vger.kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 28, 2020 at 10:17:08AM -0400, Tong Zhang wrote:
> This patch addresses an irq free warning and null pointer dereference
> error problem when nvme devices got timeout error during initialization.
> This problem happens when nvme_timeout() function is called while
> nvme_reset_work() is still in execution. This patch fixed the problem by
> setting flag of the problematic request to NVME_REQ_CANCELLED before
> calling nvme_dev_disable() to make sure __nvme_submit_sync_cmd() returns
> an error code and let nvme_submit_sync_cmd() fail gracefully.
> The following is console output.

Thanks, this looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
