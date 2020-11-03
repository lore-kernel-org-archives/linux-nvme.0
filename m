Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA03DC2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 18:08:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9B320757
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 18:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hfd+0gEw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9B320757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N3TNhuceklLhcXXXfemSvv1ur1Xud2c4b69OKIjhu3Q=; b=hfd+0gEwavw99lI+1fdMpgG9P
	Sr7Bea1ve9yGCnvWMHjJRL8xsgxe+aAY7aFoyTyMU+xmgQJJpheSYnnxKux+rz5KflV2hu52pgUz+
	jyPNWUO28WPJ2IPOjvCUOf1cNHws9WMUb1Og6pMkOynyJi7QEW88O5Ga05Q2xO9MbhXbHWgWo7eSW
	WzvQhDbij2dtNGz7GUklCEF+ZFyhsBNdpJYj/W1NcK9z/4/gNu3zpdofWBx/F83LCjMnviVqpxUc7
	fsMtHK0YXUXwQEbR7PJrXubRr603C4MvKlcxivwH/ZvKBM8veh7LaZJAKB+j/+xFHN3wB17QY+eCF
	kt1t5Tmbw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ka0jQ-0000pO-6I; Tue, 03 Nov 2020 18:08:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ka0jL-0000nM-L6
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 18:08:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9076C6736F; Tue,  3 Nov 2020 19:08:23 +0100 (CET)
Date: Tue, 3 Nov 2020 19:08:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 1/2] nvme-core: cleanup nvme_pr_type()
Message-ID: <20201103180823.GA22028@lst.de>
References: <20201029185958.7013-1-chaitanya.kulkarni@wdc.com>
 <20201029185958.7013-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029185958.7013-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_130827_851198_D0E1BDC8 
X-CRM114-Status: GOOD (  10.04  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 29, 2020 at 11:59:57AM -0700, Chaitanya Kulkarni wrote:
> The switch in the nvme_pr_type() returns values which can be mapped 1:1
> on the PR_XXX macors. Get rid of the long switch and replace with simple
> conditional operator to return the value.

We'd need BUILD_BUG_ON statements to check this all actually maps.
At which point just doing the mapping as done in the current code seem
much more sensible for something that isn't exactly a fast path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
