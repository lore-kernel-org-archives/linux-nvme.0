Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED0606A338
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tq6yLZUg;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=e3JbQsS+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=N/K74U+TcO0PjJV1p98N1BNxE+fTpOOkIZK7IOlKS3g=; b=tq6yLZUg7hHJEe
	Zx6Fa5osYCWjY0D1YyFuUF2P0SCS0966i2Ulb+/x/TjqEudqaLvY9AGS1joe2FFsPQf0+9xsID23G
	zf9UqN4G5GqlYSPPzO9KKSoA+puyewwfW4ov+rA84E7g2/KvVgRRQAsuKwUCYLPrP+dBm/MOpZV2N
	3whoW34HzgA6DxQnudo0XOCp3w9hGNXoHDCoDJjZGieAqqW65qR4ShWFKr6/MquV+TxfSwBVxmn5z
	hgXM2IAl129bx7MbDgW29RKOLXye5APx/DATtnxlHIeVxwHudl3gK0SFApMwcNW+bFHLXHeMiZObS
	Or7BeJFv0ZpUHnlE9RZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdb7-00000004B16-3voh;
	Tue, 27 Oct 2026 09:36:01 +0000
Received: from out203-205-221-242.mail.qq.com ([203.205.221.242])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdb5-00000004AzM-22yy
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 09:36:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793093756; bh=N/K74U+TcO0PjJV1p98N1BNxE+fTpOOkIZK7IOlKS3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e3JbQsS+8L3IApcXOQUkHaSGOE8UtSPCS8v+G4LH2GO5tfD6A4yhBVnL5xLgVxV+k
	 22TTLddZLQ2/6S/CikvI8byFzvHuFgJ4c6ia0bTd0QtUZNF8j2ceLtliJXP8bYbdV0
	 UFXEfmDNwklh5GQS8ftttv2MMn9Fvap6eTlVkrhA=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:2e7f:4b13:c1e3:e391])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 8F4896E6; Tue, 27 Oct 2026 17:35:52 +0800
X-QQ-mid: xmsmtpt1793093754t879s3i95
Message-ID: <tencent_39AF670751CA25EA49D4BFD8E76C509F5506@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoepF3YR80vY2w44zeOLqCaKntDJUnysCKaH1TnYpA1tTnQ7IMlN6
	 Ptq4eX0pUQ6fLbwaNtVBkYKr2fwN6/Wlyy4+n5MSUOvUm1nBG/9sK44kO6LEGrga/Wwrxra1y1aF
	 S1n4NWj4CkN5IhEoveDqyjNgD9pSdNrvRK4tz+c7N4kQUr1W5Tr0jah2Xd3FGHItJrUfoQk5+xX+
	 9bnPMw93ErK+SmHbKT9hDSGvZT1beFjWmzWOCSUexphJO1HR98F46JIY0I5qWT5iCo0HJ3GCwevm
	 0RAm8LZAr/5FVc2wDvGb/paqCmOSzepZjLbZTLyI73H3omHlaEg+/B7Ofwsb8jft0AEyFXwCQmhi
	 OeuPWRooCdzv7ijZz3rDkjRZ0niWjie55fXM0rnkFU1XTTwFkMKDfJOSE+3bGFMC7Hw2wAJgdCQY
	 3HHInqZ77D/z+IvEIDBYT7g/2aZuwoPMapA5ZmExl+Ktl+Ytax5+oa+kdnrVstN9/vCSULaspmNI
	 jmZmaExPicKzsB17xWyB+6Yg9cLAkgIh5gHPL6rGEWAnoPXpOHcnnM6Ea9UdIc/WsW7FAVwhvQn/
	 HHKDY746yBbI0WNbW5TThgrolykpyrh7oau7wExJihA0RLN/LjTweYeu3yizmk74/BqZZZPmlp+L
	 ZVvm4ZuIpX2Zecz1hf/6BOVNmIbMJ/w9tRm+SYQY573vviv8zEju6XxEdm+dcGpwYMDa7GYPXP2h
	 zshUbPkTLMK3BbjQIm9AsETO+THjysPdXWzRTg0PoreQ9UoZqQBcBuyGGZIjogl1tB8INsFvdTQq
	 DgEl0VSTT2XjEa+AMOe+AyzwyNXqVDRz/lBjFybio7Z1m7bkc3rYzTVk/c7Nqz0KrSxy6Qk2Nm04
	 SAJrLLwNAfaLAGqJkaTIkKTk2JnXg6LJxJkjSEpuyMB/PUDqwh+yFfiHQ+4UceZpnEO0c9zj5hsu
	 DT9YwRRZksMV3ZOjSPTSf6DcPLLuktYais9qZUkDVu6kPYTIhxv3+LHiBofB39Lmk6Dt+iakhq1q
	 y+ATLo9QKn9oHL8tWej4sDe8X/MlBoiUedPE25xYYwG+Pyn+Pshk90R7Rsq/Uba8Nt13eNRPiOxB
	 bYx7sDdBJCIcn0Xwk=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Yingjie Wang <1075151112@qq.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvmet-tcp: validate the TLS handshake timeout
Date: Tue, 27 Oct 2026 17:35:51 +0800
X-OQ-MSGID: <20261027093552.3934437-2-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027093552.3934437-1-1075151112@qq.com>
References: <20261027093552.3934437-1-1075151112@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_023559_844578_FD563760 
X-CRM114-Status: GOOD (  14.09  )
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
on its next advance, while the handshake agent was given about 24.9 days.
Negative values such as -1 cause the same immediate kernel-side timeout.

Store the parameter as an unsigned int and reject values that cannot be
represented both by tls_handshake_args::ta_timeout_ms and by a safe
jiffies delay. Take one snapshot so a concurrent parameter update cannot
give the handshake agent and delayed work different timeouts.

Negative and oversized values now fail with -EINVAL. Keep zero valid,
preserving the existing immediate-timeout behavior.

Fixes: 675b453e0241 ("nvmet-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 drivers/nvme/target/tcp.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

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


