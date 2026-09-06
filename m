Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EE2C79F8B
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Sep 2026 03:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Date:Content-Transfer-Encoding:Message-ID:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dE2V1aiEnm6keVvh2TaGTEeLg2wqlTumAQnOBpftMTc=; b=UKAC/nj4iOQViQo+xHW6yJ9m6P
	k4sYdZ+6VSubbaVSCVLWMWagX8aGEaatrlNvt+v5tEZ8Abzmp/8VAgMV0gKCZ1yvGDNyaJKxEXJWd
	X6/u3vCzJfxoqQi2lq79fADwkpmaPAeon0tV9k3kGezFBDruBXvzQmQR7+9gQSqg/rQhzLHT8Pf2P
	og2XMprbGrz/2cV6kGj4PYcd3DmWSkNrCmsmV6JT947+9CU5bD403XUIalLKab+EKnhr+wAGv48y7
	7GKS3OqdiXCkfWuVq1s1enyyF9d6+td4gken7rXZ13LC9vxh4fEGUy5Q0B+0j8icmsVJVgtispb72
	W3Wu1NGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x33LN-00000004bkm-1pLI;
	Sun, 06 Sep 2026 03:14:57 +0000
Received: from a11-161.smtp-out.amazonses.com ([54.240.11.161])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x33LK-00000004bk0-2I6o
	for linux-nvme@lists.infradead.org;
	Sun, 06 Sep 2026 03:14:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=willyv3.com; t=1788664489;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=IDyTIaqjPwcdbzGwtw1+rh5VfNagu3gGzzLV8NV7Wh4=;
	b=J1zNA45KuPDX2fdHSC0gGbT7lsDjesIa3uV+75YmZEMMwAzJMIl+5/LLwEE8Uj/7
	LF5jpBtBRGCvzF0w9mpWSYuCPY/eYmDUIRUobKTH57IGSYTGv87Ny5qEKqpVPCRw32z
	85lJL6zkXoxKiriuu/wMckuNFIfDrA54GmKtVtIU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1788664489;
	h=From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=IDyTIaqjPwcdbzGwtw1+rh5VfNagu3gGzzLV8NV7Wh4=;
	b=S/HrD7R0dqaaBXiYjaurFJIuS52nseN0knPjgQozhktxuJGUHrIfM7M8wz66D1CY
	t2wtLgobmYXas9NV+yZE897ZlquNK8Jam535NqJGLMvDCZeJAdNXQKlUeh7Do1NqXk2
	szWUGi4h5w1j5kH/IsurwW9QOpOtERF3jLPXc3zo=
From: willy@willyv3.com
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: use simple suspend for the Apple T2 ANS2
 controller
Message-ID: <010001a074b62726-69686506-a02a-4058-9ebc-5f8125eae0f3-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 6 Sep 2026 03:14:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.tVoVnBTusQKwEv3FXsafng3gwgTXiveIP8uCFN696SRuTdSqJLPWcLHhZMGYqGEWfSP3N+is2iSOKdmX/9ngsLeiTVoJkakNxJEB+yEN1ZJPtwlO53LLRiFsTHXrFviVUeKFV0/4bko6iGjXsDtchIeimK+HIEYE/SJqJKFonco=:1.us-east-1.pAEstvQcjyhQNKGKcgSlzI7SVR8ZSG5wSmKwiz/A8Dg=:AmazonSES
X-SES-Outgoing: 2026.09.06-54.240.11.161
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_201454_665715_92A2F690 
X-CRM114-Status: UNSURE (   6.82  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Willy VanSickle <vansicklewilly@gmail.com>
Subject: [PATCH] nvme-pci:=
 use simple suspend for the Apple T2 ANS2 controller

On T2 Macs the ANS2 NVMe controller (106b:2005) is owned by the T2
coprocessor. With suspend-to-idle the driver keeps the controller in an
NVMe power state across sleep instead of shutting it down, because
pm_suspend_via_firmware() is false. The T2 does not preserve that state:
after the first resume the controller stops completing I/O, and the next
suspend hangs in ksys_sync_helper() before it can even freeze processes
(MacBookPro15,3, 7.2.2 + t2linux patches; the machine then drains its
battery while hung).

Give the ANS2 NVME_QUIRK_SIMPLE_SUSPEND so suspend =
always goes through
nvme_disable_prepare_reset() and resume brings the =
controller back with a
full reset, which is what the T2 expects.

Signed-off-by: Willy VanSickle <vansicklewilly@gmail.com>
---
Tested on a MacBookPro15,3 (ANS2 106b:2005) running 7.2.2 with the t2linux
patch set. Without the quirk the second suspend hangs in =
ksys_sync_helper();
with it suspend/resume completes and the controller =
keeps serving I/O.

 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 =
insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.=
c
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4283,6 +4283,7 @@
 		.driver_data =3D NVME_QUIRK_SINGLE_VECTOR |
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
+				NVME_QUIRK_SIMPLE_SUSPEND |
 				NVME_QUIRK_SKIP_CID_GEN |
 				NVME_QUIRK_IDENTIFY_CNS },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPR=
ESS, 0xffffff) },

