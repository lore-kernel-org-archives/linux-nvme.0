Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DE9C04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hA07+p0uKBTYe5MM+SIwGglBUwF6JyBwXXElS6xBHO8=; b=i0fmwIimMBs/FCWGZb2pOJ+4rw
	bislF7x5zAOv/fvyeYK5aRjsegcx2avJbKRFUP2cxspiuzwHIILjsbn7WLG2/LT3tsFvbqUKGA3HN
	PLW/OxDrTPDkWzY1pJSxTgKZ+RI0Iyxiwp6gp6iFf6OUuz09+2BkJi17HjmEJauWTzbYC/y6QyyHf
	j/cRd/MCXX+Bhj8y2wggfDk+rhMcM40DnzuK/HxoOVARTQnUjWlTh/MwNvGWaNLsSJ6lsuaMzoD0V
	7wsrS31EJziUz3ipr3GtP9bu1eKkh+3UcIkM4iQC2QdwSeUTaIF4Qdl0iuvJ1jiZENbk7pdQJ35jL
	uvyPbP4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wLJ-0000000Gj5G-3Q56;
	Tue, 14 May 2024 17:53:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wLG-0000000Gj2w-1t5T
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hA07+p0uKBTYe5MM+SIwGglBUwF6JyBwXXElS6xBHO8=;
	b=MytkdEdMy5AVrqfqpeKhqB6u3xN7mdwVqK/I62nZnMan4NwVsxlS4Hsir7LmX4wsVbec56
	b++KD9efcIqhnJeO2I/PPDpBqbKaYpH9v4DnC/XcJHemV56fh4Pxndukm3Yc7zxOJ5vH4x
	uolhfVcTccgl9r7ci1D+ZBUvH/DgdMs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-X-Vf1AQEN72eU3Xt6z5nRA-1; Tue, 14 May 2024 13:53:29 -0400
X-MC-Unique: X-Vf1AQEN72eU3Xt6z5nRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C960841C61;
	Tue, 14 May 2024 17:53:28 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EEEFF400057;
	Tue, 14 May 2024 17:53:26 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com
Subject: [PATCH v4 0/6] block,nvme: queue-depth and latency I/O schedulers
Date: Tue, 14 May 2024 13:53:16 -0400
Message-Id: <20240514175322.19073-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_105334_612936_57022AF1 
X-CRM114-Status: GOOD (  14.92  )
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

Changes since V3:

I've included Ewan's queue-depth patches in this new series and rebased
everything on to nvme-6.10.  Also addressed a few review comments and
modified the commit headers.  The code is unchanged.

Changes since V2:

I've done quite a bit of work cleaning up these patches. There were a
number of checkpatch.pl problems as well as some compile time errors
when config BLK_NODE_LATENCY was turned off. After the clean up I
rebased these patches onto Ewan's "nvme: queue-depth multipath iopolicy"
patches. This allowed me to test both iopolicy changes together. 

All of my test results, together with the scripts I used to generate these
graphs, are available at:

  https://github.com/johnmeneghini/iopolicy

Please use the scripts in this repository to do your own testing.

Changes since V1:

Hi all,

there had been several attempts to implement a latency-based I/O
scheduler for native nvme multipath, all of which had its issues.

So time to start afresh, this time using the QoS framework
already present in the block layer.
It consists of two parts:
- a new 'blk-nlatency' QoS module, which is just a simple per-node
  latency tracker
- a 'latency' nvme I/O policy

Using the 'tiobench' fio script with 512 byte blocksize I'm getting
the following latencies (in usecs) as a baseline:
- seq write: avg 186 stddev 331
- rand write: avg 4598 stddev 7903
- seq read: avg 149 stddev 65
- rand read: avg 150 stddev 68

Enabling the 'latency' iopolicy:
- seq write: avg 178 stddev 113
- rand write: avg 3427 stddev 6703
- seq read: avg 140 stddev 59
- rand read: avg 141 stddev 58

Setting the 'decay' parameter to 10:
- seq write: avg 182 stddev 65
- rand write: avg 2619 stddev 5894
- seq read: avg 142 stddev 57
- rand read: avg 140 stddev 57  

That's on a 32G FC testbed running against a brd target,
fio running with 48 threads. So promises are met: latency
goes down, and we're even able to control the standard
deviation via the 'decay' parameter.

As usual, comments and reviews are welcome.

Changes to the original version:
- split the rqos debugfs entries
- Modify commit message to indicate latency
- rename to blk-nlatency

Ewan D. Milne (3):
  nvme: multipath: Implemented new iopolicy "queue-depth"
  nvme: multipath: only update ctrl->nr_active when using queue-depth
    iopolicy
  nvme: multipath: Invalidate current_path when changing iopolicy

Hannes Reinecke (2):
  block: track per-node I/O latency
  nvme: add 'latency' iopolicy

John Meneghini (1):
  nvme: multipath: pr_notice when iopolicy changes

 MAINTAINERS                   |   1 +
 block/Kconfig                 |   9 +
 block/Makefile                |   1 +
 block/blk-mq-debugfs.c        |   2 +
 block/blk-nlatency.c          | 389 ++++++++++++++++++++++++++++++++++
 block/blk-rq-qos.h            |   6 +
 drivers/nvme/host/core.c      |   2 +-
 drivers/nvme/host/multipath.c | 143 ++++++++++++-
 drivers/nvme/host/nvme.h      |   9 +
 include/linux/blk-mq.h        |  11 +
 10 files changed, 563 insertions(+), 10 deletions(-)
 create mode 100644 block/blk-nlatency.c

-- 
2.39.3


