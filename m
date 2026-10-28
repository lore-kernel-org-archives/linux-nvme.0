Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882BB606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ropmcxhn;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=klIQwHUu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vQn70RFilaV6vCUmTPIBJG08q6mnqtgfrSTQOJVWmnM=; b=RopmcxhnOVp2h/
	xtoVNFaX7ZKDYubH0IIRM99/QaYfqQmuXVTNtIduZ3AOLYzh3VGH0CTKk9QNJPj7tmCPaozKalbUg
	g8i+ufcn4IpDJASkFu03A4jRbUBFS0CHrVEyTsNNGyv4qH8A9mXyAU4gCuaf2zEqhoyjAPXi8zjXJ
	3NITCb61oXT2ajQhlKdWP1O83Lt/AAKrCOiW12KxikoyxeSPzfpts3DVDngmJwbBc2vstIWOJUB3Q
	DbpJwn8Qh7gswr7Fs87eI+XZ0+aQnjNiERmpEkaCbyA5o58TTqGZXUHH8GZquuzuUzXrnT5QGzyOn
	UHtMGqDGzZG2rEmOqRyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2Hf-00000006uCb-3D09;
	Wed, 28 Oct 2026 11:57:35 +0000
Received: from out203-205-221-173.mail.qq.com ([203.205.221.173])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM2Hd-00000006uAp-0sOS
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 11:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793188647; bh=vQn70RFilaV6vCUmTPIBJG08q6mnqtgfrSTQOJVWmnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=klIQwHUuzh2w45eHtuOnqbQAuZd7Fpx91XWMp/Gc3S/rXVxug8HU/H8SHCOe1Il86
	 8ibt/no49YAHrWUnxt645If5Ac9fwJwc4dxyORRXNe7E1KJuUNHmE82/ZZrZJtHYfs
	 XPOfAVOBkJAOj2/ETMkMVsjwgPt81IwnMHdn/tak=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:7875:da97:7462:bbd3])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id E54BDCF4; Wed, 28 Oct 2026 19:57:20 +0800
X-QQ-mid: xmsmtpt1793188644t4xpull8n
Message-ID: <tencent_BFD509CFBFC7E76F10959593270DD1CAA506@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJDwY7q+uWS/ezw2m7FPoHn9QNH3RigtCsbW4ix+ZHS/aNzvIYXU
	 SFCKEknR0qW1MsihjWZNbEMd8dacQ2CrxYSJO+MTicnuwaKy3N9P9kLnJlldIqNVIbJ86Phfdhen
	 ZreMA7dFlqxB8BIXvfkRfXDI811Oa9JXn6+m959yk7lr372RlZRaz6RQRvfalnZ6A/j9Gv8k7xVe
	 pr7YfAR6NjD/m8AcjGmIFmjQ0B0o08431itwnambfkK9OCVhXHEH0VkB3bn9ZD1siABq+V1711Ob
	 DyASJ2WIMBfL32gbWn6UYuhU3QIdgd5h0iZtEUbRXr0mI6MRCQt4Z6e/HtppUD1+a8+YGhs28NL4
	 dndWA7WCET7Ec5hRc16MXg9lPJYRf8lEoBHabubJ4RCtHlPWusNbi/rHFt08HmeFjP1km346iebZ
	 sgBY06G4h3SHVPDyKQocusDwLFKd3mYCFJ803rT9FpM0sTKi/gTGlIv/yiz87lxFmmIbMqu85mN7
	 LzajgbqQHsy3NwVy85Yd2F6T0RUaBePGokd5w3hVuvaVcho2YwwYFTX2YTwQ/NjPzNWRAPgl0dq9
	 ljasEATEQGhgClxAJxIQwlgg9SSt+f44H4aPitLkmIqfvRbJu7hdDNFeHFsBceFCw6PTRl9nAn9q
	 EBmzhLCHxj0niCfAlszdmWsMlxxXtyhTvNs69rwzP/FBtg06mR/deRx36ZBpLFqPRWEv3EZ00rzE
	 mALVoJa29tGDxzUK8qY08mXs9bj6bauOG1Nol20Cf4+ToDp24re0j9h3ooqBbSbXBxnjbULbhefF
	 L4Wo0SIeE6pbI1QZcq5+krAaIE+n64lRGg8WjAE7hYuhzXaTPSQ/CJQJh+VERNx3kxCMNQUEmPNj
	 MVQbgbjUdhnFwTIDpoTkTIJqTK635V6BGEtjnWCJYXdRp9JeTNHTEc+hCaGTmksf+Q0LJ6BZ82Iw
	 QHRK23d3nrkwtM7uUBIoZl9yIakj1JYQhA0EYVyHXGfxS37MxFN0zfjU0mVJUy7W17nr7+xTBSOr
	 IQKNcNsmS8UiFGvueKj0771zOKwxXsDR8LrsRYB1sivOrilBjmpccpAQSPUJBrOovmE+Uq2lqtlL
	 QNPZO+IzbW23ooqQVZVcza4VyUufN6nmzati6iMoPedfqtYAo=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
