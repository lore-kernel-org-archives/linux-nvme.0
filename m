Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D23E60A2626
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OGphIfHz;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=TgL7Fa+O;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=JNKFWv00
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AVwkpBeu8NdqS/JctIui3XfwTxf0w6hxtjzhtDZNdX8=; b=OGphIfHzo19Oc9
	FLvJkPxSaz/25DSvvf0HOgL14zP3WcxGk9df7Sn2caxESQ630ijf+EMmVypUrjhGLeBZ/dqv0j4mG
	b4L6UUdWO3NO0c+KIy69Gu28hfrYuLyMTNRvfohbwfJIy+yzVCCafkiKjvBvZ23A0NpG/kEztE3zZ
	xMvOgrpTBlHnfXySSr7N6i5KdF7CtKklFnBVCIYPWW4+bZMR+VELZcNlcgjBe1ob4Sx/KZquqFkFb
	UlF7j3mgYKgLvgxKe0S9bkdR95sEgh77mzMWkh/i+e+95ntqV+lGOc9cFGcsedckAYD+w/KiT/6No
	4thRRkX3ZbOdQRr4yEnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLg4v-00000004bbH-1cz4;
	Tue, 27 Oct 2026 12:14:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLg4t-00000004baO-3i47
	for linux-nvme@bombadil.infradead.org;
	Tue, 27 Oct 2026 12:14:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=AVwkpBeu8NdqS/JctIui3XfwTxf0w6hxtjzhtDZNdX8=; b=TgL7Fa+Opt7zxDXtFnKIFTHu6S
	nzM0OCaQJOripneGTqfn0loYqfJh4LOqsJu5HaMtTev6mJWTiHygvtgJR0HPj760uuBqlNJf+Cxza
	jPJVRIBUo0DhE0L7u5esMceYn8wYjMDXkJe7ro/qXHvm67B8BN+WF1N5n0Gekjd7xC6+VHTsA/2Gu
	17OhgKx0HJqAYtaZ7r2TMiaJaHgcNOsg72Z7oLSpuAWB2zTcH0INqGflGXnGTRj57jovwAKzpx0e3
	I3coDCB1slord9uka/WEfN7Jt5/hIJaxeUh+gDocsOEBAkq2pg8x85IS4l/+s7hxrN+Ji6hO2nbxN
	fqZneEVA==;
Received: from out203-205-221-164.mail.qq.com ([203.205.221.164])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLg4q-0000000EuuK-1EKZ
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 12:14:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793103288; bh=AVwkpBeu8NdqS/JctIui3XfwTxf0w6hxtjzhtDZNdX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JNKFWv00jhN/xKDciJ3kjlwy1am7zSMULwvCqK3Rq5vLy547LCaEeDOYpGIaeqlYp
	 9slDcxB3n9OBNL2gruFfEU/NImagyc6LggmMZP05ZqFDuYoGTriJvfBcBf2Uss3bED
	 By7D+C48B+3RJKWR5eJ+83R9qyN8b7ZNbkNKkb+s=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:2e7f:4b13:c1e3:e391])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 35D23E21; Tue, 27 Oct 2026 20:13:29 +0800
