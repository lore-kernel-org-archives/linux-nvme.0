Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B7FC77B7A
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 05:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVdCTCndCHhrRVOGjntFXIZJxJlYRS9UlxAdq+Wf+dw=; b=S3uUh8+2lCEZFUiD4fY5IjznsB
	y5/nSNblYJKd0P6a2xwEJ43+aPo22PZTk4x55bpudjfqiZV6gwmJaXiFPoHOB3TOxG3teDFIHLoYs
	jKO+PMRnfV0ql3aN4yfVIRHCJ7lMSKlUqQbV3zlEsSqOdazYHQTXJ21wfL+P29Qp3V066/Fll+Dga
	cp3LjIjyoppeq1wvMIpqvtwB7yvCs8Mrf40cfL+mfzDimnDyAuHPCHBXGgOJe5rV4tpt7T8AvglbN
	F0YI0QyIkjwTjzTv5qLUrk3yBw3rJodFRZaNrQQrNfkCpOqFDrCaYpyA+yM7v7fyPr4QBeEHjfEFH
	HQ8g2Iwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Eij-000jZ9-0K;
	Sat, 20 May 2023 05:01:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0Eig-000jYa-2Q
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 05:01:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 66CFD68CFE; Sat, 20 May 2023 07:01:26 +0200 (CEST)
Date: Sat, 20 May 2023 07:01:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, james.smart@broadcom.com, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/2] nvmet-auth: remove unnecessary break after goto
Message-ID: <20230520050126.GA32314@lst.de>
References: <20230519094052.48575-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519094052.48575-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_220130_957023_994BAF6A 
X-CRM114-Status: GOOD (  10.41  )
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

On Fri, May 19, 2023 at 02:40:51AM -0700, Chaitanya Kulkarni wrote:
> Remove dead break after goto.

As a trivial cleanup this looks fine, but I really hate the structure
of this code.

Can't we have local variables that we set to the dhchap_status and
dhchap_step, and then after the done label just conditionally assign
them if dhchap_status is non-zero?  This should clean up a lot of
mess, especially we'd be done to very few assignments of the step,
and we could avoid jumping out of the switch entirely.

