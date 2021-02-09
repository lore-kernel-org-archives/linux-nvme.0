Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D35C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9990564EA4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9990564EA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j7yhBOFYZIccEEaR2PKwjZiSpz7NX9e7oUE1UaQ4l/8=; b=BFH0TrEHGHeFIS2+zHQKu3HJi
	ddl6dZllfPaZoK7SaIg7Z52TIFaxbIP6DkPckm3zVXbVXuchD1E2UzD5wpEYF2O2U0vZ26OmYYVj2
	pr2RAMnr1GV+OYMuydXMFddvhG1xhIzVuWNjy9i/nrv3fS1fKkXtbomgHdnP3arkZpyvTB8JXWrOG
	u1sWNxmdr6qN7FPNEM4KmpmHwVcTDSGDRjaCO9RlBaqAyBw/dCEOZ4FG7CQ+r90x9J4RyK7KlVxN0
	/ugmLoW0T1dKvxu3tHn0VSoT1f2NcvlfsJPg2LtYdQC+sPqucLMZVDAEJU7pg76pwK8q/kPp2Zt+4
	khGzsMOwg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKl-0002yW-7o; Tue, 09 Feb 2021 04:09:03 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKb-0002sC-NO
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:08:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843733; x=1644379733;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HIyToJajUgAdIuZCw/mDAJP0ZPdWQZDrF90A9nnXr0E=;
 b=LkT58iEXHacTjm2Zl69ZiZh50AsH0kEJ+r2P7mcpF800XD5LAWs1FHyK
 J+KULDhpIkp9yoVZhwiUEPUGLf4fFSek30mMLb4zx8qnaBhp02IpKUc9j
 WT3jSB9ZcGlgFHOAY4XiybaJ5uwrmRBaVyzXxQIMBNd4FfMd3DGaSfrCX
 QErnaGb8fqjQTrYOJ1qEAREBjwBiMSo608umwdGcZzhZ5nnXYJnthhVd+
 s+GqkTcac4Y583MYri/jvwcp3v7nwL2deESkstU7Q14F/IjilTM/5dcEr
 +C+WOOMlncjawy8FGvmv41l5TVuH0eSB1XpxiA56U8liAlAJX3sHCnkSi g==;
IronPort-SDR: DJfk7ugCmj2zI6Jy2eP3N+FcbXidhA1ppjRD1KT2N3NPZIrggj4W5LHqiyMaFvo3Po1nbYc3Z5
 MbVngJu1RK6c38VOOK99Rbf8Lwoksa0PimlSaoSFKHPtYekc25BPpWlY4Gt4isC3EPdIaPudx2
 dIQmDUZXIEg7goGxldy5znGfy8V6FYcGcGoHpxMHbwMpOTOOIO/YvsA2Ijh39buRc2rqXZgyuv
 rZSVF0GijqP0iS0QTVASJPDzTlxJC7VJOA1PLCaj1XnzlwbBlH81VvP/NqpefdiTsnGng4Y/EE
 UwM=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970521"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:53 +0800
IronPort-SDR: UkeHc1pyAFctPBYUmWEh0BZEmSw/woiTSGzgAtcWIM4Gyt1DqEzmH2z6Q389mkVdvsDjyv8kCK
 PKG/XKkEq6Z/xD8GhsJJbJatiOJOuk9yAqA0SGKQnP2o/yY36K3K41Pj2JmjyvXRCX+JAYzbFF
 buiGEy3kW26xFRvfUi4ewOVAAXLXtqEZkCBtdvTV9s+5JNVYTMZzxSXBbcixruPMH75uxbNlz0
 smeJaJ2/ZZBbjD+WTNMh830yILf9GA4Ujnw/X2amGhH4exRJfvybhSYT4ZUKyLqz9cOJnYpV/b
 EKLnQtvF60wHr5e4M+EHyWGw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:47 -0800
IronPort-SDR: SUmMgyIJpuZoU8ZEzoE2Y7CVdNt/avNcceQRDxu6vbP5YYJiOIPKhkPTPEj/mZxDpm3EKrluDx
 lgnwdL2BlQQIjfCH1bRl/6s4D1UEaTydEUTk5NerYuBH5RsuXTy1d3YKWk8AL0J8OCh5v15MJz
 +JPUOF0NxBZ28M+HeYiwNjCy/qzG3enkp4SwW7W+qVm8MnZLDNyCje9Djw8aCb/7vXl4M/HivO
 z9Cvkdq5db8BfUYqvTry+kKFvIJo1kVLrrNFnII1oS9mFT4GtlTw1NaUSfsBrJaPFvfAh/1LCs
 Jfw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:08:54 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 05/11] nvmet: add helper to report invalid opcode
Date: Mon,  8 Feb 2021 20:08:37 -0800
Message-Id: <20210209040843.45572-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230855_204189_CA9CC8AF 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the NVMeOF block device backend, file backend, and passthru backend
we reject and report the commands if opcode is not handled.

Add an helper and use it in block device backend to keep the code
and error message uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 5 +----
 drivers/nvme/target/nvmet.h       | 9 +++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 23095bdfce06..105ef2b125cf 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -449,9 +449,6 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
-		       req->sq->qid);
-		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return nvmet_report_invalid_opcode(req);
 	}
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 954b3d8451f5..6b5f1b60cf50 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -613,4 +613,13 @@ static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
 	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
 }
 
+static inline u16 nvmet_report_invalid_opcode(struct nvmet_req *req)
+{
+	pr_debug("unhandled cmd %d on qid %d\n", req->cmd->common.opcode,
+		 req->sq->qid);
+
+	req->error_loc = offsetof(struct nvme_common_command, opcode);
+	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+}
+
 #endif /* _NVMET_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
