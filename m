Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B4606A327
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BW7v9VGQ;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=lZMUwWFx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QXtwSc+hRwH/JF0Ag8D7nucPQHdAV3u+OMmT1iK0RDY=; b=BW7v9VGQM/mCyH
	zgsG0l51OQxxIAKWxtVBqaD3bFBsBGe30dwt6EiBVNnJt0+vs5GErHe3KW2m6mNeDioK5VnqLmR2M
	CJozQZtio5s5QUfu7G7dG5Y0EZft6c2+TmbbYxZBUSscwMGidkanICZSQctG9jDwRpMIlTANuGOQZ
	S90axN6Uk9zEpaijtf9GgH00VUthU5+Tz0uub1JoUKRHyswvLgb0BpImnilNiI7yxHJwxBfi0as1z
	UUus9zF5ZwzS97bFK4KO/5g1c+8EA6pPGdGQW/wuXEDWbwMFuvYkQ86DuOno78yIKJapGuBVs9aM7
	3fLwl/uz4YYFlG+2a2xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2Hi-00000006uED-1QY3;
	Wed, 28 Oct 2026 11:57:38 +0000
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2Hd-00000006uAj-2xzF
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 11:57:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793188645; bh=QXtwSc+hRwH/JF0Ag8D7nucPQHdAV3u+OMmT1iK0RDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lZMUwWFx/0VS6rzfd0rGZFuWDWLbv0nFwqThnk7p4VBizdF5/CJvwfG19VPWbEHoR
	 34DvwcuNH4NxkR0FK86rvyIfwPLUrbzZQFNhmanwARvP6tFaNjqqII6HAhkyIllFfE
	 4OHEcIPKkhJy5XDsw8eVNNohJsKZaSKcDKcjf/MQ=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:7875:da97:7462:bbd3])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E54BDCF4; Wed, 28 Oct 2026 19:57:20 +0800
X-QQ-mid: xmsmtpt1793188643t2e5g5d0l
Message-ID: <tencent_39D5138228F932E024F79FE1733CC8CDAA05@qq.com>
X-QQ-XMAILINFO: NU1WwRH9AHfm7nFuko+lb5fSP2vjtf0F1VfRT1TVAbnI/gXvAbHmr8f0mAi9H7
	 2urPexqnDQmfeyWML3uoxjACaJMtksPUu71/2FcMv9WMSwCPcBiF99I9CJ/BMM2hWEcBVLUQsSYD
	 3AqgA6gVWoKmBSUvFaT+p2wtonu1SA3BOxvium6oqoO6NUO8YvCyTzzd9jGVYQdLRBaWYWrr5SmG
	 H9BFQJRjw5GprwPqTLGtfXA2mk/ftvp6YJijyrfcxT4yKJBD/UxAZplhNcbYmhLEtES88hYXg89L
	 1jioX/eyMmB+k5LSkyn0fgNABW1acxXFNbix+OXAe6R2H0vWLQHBhCR1UvheZzpuxq/RsOVdeWWS
	 0JS+T0yz+cTTFEBbnDopxGKilbiVqr1ocxfROCtpnuh2f0hZARTBNa0a7cPaOZUX7rxrcz6RBBFK
	 EdYvCZgAU2BD3g1ReBckPaQcSj1dYprnFOxftD4NKHPY2EMJISOWKDHsza/zwnibOeqY5i8lWhy3
	 QZlD9HlLfeOt12S7Kf869TuKpUCdqyxb2m+GQx0A6OXTx8/+7hm/1BZSe8+C3oVd5wVh44it7/4E
	 kpswjc1I4/IY+s5FkJszuNBYmPEN6rhAkHnKklXP9xh4qtSTJ8C387qNx5PF93ZCPIMM7TU1wUMK
	 715mb7Sj9a2MsCsEiYxy95b2uq/UjvVIq5u9uLm4aQnfU/osxP1DbrtWkP1IhKKMQtcvNhkMupph
	 JDSynUAJYS00BrFhURmEsUuwpXUDCmI9qOhE7PwaQnje+LoaDTGG3bISMS+PEcmvIjYMhyriXUBv
	 bl/G5XpJ7b3LIPDa+8UUeGXRiKLOmPuIcXSwcHxOTCX32e0KmuPL6P/86pbdHsCplYGe9T8R6RA8
	 1Gu2dGGspOfcf+fAKEDhCB9jOSkCVRQWa6RpZEqRaNsQ46CbcegOFQpHIznCnAFUKmb+w0i4lE6A
	 82pJSPN8a/j8iGnKIj2hG2ksJZJ8+qlGfyDanwntMKbZlZNu+kQID64itEFCCUwUop5+lwHx29zX
	 5VitKMUSscPr+KLERs9IGWyOYgnkonmHOkDGTngV/lYYIFYZybtkkvZWNJeAXVUdiw17HoB4mzWg
	 P4Pe/VSh9h/hmO4zvWp5NcdCb/SA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Yingjie Wang <1075151112@qq.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] nvmet-tcp: validate the TLS handshake timeout
