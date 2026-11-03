Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346B606EE96
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=v3MqPHVO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=hy2HpfDzx0MMaiYvTIIcjQt++tjiJ+pJBZshdZSr9VU=; b=v3MqPHVOeder54ur2ZyD8gyRsL
	czyVJh2IOdxYzdsTn7iH35stiYNdJL0gw9MaZv2rYAXbcI9UPwFehjGq0HC6vulROy/joJc0nuCvi
	4LyLhwQwEzyxiiKzrmDE5syScUrd+mHmdXLwH8XmhCZUUJ3PF30mcHR9Rlu67TuxjUqmTNnQPauOk
	Xox839mqhz6vgS2yEtvNVg4sWS9F7nLIKUqS3VbSfsOMsGQUyDblS4K6w8etC3Up6Cv5C9VRgrQw3
	m/ji29rf1ydxTaWKQFihBJyv3fEbkD2Ex935Qvz+Az/ExMmKUa4t55gRb5Wnqp3QbGvQkHxX+UStq
	HxdG6vUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJr0-00000003USe-2XQw;
	Tue, 03 Nov 2026 19:07:30 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJqy-00000003UR9-2fWB
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:07:29 +0000
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykQ6y3Dz8XrrJ;
	Wed, 04 Nov 2026 03:07:26 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A3J7HnM024262;
	Wed, 4 Nov 2026 03:07:17 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:20 +0800 (CST)
X-Zmail-TransId: 2af96aea30e8420-d6962
X-Mailer: Zmail v1.0
Message-ID: <20261104030720567AV9nG8iiGp4C0YlWIDDs7@zte.com.cn>
Date: Wed, 4 Nov 2026 03:07:20 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZXQ6IGZpeCBjb25maWdmcyBhdHRyaWJ1dGUgdmFsaWRhdGlvbg==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 6A3J7HnM024262
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 03:07:26 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30EE.002/4jJykQ6y3Dz8XrrJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_110728_852250_CF1B7368 
X-CRM114-Status: UNSURE (   6.07  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes two independent configfs attribute bugs in nvmet.

Patch 1 fixes a use-after-free when attr_tbkas is written while a
controller is going away.  The store callback walked subsys->ctrls under
nvmet_config_sem only, while the list is protected by subsys->lock and
nvmet_ctrl_free() does not take nvmet_config_sem.  Take subsys->lock for
the walk, as the qid_max store callback already does.

Patch 2 fixes an off-by-one write in the traddr and trsvcid store
callbacks.  A write of exactly NVMF_TRADDR_SIZE or NVMF_TRSVCID_SIZE
characters was accepted, and the following sscanf("%s") had no field
width, so it wrote the value plus the trailing NUL one byte past the
destination array.  Bound the scans to the array size.

Both patches are independent and can be applied in any order.  Both
carry Fixes: and Cc: stable.

Testing: both apply to next-20261030, pass checkpatch.pl --strict with
0 errors/0 warnings/0 checks, and drivers/nvme/target/configfs.c builds
with CONFIG_NVME_TARGET=m and W=1 without new warnings.

Patch 1 was reproduced with a KASAN kernel: hammering attr_tbkas while
loop controllers were continuously connected and deleted crashed the
unpatched kernel with a general protection fault in
nvmet_subsys_attr_tbkas_store() (KASAN wild-memory-access at a poisoned
list pointer).  With the patch the same 60-second stress, about 39k
iterations of the store, completed without any report.

Patch 2 was also reproduced and re-tested in QEMU (7.3.0-next-20261030):
a 256-character addr_traddr write cleared tsas.rdma.qptype (addr_tsas
went from "connected" to empty) before the fix, and is truncated to 255
characters with TSAS intact after it.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

