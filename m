Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB560A383D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DTiCWzMQ;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=F+Zzpd8m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2VXJ9XM97iLQduVg3UEnKJt/vf1Pmk/r9gbTiERY3d0=; b=DTiCWzMQKgELfW
	HgMNm2OSf/+rsrlYjyiYjR1TpAxAwQ+GFSYH58klTR+0V+Oi+5QUddsCoxSFeK8sG73lpeAro08OE
	49GMxXisyrXPpzBkLBu8i7EYL0K4ex+Jyaefg9xjzSkeipuq1o6YSYh6kl3DPtUCa9f5bc2IsU14U
	6YOtcgsxv4CmuQulI8YOjkfck+Br4Fp6eUloAz4GUcsRiCs+Y7ldttPutAZCiIkHJMUaZLPHwbldB
	qXylwSNOtqzIVrP+UBWj41h31uNfSJlLMw9KSR2LA8T4Jmw7Y6zKymqnm6vHFgZ7cWAM06xY5NiQ5
	8P2CzNbLO7Ia7Dsew5wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLg3h-00000004aeH-0cMt;
	Tue, 27 Oct 2026 12:13:41 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLg3c-00000004aWp-2UXN
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 12:13:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793103213; bh=2VXJ9XM97iLQduVg3UEnKJt/vf1Pmk/r9gbTiERY3d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F+Zzpd8mhSVLCSIMCbbCMTqGZL0NLkJPj62aNWNxIlTcnH4eIh8KWjGK83/LDCChn
	 pfnzuQxQYXyiPHwHyLbZO0VIQLoXl9CGUyU9J7IVEnZyu5CDyspyyO8yhf5Ck/jUfg
	 OtsqHzArPE9XJj3AoVUQu1YNKNPCppYYcRYHiQVs=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:2e7f:4b13:c1e3:e391])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 35D23E21; Tue, 27 Oct 2026 20:13:29 +0800
X-QQ-mid: xmsmtpt1793103211txq685nwy
Message-ID: <tencent_092ACB939828E092E004E81FE5F32E68CA05@qq.com>
X-QQ-XMAILINFO: NA8WCMn5GQiMy+zlO8CCuCFhNxcKbk3YTqLyzQkl9E56TpW6qghg03O7kczzEv
	 lItanb9j8biCCfSDzqJcA7chTemFZvQ/UNmVglMulBCJxNb3nLTPaLMU++tCsMBtksTC5R6jpg4d
	 /l34BeyWMpN4jGKHp8MEMnpQFeiD0nAmATv40N+AXiAybR11A4pWb6+qHV/UFD2KR4B6t+myVL26
	 VSjDVhzU7rZB1oOWMRxCTXY6H6obnsw9MEZ65i/E+l1uuf6FtUeK/kPmPKg1qJsjE0iL4rShfDYT
	 h/ULjj3BsSEuqjDoaZEjP1DaGwcleaJMzT1cXAGmnqvgjtx927iq2Ia+QmidnDvfOwxu2vf2KWwD
	 PwTMMfVdfoRmgcWjTULXck38tNG3oNCyMXdNhu5BBFcZuIor4BBXL0t1nfciT3Np90l/+xbgFbbc
	 Mb5/akVV0F4vQuFHoueek9207HQlHCOFvcnG2s7HdZLNjZlEnp78ak1R9uBy9wQHui+QxxsM18T4
	 UNTTbLk6pss4iAQQUA4SqN9dSK+cOAgPqaoN3NRCvzLXuuazJ7mPRzN0V13iLRL4btdGA22ZI8Rq
	 8N9OJBHBd6hB/FXZ0JQuVO3/UCv4M4krf5ji1inRjOp6FD8Z7t4ylsCVAvyXvuKZ7lt6qY6xzuj8
	 IBeveK7ymqM2Abm89H4QVPloGsb88VXlFydNIYx0zQ4b9qx4w74UO4hkjuakDkCk++lnTiiGpeXW
	 qrZzCSsAW+Ud4ZM5fq7CSnlsG/cFIyfmpeMYIHLc529GNvo08e/F2T6KV+9P/MRAHPp8R+2iF9NX
	 IZgSLxRl/ZrOpeQ13EF9DPVrnS9JA9ydFTLTqsR7I6q7fF8NywScnDEHK/PSKvYKIew8JYEqSDSo
	 3coOr6RNZKCsC8q1lcZEULkyknjzTP93bZhpPG4TDuDO+qL3hGgrZLLTxkmTGUcin6+2x79UBWY+
	 Wx4XLSoMyfPsnxSmrzguJy4jGmeHhgOaap5Zi3nIXgSOaGyCKy8j7+8+w9u1h/MIbreoxbpeT3Ey
	 aEiNGvIn0zS8SDtGBjMydqDTA7mDz7ZKwkzYCC0AC4hh0DuKSFqVv6AHuiuyydn8GaToWWzqNJ4Z
	 OWYk4d8QQGzQCY9AIf6/VKTJrxJOSf0a6gwthTuxVzdnZScn0=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
Subject: [PATCH v2 1/2] nvmet-tcp: validate the TLS handshake timeout
Date: Tue, 27 Oct 2026 20:13:28 +0800
X-OQ-MSGID: <f4e900d47a25513c94f68b6fd69f31cda6e40ce0.1793103202.git.1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793103202.git.1075151112@qq.com>
References: <cover.1793103202.git.1075151112@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_051337_080237_99F7B332 
X-CRM114-Status: GOOD (  14.77  )
X-Spam-Score: -1.9 (-)
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
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 drivers/nvme/target/tcp.c                     | 26 ++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 68647ff4bdd24..cc54d5f169f67 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4801,6 +4801,11 @@ Kernel parameters
 			Example:
 			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
 
+	nvmet_tcp.tls_handshake_timeout=
+			[NVME] TLS handshake timeout in seconds. Valid values
+			range from 0 to the smaller of UINT_MAX / 1000 and
+			MAX_JIFFY_OFFSET / HZ. Default: 10
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


