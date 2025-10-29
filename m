Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85139CCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 09:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ePitLdneym+I8Ua3B6nhvNXpHsjgcB2i/Bnu3T5RJfg=; b=JoufJTWJC2neZfP/GdhCOKWw8z
	2N5QeY360N2FawUp5670bN32jur/UiHbP9BZor8v52QZuOx4ghwTSYoyGFjdnobiRhuq3tAgG83hJ
	TX5/9R2GUf2ZFZf35Rd4cPZaMb3bD/pXLrnpBg7x8XUhVHJtyGXt6QcWUGyKYMHyWIiMNRgJUIbyM
	6NuNvQYXZSvVHhpnWllr13uX8lfLqHIzrOBMIQa5mqAMVjAn15J+nB4unSovLd1XN+opRAMjqpK4i
	9uiyWDiuWo37rnQRcDiXg8xAtqfOzS5yp/tuUnM0FCurl9xaRl9XM2xIZAO/Dq8eBzZAcRsZiAB1z
	nZO/UzIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2Xo-00000000VVx-08Jc;
	Wed, 29 Oct 2025 09:32:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2Xl-00000000VUy-1iH9
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 09:32:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B995A227A88; Wed, 29 Oct 2025 10:32:32 +0100 (CET)
Date: Wed, 29 Oct 2025 10:32:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, kch@nvidia.com,
	dwagner@suse.de, israelr@nvidia.com
Subject: Re: [PATCH 0/4] nvmet: fix configfs attr update handling for
 discovered subsystems
Message-ID: <20251029093232.GA791@lst.de>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com> <aNRtJZL7uxRaHifz@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNRtJZL7uxRaHifz@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_023237_599423_D79223FA 
X-CRM114-Status: GOOD (  15.86  )
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

On Wed, Sep 24, 2025 at 04:13:57PM -0600, Keith Busch wrote:
> On Wed, Sep 24, 2025 at 11:26:00PM +0300, Max Gurtovoy wrote:
> > 1. Forbid changes to controller ID min/max attributes values on already
> >    discovered subsystems.
> > 2. Switch cntlid ida allocation from global to per-subsystem scope,
> >    matching the granularity of controller ID ranges.
> > 3. Forbid changes to vendor ID and subsystem vendor ID attributes values
> >    on already discovered subsystems.
> > 4. Forbid changes to max_qid attribute values on already discovered
> >    subsystems.
> 
> Is there a reason these should be changeable after they're initialized
> even prior to being discovered?

Yes, the whole idea of allowing modifications when enabled, but not
discovered seems odd.

This seems to come from:

commit 87fd4cc1c0dda038c9a3617c9d07d5159326e80f
Author: Noam Gottlieb <ngottlieb@nvidia.com>
Date:   Mon Jun 7 12:23:24 2021 +0300

    nvmet: make ver stable once connection established

I really think we should try to replace all that with an enable
check, hoping we're not going to break something that started to
rely on it.

