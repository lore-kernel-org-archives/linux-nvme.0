Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7DCC982DA
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ocH8X1s2HOFa2KmE9/zFLWAAzVth74Tekaym0qewjiE=; b=hoRpElgmFTNXWabFCatqQSgsZj
	avetf7IW1HsmsjP5AF0gV1Sq7BXYPJBoh2hKXrM61hBfl8klWxjRzSboUyvGZuAt7P91Z8uxTzDCK
	vCx+mMVqDVnuQTMuhtFcKLFxtVWc5cumeaH4VVN1w6N3BxUkToGnzYmLoR7jmkmum7E566vvhH3vz
	/Znlw2iW/7Wh7Y4+vFl5INF7IBxPhWDasHiOv+8NFHa6P+VDNdJDIhbkn7W3csoOFAtDWLYmFVxoq
	wkW7k/qmdKZbpsiKnVVHRhGKkzUBd2sj+JAXy4gROruj+7Nbn7rFPgri1kIQlTZBiJVcot2F+F4iT
	4MqW0chQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8KYS-000000007dt-2gQy;
	Sun, 20 Sep 2026 16:38:16 +0000
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8KYP-000000007d1-0SLh
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 16:38:15 +0000
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396cccbba92so2029067a91.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789922292; x=1790527092; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ocH8X1s2HOFa2KmE9/zFLWAAzVth74Tekaym0qewjiE=;
        b=dpUKxui+GvrC/vzJYOdCrRdw+7KFDK1gpjY/iu9js4Vuyb8zwe9Viqi/yFN6QMwt3n
         SuW+xVgv7cwmO+GvXEg6POiCGcEA8+wCBE/WMWeKz/Mhlqq0/Qk0ycZuq3cJy6OwoqcP
         KCNQrjqPBKdGuyqv2ex9amErxrrgloCbyJCHDbP8D59Dyrl5khJUtAimOxIB5fyY4uTl
         GSRKlrysqzpqMmcs7WH4fIZPd1xNrl/80s+kekppkcJErtqybS2CDEeWCBN9HYk/1wAZ
         kcB1YnBtn00QtZ3en9sO3VqM7H2jTIpDBHQfj5VrmVnWdWfauvBjcznTpDG6E7DYT5l/
         NROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789922292; x=1790527092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ocH8X1s2HOFa2KmE9/zFLWAAzVth74Tekaym0qewjiE=;
        b=UnjeUKvr5P8KQzWSh8VXZ31KRVA4ATatJEYDsENns+47WZcf+XZCqMDafASGdp5kcN
         qxKZd093HtSf3gs0U/f+yCvUveohHUIpRhCGnMF+eWVYNFn9CuzrHcoXxZEZiOAB3MG+
         H/JFiAesRbkyquICT5c8uVuW/V5IICHWddDjsA24/duWzBbmFOK6lw8C8Ros2jZTqaBm
         O4pmofldrRZRGXoz1NKu236qwFRUJ8JYq032rHpTRp5ioSrcKRnACArteUqLpiz9WvzM
         zPMFJMT9UhtsfaIEfgMS5Lm/FpxT2Q8ZaR+iI4J0pAGgmZ7NLcnEzk+IFdCR+yvp4Er1
         nS9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzWFQLP6cazWp6er4nDXCn729EV9iqObP69rxjxS5ZFcq7Qh9MHYnrmMaasTgt8TBqWqzr2KHHtGf2f@lists.infradead.org
X-Gm-Message-State: AFuF++msoWzJL6iBZZ5kRIjb5pSovNAWRAf2IwagdjCulHcQaagmiEeQ
	fgCu6q/kpGkABAzZHNWSxs8q0UEbuVg9PMyopuAY/8Shb9EtuymCU1tY
