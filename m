Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFABCC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 07:05:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DA4610CA
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 07:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B6DA4610CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=WgBbMDNMUtVtuy
	uViaa5+zZZR7+xeWUCZm9+0vtLyAdvY9eLq/zW+RqUU9EMKn2L00u3IwfM/6ZegD/PWN3XGsip3S8
	65Um77jnXdQzzpSjkXcYJaZLzjTqU3X9hNwPZNpyjPKJNnGCfNKd0vilY1D2TVdn4JSbrDa5rH4Dz
	OK3nthh4/m+Q6wC37HswizCGwivBDuFxn6eGAAVPZmykikyZRLQA/P/EZcncWN0q8qSXVVJgpve2U
	UKU4jsU1YHzIVmt/6CmXMzJVLrKYY4XCdAibupyUfPLotaWvK+WcVuDTYcLwIaFW1sTIO/q/qfy7Z
	gGRM4Wtj/uoQfNbZe7Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSZpc-003kYx-5z; Tue, 21 Sep 2021 07:04:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSZpa-003kYQ-NB
 for linux-nvme@bombadil.infradead.org; Tue, 21 Sep 2021 07:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=pLhi6DxxjyiDnSFxRsA+piazY3
 Q74sL3hFqbUjq9cbbjySKw3d1ja5ARRmffelXt8iMZHNvssmXR5aQqzUyByY5wmNsyTv4bMawr/iA
 s3ympbnZ/O2x5qXSReot9ZfZD+FIyCgkfSIiFQPH5/txxSp5u9YaCdS6XwH0n/QINzuud6W1ZWgAL
 3RrEBt8jW/L2oGpE34oIjIv7vxmkDlohwbdUGDkmIeNCc02HgsPU9Hd7PoA3+BnVR7+ItAWCPOyvE
 U766bod2em9i2O80kKOoHQkU7I9nljlRvbp3LHhcvrX0KY0jVXhjlINFO54aqg9xpt/a5yUcL/8SK
 PU4axXtg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mSZp9-003aJg-HZ; Tue, 21 Sep 2021 07:04:25 +0000
Date: Tue, 21 Sep 2021 08:04:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v7 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <YUmD70Xcf6rMmHO2@infradead.org>
References: <20210914092008.40370-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914092008.40370-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
