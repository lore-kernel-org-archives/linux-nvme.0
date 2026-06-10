Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB0BCD98C5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 05:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qkignFTpZF7uHwgeYELHQN77FbWbfi1UY8WYR1I5MM0=; b=GHHpFMQQIEqa78XjjRXzRFK10R
	lC1PZPNkcM0KkKpi/rvCBzqjokmreHsknGTh4yV5O7tIWRFwVLMUUriMNQi9Leqast4hg6Z6pns7v
	J1EhCDA5dHRRnuz/YfRHvhko65uPuCthCq3iu4uheF9/Fv3TzGtksdJl8MZnjOW1gidUEqaYoDRXm
	ZO2ihkMJg3xtrYGrCT8T9UESKqJM5ZpDK8xNESGkQHgvVJLzM6SNNEqPzRoV/qTSozCK38d7c3bdt
	gTVoBcS080rxr0VQWfV2OLKjpvTYfFQDHrPf3aaIiP+yOZFvu+0ZgG0u7cBcBdW7NfpfH+dHlRim5
	IWZeTq8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBFI-00000006oUd-1OBz;
	Wed, 10 Jun 2026 05:12:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBFF-00000006oUF-12s3
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 05:12:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3D8668BEB; Wed, 10 Jun 2026 07:12:49 +0200 (CEST)
Date: Wed, 10 Jun 2026 07:12:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Rosen Penev <rosenp@gmail.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: target: allocate ana_state with port
Message-ID: <20260610051249.GB559@lst.de>
References: <20260608051223.6884-1-rosenp@gmail.com> <aihfCMQewU3kR_5J@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aihfCMQewU3kR_5J@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_221253_480299_4B4C2E6D 
X-CRM114-Status: GOOD (  11.92  )
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

On Tue, Jun 09, 2026 at 12:44:24PM -0600, Keith Busch wrote:
> On Sun, Jun 07, 2026 at 10:12:23PM -0700, Rosen Penev wrote:
> > Use a flexible array member to remove one allocation. Simplifies code
> > slightly.
> 
> Thanks, applied to nvme-7.2.

Btw, given that the array is of fixed size we don't even really the
VLA here.

