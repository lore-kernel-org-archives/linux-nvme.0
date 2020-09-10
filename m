Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8174CC43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 21:19:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F43221E2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 21:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZm4eh+X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUoTdfT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F43221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hel40/iqTNeGjq4GmJ1Fxaz8ztOGCfiyvjz3Kao37hs=; b=rZm4eh+XgcV8rVBQKailKHEIHI
	fWBTHDTcovKeODMymVahVqHshxqUJEk4IAUslhQPBXC5vmizv6GukvhE8fY/kWbDIjWiI3uwwuov9
	Mb13zn4/dvRsvZuCvaxd/NbXc0rAfK2vubXG9rbYlKK8tA0PQmxZFVe2ZAF/c3/IdyJsboyidUkfg
	3j51g6fbZiXoFqZ5u0U+JkDc3A8hYazljbxJSD0u8ArIBMHCv0hNQyIg2rHgheYH+3/HzJ2AVGmIy
	euAk6pSvAPduG9HsP3vN0pMZSMyRd6mFL+CPH7WWkC8iSAq1xX08/6tFCoMrM1JkwkJJvVBCTmRBd
	IkaUgM4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGTyA-0007lh-4z; Thu, 10 Sep 2020 21:19:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGTy7-0007lF-20
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 21:19:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599772736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=ga8kqPBhhl98o3AYB0ndARJmevhTFcbaYXhr7dJJDlM=;
 b=dUoTdfT8MTdBdNR+0Xht87HWv5BU2XOTSzFBacDppE6hkRKlbVYnOSGfpNY+a5IBoVxxlO
 /M2mLiMU6+lpyyIICFrMM4Qon+Lbdyun7KC5JS74zdBBJmksOR5hoRMuFhL+YzTvIuEzSh
 7l0sQ0fR9VYjCQbHyt6e2yBfvBWPy6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-McVGzRIuNBSz9gHKvYGK7g-1; Thu, 10 Sep 2020 17:18:53 -0400
X-MC-Unique: McVGzRIuNBSz9gHKvYGK7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BF2410BBED9;
 Thu, 10 Sep 2020 21:18:52 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-113-212.rdu2.redhat.com [10.10.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AB465D9CA;
 Thu, 10 Sep 2020 21:18:51 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de
Subject: [PATCH] nvme-pci: disable write zeros command for Intel 600P/P3100
Date: Thu, 10 Sep 2020 16:18:50 -0500
Message-Id: <1599772730-23806-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_171859_123663_CD7E5054 
X-CRM114-Status: GOOD (  12.76  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: david.fugate@linux.intel.com, esandeen@redhat.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The write zeros command does not work with 4k range.

bash-4.4# ./blkdiscard /dev/nvme0n1p2
bash-4.4# strace -efallocate xfs_io -c "fzero 536895488 2048" /dev/nvme0n1p2
fallocate(3, FALLOC_FL_ZERO_RANGE, 536895488, 2048) = 0
+++ exited with 0 +++
bash-4.4# dd bs=1 if=/dev/nvme0n1p2 skip=536895488 count=512 | hexdump -C
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000200

bash-4.4# ./blkdiscard /dev/nvme0n1p2
bash-4.4# strace -efallocate xfs_io -c "fzero 536895488 4096" /dev/nvme0n1p2
fallocate(3, FALLOC_FL_ZERO_RANGE, 536895488, 4096) = 0
+++ exited with 0 +++
bash-4.4# dd bs=1 if=/dev/nvme0n1p2 skip=536895488 count=512 | hexdump -C
00000000  5c 61 5c b0 96 21 1b 5e  85 0c 07 32 9c 8c eb 3c  |\a\..!.^...2...<|
00000010  4a a2 06 ca 67 15 2d 8e  29 8d a8 a0 7e 46 8c 62  |J...g.-.)...~F.b|
00000020  bb 4c 6c c1 6b f5 ae a5  e4 a9 bc 93 4f 60 ff 7a  |.Ll.k.......O`.z|

Reported-by: Eric Sandeen <esandeen@redhat.com>
Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5e07d5628864..d31e298669a9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3153,7 +3153,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ |
-				NVME_QUIRK_NO_TEMP_THRESH_CHANGE },
+				NVME_QUIRK_NO_TEMP_THRESH_CHANGE |
+				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
