Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42786606A32E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dHsOJel/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Iy1bK4+jBfc9gJ5+O/X5fpt1iKIpv9Dc2QHfUpTN6oY=; b=dHsOJel/z1WjvIIT1BMbGup9M0
	R7r4uofUTYlE1HAcn5PoBTkSAm1USElDsJc/zcXGdqdouG0DeC/JykKQj722rJuHmW4yz5zxmFks+
	k4bZE7LKdpau6ZIT7MoFboZ7eBVRSPt1XOrPLVkcnmUUBgyXRDPYg3dmollvuVo3rT46LpoU+krXN
	s4Bvq2bo9k4uwN8XYVSQF/4V+Cd23QxHmB3ZKDgrnVdW9t4pvhAkCd6hqUdnrzh6PG5qaSIJcLll6
	HiuhuyUP0RUQNoFsaK0J0WAMj2sMNIawmZFU9l67HE/gpBCGI+BnG0lEF9AQB1NUPP1zbwyivda9X
	JZqTDn5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOdSB-00000005sH6-3XyP;
	Wed, 04 Nov 2026 16:03:11 +0000
Received: from mxhk.zte.com.cn ([160.30.148.34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJqw-00000003UQZ-3zKg
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:07:28 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykL5mHxz5B0rZ;
	Wed, 04 Nov 2026 03:07:22 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A3J7Aad024105;
	Wed, 4 Nov 2026 03:07:10 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:12 +0800 (CST)
X-Zmail-TransId: 2afa6aea30e0aa3-d9fe2
X-Mailer: Zmail v1.0
Message-ID: <20261104030712986Mq-di1Oh8Kl1WqW3R0TQW@zte.com.cn>
In-Reply-To: <20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn>
References: 20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn
Date: Wed, 4 Nov 2026 03:07:12 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvMl0gbnZtZXQ6IHBjaS1lcGY6IGZpeCBzdWJzeXNucW4gY29uZmlnZnMgYnVmZmVyIG92ZXJmbG93?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A3J7Aad024105
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 03:07:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30EA.001/4jJykL5mHxz5B0rZ
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_110727_167796_1DC244E8 
X-CRM114-Status: GOOD (  11.36  )
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

nvmet_pci_epf_subsysnqn_store() passes the length of the configfs write
to strscpy() as the destination size:

	strscpy(nvme_epf->subsysnqn, page, len);

The third argument of strscpy() is the size of the destination buffer,
not the length of the source string.  The destination is
subsysnqn[NVMF_NQN_SIZE], i.e. 223 bytes, while a configfs attribute
store can carry up to 4095 bytes.  A longer NQN therefore overflows
subsysnqn into the following mdts_kb field and past the nvmet_pci_epf
object, corrupting the heap.

Using the write length also silently dropped the last byte of the value:
configfs terminates the buffer after the trailing newline that echo(1)
writes, so a normal write stored the right NQN while a write without a
newline lost its last character.

Take the length of the value up to the newline, reject a value that does
not fit and copy the NQN explicitly.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest) with configfs and
nvmet-pci-epf; the attribute store does not need a PCI endpoint
controller.

Writing 230 bytes to the subsysnqn attribute of an nvmet_pci_epf
instance runs past subsysnqn[NVMF_NQN_SIZE] (223) and overwrites the
following mdts_kb field:

  unpatched                            patched
  write accepted                       write rejected (-EINVAL)
  mdts_kb 512 -> 4276545 (0x414141)    mdts_kb stays 512

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a8df176c1a57..38c210cac961 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2531,15 +2531,18 @@ static ssize_t nvmet_pci_epf_subsysnqn_store(struct config_item *item,
 {
 	struct config_group *group = to_config_group(item);
 	struct nvmet_pci_epf *nvme_epf = to_nvme_epf(group);
+	size_t nqn_len;
 
 	/* Do not allow setting this when the function is already started. */
 	if (nvme_epf->ctrl.tctrl)
 		return -EBUSY;
 
-	if (!len)
+	nqn_len = strcspn(page, "\n");
+	if (!nqn_len || nqn_len >= sizeof(nvme_epf->subsysnqn))
 		return -EINVAL;
 
-	strscpy(nvme_epf->subsysnqn, page, len);
+	memcpy(nvme_epf->subsysnqn, page, nqn_len);
+	nvme_epf->subsysnqn[nqn_len] = '\0';
 
 	return len;
 }

