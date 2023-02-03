Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0841BC61DA4
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Feb 2023 15:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2wTw7HkUjs1o6mx8pDSLEqzVcH91B6qVA7sAnj3S4Po=; b=npI/YMLy+qj8jhDzvj1Vf1BzS0
	2xqZgnOt4LTByWFzOPPDH6n4efSLsIIr6krNPDim2wwW9FSLda3CHUvjTH97K4rMr0Hy3sXIuAxtQ
	P/hM0u65K7Alzl5Eh3eIYThPoWokaNEVo4r1HD/KomTtgDf2bJqxSUUr8fsTxt8Xm7xcZgsHqJUz+
	9Y46ZY06M+LG/OM6vO7fCG8OEM+4Hk8nSZ8ZkuNqxU87sF2OdwwmUqqWteu4r99dkJk0tEfCMHuhD
	rDBX/rVK+GCBWURDUv2sxF6mil3VNpWuiDKfOYsZdbWElkJG2TaRvAfUH0l2IBrcZhL0fmBV1zKEg
	Y5NCUtog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxvZ-002hd9-EV; Fri, 03 Feb 2023 15:24:37 +0000
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pNxfH-002bLQ-H0; Fri, 03 Feb 2023 15:07:48 +0000
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
Subject: [PATCH 20/23] rxrpc: use bvec_set_page to initialize a bvec
Date: Fri,  3 Feb 2023 16:06:31 +0100
Message-Id: <20230203150634.3199647-21-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150634.3199647-1-hch@lst.de>
References: <20230203150634.3199647-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Feb 2023 07:21:38 -0800
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

Use the bvec_set_page helper to initialize a bvec.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Howells <dhowells@redhat.com>
---
 net/rxrpc/rxperf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
index 16dcabb71ebe16..4a2e90015ca72c 100644
--- a/net/rxrpc/rxperf.c
+++ b/net/rxrpc/rxperf.c
@@ -493,7 +493,7 @@ static int rxperf_deliver_request(struct rxperf_call *call)
 static int rxperf_process_call(struct rxperf_call *call)
 {
 	struct msghdr msg = {};
-	struct bio_vec bv[1];
+	struct bio_vec bv;
 	struct kvec iov[1];
 	ssize_t n;
 	size_t reply_len = call->reply_len, len;
@@ -503,10 +503,8 @@ static int rxperf_process_call(struct rxperf_call *call)
 
 	while (reply_len > 0) {
 		len = min_t(size_t, reply_len, PAGE_SIZE);
-		bv[0].bv_page	= ZERO_PAGE(0);
-		bv[0].bv_offset	= 0;
-		bv[0].bv_len	= len;
-		iov_iter_bvec(&msg.msg_iter, WRITE, bv, 1, len);
+		bvec_set_page(&bv, ZERO_PAGE(0), len, 0);
+		iov_iter_bvec(&msg.msg_iter, WRITE, &bv, 1, len);
 		msg.msg_flags = MSG_MORE;
 		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
 					   len, rxperf_notify_end_reply_tx);
-- 
2.39.0


