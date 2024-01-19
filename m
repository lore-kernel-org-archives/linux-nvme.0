Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1F2C47DD3
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 16:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6SmJw14/0T3QFq2lCb7AOALWjjzOgKZ9hRbndy0R7AI=; b=iHcYNHBS4aQRmvprxJ9azxBDyF
	6kg9Gr5PH2zZ3SZD3ju9vamP6Lw2IFG6jkvrbNn1vucJ87JByI0mwjLfIX5vaoqtLYhJVoExi/W+4
	yEGvpooChLJ77oII5qWabuXhDeXohQaYcsCYOQoYBY9z287UNxVgufI2049+c/2PInm+5HirrrRqX
	CLzo2uCydVd09LczxedJaev16TLM/g56egHi5zDb+0owRSNlKHgne5O7oyQZ6DcaVGaKrrBWqZP8c
	xySkNxWoe+1Hm63dUHu9FrqqRXoaRpgcy3K5KBMyrb37IvBxhv4aYJFmlAYcrcWEyzeeSpWGGecTu
	sp4ziy4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQrfX-0066E5-0K;
	Fri, 19 Jan 2024 16:24:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQrfV-0066Db-0U
	for linux-nvme@bombadil.infradead.org;
	Fri, 19 Jan 2024 16:24:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=6SmJw14/0T3QFq2lCb7AOALWjjzOgKZ9hRbndy0R7AI=; b=t6WunDiYYjv6iOpAEiG0tTCiOE
	9KraFRh/TQwUXy3kvYdi+ZqCTKgneFa0x6a5u6ViyfwU7KPPN7aG6+TZilHG/ijMF0asm+qQTB9M3
	uIZHwojOT6FFml7KCO6UCwhQGLZ2Ii9LXk4Xum3qdI74l+cd0VTendMVH/PZVhTAJcKUSm5ck7BVr
	U87GBkNPCjisje8+dDjlvDBBrZssy8R0jbEF4yvZxflR5RU/lfoiZKTT+m2bG4AXy3hXtrgvyG+M2
	E66gK3u5hPu6ZG1k2LJy15VP7WmpeOnqj48FT9WAmXUjTw12zJ8DSwo5DOHmNKNyo9vdzMlhoNB8E
	v+Qe6Zmw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQrfR-00000005fBk-346O;
	Fri, 19 Jan 2024 16:24:29 +0000
Date: Fri, 19 Jan 2024 16:24:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	bpf@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] State Of The Page
Message-ID: <ZaqiPSj1wMrTMdHa@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

It's probably worth doing another roundup of where we are on our journey
to separating folios, slabs, pages, etc.  Something suitable for people
who aren't MM experts, and don't care about the details of how page
allocation works.  I can talk for hours about whatever people want to
hear about but some ideas from me:

 - Overview of how the conversion is going
 - Convenience functions for filesystem writers
 - What's next?
 - What's the difference between &folio->page and page_folio(folio, 0)?
 - What are we going to do about bio_vecs?
 - How does all of this work with kmap()?

I'm sure people would like to suggest other questions they have that
aren't adequately answered already and might be of interest to a wider
audience.

