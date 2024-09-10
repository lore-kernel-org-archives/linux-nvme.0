Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36757ECE564
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 04:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPfFns8xo8iHVTkrKx/3ue3BS9+6RQWrOd8K2gLZwpk=; b=dDsx1FeNFxZGJCQLS/vVBk9F39
	yKZ4mx0FpJe7Zm/DQEm5pdWZZ6F2fZrvUbpvaN7+sBR+Tfpy5ugOpvf4auEDq9jYpChcwjM0fYNa1
	DWvdiO2mqvoTFklpKIu+vuLbalBMCzXEy6oY+Iq0g9LdG1B8yPAC3bLvUDqBsf1Iv5P/gANlLdA5u
	iAV/MgeTLqZV4RzvWckJiGN16BV2G8XbKkHkCCNxJvvGlGq4wfPg3U4gFAnWXnr6J7JW6rpmPeDAE
	wptjxkh9kdM7vXzmT7c2GNJk0eg6R1JVnFt0HhlhkzcyjI80MCIyROeRnZbMoHPtZSGwUzOYyLAgO
	2G1/uheA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsWx-00000004DMt-3yrS;
	Tue, 10 Sep 2024 04:31:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsQQ-00000004CXl-200A
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 04:24:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 07956227AAD; Tue, 10 Sep 2024 06:24:12 +0200 (CEST)
Date: Tue, 10 Sep 2024 06:24:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: possible regression fs corruption on 64GB nvme
Message-ID: <20240910042411.GA15282@lst.de>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_212422_669652_AAA5282F 
X-CRM114-Status: UNSURE (   9.99  )
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

Hi Robert,

what platform is this on?  Does it have DMA that is not cache coherent?


