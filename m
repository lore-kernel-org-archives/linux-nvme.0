Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9FC606A32C
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YRXNRSCA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uk97Gt0Jv+LwDSOVzveSlW80YqNEq2rrsDMgaor32B0=; b=YRXNRSCAte3sFZm/mo59UM7NSe
	aKSkR8p6/tlPcj/NKf0HJ1mvWL6EMqGX+kG6hCJjdFGCP4RxxF9V9+br9s4WGwq4/v9xI8K8wPu/p
	9aC3tKHJqYYbUYDkBv7+Afzm4PZYFP8XbiEtlpleyVdj6P0OtqylGjvJTeDLd1F38ZiHOgz5QFInJ
	6zIRXFpzOEfxeufkkHy0gKOISKCm/8lmOaLS+ihCnSgJqWP+JF3P3lEL8lr8RkFdkcmt+rl6qwDYY
	LfZEo7jVJnUSyhPB2YBxL6HUwu2uCJ0SkYCBauKt6xjH5eU/ifRGT9i5XfANZyV/8STxqHJpiPh7v
	67GVa2tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdSC-00000005sHO-125D;
	Wed, 04 Nov 2026 16:03:12 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJr0-00000003USC-3lH8
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:07:32 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykT1z91z8Xrr9;
	Wed, 04 Nov 2026 03:07:29 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A3J7Nir024435;
	Wed, 4 Nov 2026 03:07:23 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:27 +0800 (CST)
X-Zmail-TransId: 2af96aea30ef5c7-d6b09
X-Mailer: Zmail v1.0
Message-ID: <20261104030727274tgEBQGKcKOwkQ_xIxqIhN@zte.com.cn>
In-Reply-To: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
References: 20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn
Date: Wed, 4 Nov 2026 03:07:27 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gbnZtZXQ6IGJvdW5kIHRoZSB0cmFkZHIgYW5kIHRyc3ZjaWQgY29uZmlnZnMgd3JpdGVz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A3J7Nir024435
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 03:07:29 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30F1.000/4jJykT1z91z8Xrr9
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_110731_094641_22217716 
X-CRM114-Status: UNSURE (   7.80  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:03:11 -0800
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

nvmet_addr_traddr_store() and nvmet_addr_trsvcid_store() reject a write
only when count is larger than NVMF_TRADDR_SIZE (256) respectively
NVMF_TRSVCID_SIZE (32).  A write of exactly that many characters is
accepted, and the following

	sscanf(page, "%s\n", port->disc_addr.traddr)

has no field width.  configfs terminates the buffer at page[count], so
the scan writes 256 characters plus the trailing NUL, i.e. 257 bytes,
into traddr[256].  The extra byte lands in the following tsas field of
the discovery log entry, silently clearing the first TSAS byte (the
RDMA queue type, or the TLS section type for TCP).  trsvcid has the
same off-by-one with a 32-byte write; there the extra byte lands in
the reserved bytes that follow trsvcid.

Limit the scans to one byte less than the destination arrays.  The
count checks can stay as they are so that a normal newline-terminated
write is still accepted.

Fixes: 9ba2a5cb8896 ("nvmet: filter newlines from user input")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with configfs; no RDMA
device is needed to set the port attributes.

Writing exactly NVMF_TRADDR_SIZE (256) characters to addr_traddr makes
the unterminated sscanf() store 257 bytes, so the trailing NUL clears
the first TSAS byte of the discovery entry:

  unpatched                            patched
  addr_tsas 'connected' -> ''          addr_tsas stays 'connected'
  addr_traddr read returns 257 bytes   read returns 256 bytes

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index b3a5242d06f9..8a6968b014c6 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -150,7 +150,7 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	if (sscanf(page, "%s\n", port->disc_addr.traddr) != 1)
+	if (sscanf(page, "%255s", port->disc_addr.traddr) != 1)
 		return -EINVAL;
 	return count;
 }
@@ -242,7 +242,7 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 	if (nvmet_is_port_enabled(port, __func__))
 		return -EACCES;
 
-	if (sscanf(page, "%s\n", port->disc_addr.trsvcid) != 1)
+	if (sscanf(page, "%31s", port->disc_addr.trsvcid) != 1)
 		return -EINVAL;
 	return count;
 }

