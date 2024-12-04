Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134C2E7716D
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P7zlab8inyyLjI+G2JuzSdnzEIxtNXuL+pPm28+LdBM=; b=SQEabEyXP2n5ishtvDnNnGw8PN
	1y5/NWnwlNNJ56YzYexn2TLbpz/OMVJb6MEtxWrk3l+MvtEnmUmPQC+VNtSLjn8hQpuQDcWsWtasf
	ozwXbWw5/YF4UNryPXY5WzGwcqOowY6fYFKJGQfUpqFrP+vokTARlrXA40LySB2dj+9PTn/JO3YcE
	78l6nqev2cXja24YAAWw828wmT/8ewrb9dPKOS/4+z8sS3ivNv+CZZbmbDHQhqEwTENH45uHV+xYx
	/4KiaVWVERYKaY91lVpUEW4ibPKdiIvhi01fTYB9axrV+6NRqgXeg4ywoJtASGJRMuwogwYQdkexy
	+TLz/o5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsPw-0000000DDWS-3n2g;
	Wed, 04 Dec 2024 16:40:00 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsPu-0000000DDVL-1F0N
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 16:39:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DC8E4A409B7;
	Wed,  4 Dec 2024 16:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8030FC4CEDD;
	Wed,  4 Dec 2024 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733330396;
	bh=ARERutmIGt/pnw0tG74aNGHIAQLB/Ynz5Gc9sj7XpHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ddmc6gzbPpPQ4OKLKhbU2s+D+DNZQzfzdVDylPHCsw9G6cFq1Ss8n0S7vmdi+DVAx
	 zqZtBCShy7mUAvTfve96sHQeH/I/2psWE2GRsgrN1Yb/RDnF0a98lrGacNDOo2Okmk
	 buGM2dTyUZ9/he3vT+iZiLQgWqCJRnmUoIhvApWBAwNCKTobk7kXT76B7Kl5IgM+uq
	 AmQ7Wm9AUMFftWYzbHgue+YoHG7tTQ0C1pfzBxQCSPsjN2D2NyfA5+GTt7fbgJ0jA5
	 1+eV39TC0FrTLtVagmEEbDPEXsN0eRclPPBLwXGEIe74M0edhpx8o2phkkp+Mw1PP3
	 /p3MusQf28rxQ==
Date: Wed, 4 Dec 2024 08:39:54 -0800
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
Message-ID: <Z1CF2vn1_xkNIVAM@kbusch-mbp>
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp>
 <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_083958_395096_B12A6E03 
X-CRM114-Status: GOOD (  24.15  )
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

On Wed, Dec 04, 2024 at 08:14:08AM +0100, Hannes Reinecke wrote:
> On 12/3/24 20:15, Keith Busch wrote:
> > On Fri, Nov 29, 2024 at 03:06:08PM +0100, Hannes Reinecke wrote:
> > > When a namespace gets unmapped on the target during scanning
> > > nvme_identify_ns_descs() returns with a non-retryable error.
> > > With the currrent code we will ignore that error on the grounds
> > > that we failed to get information, and hence cannot make any
> > > decisions whether to keep or remove that namespace.
> > > But a non-retryable error implies that the namespace is _not_
> > > present as we cannot retry that command and will never get
> > > information about that namespace.
> > > And we need to remove the namespace during scanning, as otherwise
> > > the AEN informing us about a namespace change will find the NSID
> > > present, but nvme_validate_ns() will fail, and the namespace
> > > will never be updated with the correct information.
> > 
> > The scanning only checks namespaces returned in the "active" namespace
> > list. Every namespace not in the active list gets removed already. Why
> > is this unmapped namespace appearing on the active list?
> 
> Timing. Imagine a system used as a backing store for kubernetes, where
> namespaces come and go at a _really_ fast pace.
> 1) AEN triggers a rescan
> 2) List of active namespace is retrieved
> -> NSID A gets unmapped (or moved to another node in the cluster)
> 3) Scan of NSID A returns an error with DNR set.
> Without this patch we keep the namespace around, so eventually we'll
> trip over the 'non-matching UUID' check once the NSID is reused.

I'm still not sure that makes sense. The target shouldn't attach the new
namespace until the host acknowledges the removal of the older NSID via
the Namespace Change List log. Until the log is read, the inventory for
removed namespaces should be latched. Otherwise, timing might remove+add
a specific NSID before the host requests the NS Descriptor for the
racing removal, then it would just get the "non-matching UUID" issue
anyway.

