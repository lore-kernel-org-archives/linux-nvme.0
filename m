Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0D2CDB483
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6sNd9aJwFqPqmqj7jEpOmb3ih+tWgChZnBsGY/fIpus=; b=sWuiDKweT17n7+Cx4YXWQxzfD/
	0NsxeGn6AI+QCkC5oJKrF8CfRBjSmt96K3r3bXraHALGMB819YnaGU0yPyrYkJOh0krye1pdEH6g8
	m3UkPKaW4u3WReF8vfePXHI+Uc2jllqKS7oIfhvsu8NOwOlFQysnlHnKSZNMawmgntIAGkWIZTSa8
	Kw/FEiW0O9rhGNk5KFkYXI4q7LgzlKmO3LVvctMt+CHDhdBEhbC66pwb/2x/tvAxt3M8wRXt7lJ8t
	sszlo6PtLrjGpgwR8x7hGnZAei0APy0LYu8YKHEJeBWz0Ackr+EsAapMsNUGFXMzM0/l2pd+/kPSx
	jsNxi+Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrEjG-002zgR-0E;
	Fri, 13 Oct 2023 09:45:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrEjC-002zfm-2n
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 09:45:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697190303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6sNd9aJwFqPqmqj7jEpOmb3ih+tWgChZnBsGY/fIpus=;
	b=TRTNS3PuF4pIoa6p4cvFGjKOSYxqE6eItTNQ0DYOKKEkZRNv1NghAMj3uIM9QGPha1/xWa
	dx4ELAVlBVQ/OSpqLt36KA6YdbvO+Irr+TiofGMJusywY2T5rsFBTO8d/+E0fNTTG/ByLA
	2llyShG3nFJx7rAWBguKKHXa4h2SqGA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-sw4PZmqyPdiXistQNuGWfQ-1; Fri, 13 Oct 2023 05:42:43 -0400
X-MC-Unique: sw4PZmqyPdiXistQNuGWfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D50B0281295D;
	Fri, 13 Oct 2023 09:42:42 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.14])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D86825C0;
	Fri, 13 Oct 2023 09:42:40 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hare@suse.de
Cc: sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-auth: complete a request only after freeing the dhchap pointers
Date: Fri, 13 Oct 2023 11:42:39 +0200
Message-Id: <20231013094239.332235-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_024507_023617_552D55DE 
X-CRM114-Status: GOOD (  13.10  )
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

It may happen that the work to destroy a queue
(for example nvmet_tcp_release_queue_work()) is started while
an auth-send or auth-receive command is still completing.

nvmet_sq_destroy() will block, waiting for all the references
to the sq to be dropped, the last reference is then
dropped when nvmet_req_complete() is called.

When this happens, both nvmet_sq_destroy() and
nvmet_execute_auth_send()/_receive() will free the dhchap pointers by
calling nvmet_auth_sq_free().
Since there isn't any lock, the two threads may race against each other,
causing double frees and memory corruptions, as reported by KASAN.

Reproduced by stress blktests nvme/041 nvme/042 nvme/043

 nvme nvme2: qid 0: authenticated with hash hmac(sha512) dhgroup ffdhe4096
 ==================================================================
 BUG: KASAN: double-free in kfree+0xec/0x4b0

 Call Trace:
  <TASK>
  kfree+0xec/0x4b0
  nvmet_auth_sq_free+0xe1/0x160 [nvmet]
  nvmet_execute_auth_send+0x482/0x16d0 [nvmet]
  process_one_work+0x8e5/0x1510

 Allocated by task 191846:
  __kasan_kmalloc+0x81/0xa0
  nvmet_auth_ctrl_sesskey+0xf6/0x380 [nvmet]
  nvmet_auth_reply+0x119/0x990 [nvmet]

 Freed by task 143270:
  kfree+0xec/0x4b0
  nvmet_auth_sq_free+0xe1/0x160 [nvmet]
  process_one_work+0x8e5/0x1510

Fix this bug by calling nvmet_req_complete() only after freeing the
pointers, so we will prevent the race by holding the sq reference.

Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 586458f765f1..7385b18a491c 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -333,19 +333,21 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			 __func__, ctrl->cntlid, req->sq->qid,
 			 status, req->error_loc);
 	req->cqe->result.u64 = 0;
-	nvmet_req_complete(req, status);
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
 
 		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
 				 auth_expire_secs * HZ);
+
+		nvmet_req_complete(req, status);
 		return;
 	}
 	/* Final states, clear up variables */
 	nvmet_auth_sq_free(req->sq);
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
 		nvmet_ctrl_fatal_error(ctrl);
+	nvmet_req_complete(req, status);
 }
 
 static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
@@ -514,11 +516,14 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	kfree(d);
 done:
 	req->cqe->result.u64 = 0;
-	nvmet_req_complete(req, status);
+
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
 		nvmet_auth_sq_free(req->sq);
 	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
 		nvmet_auth_sq_free(req->sq);
 		nvmet_ctrl_fatal_error(ctrl);
+		nvmet_req_complete(req, status);
+		return;
 	}
+	nvmet_req_complete(req, status);
 }
-- 
2.39.3


