Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33FEC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 05:42:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51352074B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 05:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LHAQQ1kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51352074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qr7XmO6MA/yWTYWMZ8bc7P06jJWPoZc9l17qS1b4Ft8=; b=LHAQQ1krGpBdlk
	CNKXNi5Kp7HCVa+sO9WNFKPp2ZGMwBEZPeBtY456643iYnXY4FxtXIaTYqtiyXXSRfwvkb0P9Web2
	B5n6sIQfY9cmrOXYZZZdR5W93BiFo2xfRgI+1gIDtOIm1ERFGIZJBXR99b/eSmdezM1VXy/gUAZ/p
	oAXDSAMBf05Rd54Fox7f+J2lBEoeZaNEY2B5UbWcF+MNTdIIaaOzykq4pDT2fFuM78TRaIwGLClos
	KbxGYugXQPi8AeD8VwCOLvqPQ7RbjBzezoG/8KroX0xxJjM0ckwK4c+BI0L0C3BQ3/7rpQ3VBpmiu
	h/eAhZ4zpk0SjGVjkO+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjFyX-0001ar-3v; Thu, 11 Jun 2020 05:42:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjFyT-0001Yz-Sg
 for linux-nvme@lists.infradead.org; Thu, 11 Jun 2020 05:42:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D85496736F; Thu, 11 Jun 2020 07:41:56 +0200 (CEST)
Date: Thu, 11 Jun 2020 07:41:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Fugate <david.fugate@linux.intel.com>
Subject: Re: [PATCH] nvme: associate stripe size quirk with D4512
Message-ID: <20200611054156.GB3518@lst.de>
References: <20200611033836.45701-1-david.fugate@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200611033836.45701-1-david.fugate@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200610_224202_075211_A4B4A2BA 
X-CRM114-Status: UNSURE (   8.18  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, axboe@fb.com,
 kbusch@kernel.org, david.fugate@intel.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 10, 2020 at 09:38:36PM -0600, David Fugate wrote:
> Intel's D4512 dual-port SSD is based on the older Intel P4500 SSDs
> whose development predated the NOIOB feature. Based on a customer
> request, the D4512's device ID was changed from the P4500s'. This
> patch associates D4512's device ID with the stripe size quirk to
> improve its performance.

NAK.  We've been told Intel forever that we need a standard quirk,
and we actually do have way to expose this information in Identify now.
Just kick your firmware engineers in the but to set the trivial field
in Identify.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
