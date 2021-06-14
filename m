Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC972C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A4B6613AB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 01:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4B6613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JVdbHk1iI2xYtWjT9XxB4UTrcxrnX8bZ/etyafpGhQc=; b=W3KWBOlWDZGBJh
	wfJobpgRImMWBDR12qnLjJpWYB5Uuek67JMEZJrfxy5wvfZRrzQro7ckgcqe1NZ/8ayC+KQxMA/wN
	x1AQerAoJnO2XrlGa7BmV1QJvE6GhTPv7iY3RTs7+gkm8b72pxFRvwK+pozGP5kFeylULqHkVPe/6
	OCuawt9iLiwBEkgPUCYXAYVE6aAJ/nNmEhYag8f31ORi+4PjmzsDqBPdazVBGa1sz5oLW32BwSECg
	95n9/vXD4gGgBd6tbN/7MH1pWf/3oNIXNFJ55ImQyKwGGpT7w+hnIPi2ylnbhfmLeXlbfb99WZyKr
	nUffZnNeJoJCGGjGCQKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsbsc-00ByoB-Ct; Mon, 14 Jun 2021 01:59:10 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsbsT-00BymC-Cz
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 01:59:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623635942; x=1655171942;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MHrSJrcxZ+ipFRHJOGnhLbDqiSLBNhTcGmLN4p44L/A=;
 b=VUNZjcoMeti6oqd9fNLs7XwQj+CBv75Kp1DXc7VvRYXMa0i9Q/uG/UEu
 1ZVHw8XmukDNIPiLc/AtvWHUfW5pOQ3VzF8O+QLN/dYbCGsNJRzlkUwXL
 aa8gUKX8CvV5xiAzEvfdKEiZv87QkppNkW91oHmA8jVXyTbbf6aYE5Dya
 8KXyCSw4AkTj7Fw9wOLcwLFRFl2kwj2/f2C5LjVf//mT4bv59cOZISC3y
 A2x5pQggLdyghR4QbKmt6Ltku2qAJ121njf10mt0txtFNypJrlxZ/F4Vv
 qS5eTu6Xr77S4XGMsQQ9JCMfbNcqEV2USZo7qpGwGrjsbDblk6dwsMEew A==;
IronPort-SDR: RAJ8fkBl0UXBuquonsGex6DFIe978+fJ2HSie63BfIshLg/woB/hvOMHc6qi65367y1mPzSK08
 scZs90QIgARnNbO/fGEV9SJBfqv9dDc+OBaCCw5hD+kX7b604tWz5rmBSBNqbjrAJIbQOTfjXE
 JzjfuGipRjgbrQ9j7nxJ9d6BN5TBRm9s/JqW0yZ0SMPVvHXdIM6OWjlqcY2uc7xRVRWUvtZq8N
 NQsWBAr/Rpi+Kzs3g8hkXb5MRIGk9dllQd5L5COYj6U0GhswuqwovD7im5mAzI4fUy7+2nKZeG
 Vhc=
X-IronPort-AV: E=Sophos;i="5.83,272,1616428800"; d="scan'208";a="172340327"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2021 09:59:01 +0800
IronPort-SDR: 0ETvDrQF7VYCDFuENnCsvRpydb8P19GVZj2exYmgieLx6NFX7HUOI7rHYoEUxFn558z5yV5yZo
 LCUAjhMHf87vk8pb6NqUyuStDTMVgA7hLusy9eWr5y86bu7fVmlMvU/qU9GgcPpy7ADbXth9Cb
 FEF5tfphPuM+NnHzGd0qyVKIt88nDPm7C+ikQ+BkEiICZNNydIGGiF8rMp7coW/sYBxKsBpfZt
 N0q5hXyHVIIfMdQUz6Aiv51as3zHYNXDvXyf4YyYexpzMESErw6HQkFwMroIPR3m8x5t4OQ2Sw
 dVqiTxm3dUDf3mSApgSR2AmQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2021 18:37:58 -0700
IronPort-SDR: 0PvFd/zRlfVcW3Kbuia22xj6AH0lWIMic6l0p68IqRkFxVoH0xbeKumaJLG0Lcu1uiNYy6/4mu
 8n6iBI7u96q3+p+a2PEx9wASOURGflMIqEVBQILc3HwNQpld1BtrKCsXZYaO0NIRr0vmJRrBfy
 6FQ7zpLfuvAfORPEkZlS/GDWA8lylZMmpVf9W471xKQPWSPtmiHA8i0IqGL1qJVXsVw4E+rN12
 joFPsCcDktTKvPKkFVMFJoYNT2kY6TcKwZP9ZqbHddNCMmPGbEsvprtqk6zb9ylaqfCAtdwI6R
 klk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jun 2021 18:59:01 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 1/6] nvmet: use req->cmd directly in bdev-ns fast path
Date: Sun, 13 Jun 2021 18:58:46 -0700
Message-Id: <20210614015851.53925-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
References: <20210614015851.53925-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210613_185901_533018_8629718F 
X-CRM114-Status: GOOD (  13.31  )
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

The function nvmet_bdev_parse_io_cmd() is called from the fast path.
The local variable to that function cmd is only used once.

Remove the local variable and use req->cmd directly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index f673679d258a..5d998e5873d3 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -429,9 +429,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
-	struct nvme_command *cmd = req->cmd;
-
-	switch (cmd->common.opcode) {
+	switch (req->cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		req->execute = nvmet_bdev_execute_rw;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
