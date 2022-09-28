Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3C8C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m3iyGh2OXGr2S8EHMBSxFbjaxrImj8RqeUdmaMDb0hA=; b=opYcq4Pom6I2a1gqLKPgybHIJE
	9A1+3wORkD6PP/o+s7XIvpBltitNaUXC3VsSzQtw98REU+N3oDK5NghWbmn25rOKNupGi6/MZCtGr
	tYR3zKWW7pSit8LVCJUCz1+5LJqNO76po6rrBd2Ga0QDvWGt1+PrB6mrYq2rC1jX9XBgo7TvAgNwC
	TjuEFksAsCXc7daGWhXjVMInzu/DIihwcScDxE9ALwjKNOHLaM+HGZfKlo2S+SOAVVKcIj8ov1cjJ
	lHE7cv+owvPCPh1n/6+4xGByavh9xIKL7too7nyFD4PRT6ke0mwhW4yHj8HxsXJl0PUpUSa4YjMPB
	ZJOEMZ1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oddOD-000H8E-2m; Wed, 28 Sep 2022 20:10:41 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oddO8-000H68-D5
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 20:10:38 +0000
Received: by mail-ej1-f42.google.com with SMTP id lh5so29420394ejb.10
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 13:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=m3iyGh2OXGr2S8EHMBSxFbjaxrImj8RqeUdmaMDb0hA=;
        b=fQnTd4ySYotElRL0j2BtlEpUm7oKuwg/wHtd54Z4PKjXXH8YWa3FS/dSl8KQtoUWVZ
         8UntAOgaYcOuH5KtS/qv6YDl1ByMIKKEXqa8PC7Nb7e+SiA58z/fTDoQaX/eEoflTWeT
         sUUFFaMBEbgnVJB9gTsTISBd+qA3+xCoij/REBNQ5hrJJ9gcuqFrXgwMTGWXMeg1AGDB
         cC3bwd0ZapPunmPlCvxxgNzyJ3Kd9W+tQ/5JCfKadTi+k5afErOQUxyXLi5IIRcGM7xZ
         8ox1REaU0PhYs2GL6cC6uKQRTIS7L1OxmvIf8kfF9CXztpkqjBnNnDC1CEnvbegWjlqE
         a8Sw==
X-Gm-Message-State: ACrzQf1KBxNlb3AUe1Fs/mXGLrImVKNQrjdHkFhRLMerfeP8aXNfC+FL
	Vmytk/8X+PbwAtU02P9adFbRhoPMObU=
X-Google-Smtp-Source: AMsMyM6H72FtRydrfc5JqSN1m9BUbFrt17HRsin2vYkbCWl7M1iRB0GGfBlMM59xC7mAVVHT4MhNAg==
X-Received: by 2002:a17:906:8a5a:b0:781:6a01:5ccc with SMTP id gx26-20020a1709068a5a00b007816a015cccmr28929450ejc.118.1664395833997;
        Wed, 28 Sep 2022 13:10:33 -0700 (PDT)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b00764a76d5888sm2838321ejh.27.2022.09.28.13.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:10:33 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Yogev Cohen <yogev@lightbitslabs.com>
Subject: [PATCH v2] nvme-multipath: fix possible hang in live ns resize with ANA access
Date: Wed, 28 Sep 2022 23:10:31 +0300
Message-Id: <20220928201031.166876-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_131036_494062_923AF03A 
X-CRM114-Status: GOOD (  16.49  )
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

When we revalidate paths as part of ns size change (as of commit
e7d65803e2bb), it is possible that during the path revalidation, the
only paths that is IO capable (i.e. optimized/non-optimized) are the
ones that ns resize was not yet informed to the host, which will cause
inflight requests to be requeued (as we have available paths but none
are IO capable). These requests on the requeue list are waiting for
someone to resubmit them at some point.

The IO capable paths will eventually notify the ns resize change to the
host, but there is nothing that will kick the requeue list to resubmit
the queued requests.

Fix this by always kicking the requeue list, and if no IO capable path
exists, these requests will just end up being queued again.

A typical log that indicates that IOs are requeued:
--
nvme nvme1: creating 4 I/O queues.
nvme nvme1: new ctrl: "testnqn1"
nvme nvme2: creating 4 I/O queues.
nvme nvme2: mapped 4/0/0 default/read/poll queues.
nvme nvme2: new ctrl: NQN "testnqn1", addr 127.0.0.1:8009
nvme nvme1: rescanning namespaces.
nvme1n1: detected capacity change from 2097152 to 4194304
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
block nvme1n1: no usable path - requeuing I/O
nvme nvme2: rescanning namespaces.
--

Reported-by: Yogev Cohen <yogev@lightbitslabs.com>
Fixes: e7d65803e2bb ("nvme-multipath: revalidate paths during rescan")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- fix commit msg body format
- follow reverse-xmas declaration pattern

 drivers/nvme/host/multipath.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6ef497c75a16..1113139c9736 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -173,15 +173,17 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
 	sector_t capacity = get_capacity(head->disk);
+	struct nvme_ns *n;
 	int node;
 
-	list_for_each_entry_rcu(ns, &head->list, siblings) {
-		if (capacity != get_capacity(ns->disk))
-			clear_bit(NVME_NS_READY, &ns->flags);
+	list_for_each_entry_rcu(n, &head->list, siblings) {
+		if (capacity != get_capacity(n->disk))
+			clear_bit(NVME_NS_READY, &n->flags);
 	}
 
 	for_each_node(node)
 		rcu_assign_pointer(head->current_path[node], NULL);
+	nvme_kick_requeue_lists(ns->ctrl);
 }
 
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
-- 
2.34.1


