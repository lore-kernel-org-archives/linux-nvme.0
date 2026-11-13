Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCE606A333
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZOhzMGKi;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=Pq6gO6h8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fgro+ban3kP3wZ+F7xloUk0LFI8VjA2ejB/WtI6oAZc=; b=ZOhzMGKiaP9CCyscTIAk/Dr4E9
	L1jdsZ59JodLUTYhg57RivgR0LBd/s7QK2F3YrjL45GSNC63Vrd89m6wQCQu5NGnUUihH5NNaHitc
	wNClglpf6t++YWN/WAo3IqzLUiQ6IzjWJ2WKMlwWlN3MTE7jBrr67o6H05VwLGl/7GiIoa3np6zmN
	0W+YOhZkKgai7EV/CGGSID6qHQiNm0E+WJMKoebs5atS0vNbPhd4MuwhBtW9Dvzt6wSS9XlpfkuRr
	2bw2YfBNDwV4OZNmhg3F8Po5tbHGhbWcyxRDtUQaWk05AWFiHHyj0N6xwcuZ2VjwAVRVE25OZBlsy
	bwkhHTLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRx3x-0000000EE0W-1Bpq;
	Fri, 13 Nov 2026 19:35:53 +0000
Received: from mxct.zte.com.cn ([183.62.165.209])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRvc5-0000000Dp0f-3Hwl
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 18:03:04 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jR4qK2b7sz51Sn7;
	Sat, 14 Nov 2026 02:02:53 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592973;
	bh=e6u3qllTmCAjq21LbXEs9vNsY4HTKsDe7XWF96ESme4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=Pq6gO6h8JguHtsyBViBdulG7qbKErZ1YMAO/SwJPzf8OmbP+FDAYD8opDq5FeUV6a
	 KJW3dkat/9I/LYpwZXm3ltpnquAnpMs7Flwo9e4g6B1b7gZm9MCIKC3dIZ3+J1ONP5
	 i0vZ8drehjOpp8Ttz9oilGJ5fu5ENMvK8OiJMf1xbWBoZ4Bv5iie6BhjJDnjqYMP62
	 yVN/3tnNEBJ/ULOwPGu1g1Ka7w4rdXXwAEP95vFsC1HQE9vBYHKdraahdPodnDWAk+
	 +OWd5YD1k3hpTbgjWjzLLqUVRICo9Xs0DvCJisbd96GH1EXjvkpyRooINsi3hUVauD
	 KIGffDi1KoM2g==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6ADI2jqJ073551;
	Sat, 14 Nov 2026 02:02:45 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:02:49 +0800 (CST)
X-Zmail-TransId: 2afa6af750c93ca-3b2ea
X-Mailer: Zmail v1.0
Message-ID: <20261114020249092lDPe3OpMiMq8nakVU-IJ6@zte.com.cn>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: 20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn
Date: Sat, 14 Nov 2026 02:02:49 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvNl0gbnZtZXQtdGNwOiBvbmx5IHdhaXQgZm9yIGluLWNhcHN1bGUgZGF0YSBmb3IgaW5saW5lIFNHTHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6ADI2jqJ073551
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 02:02:53 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750CD.000/4jR4qK2b7sz51Sn7
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_100302_140177_844F7CE3 
X-CRM114-Status: GOOD (  17.44  )
X-Spam-Score: -4.4 (----)
X-Mailman-Approved-At: Fri, 13 Nov 2026 11:35:09 -0800
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet-tcp decides whether to wait for in-capsule data using only the
write direction and SGL length.  A write using a transport SGL can fit
within inline_data_size without carrying any in-capsule data.  The
response path then withholds its R2T, leaving the command stuck.

If request initialization fails, the same length-only test both
withholds the error response and attempts to drain inline data that
will never arrive.  This can also consume the following PDU as data
or a digest.

Require an offset data-block SGL in both checks.  Share a helper that
only uses command and port fields, as the completion callback can run
before nvmet_req_init() has finished.

Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")
Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Changes in v2 (Christoph Hellwig):
- Split nvmet_tcp_sgl_is_inline() into separate conditions. No
  functional change; keep the existing request paths unchanged.
