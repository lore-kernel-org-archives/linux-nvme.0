Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD42EC433EA
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 17:29:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9D420714
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 17:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xGh0rFND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9D420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RK6PL/y62jJOmNSM2j8xJJbvV2hBJ8Bf7TIdA8Zv2Nc=; b=xGh0rFNDPdlrRbMt0VOcME7+wz
	5sdI/cw2RTFijyLzaGY5LgPWKuQFTRa2SJenNXirnvv5dbTzGCxwJdqoOcAZYTsKDHssD6tOJJ8H2
	KL1Lgd5WdrNfvPirZGwJwuK9xzfa++7muhgoVE8IhYMb4Ine26sUVKHlzfUemtQJwVd9fRkMJ6RQm
	s8EBPy4RDW0r0ktRVI+HmCmMo97tH0Va6u7fT/QQ2zGnAkQM0rSKLOt++BXeOa7huT7FaB3yAG7fC
	mzDuJDu3sm54A3SMMp/RZIIxAtXC9/ei4BQsn+Q9b4N6Ymv7xke1OW3FRnQHsbwHcWqcs9Njm49uv
	8sgxTyvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyf2J-0006G0-OK; Thu, 23 Jul 2020 17:29:39 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyf2F-0006EA-WD
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 17:29:37 +0000
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1jyf1z-0001YW-VR; Thu, 23 Jul 2020 17:29:20 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH v3] nvme/pci: Prevent SK hynix PC400 from using Write Zeroes
 command
Date: Fri, 24 Jul 2020 01:29:10 +0800
Message-Id: <20200723172910.28350-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723155731.22313-1-kai.heng.feng@canonical.com>
References: <20200723155731.22313-1-kai.heng.feng@canonical.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_132936_168239_5439917F 
X-CRM114-Status: GOOD (  10.75  )
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
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
 kyounghwan sohn <kyounghwan.sohn@sk.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
command"), SK hynix PC400 becomes very slow with the following error
message:
[  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]

SK Hynix PC400 has a buggy firmware that treats NLB as max value instead
of a range, so the NLB passed isn't a valid value to the firmware.

According to SK hynix there are three commands are affected:
- Write Zeroes
- Compare
- Write Uncorrectable

Right now only Write Zeroes is implemented, so disable it completely on
SK hynix PC400.

BugLink: https://bugs.launchpad.net/bugs/1872383
Cc: kyounghwan sohn <kyounghwan.sohn@sk.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
- Simply disable Write Zeroes command.

v2:
- SK hynix found the root cause so change the approach accordingly.
- lspci is wrong, the device is PC400 instead of SC300.

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0633c7..25a187e43dbe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3122,6 +3122,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
