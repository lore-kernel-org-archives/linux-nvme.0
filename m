Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFCAC48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AAB613AB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AAB613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=61Dx1nnj/dh95IDx3e25WssMZJDFRwRlyKLqx1+oh6I=; b=Ua9+CBweI9hVQo
	U6U/ANy+JmggwhKMWqrClZ4p14xepHNO1NusUwxiOpW+7DdK7QT2mAioVAYip3ECOoA46jal7xOG0
	oNh2+HACuwH2tliUj8Y1kCq7MzvdvI9/tTWbaIww2ZI4YuinGIbJkVyXUtFDdkxi+XsbA5U7x/koj
	R5YFeD7cAVMNLqOYLBgo3Ho05xYub5c0CL+55th6zVXKNad85tmBgEg47Os/dhD5/KAHl3a6yAtO2
	NH0ql9coVWUtbdGNWYBkmcnqTx1QWkuup3YE0mNCWT0RohAVmEZPbfrkQSljNeXUkRDGYq4pVpYVi
	Mc+KDNYnf+QZGVk7sc7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbsn-00Byqd-6S; Mon, 14 Jun 2021 01:59:21 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbsc-00ByoL-Vz
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:59:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623635950; x=1655171950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wM/M6Tq8l0lEf40NrGLbQoP6yrYtkMRIy6nx2A+go58=;
 b=o7R4LmyQnBxPedkp7zdLT74xx6/MbIUSX+lprG+5fu7XOnDY0ZoPM9JE
 mmmHejqByNGHsLepMhyf7WpqQcT2AcT2P5SCTBt5ljMxB5o2/3PmfgwdM
 Q9KcAkRLzqLq0TVH1f8bo78Y14AF7Mqa6haYRfd48Ie3fuNaLx98TaOG3
 oBcAKI6uLOd0kNhBvjOievAvdQT1fz4o6gufzeKyv3eetaECMbZnAXBlV
 QNXZAMArGSgKrNDe0ceb1SMFAGUFto77Cd7mMbPPsjhJj60mWykIFe9iU
 wsZKiuwY4BN3dC3jwrO4Zn5e6RryK3Jz8P0OH7P1Cxtt1r2Yu2NP0hK6/ A==;
IronPort-SDR: QBX7rcWpyxs36nPPYhjJytebwardqiklu5mFvZtP9j6iPmWdebwLP5wl28rRgqgWRHDORBBxI6
 rBumuFEOvN64NbZwumVMaw4FncMP+18wjp3uRyLQi5b21tyT9aI4MRzDc2/QejfPA20DVfQGs3
 Ssmp5vtLGw+6+WpcVrlD0Z7NtCLjr++ixhXhp68WcPzlJt8oijMnCbJ17M7+6npu7t4udu2310
 Qve2APPgXhmnpjNFI6phnLPiQfwtNO7L7+x0em+U8Ks2ggGW8M6A2IC5w7IV+5jyuMO3J2SMhB
 /xI=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="171776436"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:59:07 +0800
IronPort-SDR: O0ryCz/mKsNwJARkyekYeJzEtgJ0DCkldP0mo+X7z02YZA/qYF7uff1YpqbOycUVhZIDdvBkLn
 S8pgEYRyzudcxTN5KD5wECArbh91W+817GALnN2cUZOgANtWTyBkzmaZtDLzh3xIjoQfHpJ+nA
 MNc026RqZhM79YqvkTbn4ZztQ5ji1RFTXkc4AZdXmUtHF8TdSqyMy41PxxQdi8mwFbRqGZHcxj
 NmSd1dA7RBHn0LKtcSCvsTUw16Flb0RobcdWj4vc5Laua+f5kvQGIla1T37kGmMZEG807j7GLD
 7SoLQApc2cBTrUoQd/YM96fn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:38:06 -0700
IronPort-SDR: VTI4WSjTmgTywzcbTGnL+O2rSIWJWbyaNsSe4bPUO2YrniOzeozT4ug7Kjws9pZy0dOOGATmar
 jDfuS6Oe3t9A+ljtQvtNbUPjbr2E+R2WDxg06t7VnnHPxBZSCXuLE20MhiaWHCJDkf037F902/
 E7euvnw3Xf/AyA118dDnbZ2Q2pmnJM4rGPq+ugSYA7LcBQj4C3KRJlPlTu0eBN7yzFE1Jv1rWr
 xNjK7KGG5dbjX9DgmCPLF/ZowNDPj3ViSokdJgtjT14zgMs8gd0AWya8VtbUexVmKmuOjq0UC9
 7bo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:59:09 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/6] nvmet: use req->cmd directly in file-ns fast path
Date: Sun, 13 Jun 2021 18:58:47 -0700
Message-Id: <20210614015851.53925-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
References: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_185911_063561_1134A96A 
X-CRM114-Status: GOOD (  11.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_file_parse_io_cmd() is called from the fast path. The
local variable to that function cmd is only used once.

Remove the local variable and use req->cmd directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 7fdbdc496597..1dd1a0fe2e81 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -385,9 +385,7 @@ static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 {
-	struct nvme_command *cmd = req->cmd;
-
-	switch (cmd->common.opcode) {
+	switch (req->cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		req->execute = nvmet_file_execute_rw;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
