Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F9C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 12:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=V6vTeVpjp2A+b20pHSmwR2CuwcqglwhhqrSm/0XoakY=; b=e3xKbr6403iqT+
	bQoQ0DRcxr+7IRJNuG+y3qLLp9RTaiT34LhySCKJVMknHqgQWYO3hkXNM5tthXCRUd5FEYSQRXeLC
	+4TTT2wH1pA8YY8IqjTbU4QLLGucrNCNZuPGeU5gJl9vmq91WHy5E+J2I76Hyif2mNkmkAfHayVdh
	136kdtrMtf010Mw744v8OVHIqzFYcYYA41mrbUKC4DkK+f8mY9q5riA1yC9iMNmO1wBE0e8Ar9LeB
	TG3gKE56kWvjTMUX/M7Ngmxq1txKhEUCEnGo7qPIiFRYPPeBU42eNye9ukGp18vvmmZ3FOcojR3tO
	q2XNeq95UsIKtjV/c1/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Htc-0000000H4bH-2Ped;
	Fri, 25 Apr 2025 12:11:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8GEA-0000000Gixo-1m3m
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 10:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745576652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V6vTeVpjp2A+b20pHSmwR2CuwcqglwhhqrSm/0XoakY=;
	b=gtzN4r3CK0tq9KuZfCU0XW6N+EuttA36cAlQiJxsXKl5D8MMpErQUz2HoaseKy863eFP83
	QrEtsprHWiydAW0Q51ZIRy0h9+Po5DwRRSSbwMu4qw9oj8+4lq+PbM6DX1mxUeHhaBqxLT
	z5SL9GY9ErtW7qAR8s0C0xOBoEp4Yb4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-vWd2ZrzQOsuFCZ11rudurg-1; Fri,
 25 Apr 2025 06:22:36 -0400
X-MC-Unique: vWd2ZrzQOsuFCZ11rudurg-1
X-Mimecast-MFC-AGG-ID: vWd2ZrzQOsuFCZ11rudurg_1745576555
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A6241800360
	for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 10:22:35 +0000 (UTC)
Received: from vm-10-0-76-146.hosted.upshift.rdu2.redhat.com (vm-10-0-76-146.hosted.upshift.rdu2.redhat.com [10.0.76.146])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0055C18001DA
	for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 10:22:34 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: typo fix for nvme subsystem
Date: Fri, 25 Apr 2025 06:01:07 -0400
Message-ID: <20250425100107.844298-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3ObKih8GSDwrtvII1Kii78OItDu7RcAu1yTFNUm0kSU_1745576555
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_032414_603436_65F10CD9 
X-CRM114-Status: GOOD (  33.42  )
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

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 drivers/nvme/common/auth.c        | 6 +++---
 drivers/nvme/host/Kconfig         | 2 +-
 drivers/nvme/host/core.c          | 2 +-
 drivers/nvme/host/fabrics.c       | 2 +-
 drivers/nvme/host/fabrics.h       | 6 +++---
 drivers/nvme/host/fc.c            | 4 ++--
 drivers/nvme/host/ioctl.c         | 2 +-
 drivers/nvme/host/multipath.c     | 2 +-
 drivers/nvme/host/nvme.h          | 2 +-
 drivers/nvme/host/pci.c           | 4 ++--
 drivers/nvme/host/rdma.c          | 4 ++--
 drivers/nvme/target/admin-cmd.c   | 2 +-
 drivers/nvme/target/core.c        | 2 +-
 drivers/nvme/target/fc.c          | 2 +-
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 drivers/nvme/target/passthru.c    | 2 +-
 16 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 2c092ec8c0a9..c9a029748249 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -482,7 +482,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
  * @c1: Value of challenge C1
  * @c2: Value of challenge C2
  * @hash_len: Hash length of the hash algorithm
- * @ret_psk: Pointer too the resulting generated PSK
+ * @ret_psk: Pointer to the resulting generated PSK
  * @ret_len: length of @ret_psk
  *
  * Generate a PSK for TLS as specified in NVMe base specification, section