v1: https://lore.kernel.org/all/20261110230310932grXKWow1mHtiisyby_D4-@zte.com.cn/

The original and revised helpers were compiled with GCC 13 and UBSAN
and compared across every SGL type and opcode, with zero, boundary and
large lengths and inline limits. All results matched. This function
test uses command/port stubs and does not exercise TCP or request
initialization. The runtime results below are from v1.

Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with nvmet-tcp over
loopback.  The standard nvme-tcp host driver only sends in-capsule data
with an inline SGL, so it can never produce the triggering combination;
the test instead drives a minimal user-space NVMe/TCP host that crafts
the ICReq/Connect/command PDUs itself.

It sends a valid 4 KiB write with a transport SGL (type 0x5A) on an
enabled controller and I/O queue:

  unpatched                            patched
  no R2T, write hangs                  R2T received, H2CData sent,
                                       write completes (status 0x0000)

 drivers/nvme/target/tcp.c | 42 +++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8092ce4914b62c80504083cc0519cf7908381d81..dc97534c5b7a83b98cf4f0fd4429476afe16c889 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -269,6 +269,30 @@ static inline bool nvmet_tcp_has_inline_data(struct nvmet_tcp_cmd *cmd)
 		!cmd->rbytes_done;
 }
 
+/*
+ * Check whether the SGL of @cmd carries in-capsule data that the host
+ * will send right after the command PDU.  Only the offset form of the
+ * data block descriptor is in-capsule; a regular transport SGL is
+ * fetched through an R2T instead.
+ */
+static inline bool nvmet_tcp_sgl_is_inline(struct nvmet_tcp_cmd *cmd)
+{
+	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
+	u32 len = le32_to_cpu(sgl->length);
+
+	if (sgl->type != ((NVME_SGL_FMT_DATA_DESC << 4) |
+			  NVME_SGL_FMT_OFFSET))
+		return false;
+
+	if (!nvme_is_write(cmd->req.cmd))
+		return false;
+
+	if (!len)
+		return false;
+
+	return len <= cmd->req.port->inline_data_size;
+}
+
 static inline struct nvmet_tcp_cmd *
 nvmet_tcp_get_cmd(struct nvmet_tcp_queue *queue)
 {
@@ -625,25 +649,19 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 	enum nvmet_tcp_recv_state queue_state;
 	struct nvmet_tcp_cmd *queue_cmd;
-	struct nvme_sgl_desc *sgl;
-	u32 len;
 
 	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
 	queue_state = smp_load_acquire(&queue->rcv_state);
 	queue_cmd = READ_ONCE(queue->cmd);
 
 	if (unlikely(cmd == queue_cmd)) {
-		sgl = &cmd->req.cmd->common.dptr.sgl;
-		len = le32_to_cpu(sgl->length);
-
 		/*
-		 * Wait for inline data before processing the response.
-		 * Avoid using helpers, this might happen before
-		 * nvmet_req_init is completed.
+		 * Wait for in-capsule data before processing the response.
+		 * This can happen before nvmet_req_init() has completed, so
+		 * only look at the SGL descriptor itself.
 		 */
 		if (queue_state == NVMET_TCP_RECV_PDU &&
-		    len && len <= cmd->req.port->inline_data_size &&
-		    nvme_is_write(cmd->req.cmd))
+		    nvmet_tcp_sgl_is_inline(cmd))
 			return;
 	}
 
@@ -981,7 +999,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
 {
-	size_t data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
 	int ret;
 
 	/*
@@ -991,8 +1008,7 @@ static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	 * otherwise we will need to prepare a buffer and receive the
 	 * stale data before continuing forward.
 	 */
-	if (!nvme_is_write(cmd->req.cmd) || !data_len ||
-	    data_len > cmd->req.port->inline_data_size) {
+	if (!nvmet_tcp_sgl_is_inline(cmd)) {
 		nvmet_prepare_receive_pdu(queue);
 		return 0;
 	}
-- 
2.27.0

