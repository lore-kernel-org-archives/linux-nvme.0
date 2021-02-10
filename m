Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3463BC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E6564DE1
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E6564DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j7yhBOFYZIccEEaR2PKwjZiSpz7NX9e7oUE1UaQ4l/8=; b=3km9EiDqYEskb/7/XqS4xMHQ4
	PlOpGTF1bg2Nk25ssLYa0qar6JUdQFQuchl74BJZB+uwJLMeRtPuQGbL85xzdBJIunTnDt7Jl94cd
	yrZb6XWLvs5TCoJYpwfNiEDZcqpK5skf0ixkllFEsGdvHuYuCvQEvoqO7L24AVgk7810pYgW42amB
	iqVCz4c1liSOU54ohfQ2sxYevicB4jGKdWEHSsdwCit028HHwngpVi73qTHsMswXkC/LHqXvA8bmz
	NkH8iDf0z4ACXndKe/WNz22zlxi6UKrtQgM/xY/5rv2oKDQgciLmqTJYEi5cMDm9iRTKlNDU1q25t
	Q0a6apHLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iMr-0006uV-Tz; Wed, 10 Feb 2021 05:48:49 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iMp-0006tf-2Y
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:48:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936127; x=1644472127;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HIyToJajUgAdIuZCw/mDAJP0ZPdWQZDrF90A9nnXr0E=;
 b=reRPoItx983w5Ab1emBP4NTmHzxcARJqnOfNp1d7mCzUCRcJtKA80sGH
 6PML0mg1OFC7V8r3pfx3D6nZB7uFQsXHyk97TSzO1l62Tsl5toJjfY5pg
 N/6KhiBnG+SigQTGI8RPv2T/oAfE/dARp5/BQYPbxfHbDe8Od/o9N2848
 qUwl7JOcx9VITvfHncv3Nk9YDtm0xAytwIuucyB01lOqiETvvAxvVex9G
 AoyXXCye8qc37F3g+/BPwc+gSrcGZ0NFmuJpqNjmglKZW62Sz/sqeN+an
 wuQVAlkl44F0b/3nCp0mxX5G7mpnzW75WwZCB9vn5i4BcC3xT27wy4rcW w==;
IronPort-SDR: 9bBykznA0PpgzKuIbdT8UeDX0y8mL6Epndr4dsWXzszS+6E5GSJdtc0qaK4KU8277s2E2HG/zP
 KpKmYBfUNFOLht7KptvsOHPcr5izpGp8jzDsFuJmBpQx2RWFQy7BEbgl6iI6F6tnaEnm/v87mT
 uGvwB+t0DD1r2eLKroG+fZ0FF9c5xIfLmZmZ7BMslFDjkPZgOuiPD3vURCmM+K4AY4Umtqkt8b
 BdNv3iyBZT+PwO+NOE7igjFT0qDiqe+FYmHwE7AIasBc4CMt8vqHnFN8rEA+3+pZNBwnwpAcdF
 XBI=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="159609254"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:48:46 +0800
IronPort-SDR: LN3CbmZ1cm8foMHWbYvadfpQpJX61owonmZKsb4P3CBl3TzwdWCO4QavwP8JtMImR0GlUCT20/
 YOdWitVmKaDh0oMmTFcKMv9dT8KVch7Z678OAMdLWUvgx4Hxe4IgnlYeRnaDhgQGPyXq40x4q1
 n24Xh68S8ZDLocejN2rdSvKwwUa5y2TOfQbhYXfBfn1ZUXuznSBsiql8zoyY5bfCZV4266FnuB
 qeIIlOqRD2rphGFQqeRioERILg8o2M94wxsi5Wf0HEhpZilgwbW4lMNb4nygyROS1M20LbM7MG
 y9hyBUnz33T0N97M9P5ahiIF
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:32:29 -0800
IronPort-SDR: motrmXhE79PPdhPabHVRPkPvd+NlyJufH1ap7gwYmK8u8wHQSfqY3Or2DHPCRnIQa6r+4+UAUH
 XWKSkfcztzooCg4W3vgcQPR8oeMsIRe1iDXr364RUm5XpaQ3miazKBcIMtPr1c/fQBdXDxyWnq
 bBZ4+XnWPGvE4MvL1DYNdrhac+KSpSKRAhZ1tHUmcML6oYRkNyHvdKlF1vnR3ntXi6lSv9eEa8
 nAr/gyhDRbRHtoaH8qv6W1NHzRlyykFa+jlpWJGMVB6yYF2uTchmDOT/77mJsO3b8yJBt10wti
 S6M=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:48:46 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 05/11] nvmet: add helper to report invalid opcode
Date: Tue,  9 Feb 2021 21:47:56 -0800
Message-Id: <20210210054802.34269-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004847_253642_5881D764 
X-CRM114-Status: GOOD (  12.52  )
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