Date: Wed, 28 Oct 2026 19:57:19 +0800
X-OQ-MSGID: <327de3691ee9f30c67f286952720d8ad11128156.1793188633.git.1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793188633.git.1075151112@qq.com>
References: <cover.1793188633.git.1075151112@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_045734_308012_DADEF74D 
X-CRM114-Status: GOOD (  15.01  )
X-Spam-Score: -1.8 (-)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tls_handshake_timeout is writable but stored as a signed int. Multiplying
the value by MSEC_PER_SEC and HZ therefore uses signed arithmetic.

With HZ=1000, setting it to 2147484 overflows both multiplications. If
the handshake request is accepted and remains pending, the timer wheel
treats the jiffies delay as already expired and queues the timeout work
on its next advance, while the handshake agent was given about 24.9
days. Negative values such as -1 cause the same immediate kernel-side
timeout.

Store the parameter as an unsigned int and reject values that cannot be
represented both by tls_handshake_args::ta_timeout_ms and by a safe
jiffies delay. Take one snapshot so a concurrent parameter update cannot
give the handshake agent and delayed work different timeouts. Document
the accepted range for built-in use.

Negative and oversized values now fail with -EINVAL. Keep zero valid,
preserving the existing immediate-timeout behavior.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 drivers/nvme/target/tcp.c                     | 26 ++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd24..5bd8a24be6b61 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4801,6 +4801,11 @@ Kernel parameters
 			Example:
 			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
 
+	nvmet_tcp.tls_handshake_timeout=
+			[NVME] NVMe/TCP target TLS handshake timeout in seconds.
+			Valid values range from 0 to the smaller of
+			UINT_MAX / 1000 and MAX_JIFFY_OFFSET / HZ. Default: 10
+
 	ohci1394_dma=early	[HW,EARLY] enable debugging via the ohci1394 driver.
 			See Documentation/core-api/debugging-via-ohci1394.rst for more
 			info.
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index e598101752620..7937377436d3b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/crc32c.h>
 #include <linux/err.h>
@@ -76,8 +77,24 @@ MODULE_PARM_DESC(idle_poll_period_usecs,
 /*
  * TLS handshake timeout
  */
-static int tls_handshake_timeout = 10;
-module_param(tls_handshake_timeout, int, 0644);
+static unsigned int tls_handshake_timeout = 10;
+
+static int tls_handshake_timeout_set(const char *val,
+				     const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 0,
+		min_t(unsigned long, UINT_MAX / MSEC_PER_SEC,
+		      MAX_JIFFY_OFFSET / HZ));
+}
+
+static const struct kernel_param_ops tls_handshake_timeout_ops = {
+	.set = tls_handshake_timeout_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(tls_handshake_timeout, &tls_handshake_timeout_ops,
+		&tls_handshake_timeout, 0644);
+__MODULE_PARM_TYPE(tls_handshake_timeout, "uint");
 MODULE_PARM_DESC(tls_handshake_timeout,
 		 "nvme TLS handshake timeout in seconds (default 10)");
 #endif
@@ -1904,6 +1921,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
+	unsigned int timeout = READ_ONCE(tls_handshake_timeout);
 
 	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
 		pr_warn("cannot start TLS in state %d\n", queue->state);
@@ -1917,7 +1935,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 	args.ta_done = nvmet_tcp_tls_handshake_done;
 	args.ta_data = queue;
 	args.ta_keyring = key_serial(queue->port->nport->keyring);
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 
 	ret = tls_server_hello_psk(&args, GFP_KERNEL);
 	if (ret) {
@@ -1925,7 +1943,7 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 		pr_err("failed to start TLS, err=%d\n", ret);
 	} else {
 		queue_delayed_work(nvmet_wq, &queue->tls_handshake_tmo_work,
-				   tls_handshake_timeout * HZ);
+				   (unsigned long)timeout * HZ);
 	}
 	return ret;
 }
-- 
2.43.0



