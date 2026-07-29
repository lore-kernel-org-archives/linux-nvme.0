Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6A5C54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xD+X9ia/eDtJrGcUqaYxaHDODjoWw3NqgRLnLXAzecA=; b=iPAromLnnZzXBssKiGIIU1tvwd
	9b3EYwwQGiNdGq4fsDgfxf3iuM9iu3N868V6rJKrjXWBR37bsNdJ1flGxU9G5BYxoPEPcl6TqoDt5
	ood1M86k9s3wtwQeVsdycrek+GCfYqxJ4KkrlFj2ZWZGCx/cFCD1ViK6O01VExRP5yUxekFqM4JYS
	45vsu6bbL+RTR0cdLsEu6jtkSvWiHbfNx49MeYXUMwGSUEvmo//jmyEffVBxKYHfrrik6O8yf0Wpi
	xZTWyau3BPwpNd9WaoGPxvZcEnB63Pi6sgj5RIz/bvP6y0Al9jaUBMJ8ZJSLT47G10WfCYhEJLgm7
	CaExZbgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp24R-00000007fvS-3esn;
	Wed, 29 Jul 2026 11:03:31 +0000
Received: from m16.mail.163.com ([117.135.210.2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp24N-00000007ft8-1c1v
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:03:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=xD
	+X9ia/eDtJrGcUqaYxaHDODjoWw3NqgRLnLXAzecA=; b=liQOkme0wiffP8mW+T
	ZbWCR4Z3+FG2UwtalgwVPeSqjn1HX1p0OBjokrLOC6une8H4aqRv+heJNgsdyXU6
	5kSK1B8m2Z71mwCtjPuajL0P1DETYMtrXHUyAgH4siSYVPoIQHgjHOTU7HG/TMb9
	SXjau9mV4+LI7qmAsP4xdi75g=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wCXJXGw3WlqfCNlLw--.63477S2;
	Wed, 29 Jul 2026 19:02:17 +0800 (CST)
From: Jiang HongHui <jiang_hh2019@163.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiang HongHui <jiang_hh2019@163.com>
Subject: [PATCH] nvmet-fc: fix invalid free in LS IOD error path
Date: Wed, 29 Jul 2026 19:02:06 +0800
Message-ID: <20260729110206.207755-1-jiang_hh2019@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCXJXGw3WlqfCNlLw--.63477S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy7tF18uF4kKF13GrW5Awb_yoW8Cw13pF
	W5KrWakrZFkFW8t3yDAFs7ua40ka17WryUCr1Igw1qvwn3GrW8tryqkF1j9FyYvr48ua48
	AFWDAryY9Fs8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi1EE8UUUUU=
X-Originating-IP: [220.248.3.123]
X-CM-SenderInfo: xmld0whbkkjiirz6il2tof0z/xtbC9hma2mpp3bl6KAAA3a
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_040327_862156_66CC37C5 
X-CRM114-Status: GOOD (  11.48  )
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

nvmet_fc_alloc_ls_iodlist() advances iod while initializing the LS IOD
array. If an rqstbuf allocation or response buffer DMA mapping fails,
the unwind loop decrements iod past the start of the array. The final
kfree(iod) therefore frees an address before the allocated object.

This can be reproduced with nvme-fcloop and failslab by setting
fail-nth to 6 before creating a target port. KASAN reports:

  BUG: KASAN: invalid-free in nvmet_fc_register_targetport
  Free of addr ffff88816cf8ff48 by task nvmet_fail_nth/9552

Free the original allocation base stored in tgtport->iod instead. With
this fix applied, the same sysfs write with fail-nth=6 returns -ENOMEM
without any KASAN report.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jiang HongHui <jiang_hh2019@163.com>
---
Tested on v7.2-rc5 with CONFIG_NVME_TARGET_FCLOOP=m, CONFIG_KASAN=y,
CONFIG_FAULT_INJECTION=y and CONFIG_FAILSLAB=y.

Before the fix, faddr2line resolved the fail-nth=6 injection to the
rqstbuf kzalloc() at drivers/nvme/target/fc.c:542, and KASAN reported
an invalid free. After the fix, the same injection resolved to the same
allocation, the sysfs write returned -ENOMEM, fail-nth read back as 0,
and dmesg contained no KASAN, invalid-free, BAD_PAGE or Oops reports.

 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d16170755..1b557775e 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -566,7 +566,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 		list_del(&iod->ls_rcv_list);
 	}
 
-	kfree(iod);
+	kfree(tgtport->iod);
 
 	return -EFAULT;
 }

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.43.0


