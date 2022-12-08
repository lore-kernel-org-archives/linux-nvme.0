Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C083FC4708D
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Dec 2022 00:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4ErYMieA6OJEUMJE0yCCDMwhO++iV9ICSz8Ul7U5y8=; b=k+YRn0yFJhs2x9AKU9yn3iWQ80
	IG1mrSQGfrSpQZIdpnKls4XzAoCYeXqPuUroYFS6mySF3nK2sTyRyAIl/labHJvH92Oc2rDNniD2X
	b+zHX45vtsjnwkSYx4/UiAwgW8jGCuzB8CdX2aZSwajIT43mTSEWI3VUpMJhG8nEnwmeVGty7NJBz
	znUc41+5J+/CVT+XL/qG3WPMmsmn9rDybhzMLLDRDJ4h/cB0p1/b4CekUA6pKa8eTSlrIEc54X8Jy
	bvRfR8B9bM63cEfpdAvN0+j4Qw6KmtHxyZfv5bloDSrDIMPWsCM0MYl1m2mBkLq4cDk/YIiyggsvK
	s8NvhMOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p34O7-00GQha-6c; Thu, 08 Dec 2022 00:03:43 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p34O4-00GQTp-4d
	for linux-nvme@lists.infradead.org; Thu, 08 Dec 2022 00:03:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A1391B820CD;
	Thu,  8 Dec 2022 00:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A01D1C433D6;
	Thu,  8 Dec 2022 00:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670457816;
	bh=PXHLBIq5qGAzQZVboYkp+lfQFyGGl47qRz7WivUcQd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Df9Gk5jg0r/WMdPcrOQOX14/7HRiJ7O1ffIrw1VaoXZ5r7Dv4A6x2jJImrjEPADox
	 cpdpehM6MoZ2JgNT5u9FLtrm9haBM88eudSFi43LMKrcDTcj5Y3vufHOGYTpCeIMGA
	 4beBgwMXU5nPx5ce2i/jrsOHAUsrLLgkMRwTeM5HGexF/2QIQ2zn/TrFJmDczMNrm9
	 ZJ3xAbPHMKY6e21y7nulTvMdahvdL/Y0A2dC/dJSQM0PdxFthxwdUCG7B96iZLriqN
	 0xtqfvAUv7Pbc876DDO8AiaIo+rGh/hSp7UV5/7MUNQo9bqCMw1A+H3zbMAcR89PWO
	 bGauocV10wXvw==
Date: Thu, 8 Dec 2022 00:03:32 +0000
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jonathan Derrick <jonathan.derrick@linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Message-ID: <Y5Ep1FEykjuy7HFb@kbusch-mbp>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
 <ef7bffa5-5d74-ada2-87e7-2f0a442f3240@linux.dev>
 <e96442cb-a296-4f90-36b5-432a2c0b660f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e96442cb-a296-4f90-36b5-432a2c0b660f@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_160340_399445_327399C5 
X-CRM114-Status: GOOD (  12.36  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 07, 2022 at 10:54:25PM +0000, Chaitanya Kulkarni wrote:
> This is only reference implementation. The process of the 
> standardization of the NVMe Live Migration is will take of these
> opcodes and anything Vendor specific present in this series.
> 
> It is very important to get some feedback on this to help the
> standardization in any way.

We have the NVMe TWG, and live-migration is already active with TPAR4195. Why
is anyone thinking a Linux mailing list is the appropriate forum to discuss
standardizing an OS agnositic feature at this point? Your vfio APIs and vendor
specific hijacks are premature implementation details at this point.

