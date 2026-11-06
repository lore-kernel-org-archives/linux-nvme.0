Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FE606A330
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 06:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2oxDmvqe;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=UPH8NmHx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Date:Subject:Cc:To:From:Message-ID:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=9nbHrpdZ+FKysVhhp4Y+Wfae1ZVEWqntwWaQsXRxDi0=; b=2oxDmvqeHMhxHfSQCmMULoMsQT
	rQfMq2WtCCDipCnLz6wQtsYHS7lfCojyRJAebVPS+kDNar+j3wo7PUmfpAD6MCxiM2sWRTEUX0WQT
	IubVNReR6bpmwDzw1nIRpIvL0YIs0IBvfbjOKNe1Q+bMhjcVYG+s3zRJtBXvyppji2Cre3KbObgyJ
	DXhawxwbx4mPqyEBd/TupvrgMhyhsBRFmDh0odK/wjDpS1aSpO1NHOkCnFdVjfnI/ilDdlx+1Wkpd
	Z3b/rS6nOFZWEchV09xailz3sVO/wLBjVxcxXVMJXOj8ul7bvdGMyKzPvSibypLw3QKptCzcTNEnv
	NMB0tNrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPDOF-0000000BLac-2Q7P;
	Fri, 06 Nov 2026 06:25:31 +0000
Received: from out203-205-221-190.mail.qq.com ([203.205.221.190])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPDOA-0000000BLZz-2Vov
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 06:25:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793946319; bh=9nbHrpdZ+FKysVhhp4Y+Wfae1ZVEWqntwWaQsXRxDi0=;
	h=From:To:Cc:Subject:Date;
	b=UPH8NmHxDd+JGIHrooY+1eyw51nRdUZNFJl5oMGo7no9fniTFyGqoC+FUgSLoh64u
	 4MAZh4QRFsqIlGJGQmQ25uXZd3UgxENUafs5nV/tBMVgY81A+2pVXGwBntMJjqYTIa
	 X/d+vIfl0FxSP2SgBs5hBvCnOb6CjUwzbvPevlys=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:7ec2:9796:1e6d:4c54])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 6511921F; Fri, 06 Nov 2026 14:25:17 +0800
X-QQ-mid: xmsmtpt1793946317topchmmih
Message-ID: <tencent_1B8D08FB52E404EC3FE4933548D6CACB7305@qq.com>
X-QQ-XMAILINFO: OJNvdD+rp7v+p0jSwX4jP4ypq+9pDOsbzA0E3p+o7ZdCyeEBKIMNOwlHDMM+CB
	 sai2xsZHlqr2kgETm5LwPNnrSds/srsKZB81TTn23zV9kIJ36lAZNO2rVjtdthreRxJ4H2BL/sd1
	 Bd6brMg1ata8nItHJtkjgWYKpqkcPsqIrizK6MyqX3/AgcwJ0UETI7nSgmBh3lkpwrg/ApwFdD3i
	 cT57vp+CzpGLQSWOIPwAZMZU7umKhl4VD3ixgMbmaRqaDcOVKQFppoTUw6wMQePh2ndEWTU1fYXw
	 moZoSUeZYpepAOlbKo8FANphkWJquc4pidPy8znbwguykrLoeR/E1J8385ekR/BnX8Pfd1ZA4ZJy
	 /Ss6rT6WI9IHayfdBDVOfLgdY/OmqMiP9MSoaAj+KgDUwcLHWsOvgw4X2UHAP0AuLNpLeBxx5dpe
	 kQ8qzDGo1X7T176b1usztx+5k9XDS/uq5c9LcNFaf+8OIYjyFIgE+ETt2gwMi4H8R01MjYq8arrp
	 jWFdKSr43kBTcy5QQpcfdfJ7+RHco4VCFIIMDqJfObiiQazXZHWfBH8XibKi5C/yEhktFZPxDizI
	 nvGXyy5zquC49jTLCj0k+Hv1pCZCYMAD8ASu8CmpE+1uYdHx14DM4lCHTnawa1X08nSGUzcWt7u5
	 7vOrE4VJELv4K6i8Nbd0YpieXSD7h9RaJmx3P94HIioht2EF9KWmxTBf9Lio7P+j3JhrTG9FV5R8
	 TFnBOyTUhK+VLMxuboM0zk8ggl+xwvAUWwjJUNGkzsZDF6H+p7Zho9WfVuUwVRDam82EYBPvls1k
	 74ZNeeskV+z7djG9uoSPQVMrpEadHqSjGXevFnWqkEdrcm52q/mEokoVvLwKFFCvyoJ/yf+25rrI
	 Dtpkb/hsaA7z3rB4JSzS132duLwSldrRwn4MTBajlTQKk70/WDp61cpZ0OULKlPiMMe0mEdr0uls
	 vyTY7OAYBhT4ph8wa1hxsbC5zwOK9otVftQbzgVOmEVAguAhbpAjuYpIOhmePKLAIwyxNLr4eiMh
	 VoQzgt0LlQWUx7pABQWJ6LI3Os51tuSneWDZ4FeHvujyewrB5KacI1p9j28mI=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Yingjie Wang <1075151112@qq.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Marc Olson <marcolso@amazon.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: avoid wrapping admin_timeout and io_timeout
