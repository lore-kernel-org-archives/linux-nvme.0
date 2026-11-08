Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344D606A336
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vv8VoBOn;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZxUl3w55
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aNzkqDCBVXwmi5oj0PGy5yPAAg5hMAVbnirK2n7hgX4=; b=vv8VoBOnB7ildL
	J+x+PGoVhhOpMzWArTk7tO/rfE5xZUmv+5oMcnbCltmpvzfTJq6vpocNiEpK+uVPxHajC1x8D7oMz
	v3dC2cdGt+d5dZO5s71KiTPntA2khByh4PmJcSIigdN7QZikmrJixuZuGQ5OZVWns6azUIddfvGSB
	T6+UgXJsXHusME86cCYzSi5Rc5V04ntYL97pH6iTn4RwiKRiJc6wy5ZWsiNn4tvhhbsYsm18lsFSG
	Y3DkXFznXUp3VSTbApi9Rwjvkn3E8mzKaCW7dIy5ZFmEaa0TWV6gJhTaWn2m2q68yvWLgRg+tc2DT
	wW5Lyig804ahbl/PckJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9nx-0000000GbhW-0rog;
	Sun, 08 Nov 2026 20:47:57 +0000
Received: from out-18.mta1.migadu.com ([95.215.58.18] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9nu-0000000GbgP-2ryV
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:47:56 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=Q+2pKZ+L2WOBU15nwp1Wi0VRAz2LduR8/HNqLcSY8YQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170871; v=1; x=1794775671;
 b=ZxUl3w55KgPzPTNm5iVSijHlrMf5EXOAc4m1hAD7uDigKoIkbGzkoR3F/w27tYnp0cUCgkDY
 jK32uHrQaZwhtAexWa3xHyxIzZ9KGtmb2oVirH4kziEd+Bu9Vgg4kRfNFBNR9zLv92S8QGS+hhb
 3A5SytfUjnbyNVvjGRaIe9LQ=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 3ae26450b5a369b2;
	Sun, 08 Nov 2026 20:47:51 +0000
X-Mizu-Trace-ID: 3ae26450b5a369b2
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: james.bottomley@hansenpartnership.com,
	mkp@kernel.org
Cc: hare@suse.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	snitzer@kernel.org,
	jmeneghi@redhat.com,
	bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	hch@lst.de,
	michael.christie@oracle.com,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v9 01/29] scsi: core: Clear cmd->flags for terminal queuing error
Date: Sun,  8 Nov 2026 20:47:05 +0000
Message-ID: <20261108204733.557995-2-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124754_874031_879E6992 
X-CRM114-Status: GOOD (  12.25  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

If a request can't be queued in scsi_queue_rq(), then we error out with
a blk_status_t code. Such a scenario may be the scsi_device has its
transport offline.

For BLK_STS_RESOURCE or BLK_STS_AGAIN, the request will be requeued in the
block layer. For other errors, the block layer ends the request and so
we won't see it again (until recycled).

Normally when a request completes scmd->flags is cleared in
scsi_end_request().

However for the error scenario mentioned above, scsi_end_request() is
not called and so scmd->flags is not cleared. As such, when the request
is recycled we see the old value in scmd->flags.

Fix this issue by clearing scmd->flags in the error scenario mentioned by
calling scsi_cleanup_rq().

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b52b4c5daa42..36bc995e4e25 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1994,8 +1994,8 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		 * we hit an error, as we will never see this command
 		 * again.
 		 */
-		if (req->rq_flags & RQF_DONTPREP)
-			scsi_mq_uninit_cmd(cmd);
+		scsi_cleanup_rq(req);
+
 		scsi_run_queue_async(sdev);
 		break;
 	}
-- 
2.43.0


