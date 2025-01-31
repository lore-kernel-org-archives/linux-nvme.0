Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76174C02194
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=toZkHOKmtEQt0GILvsU2MdLlyWFdCCeeIMu36shQMpg=; b=3NkKsGk1h7ZqVi0RcULSyCCdSf
	4yTRyiLeKcOGWho2g7sQIprjdz6j92q1YAwYS3Sz9rGqjzzwLy+yakWOJ/0lZLeG3sZ5MmFToaG5o
	c6kjnDAXVdCPck8GPiIlXSsQxk9NCF4toEbN5NOZ0ncj5kXpjlopQf6Qtr5jLfGATM0uv96dLhewV
	gvX0RRIn3gn2fb3HX+fsan/N6KKFhuPw2qPzfbfneH4Ftzg4UehkgMtSqAu0JOkqSMb3OEXhr3V+f
	gHLb+ycAdgjkNa2E6GaTLwdiLNBfVs8G4qIJwomETjVmYPEx6WmFHkKYV++ADsjZ2JygcXWsnFth/
	2hcqGyNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpkc-0000000AZMB-09p8;
	Fri, 31 Jan 2025 12:03:58 +0000
Received: from 2a02-8389-2341-5b80-85a0-dd45-e939-a129.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:85a0:dd45:e939:a129] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tdpkY-0000000AZLj-3pum;
	Fri, 31 Jan 2025 12:03:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: annotate noio context v2
Date: Fri, 31 Jan 2025 13:03:46 +0100
Message-ID: <20250131120352.1315351-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

based on the reports from lockdep annotating q_usage_count it became
clear that we need to do noio allocations in a lot more place.  This
patch takes care of ensuring allocations with a frozen queue are
done using the noio flag to avoid deadlocks.

Changes since v1:
 - drop the loop patch that isn't needed

