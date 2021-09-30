Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF96CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 16:06:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01BD61269
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 16:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C01BD61269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YxnOhLQ/g7WVH6n9B9hYReqxvbakVMwdbHWTH2gKlgQ=; b=MvpbXYr/5s/GmD
	BSNHuKy27ObDh6AS3GoDQpH6jIuzwu6v2i0sS5EQfjmEa1wOSIEQJsbp0yfTXqCXNypf6FHP+i9ZS
	+qCw99J2SJFKrc/BLfipeAAEpzt37Bs5fp+SwCKXYPPSXDdFDSFoQYYTvsxp7wsBnvtJdprU2oSrP
	QErMlUBJOfp1HfgiXAAOMCwqoz++Qpx2XfiHHe9OmI1wJPmM1M05yPXPmLm07hIjPuUNFStcVfFPH
	y4igoA0E9AxVcbiBj3UxBGc5BxZQo2QWO2uWMarYSmib6cRJtLA53czj8qq8UrgeBN6MhWflIkugW
	w64QOcxsidRrag/M3h5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVyZV-00F7je-HD; Thu, 30 Sep 2021 16:06:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVyY0-00F78C-70
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 16:04:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C637E613A9;
 Thu, 30 Sep 2021 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633017875;
 bh=zQ69yi3Q7jdlpjfR+Odd3ZuHa577udw/pjjvYbQg3Lg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t/0ABdx1npifhEAAowCcVNS18ViY/YY/QeL1tj5OPqY0yczEQsP4YO/upx2BcUGQ7
 pfznGoh95vhu0vXjq2Zrwe/bEsClAFodBZhSrvHCV9JL6loUZK03ML6eydkTjvIqDE
 WqJGWOrKTclvUHCpnWsdz6bUr9qhwCDpRRihMfN7zeOhrtMOS6rhopNgw0t5AwzBFf
 0pYy8KXZjZZyYh80wGzl+J8fiXPaLbuLllHP/XLATV41UQnmG1ea3NcHCuJKDqtBvM
 AnTZssZMepVLYST6KMTl6hSxCfooXYjs3wcErDXZMASpDMmqr61O3EjdsNiGPoTNeO
 hzYT4PK1DT17w==
Date: Thu, 30 Sep 2021 09:04:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Aviv Heller <Aviv.Heller@kioxia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/1] nvme: check for Identify CNS 06h opcode support
Message-ID: <20210930160432.GA407610@dhcp-10-100-145-180.wdc.com>
References: <5721a04a493e4f7fb87f2899d08391ef@kioxia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5721a04a493e4f7fb87f2899d08391ef@kioxia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_090436_339758_4415808D 
X-CRM114-Status: GOOD (  13.57  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

On Thu, Sep 30, 2021 at 12:14:26PM +0000, Aviv Heller wrote:
> nvme_init_non_mdts_limits() issues Identify CNS 06h command, and
> silently fails in case of command failure.
> 
> The code checks whether CNS values greater than 1 are supported,
> however, CNS 06h is only supported since 2.0.
> 
> Modify the check such that the command is only issued for 2.0
> compliant devices.
>
> Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")

There's no requirement that a controller report a particular version in
order to implement a TP, though. It's perfectly valid for a controller
that reports version 1.4 may implement this feature. We just don't have
a way to konw if a controller implements this CNS (TPAR 4135 aims to fix
that), so we just try it and look for success.

The driver doesn't care if the controller doesn't support this
identification. If the controller doesn't support it, we should get an
Invalid Field status. The driver will carry on as before, so it should
be harmless. What problem is this actually fixing?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