X-QQ-mid: xmsmtpt1793103212tfvq3ejc2
Message-ID: <tencent_02EC3FD2E750D09B95ACA70091EE65DE0906@qq.com>
X-QQ-XMAILINFO: NwU6Bou9okj/Q/KZUGeG8LdJVBltaHZhj/6AWec96xENzjDyRt9GtIOIwuqwAK
	 nOi+6IOkDiSmKNPzkZceqpEwOElKr1BS3VB/KNNLJcbJadDjbp4f5EIyBd2u2rHwg5n52Noejd99
	 3Bat3FJQkUI+YSoxW6NJKkt3ieo3Z+oneV8dmLiUAsc9NRiXWeb0SoUt4Onl6sXgpUjlV8+PP1ln
	 olKzGjKI17mn5H48v7JMGQR9IKX6wsGQl366/ukIvB4QZRRLBvZabJB03o1p+yZ5gQu0+kdA7lqJ
	 lWx5q+wzmOsWC/9V7cc4wFvCU1neRJRkVNmhqb/OnhGxsHNmyU0AO9tQZNYvmWlRGhHU5hTSBkxk
	 SleGW1hNp+f8b1LTtohUhcGHqJXyS7K9tTYT+GmMTcIUMDoox85c1YtXiNnOc+GmMzfmDsoqjFzn
	 fcpxBDdnR09EwN5a7akKD0x0ADBHVmfUSb1/EX5TYTvEdG1l1OG1//lZFHXmJddN6RWq7PvIPyBx
	 k3frwmBH+FHlnm6ISkNR9bUeSIR8u3XoZioevq2JIDpkH6s9Stb/aVyKU6veHBQHUNdxRDW+grJp
	 uiT2lM/lH/Azd1kM9x3RaZJuyTW5udvS712T+GaxMgY26tY33GX97MuWW6PPKxiQhTu2sHhEXVP5
	 vZUZY00fu792YfKXbiZ5t1PsaPrkFAbt2OeqiLmbuo36vl97t0T5yE/2gkBgRtmLz1UAZfDA02ic
	 cSMJYBV9IlbTF7Gp9cGmXxB786nuiKzJ3os9zYuHzBiRSk8KY69RLkVYQIEOnr6U/Tk1gQhchkIt
	 hwBlOKCzV9caTkC3w96RhnhN6tyjfDdcC5UIQzlhpq/NbA9i/Vv5izliSZs+dEwSRXhzn5Txu3Ie
	 r/dXia+BjZDPze3fAqyPrOhx/PPpkuC4afXXmMQKly214zqFmQ6z9F1zN9vzOCoS95/NIr409Cny
	 Q5Y4NLBLoSTGEiUMjLIh5hILxw0J73RVUz6ksgvmzXxEbIeQWlGIoYQCSCwgbodklMRjhvjIcHAC
	 0MIyk0TyUUC4IvX5IdHmi/4NSVSLNiqjzWTOc9fQ411v8YxK0zUYhh/aqooEwnPJhe9UjQhJ99Xb
	 2cCYbFuspaUEiiI5yeaHBG+jhs9A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
Subject: [PATCH v2 2/2] nvme-tcp: validate the TLS handshake timeout
Date: Tue, 27 Oct 2026 20:13:29 +0800
X-OQ-MSGID: <d229a135c68b8713acd0ed48c2b79254f7fc7b6c.1793103202.git.1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793103202.git.1075151112@qq.com>
References: <cover.1793103202.git.1075151112@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_121452_808357_03689B01 
X-CRM114-Status: GOOD (  16.75  )
X-Spam-Score: 0.0 (/)
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
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/nvme/host/tcp.c                       | 34 ++++++++++++++-----
 2 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cc54d5f169f67..a5adbf58fb8f7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4801,6 +4801,11 @@ Kernel parameters
 			Example:
 			nvme.quirks=7710:2267:bogus_nid,^identify_cns-9900:7711:broken_msi
 
+	nvme_tcp.tls_handshake_timeout=
+			[NVME] TLS handshake timeout in seconds. Valid values
+			range from 0 to the smaller of UINT_MAX / 1000 and
+			MAX_JIFFY_OFFSET / HZ. Default: 10
+
 	nvmet_tcp.tls_handshake_timeout=
 			[NVME] TLS handshake timeout in seconds. Valid values
 			range from 0 to the smaller of UINT_MAX / 1000 and
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f876375dffd21..f0c18e1844eb9 100644
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
@@ -1799,8 +1815,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
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
@@ -1814,7 +1832,7 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->keyring)
 		keyring = key_serial(nctrl->opts->keyring);
 	args.ta_keyring = keyring;
-	args.ta_timeout_ms = tls_handshake_timeout * 1000;
+	args.ta_timeout_ms = timeout * MSEC_PER_SEC;
 	queue->tls_err = -EOPNOTSUPP;
 	init_completion(&queue->tls_complete);
 	ret = tls_client_hello_psk(&args, GFP_KERNEL);
@@ -1823,10 +1841,10 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
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


