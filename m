Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011CC60A2614
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WIo1yPR2;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=KVLWWmBy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1spmQh6Yas3J35bB8ukAmcYtaU7xe/o+5I9/z5JDLPQ=; b=WIo1yPR28HRb3P
	efA5+/6abdqNlJdwwRNWVK0JHSxsMOe/v8f6BnFqzgyftZJtR8+cuPLwF/AZCTSZ9vsCg8N5oOF+2
	8U4xI5EWirKe7nlesqYvTp4y7BVyt5fr3Hmretv3/v87Vk2KHzA4wO6m8E6ryULh3ubiYRQovsW5v
	VoKYpK+oeVX5RyGH5zn5K05G5siCr9ePcpYHVhNGRD+rjgvoZvegeB1puCmvng1K9lysu1s43zssz
	D3hmN2yUbYAeST5yNJ416Dd8Wk9jGlNkF4GQSxlY+4vmu30LMcneR0YNRcUbcccwUSc8KabSYNcn9
	f2GqG6fZNYez6l7hGckQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdb9-00000004B1b-147B;
	Tue, 27 Oct 2026 09:36:03 +0000
Received: from out203-205-221-191.mail.qq.com ([203.205.221.191])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLdb6-00000004Azb-2Wkl
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 09:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793093757; bh=1spmQh6Yas3J35bB8ukAmcYtaU7xe/o+5I9/z5JDLPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KVLWWmByPH1N62sYMLGvLCuuzICgz1s4i93QTcFoId1xWQgcmzPRdKWsy8QuiAUWw
	 qvpY5AHHKB72U46YmZq7LtDp2gslf36YzvnQVqO1RKO+UpmsnJ0nPnNBf8gkPV0Qmq
	 aRjBvUedtRfxyex+upFmGzINR4GKry5mNKTThum0=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:2e7f:4b13:c1e3:e391])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 8F4896E6; Tue, 27 Oct 2026 17:35:52 +0800
X-QQ-mid: xmsmtpt1793093755teyezy5xc
Message-ID: <tencent_E33FE1732968D0AADAB39548E7D2F3C4F705@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X/5dyikJ+7sWqlg38ClHbmTIf3/OEaibk1PBYUE1+7bOWJI8MqS
	 yOw21MgyGtR/T1/M00FdcaLjRFIHtRLrGdsStE1MZXbWVnfA43kUZwjad49DdiM6PIV8WMVPs808
	 yvLzFr2I9MGNly3t31BlkbnqOQ1FsDzry6E/8CvBg/muodmmleWxx5YUHx/bnh4kncgdwddw3dGL
	 hJpFkYdgVpjd+XJ+VRhLEZc6xpNKTtMx8nhmJkOpWwZjbAol/e2b5HUGz6CPVTjwBTEqh8pSFYkk
	 RfRVjBtl9aGcVm6R32PRKKTzL7G0/VPj3QPtIGotfIdHcfN4NQL+D1YAlYzB4ySywUXbzxa2QjXt
	 STClbe11vJhXMxZDx9XAtkFpr8NY8oAW+hAzt/2Y2PSfuMuMd9MPEAwA9B9D9yI6iD5sdx0xa+b4
	 CXcBfJro0Rj8krz0Oik9xjFyEh4987OoD9FjsljDAtjOOs7ue7iwOPZi5uBeX+scRLn1aZbOGB+1
	 mbJyyzj7Xo9iO7oKjW0Jn4nQVJv9ZU02WJwekrNhSjls0GNAgOjWDuhMiV6sLYLQw17hZZQkQIgA
	 XeQVJp8Er4MvM6BTBcVEwb9L+07Z0VFjxc/A6ulBIuPLMicg+7R+eU6A6lh1AAi01o5C4sbmBTYm
	 xQZ0UpoEbTbwF1lK5Nd/VJAfHL5mW6Pzqao6bgJagJErVODcS2ZG9O5wvZQAplcoSHmGnFmeJ28y
	 17Dfa4e8Uogm+Xca9SVNhmCI8EiG9+ARXdQQQqpoM7FRrQI4evgTZj0dGtUEp7cWrnlur02Y1g49
	 FcZhgwU9x2mfYBAga3iQtHxmUnkN/k/t/E1Efr/OxfcTsriAMTmsTWW/QSq24CCf9RhKS8X/z1Ju
	 Pwq4aMI7XfAkWaZttrPpBp5R1LOUyIDDpQapej+aW7DsroGuFKo8K4TK3JpG2G0SmmMHzZQER08Q
	 3DaHrEDR4RqQ2T6ww5uD0/AWXIUUD9ZIocp4MOpBPsot5pGPcXB5PVNuN7y0KfuK45rv9kwwHtbN
	 w5PfLLAlHoqL8nJEkkKTUhoKrSYvofmmLiMxbSpjNaifLykZkqzUNt+1fvA28=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Yingjie Wang <1075151112@qq.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme-tcp: validate the TLS handshake timeout
Date: Tue, 27 Oct 2026 17:35:52 +0800
X-OQ-MSGID: <20261027093552.3934437-3-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027093552.3934437-1-1075151112@qq.com>
References: <20261027093552.3934437-1-1075151112@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_023600_947002_76256D9A 
X-CRM114-Status: GOOD (  13.41  )
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
returns zero. The handshake then fails immediately with -ETIMEDOUT, while
the handshake agent was given about 24.9 days. Negative values such as -1
have the same kernel-side effect.

Store the parameter as an unsigned int and reject values that cannot be
represented both by tls_handshake_args::ta_timeout_ms and by a safe
jiffies delay. Take one snapshot so a concurrent parameter update cannot
give the handshake agent and completion wait different timeouts.

Negative and oversized values now fail with -EINVAL. Keep zero valid,
preserving the existing immediate-timeout behavior.

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 drivers/nvme/host/tcp.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f876375dffd21..ac76d333ddceb 100644
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
@@ -1800,7 +1816,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	int qid = nvme_tcp_queue_id(queue);
 	int ret;
 	struct tls_handshake_args args;
-	unsigned long tmo = tls_handshake_timeout * HZ;
+	unsigned int timeout = READ_ONCE(tls_handshake_timeout);
+	unsigned long tmo = (unsigned long)timeout * HZ;
 	key_serial_t keyring = nvme_keyring_id();
 
 	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
@@ -1814,7 +1831,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->keyring)
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL);
-- 
2.43.0


