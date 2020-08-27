Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21595C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:04:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E17D220678
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 15:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="isclFd2s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHKTr+we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17D220678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JyU3WRfmZ5qlEAZZQ4fBv8GHQLE6ul/JXB0PXVfZ3WU=; b=isclFd2s5A3NWNIPDVjwcMtMf
	nnJAeuSg76YL3oPKnW+dkTnkx6bJtE3HZBNN/Xt4wQ8E4XR5pV94PWcKVApO/o19A0QUPupyQ343g
	mJOIXtPSdBgoDeM8KOxgnyaViFeHLVP/GclB/lUUjG1K3B2Pv6XnnR0GkDEdPlBRbLVZ4KE+mhZK8
	7833S+mkloLpK1HiTY52F49dJ5IXLFADfNPXMYmfWl+94T6vkPxqtQJ3KlKAyYuWFLZuz5YN7+IvH
	+xwi4PL3m3AWvYJMjmpgUQtN7HhuBeFQ6NDdnD9jy0zVB/q+2lU2TUhxM8BTFl+EEYf2OnNuDlx8X
	DnsSIVN5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBJSH-0001nT-BJ; Thu, 27 Aug 2020 15:04:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBJSE-0001mI-DO
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 15:04:43 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9C6CD20678;
 Thu, 27 Aug 2020 15:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598540681;
 bh=uN++wh0qicYn3Cva6dLpzWIu+eqedGD8q1sk6JJxSn0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OHKTr+wee4O6DrnwUacPMp+oi0z63RBboi9aXMtXH7UF0XclX3lI1QusNew/lhzvj
 TkoUH3cxOD+Ypp3lT8mKXt2KPSS06NyTB4RExB+IHSDAO5xeH7dSaApM234qQJZAXR
 NX6CxmtDhtke25AP+CvqG7fwPPeZnDR0MlxFDR90=
Date: Thu, 27 Aug 2020 08:04:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: only use power of two io boundaries
Message-ID: <20200827150439.GB2613662@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200825163516.1706267-1-kbusch@kernel.org>
 <20200827074612.GB7448@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200827074612.GB7448@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_110442_515462_FBB66F3E 
X-CRM114-Status: GOOD (  18.08  )
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

On Thu, Aug 27, 2020 at 09:46:12AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 25, 2020 at 09:35:16AM -0700, Keith Busch wrote:
> > The kernel requires a power of two for boundaries because that's the
> > only way it can efficiently split commands that cross them. A
> > controller, however, may report a non-power of two boundary.
> > 
> > The driver had been rounding the controller's value to one the kernel
> > can use, but splitting on the wrong boundary provides no benefit on the
> > device side, and actually incurs additional submission overhead from
> > non-optimal splits. Don't provide any boundary hint if the controller's
> > value can't be used.
> 
> Shouldn't we log a warning about non-power of two sizes?

Sure, this would provide an explanation for unexpectedly lower
performance. That's worthy of a warning, so sending a v2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
