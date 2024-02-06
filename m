Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D086C48297
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CnWkk7cuFSOiLkiqPK3HcpUUisb9YLpwBC4aVToPIOQ=; b=PSWXauP+mvmDSjJkZqH/qU/H8N
	TW+HGR95PsXN5mKRoSMFN2YTQGvjAXEQSect2tjYq2pKxi48sgqt3GmKzImBJ1NK49dDz9VVvC2sX
	mRTNMesIrZVkqjoPFii64WSfEdXHUHS0iePB6Y4XpC0Lm+yesLU+m7X7JJ0oJIvu3Zkg6KPHHK701
	2lPdb3YjwDZILA0cv4NmoqEOdI7wnsfeXnzql3QZJByRR81jVZtLjqgf0j8+XLY2n9BpGxoU6YHVz
	FKQ9HWRSynXISlMsaxTjXIAz0mlIxd6dfzNAt6y2D6NtywOA753s4J71l7+93o1QIL4SBM3GvrVkX
	PJE+BeUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXOf7-00000008J9G-0hsE;
	Tue, 06 Feb 2024 16:51:09 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXOeg-00000008J6I-153L
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 16:51:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 427BACE0FF3;
	Tue,  6 Feb 2024 16:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63163C433F1;
	Tue,  6 Feb 2024 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707238235;
	bh=XR/MQzn75Tw+hj3swPGKO8AQr6S2qxqzCr7pDVMWr0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=muPRkAOEEmQUrk01o5zdxSzoEOz6xt1QPFEPYd1+mKdEo7/6mGbaFXok4bw4jcHNK
	 2GvR+jdGi2JZfbm/S5AwoQjFhrcCvBjngFII42Tzo9MGZfkd3PN5pOhQYHR+0jrNsO
	 kWiPZ+cP2SuvD+ymZC8AoQvpGPzD9+9oqzvhLWVGwO2FSGExKl9T/hpF9pG0RYGhYn
	 UeCf9d8zvlRCUrlPS/oeTXP5/L6YqkySkfp1Dv64w2v7nWVKvnGdvqTGHmFPu392OG
	 kxKa5KZG/rCWYUFHYvzrq2Tn2Gg8Gvi7ZIrZRtu5HEUNkSRrIxzEwU09VgiHAequ0d
	 tp6kwmsjXaWkQ==
Date: Tue, 6 Feb 2024 08:50:33 -0800
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme: test log page offsets
Message-ID: <ZcJjWU4pD98FR8AH@kbusch-mbp.mynextlight.net>
References: <20240205185225.2878642-1-kbusch@meta.com>
 <mabar2czffh5f7ftappnbtir34vzz65ecxatz7p4xbe6u6ts2s@hwe7yb3pcajx>
 <ZcHUf_MF_yDAkrMG@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcHUf_MF_yDAkrMG@kbusch-mbp.mynextlight.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_085106_440647_1B833E60 
X-CRM114-Status: UNSURE (   6.94  )
X-CRM114-Notice: Please train this message.
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

On Mon, Feb 05, 2024 at 10:41:03PM -0800, Keith Busch wrote:
> 
> FWIW, while the device handling is completely wrong, this log has read
> side effects, so an application reading non-zero offsets is pretty much
> nonsense (and unfortunately nvme-cli does similiar things too).

Ah, please ignore this statement. Error logs are just temporal before
dropping off. I confused myself with a different log with that behavior.
Yesterday was a long day...

