Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE16CC4727F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 01:31:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAA821734
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 01:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x8R3OJw4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2MA/n4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAA821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WJUc5Irlk1vYea/3vA5zF5/UG9ahu4q2Be/Fw0AyTWA=; b=x8R3OJw4KXXJl8/2lFaOmoXhK
	BhI4TlhsuHPVSJgUq5NI6klOljMRSXgl0H65KWuNhL8f9v8bve9+H5VcoM2jkf1ZZPuSztc0k2GT8
	M7XXNxpwM3DfGWMV4d3mq8+u0lmPSD6PRU3vzS268Ev52+SspXsXb/qkzJKnwhH2pVeoMJpGaphj0
	madYtDcx86vGot6d+QjPL7hoSFgteCyOGckWEUPJ9IOJaESxFgfvZk03WjlNmM6oTkTiIbliTAYVF
	W2QEBQHbrkajHB7HLagzt3pQCq0TH8IFagt7UCIFECh6lTCE8WPpHOq6hed7GkfIdohkYXVNU6Ni1
	Vg+BvNR/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kN4Tk-0007CV-0x; Tue, 29 Sep 2020 01:30:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kN4Td-0007AY-Vp
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 01:30:47 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D838221EF;
 Tue, 29 Sep 2020 01:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601343044;
 bh=tSj8Ri06+wF3ANOcZBQI6Ri2GA0CBE4r2n61sONm++Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A2MA/n4BBLTmeq67Z3vT/xua6zY537GpikPTETUV9Yq9HCoHtMeiGGoCM3wNzaQJo
 cl/RqdInhjZjFT0VNZFLMIvt2Cwfp6J+w/uBm72LzvStJMT9Czxz8vSztGeaDVVn7v
 tvt6jdeq2mzytU6m0zpdVIzFEqiQk2saxzkI02bA=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 12/29] nvme-pci: disable the write zeros command
 for Intel 600P/P3100
Date: Mon, 28 Sep 2020 21:30:09 -0400
Message-Id: <20200929013027.2406344-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929013027.2406344-1-sashal@kernel.org>
References: <20200929013027.2406344-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_213046_108063_63ABC36F 
X-CRM114-Status: GOOD (  15.30  )
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
Cc: Sasha Levin <sashal@kernel.org>, Eric Sandeen <sandeen@redhat.com>,
 Eric Sandeen <esandeen@redhat.com>, linux-nvme@lists.infradead.org,
 David Milburn <dmilburn@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: David Milburn <dmilburn@redhat.com>

[ Upstream commit ce4cc3133dc72c31bd49ddcf22d0f9eeff47a761 ]

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
Tested-by: Eric Sandeen <sandeen@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69a19fe241063..90346cba87d1e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3093,7 +3093,8 @@ static const struct pci_device_id nvme_id_table[] = {
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
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
