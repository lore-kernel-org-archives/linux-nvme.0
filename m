Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91C1C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mraJ0dlvK0XwWYXGT0DcPLxhMI+ORe9CMkm05FoHT2s=; b=2EdAw0gJ+BI/nRR6gPnhjaRvix
	TQNHAMWtLqbmVrcpJy9eXNJTbQgyAsZm4XJdhwENwRtC7B/L9g48a46vxu1kXACq4fs6TjnnC9PKF
	CD+p1bkwx1dwXjrWlFhrPAxjIPkODkKqDJNv29V4XnjGkzGagdAIyLzIyzoK/G48aWQvvMjTEk9p6
	xxThNf3HIZLZuCLRkTmjkDMkkr9uY8CEDcreZYDTXQ6mX9k8NuFefwS4F+sBXrLaz8zmGn13GPIc5
	djuMpPPbDKjRwRQLr9xORjsAW2CB+fIz4FmF0Quy1lINFByqEYczfYeBRalkrlCNPbsaP3AKNSNsB
	0lWez64A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQPn-002pVh-Pm; Mon, 30 Jan 2023 09:25:27 +0000
Received: from [2001:4bb8:19a:272a:732e:e417:47d7:2f4a] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQMo-002o3h-6D; Mon, 30 Jan 2023 09:22:22 +0000
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
Subject: [PATCH 05/23] target: use bvec_set_page to initialize bvecs
Date: Mon, 30 Jan 2023 10:21:39 +0100
Message-Id: <20230130092157.1759539-6-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230130092157.1759539-1-hch@lst.de>
References: <20230130092157.1759539-1-hch@lst.de>
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

Use the bvec_set_page helper to initialize bvecs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/target/target_core_file.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index fd584111da45c0..ce0e000b74fc39 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -281,10 +281,8 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
 	for_each_sg(sgl, sg, sgl_nents, i) {
-		aio_cmd->bvecs[i].bv_page = sg_page(sg);
-		aio_cmd->bvecs[i].bv_len = sg->length;
-		aio_cmd->bvecs[i].bv_offset = sg->offset;
-
+		bvec_set_page(&aio_cmd->bvecs[i], sg_page(sg), sg->length,
+			      sg->offset);
 		len += sg->length;
 	}
 
@@ -329,10 +327,7 @@ static int fd_do_rw(struct se_cmd *cmd, struct file *fd,
 	}
 
 	for_each_sg(sgl, sg, sgl_nents, i) {
-		bvec[i].bv_page = sg_page(sg);
-		bvec[i].bv_len = sg->length;
-		bvec[i].bv_offset = sg->offset;
-
+		bvec_set_page(&bvec[i], sg_page(sg), sg->length, sg->offset);
 		len += sg->length;
 	}
 
@@ -465,10 +460,9 @@ fd_execute_write_same(struct se_cmd *cmd)
 		return TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE;
 
 	for (i = 0; i < nolb; i++) {
-		bvec[i].bv_page = sg_page(&cmd->t_data_sg[0]);
-		bvec[i].bv_len = cmd->t_data_sg[0].length;
-		bvec[i].bv_offset = cmd->t_data_sg[0].offset;
-
+		bvec_set_page(&bvec[i], sg_page(&cmd->t_data_sg[0]),
+			      cmd->t_data_sg[0].length,
+			      cmd->t_data_sg[0].offset);
 		len += se_dev->dev_attrib.block_size;
 	}
 
-- 
2.39.0


