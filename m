Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDDA606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UscrEioW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lEwWZMnT2E5q2mu75iPMVwDrV0VDr43djSV3nOSktwA=; b=UscrEioWhyHRbhH06bzT0stCp8
	uD80uvhAZ2RW/bxW499KXvk/ARXP+r34lHu5qNjCQFrFo52eP+vZ2aRMQ7i79/SDas2ypdsIax88y
	X5DyPccJ27ZX8X8mGXwuHmEFuDfr5p7zizp3X764Duq+4Y9Pp/VqNztNysVI1vOqGSJrKVyDs3rav
	jZrc3cpc4OIt4o7eMv4suByv+31tuM8EJO+m71P5w4DIyueVLXPoKg1FSmS4L40BKGTHhbvpWGIZl
	WGOy+D+x3IIMV6DcaBeBX41sjAsgzUUkXdMVdjTIpvUoSyVit3PXnn50fxD8eJTPvcdfsXH/YUj5w
	9LhDi/mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPLdL-0000000CnDf-3AAK;
	Fri, 06 Nov 2026 15:13:39 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPLQe-0000000ClZY-3ijZ
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 15:00:34 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jLj620pGhz8Xrr9;
	Fri, 06 Nov 2026 23:00:26 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 6A6F0GWE055283;
	Fri, 6 Nov 2026 23:00:17 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 6 Nov 2026 23:00:20 +0800 (CST)
X-Zmail-TransId: 2afa6aedeb84f92-76f49
X-Mailer: Zmail v1.0
Message-ID: <20261106230020595sdtR1cTOchAJ3lWjuD06g@zte.com.cn>
In-Reply-To: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
References: 20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn
Date: Fri, 6 Nov 2026 23:00:20 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvMl0gbnZtZXQ6IHpuczogcmV0dXJuIHRoZSBuYW1lc3BhY2UgbG9va3VwIGVycm9yIGZvciBJZGVudGlmeQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6A6F0GWE055283
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 06 Nov 2026 23:00:26 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEDEB8A.000/4jLj620pGhz8Xrr9
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_070033_139791_8344D9A1 
X-CRM114-Status: UNSURE (   4.91  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Fri, 06 Nov 2026 07:13:38 -0800
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvmet_execute_identify_ns_zns() jumps to done when nvmet_req_find_ns()
fails, and that label overwrites status with a successful copy of the
zeroed identify data.  An Identify with CNS 05h and CSI 02h for a
missing NSID therefore completes with SUCCESS and zeroed data instead
of Invalid Namespace.

Return the lookup error instead.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with the loop transport
and CONFIG_BLK_DEV_ZONED.

An Identify with CNS 05h and CSI 02h for a namespace that does not
exist (NSID 100) completes successfully and returns a zeroed structure:

  unpatched                            patched
  ret=0, all 4096 bytes zero           ret=24587 (Invalid Namespace)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 92f5c1435582..cea05b4bc740 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -108,7 +108,7 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 
 	status = nvmet_req_find_ns(req);
 	if (status)
-		goto done;
+		goto out;
 
 	if (nvmet_ns_revalidate(req->ns)) {
 		mutex_lock(&req->ns->subsys->lock);
@@ -140,7 +140,6 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 		mar--;
 	id_zns->mar = cpu_to_le32(mar);
 
-done:
 	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
 out:
 	kfree(id_zns);

