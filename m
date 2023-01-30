Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903F3C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lCuBrdiApHtnAzdlL9jd8/orKVtuLY/i0Sero01PH48=; b=P0ts4q3dFjQ6N34Baz5H2/Dl1W
	/O9O/dQdAbVa10GHufff0DTZ0/HHTb5XO74mdb8P9pCQVddUT28l40qQoo2j9g2FNrg2SoojrXCUs
	wFyd/JE6RKzhWeo1+hC3QiwK6nos6Vk4Hxq/ucu+0MVozhFJRg1qXrJM+teD8Q1X9RR9BAbsuMs6g
	INh5QEkw0UcTzbiC/v+ugwnLUPyMZMh9oYa08KIGDmNZ+dcne565zh4OYvPSknfYW9pi+FQBa3jw/
	1+jAwdgOScD4jtO2h27gVrOVf9OylLY1WkPhI9hY6gCsG5DCU9ov/q4hEqgV5/XmeYdRGKvMZarIF
	6FCXVZ3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQPT-002pLt-5q; Mon, 30 Jan 2023 09:25:07 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQMS-002nyI-W6; Mon, 30 Jan 2023 09:22:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Steve French <sfrench@samba.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	devel@lists.orangefs.org,
	io-uring@vger.kernel.org,
	linux-mm@kvack.org
Subject: add bvec initialization helpers
Date: Mon, 30 Jan 2023 10:21:34 +0100
Message-Id: <20230130092157.1759539-1-hch@lst.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Jan 2023 01:24:49 -0800
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

this series adds the helpers to initalize a bvec.  These remove open coding of
bvec internals and help with experimenting with other representations like
a phys_addr_t instead of page + offset.

Diffstat:
 block/bio-integrity.c             |    7 ------
 block/bio.c                       |   12 +----------
 drivers/block/rbd.c               |    7 ++----
 drivers/block/virtio_blk.c        |    4 ---
 drivers/block/zram/zram_drv.c     |   15 +++-----------
 drivers/nvme/host/core.c          |    4 ---
 drivers/nvme/target/io-cmd-file.c |   10 +--------
 drivers/nvme/target/tcp.c         |    5 +---
 drivers/scsi/sd.c                 |   36 ++++++++++++++++------------------
 drivers/target/target_core_file.c |   18 +++++------------
 drivers/vhost/vringh.c            |    5 +---
 fs/afs/write.c                    |    8 ++-----
 fs/ceph/file.c                    |   10 ++++-----
 fs/cifs/connect.c                 |    5 ++--
 fs/cifs/fscache.c                 |   16 +++++----------
 fs/cifs/misc.c                    |    5 +---
 fs/cifs/smb2ops.c                 |    6 ++---
 fs/coredump.c                     |    7 +-----
 fs/nfs/fscache.c                  |   16 +++++----------
 fs/orangefs/inode.c               |   22 ++++++--------------
 fs/splice.c                       |    5 +---
 include/linux/bvec.h              |   40 ++++++++++++++++++++++++++++++++++++++
 io_uring/rsrc.c                   |    4 ---
 mm/page_io.c                      |    8 +------
 net/ceph/messenger_v1.c           |    7 +-----
 net/ceph/messenger_v2.c           |   28 ++++++++++----------------
 net/rxrpc/rxperf.c                |    8 ++-----
 net/sunrpc/svcsock.c              |    7 +-----
 net/sunrpc/xdr.c                  |    5 +---
 29 files changed, 143 insertions(+), 187 deletions(-)

