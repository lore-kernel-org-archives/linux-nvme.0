Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAA606EE97
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EH4p8Q+D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:Message-ID:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=YKxG32AxsufUd7YchK7727X8TY3T1MC6mpG7My++UTg=; b=EH4p8Q+D2ViYcEKdfpKSQ5cs3d
	AigHCub4HJ9V+JD7uwtujvM+cHko3ZdC2TPPtu+QfVlwJxh5ByXuzjV+4IhkNyZrnpnfIjeoXb6x1
	DJz+VTnRRMldEFhEoM1uUEwztbzPVE0Tg3s3PGfhZ39Ka1B8kS/y2sFukOKeiDibL0rQAlKetZ1Pd
	RJbX+jnxPi6Y3ETqZSiPt8OKXRUVtw47tLRrjQwvWNJZTJyvqVwLUx6Yo1ja5TfpgSH045llFyp+H
	Rej1pdAvy8+BKNoG4hBMqQKVZU4mibJbvQCvX66UHyYTD9jAHoaa7CEmHfAv2mMCJ3zIG8dfioAS/
	bSx+ONlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJqz-00000003URx-1mZ0;
	Tue, 03 Nov 2026 19:07:29 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOJqv-00000003UQX-2C5m
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:07:27 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJykF5hzRz8Xrr9;
	Wed, 04 Nov 2026 03:07:17 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A3J73md084144;
	Wed, 4 Nov 2026 03:07:03 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 03:07:07 +0800 (CST)
X-Zmail-TransId: 2afc6aea30db9b5-d1efc
X-Mailer: Zmail v1.0
Message-ID: <20261104030707567QiZNPqBVEESVbvpNukFkY@zte.com.cn>
Date: Wed, 4 Nov 2026 03:07:07 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvMl0gbnZtZXQ6IHBjaS1lcGY6IGZpeCBhIGNvbmZpZ2ZzIG92ZXJmbG93IGFuZCBhIGZhaWxlZC1yZWFkIGhhbmc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6A3J73md084144
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 04 Nov 2026 03:07:17 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEA30E5.000/4jJykF5hzRz8Xrr9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_110725_740635_14D46115 
X-CRM114-Status: UNSURE (   8.47  )
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

This series fixes two independent bugs in the NVMe PCI endpoint function
target driver.

Patch 1 fixes a heap overflow in the subsysnqn configfs attribute.  The
store callback passed the length of the configfs write buffer to
strscpy() as the destination size; an NQN longer than NVMF_NQN_SIZE
therefore wrote past subsysnqn into the following fields of the
nvmet_pci_epf object.

Patch 2 fixes a hang on failed read commands.  queue_response() completed
a command with a non-zero status directly, without waking
exec_iod_work(), which is waiting for the transfer of a DMA_TO_DEVICE
command.  The completion queue work could then free the iod while the
work item was still waiting on iod->done.  The work item now waits based
only on the data direction and length, and completes the command after
the wait even when it failed.  This is a follow-up to the recent fix for
the use-after-free in the same function (c9e9bb757971), which moved the
wait decision earlier but left the failed-command case from
746d0ac5a07d in place.

The two patches are independent, have no inter-patch dependencies and can
be applied in any order or as a subset.  Both carry Fixes: and
Cc: stable.

Testing: both apply to next-20261030, pass checkpatch.pl --strict with
0 errors/0 warnings/0 checks, and drivers/nvme/target/pci-epf.c builds
with CONFIG_NVME_TARGET_PCI_EPF=m and W=1 without new warnings.

Patch 1 was also reproduced and re-tested in QEMU (7.3.0-next-20261030,
configfs pci_ep framework, no endpoint controller needed): writing a
230-byte value through the subsysnqn attribute stored it and clobbered
mdts_kb (512 -> 4276545) before the fix, and is rejected with -EINVAL
after it.  Patch 2 was not runtime-tested: this setup has no PCI
endpoint controller.

Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c