@@ -770,8 +770,8 @@ int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
 		goto out_free_prk;
 
 	/*
-	 * 2 addtional bytes for the length field from HDKF-Expand-Label,
-	 * 2 addtional bytes for the HMAC ID, and one byte for the space
+	 * 2 additional bytes for the length field from HDKF-Expand-Label,
+	 * 2 additional bytes for the HMAC ID, and one byte for the space
 	 * separator.
 	 */
 	info_len = strlen(psk_digest) + strlen(psk_prefix) + 5;
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index d47dfa80fb95..06c62a458e77 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -105,7 +105,7 @@ config NVME_TCP_TLS
 	help
 	  Enables TLS encryption for NVMe TCP using the netlink handshake API.
 
-	  The TLS handshake daemon is availble at
+	  The TLS handshake daemon is available at
 	  https://github.com/oracle/ktls-utils.
 
 	  If unsure, say N.
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cc..9c860d0a41d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1010,7 +1010,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	if (ns->head->ms) {
 		/*
-		 * If formated with metadata, the block layer always provides a
+		 * If formatted with metadata, the block layer always provides a
 		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
 		 * we enable the PRACT bit for protection information or set the
 		 * namespace capacity to zero to prevent any I/O.
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 93e9041b9657..2e58a7ce1090 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -582,7 +582,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
  * Do not retry when:
  *
  * - the DNR bit is set and the specification states no further connect
- *   attempts with the same set of paramenters should be attempted.
+ *   attempts with the same set of parameters should be attempted.
  *
  * - when the authentication attempt fails, because the key was invalid.
  *   This error code is set on the host side.
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 9cf5b020adba..1b58ee7d0dce 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -80,7 +80,7 @@ enum {
  * @transport:	Holds the fabric transport "technology name" (for a lack of
  *		better description) that will be used by an NVMe controller
  *		being added.
- * @subsysnqn:	Hold the fully qualified NQN subystem name (format defined
+ * @subsysnqn:	Hold the fully qualified NQN subsystem name (format defined
  *		in the NVMe specification, "NVMe Qualified Names").
  * @traddr:	The transport-specific TRADDR field for a port on the
  *              subsystem which is adding a controller.
@@ -156,7 +156,7 @@ struct nvmf_ctrl_options {
  * @create_ctrl():	function pointer that points to a non-NVMe
  *			implementation-specific fabric technology
  *			that would go into starting up that fabric
- *			for the purpose of conneciton to an NVMe controller
+ *			for the purpose of connection to an NVMe controller
  *			using that fabric technology.
  *
  * Notes:
@@ -165,7 +165,7 @@ struct nvmf_ctrl_options {
  *	2. create_ctrl() must be defined (even if it does nothing)
  *	3. struct nvmf_transport_ops must be statically allocated in the
  *	   modules .bss section so that a pure module_get on @module
- *	   prevents the memory from beeing freed.
+ *	   prevents the memory from being freed.
  */
 struct nvmf_transport_ops {
 	struct list_head	entry;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2257c3c96dd2..e36843cc2732 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1948,7 +1948,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	}
 
 	/*
-	 * For the linux implementation, if we have an unsuccesful
+	 * For the linux implementation, if we have an unsucceesful
 	 * status, they blk-mq layer can typically be called with the
 	 * non-zero status and the content of the cqe isn't important.
 	 */
@@ -2472,7 +2472,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * writing the registers for shutdown and polling (call
 	 * nvme_disable_ctrl()). Given a bunch of i/o was potentially
 	 * just aborted and we will wait on those contexts, and given
-	 * there was no indication of how live the controlelr is on the
+	 * there was no indication of how live the controller is on the
 	 * link, don't send more io to create more contexts for the
 	 * shutdown. Let the controller fail via keepalive failure if
 	 * its still present.
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index ca86d3bf7ea4..8964364248ce 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -727,7 +727,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	/*
 	 * Handle ioctls that apply to the controller instead of the namespace
-	 * seperately and drop the ns SRCU reference early.  This avoids a
+	 * separately and drop the ns SRCU reference early.  This avoids a
 	 * deadlock when deleting namespaces using the passthrough interface.
 	 */
 	if (is_ctrl_ioctl(cmd))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 250f3da67cc9..7f69ba345b61 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -653,7 +653,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * controller's scan_work context. If a path error occurs here, the IO
 	 * will wait until a path becomes available or all paths are torn down,
 	 * but that action also occurs within scan_work, so it would deadlock.
-	 * Defer the partion scan to a different context that does not block
+	 * Defer the partition scan to a different context that does not block
 	 * scan_work.
 	 */
 	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..23b24991ba74 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -516,7 +516,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeores supported */
+	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeroes supported */
 };
 
 struct nvme_ns {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b178d52eac1b..c88533d88937 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2972,7 +2972,7 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 
 	/*
-	 * Freeze and update the number of I/O queues as thos might have
+	 * Freeze and update the number of I/O queues as those might have
 	 * changed.  If there are no I/O queues left after this reset, keep the
 	 * controller around but remove all namespaces.
 	 */
@@ -3143,7 +3143,7 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		/*
 		 * Exclude some Kingston NV1 and A2000 devices from
 		 * NVME_QUIRK_SIMPLE_SUSPEND. Do a full suspend to save a
-		 * lot fo energy with s2idle sleep on some TUXEDO platforms.
+		 * lot of energy with s2idle sleep on some TUXEDO platforms.
 		 */
 		if (dmi_match(DMI_BOARD_NAME, "NS5X_NS7XAU") ||
 		    dmi_match(DMI_BOARD_NAME, "NS5x_7xAU") ||
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b5a0295b5bf4..9bd3646568d0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -221,7 +221,7 @@ static struct nvme_rdma_qe *nvme_rdma_alloc_ring(struct ib_device *ibdev,
 
 	/*
 	 * Bind the CQEs (post recv buffers) DMA mapping to the RDMA queue
-	 * lifetime. It's safe, since any chage in the underlying RDMA device
+	 * lifetime. It's safe, since any change in the underlying RDMA device
 	 * will issue error recovery and queue re-creation.
 	 */
 	for (i = 0; i < ib_queue_size; i++) {
@@ -800,7 +800,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	/*
 	 * Bind the async event SQE DMA mapping to the admin queue lifetime.
-	 * It's safe, since any chage in the underlying RDMA device will issue
+	 * It's safe, since any change in the underlying RDMA device will issue
 	 * error recovery and queue re-creation.
 	 */
 	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index acc138bbf8f2..ff731b5a072e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1174,7 +1174,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
  * A "minimum viable" abort implementation: the command is mandatory in the
  * spec, but we are not required to do any useful work.  We couldn't really
  * do a useful abort, so don't bother even with waiting for the command
- * to be exectuted and return immediately telling the command to abort
+ * to be executed and return immediately telling the command to abort
  * wasn't found.
  */
 static void nvmet_execute_abort(struct nvmet_req *req)
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 71f8d06998d6..aac398f96c9e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -648,7 +648,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	 * Now that we removed the namespaces from the lookup list, we
 	 * can kill the per_cpu ref and wait for any remaining references
 	 * to be dropped, as well as a RCU grace period for anyone only
-	 * using the namepace under rcu_read_lock().  Note that we can't
+	 * using the namespace under rcu_read_lock().  Note that we can't
 	 * use call_rcu here as we need to ensure the namespaces have
 	 * been fully destroyed before unloading the module.
 	 */
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7b50130f10f6..297bf2886127 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1328,7 +1328,7 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 /**
  * nvmet_fc_register_targetport - transport entry point called by an
  *                              LLDD to register the existence of a local
- *                              NVME subystem FC port.
+ *                              NVME subsystem FC port.
  * @pinfo:     pointer to information about the port to be registered
  * @template:  LLDD entrypoints and operational parameters for the port
  * @dev:       physical hardware device node port corresponds to. Will be
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 83be0657e6df..b25af5cbaf05 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -133,7 +133,7 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 	 * Right now there exists M : 1 mapping between block layer error
 	 * to the NVMe status code (see nvme_error_status()). For consistency,
 	 * when we reverse map we use most appropriate NVMe Status code from
-	 * the group of the NVMe staus codes used in the nvme_error_status().
+	 * the group of the NVMe status codes used in the nvme_error_status().
 	 */
 	switch (blk_sts) {
 	case BLK_STS_NOSPC:
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 26e2907ce8bb..b7515c53829b 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -99,7 +99,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 
 	/*
 	 * The passthru NVMe driver may have a limit on the number of segments
-	 * which depends on the host's memory fragementation. To solve this,
+	 * which depends on the host's memory fragmentation. To solve this,
 	 * ensure mdts is limited to the pages equal to the number of segments.
 	 */
 	max_hw_sectors = min_not_zero(pctrl->max_segments << PAGE_SECTORS_SHIFT,
-- 
2.45.1


