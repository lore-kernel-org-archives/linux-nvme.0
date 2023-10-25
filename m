Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07037C25B47
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 10:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJl2pNGus+zmZZ2QAVuG7fmdoEEDiypT/1RRzJ57qyw=; b=d37gGa0Evz+1lQCY61JXsTj8sS
	5geXHBRATEkHzmK954gQkza2qzMFfhNyDTAZzr/nleuS3hknsn6fe4Tj2xa2P6wl+QoTd6cLH47vO
	uaZR/CAL7Isee3XrdD9LmFteizaAiZp09R8bT+QuBAENEdq+E5iAiFNfhzNMe82m8dc7LheyHNitY
	IktzqkytLZo+UlVW6qCJMhSJP22GIztFR5HS6KinzCLOThrmkwWbfLGjEoqlhfZi4+8NeL3s+uUOU
	joq2SY7gnGV4oh8gM3stVABnAbIv0NjTXDxZP/qjNktUpSGeJOLK2uMwTFd0cSvUcNEJNq0oxEFzD
	l4bFCZdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbUM-00C7KG-0s;
	Wed, 25 Oct 2023 10:51:50 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbUG-00C7HX-0R
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 10:51:46 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id CDBE6240103
	for <linux-nvme@lists.infradead.org>; Wed, 25 Oct 2023 12:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698231100; bh=YFBxTR0zvXLVBvSBdoAtunK27N4nE0w7KBv3zsHx+dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=G8WLzTYnOQwb7L+Iv+qxQD7cF8gI3zQa/zQtvHCVopa5UOWp9r25c4qNwV1PCbo6t
	 xLPFuZbjtcV+DZYqzuoigK6kvE1K3DF1aijVZw1lTMMKj1ws4eCl47jJo0wBaCiiyG
	 XG2tgjwqvWJAEi2Aakg/8T2gYwmycF/AXHn9mVOM+8VQANW1zUWNG6WTGegs8JaWl5
	 ZwpM8jY69Uyy8BJFSmF51482P7BrruWNJPx9HY1RFqEshKuwrCRnAtSCt1c3kWEDDr
	 GRrbhRcKeeAXyso/8YSJlhraX2gHHivkvZxhXOrb3eTzKWferG+Am/ZcchZz4dMbPb
	 IsZ5TbDbFYsEA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SFm2M3kRBz9rxL;
	Wed, 25 Oct 2023 12:51:39 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v3 3/3] nvme-auth: always set valid seq_num in dhchap reply
Date: Wed, 25 Oct 2023 10:51:25 +0000
Message-Id: <20231025105125.134443-4-shiftee@posteo.net>
In-Reply-To: <20231025105125.134443-1-shiftee@posteo.net>
References: <20231025105125.134443-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_035144_342067_2CA76B84 
X-CRM114-Status: GOOD (  13.84  )
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

Currently a seqnum of zero is sent during uni-directional
authentication. The zero value is reserved for the secure channel
feature which is not yet implemented.

Relevant extract from the spec:
The value 0h is used to indicate that bidirectional authentication
is not performed, but a challenge value C2 is carried in order to
generate a pre-shared key (PSK) for subsequent establishment of a
secure channel

Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>

---
v1: used incorrect prefix nvme-tcp
v2: added spec extract to commit message
v3: read the seq-num in nvme-target code

 drivers/nvme/host/auth.c               | 3 +--
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 8558a02865ac..7f6b2e99a78c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -316,15 +316,14 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 		chap->bi_directional = true;
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid = 1;
-		chap->s2 = nvme_auth_get_seqnum();
 		memcpy(data->rval + chap->hash_len, chap->c2,
 		       chap->hash_len);
 		dev_dbg(ctrl->device, "%s: qid %d ctrl challenge %*ph\n",
 			__func__, chap->qid, (int)chap->hash_len, chap->c2);
 	} else {
 		memset(chap->c2, 0, chap->hash_len);
-		chap->s2 = 0;
 	}
+	chap->s2 = nvme_auth_get_seqnum();
 	data->seqnum = cpu_to_le32(chap->s2);
 	if (chap->host_key_len) {
 		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 1d9854484e2e..eb7785be0ca7 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -163,11 +163,11 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 		pr_debug("%s: ctrl %d qid %d challenge %*ph\n",
 			 __func__, ctrl->cntlid, req->sq->qid, data->hl,
 			 req->sq->dhchap_c2);
-		req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 	} else {
 		req->sq->authenticated = true;
 		req->sq->dhchap_c2 = NULL;
 	}
+	req->sq->dhchap_s2 = le32_to_cpu(data->seqnum);
 
 	return 0;
 }
-- 
2.39.2