Subject: [PATCH v3 2/2] nvme-tcp: validate the TLS handshake timeout
Date: Wed, 28 Oct 2026 19:57:20 +0800
X-OQ-MSGID: <54ebf9c3b89165a0a4d5df754b3a099253dc15b2.1793188633.git.1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793188633.git.1075151112@qq.com>
References: <cover.1793188633.git.1075151112@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_045733_560656_8622EDB7 
X-CRM114-Status: GOOD (  15.86  )
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
the handshake request is accepted and its completion remains pending,
schedule_timeout() reports a wrong timeout value with a stack dump and
returns zero. The handshake then fails immediately with -ETIMEDOUT,
while the handshake agent was given about 24.9 days. Negative values
such as -1 have the same kernel-side effect.

Store the parameter as an unsigned int and reject values that cannot be
represented both by tls_handshake_args::ta_timeout_ms and by a safe
jiffies delay. Take one snapshot so a concurrent parameter update cannot
give the handshake agent and completion wait different timeouts.
Document the accepted range for built-in use.

wait_for_completion_interruptible_timeout() returns the remaining
jiffies as a long after a successful completion. Keep that result in a
long because an accepted timeout can exceed INT_MAX jiffies on 64-bit
systems.

Negative and oversized values now fail with -EINVAL. Keep zero valid,
preserving the existing immediate-timeout behavior.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/nvme/host/tcp.c                       | 34 ++++++++++++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5bd8a24be6b61..187917a4f196d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4801,6 +4801,11 @@ Kernel parameters
 			Example:
 			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
 
+	nvme_tcp.tls_handshake_timeout=
+			[NVME] NVMe/TCP host TLS handshake timeout in seconds.
+			Valid values range from 0 to the smaller of
+			UINT_MAX / 1000 and MAX_JIFFY_OFFSET / HZ. Default: 10
+
 	nvmet_tcp.tls_handshake_timeout=
 			[NVME] NVMe/TCP target TLS handshake timeout in seconds.
 			Valid values range from 0 to the smaller of
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index dbefe36b0575e..1b9c090bfda93 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/jiffies.h>
 #include <linux/slab.h>
 #include <linux/async.h>
 #include <linux/err.h>
@@ -48,9 +49,24 @@ MODULE_PARM_DESC(wq_unbound, "Use unbound workqueue for nvme-tcp IO context (def
 /*
  * TLS handshake timeout
  */
-static int tls_handshake_timeout = 10;
+static unsigned int tls_handshake_timeout = 10;
 #ifdef CONFIG_NVME_TCP_TLS
-module_param(tls_handshake_timeout, int, 0644);
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
@@ -1930,8 +1946,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 {
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
+	long wait_ret;
 	struct tls_handshake_args args;
-	unsigned long tmo = tls_handshake_timeout * HZ;
+	unsigned int timeout = READ_ONCE(tls_handshake_timeout);
+	unsigned long tmo = (unsigned long)timeout * HZ;
 	key_serial_t keyring = nvme_keyring_id();
 
 	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
@@ -1945,7 +1963,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->keyring)
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL);
@@ -1954,10 +1972,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			qid, ret);
 		return ret;
 	}
-	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, tmo);
-	if (ret <= 0) {
-		if (ret == 0)
-			ret = -ETIMEDOUT;
+	wait_ret = wait_for_completion_interruptible_timeout(&queue->tls_complete,
+							     tmo);
+	if (wait_ret <= 0) {
+		ret = wait_ret < 0 ? -ERESTARTSYS : -ETIMEDOUT;
 
 		dev_err(nctrl->device,
 			"queue %d: TLS handshake failed, error %d\n",
-- 
2.43.0


