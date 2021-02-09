Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313CDC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D118B64EB1
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D118B64EB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nENUwIuhUD50wRhvFXFfRnGhY/ZJ+kXAwGmp1ku6WK4=; b=rnleAeu0ZNUrhuTclEJszjN9j
	iCRbbD9KqqcqVpa9kNjunHeYhzrLTk+jrTjdI7TcJcrOplIHUCkOPT+s7KFuN5V39XcQC7zay6JMb
	+OsZOAFYhiB8JZ8bq1iwC44ev/lqlqhrZnhxkRYe1qlNNC9t2QDFpC4R09TtIBJ4mrt776+CdwrTo
	V3bKuuIGJzCFLFSZAiYYw9c5ZhzJwRfEEHRLtrylNAwnaXf9rwn929E33CwsINmz1VrPCnT0hQ0D4
	weEI9EwVB1ONXA/b2ygErjTSmyeNtgZ8fHjgnbiG0l5mYwFEsDF8NcPpJu9DNTdPi1vF+gn3WED4i
	QU2autbrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KKv-00032l-0E; Tue, 09 Feb 2021 04:09:13 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKg-0002vS-2A
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:08:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843738; x=1644379738;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=622s1k8h3rZaxUl+ImtLrqjV0H+uclrC8JFnzWr06EQ=;
 b=kE4Ng3gvgrgHZPJtoe7Lg2oh/q3Gb7Q97B7KjoDjNHWnVPjlkkutBSiP
 fw+bCylI44KbA+9XjqD1RKSaj6roqYuDJJ1XKN1fJ9syVIDUqbFEk6+wF
 IMYqveN+PcJp8NOxAGD+PFHr7kCf2Y9DEj6ubGfRt5radHv7xQlZnfu/A
 NfmC7Pt1lvJIJnvppxSvkRPybo39sPXQdDGdjNq/mXa/IMzUHeJ3bRgan
 1BcPa9/uXqYfhVLWA984hlUgLZbpKJ3VY7QKGjxgRzKtqHZydjTmFCP92
 31mAZ97I7nsfoGIwaDqWAiCFE2v0zQKDnMWqdhFZ6rzdHKrOrNVbbtoYt g==;
IronPort-SDR: +yJNItpRCLD802LCt5297yluFEJgSGXUHaOqiy9g9VkP8eHWQn2rrxErORNcNIzIdb/fSpE7iZ
 VCWR0TiGjt4OJCDaQcHty9audAuRlo4gtdw55G5m6xcaU+kVBeahflsZMAhkHR4xMFDTXCXdyG
 sVEctQcjHQ+fq874qrwPZWQ9a/TUz47Uto3DepKh+XdZRBdk9CwNzhY326/LlgE2KFTXMswgPP
 kShq2C0UShV4odDZc7SMP1LHE8dFTnMjNjQMtCGzrNYYOGC04TAbmZTdBGJkzUxRmVCzi9piu+
 M14=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970523"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:08:57 +0800
IronPort-SDR: o7xwOGYzQRwAO+UorYCbon2PUwFZYndMEvbf3ZFyRbvZ4l56IUgQLHqUyZhcjmq4jZcm3C80Ln
 H0ptta8zTWGhSu8TOpWtJ1fwQiq5MFswcJaMRK7oIlP2lWZxb2xKZ1lYcA+uLfEsY6PIsnrFdq
 x2WVbz+9Z9L9fWxe9D20UdSf31t0pQsLuq1Z4bhurW/9VvJIqK4CuafMJJNnUN0NmNK3l/CDSR
 F2aA8lW93ZUxdPhlCdZwB/i/MUZ8Tk2aG3TuLG5wjB4RpCy+Cdid8F+AdTM0ZqwCXx6sPxYVSj
 fctS/gSLQ+978C3ukRSnXNmG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:51 -0800
IronPort-SDR: cLF3kdNe9drk7XgK5+Dsh+WgLuYyjPT3/eq3LC/oZBghJXkZM/I2B3+49wfE/HV9HrCQXEEBzo
 ZZc0+bnrkXOL+ZcGZsx899afKfZkMjhwNTPSy0tcz8GMzt/JowXav+MLHe61v/cERTdYAdQchP
 rKKqgonMegP7wXGaQYbtv+6C6qK1XOPZCbDECc1cL8yM9cCWVn6wu8PLopmkAeYv42W3KXDuSp
 Pnx7uVRqVz1C+qy/JSCgkOsh7z/GYHp52+uyVyRpbqInjtPez8PCy8RyN2tSS5q8ZvnXmHgXEj
 NmM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:08:58 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 07/11] nvmet: use invalid cmd opcode helper
Date: Mon,  8 Feb 2021 20:08:39 -0800
Message-Id: <20210209040843.45572-8-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230858_412345_E4572A0A 
X-CRM114-Status: GOOD (  13.63  )
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

Use the previously introduced helper in the passthru backend to make the
error message uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index cbc88acdd233..3b22f4a868f4 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -494,7 +494,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 		return nvmet_setup_passthru_command(req);
 	default:
 		/* Reject commands not in the allowlist above */
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return nvmet_report_invalid_opcode(req);
 	}
 }
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