Date: Fri,  6 Nov 2026 14:25:16 +0800
X-OQ-MSGID: <a09cbe79b8adb7d5317f2630d4ac604a3708a97c.1793946310.git.1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_222527_144169_38D44E15 
X-CRM114-Status: GOOD (  16.03  )
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

NVME_ADMIN_TIMEOUT and NVME_IO_TIMEOUT multiply the admin_timeout and
io_timeout module parameters by HZ in unsigned int arithmetic, and
nvme_fw_act_work() does the same through secs_to_jiffies(). The parameters
accept any unsigned int, so values above UINT_MAX / HZ wrap. With HZ=1000,
io_timeout=4294968 becomes 704 jiffies, and a controller created afterwards
times out I/O after 0.7 seconds instead of about 49.7 days. On 32-bit
systems, results above MAX_JIFFY_OFFSET are also unsafe relative delays and
can be treated as already expired.

These large values are used in practice. AWS documents
nvme_core.io_timeout=4294967295 for EBS volumes and says Amazon Linux uses
it by default. With HZ=1000, the current code happens to wrap this setting
to 4294966296 jiffies, which still behaves as a long timeout on 64-bit
systems.

Add nvme_timeout_to_jiffies(), which caps the seconds value so that the
result fits the u32 timeout fields and stays within MAX_JIFFY_OFFSET for
32-bit timers, and use it for both macros and for the firmware
activation wait. On 64-bit kernels every timeout that did not wrap is
unchanged. Larger values saturate instead of being rejected so that the
documented setting keeps a long timeout.

Fixes: 8ae4e4477d8f ("nvme: update timeout module parameter type")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Wang <1075151112@qq.com>
---

Notes:
    Unlike the recent tls_handshake_timeout fix, which rejects out-of-range
    values, this saturates so the documented io_timeout=4294967295 setting
    remains accepted as a long timeout.
    
    AWS documentation referenced above:
    https://docs.aws.amazon.com/ebs/latest/userguide/timeout-nvme-ebs-volumes.html
    
    Tested on nvme-7.4 f33c8bc78540, x86-64 (HZ=1000) in QEMU. With a
    3-second dm-delay read, io_timeout=4294968 timed out after 704 ms and
    failed with EIO on the base kernel; with this patch the read completed
    after 3 seconds with no timeout. The 4294967 boundary and a 1-second
    control behaved the same on both kernels. admin_timeout and io_timeout
    readback also matched the expected boundaries over nvme-loop.
    
    The affected objects built with W=1 for x86-64 allmodconfig and i386
    HZ=1000; the i386 objects had no 64-bit division helper dependency.

 drivers/nvme/host/core.c |  2 +-
 drivers/nvme/host/nvme.h | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 03671bba1754..af8ccbc11c53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4891,7 +4891,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 	if (ctrl->mtfa)
 		fw_act_timeout = jiffies + msecs_to_jiffies(ctrl->mtfa * 100);
 	else
-		fw_act_timeout = jiffies + secs_to_jiffies(admin_timeout);
+		fw_act_timeout = jiffies + NVME_ADMIN_TIMEOUT;
 
 	nvme_quiesce_io_queues(ctrl);
 	while (nvme_ctrl_pp_status(ctrl)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 82cdc7d32b22..8305fd82038b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -22,11 +22,20 @@
 
 extern const struct pr_ops nvme_pr_ops;
 
+/* Seconds to jiffies, capped for the u32 timeouts and timer delays */
+static inline unsigned int nvme_timeout_to_jiffies(unsigned int timeout)
+{
+	unsigned long max_secs;
+
+	max_secs = min_t(unsigned long, UINT_MAX, MAX_JIFFY_OFFSET) / HZ;
+	return min_t(unsigned long, timeout, max_secs) * HZ;
+}
+
 extern unsigned int nvme_io_timeout;
-#define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
+#define NVME_IO_TIMEOUT	nvme_timeout_to_jiffies(nvme_io_timeout)
 
 extern unsigned int admin_timeout;
-#define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
+#define NVME_ADMIN_TIMEOUT	nvme_timeout_to_jiffies(admin_timeout)
 
 #define NVME_DEFAULT_KATO	5
 

base-commit: f33c8bc785401669b29229bcf3d0086ba9f5b87c
-- 
2.43.0