X-Gm-Gg: AYBFou08zJK1hHA/n1Vvm4SxXSjHYFZVbphIl1/oKVb96tZIBCre98WjodWeNJMWKC7
	pxEP380f/8/LRbuH+ueDTvkNOPHs1KEd8KMaZh7Xs76zsuB0+vsKVeeZulMlwN9FbAWa1UorLwY
	2Wh4I/N4B7Wh4lGRDChtcJka48zCbERHgt9kfPFtGXpYB4Z+NA9zz55Ly3pNuHGFD4/+IQzjids
	6DLh2eXt4xKigLgORmjl1UHAJjySU3U+bj2oVokKBq/+w8S2maYIzzYed6alyzMUIxqCkRheTXy
	Xy+yG8lsmzI9xh23RseV/gVWj8Ogew8X6MxKFlY2K11u2HLP0VVpTx0ATh7Nv6iUEvtHov6TKsy
	KS/wtOw/1/kgJtY6+G/I5Oqd+yXd09C02XLWGBw+QoWRiiehvXaMjGhfXosAQlzYMMbh4VBZOzB
	ycjtBbSj9ki8mCIGUeYMyFahATUAy1KdfdFrlLxQXlhjyboLEJ34McCvrNyIYtPCr/4+FpFiDK2
	OUpuYN1aYf+lPE=
X-Received: by 2002:a17:90b:17cc:b0:39e:135e:130e with SMTP id 98e67ed59e1d1-39e54af6a0emr13628763a91.3.1789922291762;
        Sun, 20 Sep 2026 09:38:11 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:2022:c2a9:de8:d005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5647c151sm5267536a91.4.2026.09.20.09.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 09:38:10 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	syzbot+77955102efac681ec73b@syzkaller.appspotmail.com
Subject: [PATCH] nvmet-fcloop: fail LS request synchronously when remote port is gone
Date: Sun, 20 Sep 2026 23:38:04 +0700
Message-ID: <20260920163804.67858-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_093813_146375_BBBA3D67 
X-CRM114-Status: GOOD (  10.99  )
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

fcloop_t2h_ls_req() handles a missing remoteport by queueing the request
on tport->ls_list and completing it with -ECONNREFUSED from a work item.

nvmet_fc_delete_assoc_work() sends the Disconnect Association LS this
way. When it runs during nvmet_fc_unregister_targetport(), the work is
queued after flush_workqueue() has started, so it is not waited for.
nvmet_fc_free_pending_reqs() then frees the still-pending lsop and the
late work item calls lsreq->done() on freed memory:

  BUG: KASAN: slab-use-after-free in fcloop_rport_lsrqst_work+0x242/0x2e0
  Workqueue: nvmet-wq fcloop_tport_lsrqst_work
  Allocated by nvmet_fc_xmt_disconnect_assoc
  Freed by nvmet_fc_free_pending_reqs
           nvmet_fc_unregister_targetport
           fcloop_delete_target_port

Return -ECONNREFUSED directly instead. __nvmet_fc_send_ls_req() unwinds
and nvmet_fc_xmt_disconnect_assoc() frees the lsop, so no completion is
left outstanding.

Reported-by: syzbot+77955102efac681ec73b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=77955102efac681ec73b
Fixes: bbccbf791e6f ("nvmet-fc: free pending reqs on tgtport unregister")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/nvme/target/fcloop.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b63af3b643a6..9f9fb40f8a97 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -456,21 +456,18 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 	 * 1:1 tgtport vs remoteport
 	 */
 
+	/*
+	 * Fail synchronously: an async completion can run after
+	 * nvmet_fc_unregister_targetport() has freed the pending lsreq.
+	 */
+	if (!tport->remoteport)
+		return -ECONNREFUSED;
+
 	tls_req = kmem_cache_alloc(lsreq_cache, GFP_KERNEL);
 	if (!tls_req)
 		return -ENOMEM;
 	tls_req->lsreq = lsreq;
 	INIT_LIST_HEAD(&tls_req->ls_list);
-
-	if (!tport->remoteport) {
-		tls_req->status = -ECONNREFUSED;
-		spin_lock(&tport->lock);
-		list_add_tail(&tls_req->ls_list, &tport->ls_list);
-		spin_unlock(&tport->lock);
-		queue_work(nvmet_wq, &tport->ls_work);
-		return ret;
-	}
-
 	tls_req->status = 0;
 	ret = nvme_fc_rcv_ls_req(tport->remoteport, &tls_req->ls_rsp,
 				 lsreq->rqstaddr, lsreq->rqstlen);
-- 
2.43.0


