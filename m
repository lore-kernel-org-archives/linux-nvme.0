Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E86C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B5A20725
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MSoTnIkw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jSJFB5vC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B5A20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=p/JdAhgbPKWyvvSO5QrcCllamvyoKQ7x+iJWOQ/tWvw=; b=MSoTnIkwdFzqkIsde5cuiau2c
	5oNlPlkfEoQ6jWgws0IECC1zldLjdlGZEZzYkfzW6NKgCdXxbhwnxuWglKCSuJuoWD1dl3HqZsPQP
	MTBexKGO+lupGtxsmT2Ceg427Iq6uRrGc9ByTENtGpBG8fHHoP5s8tCzwNEicN+Knu7mLC8lZfOE/
	0VjPwrbf9dRr/XAnv1ByVTPYXuuGyUfzgYdUkgoZtjEsGynIF8jnOQMxKe/SU0ucNDfuAIxuLPJ9r
	BUAG3Tpz63oJy3/sFxnck36FwXCA3ANJg3OCNoVZi72sL5NVA7d7aBGm8ZE8xaE35HDEf+GUIPa2E
	VLoEeUaAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx4l-0000Bg-Rj; Tue, 01 Dec 2020 04:15:39 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx4j-0000A4-Lf
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796137; x=1638332137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KZvesihZxqvpooUM98Q5I5u1Gk/h9BuWE3/slZ8Ndhs=;
 b=jSJFB5vCsIPc/L32dA3PxqX5vcgXLT5dAg3Km58pUavhO9UA72m0DbKB
 WeZzTboFIx6FPED3RNCg8ePkF1vUff1SAfjy1ricv0vYFDHZTLqk+AXSo
 LV56QStZJ4jH/4bZ46Cn+iEJr7k6gEkZObcXEW28o2Gr5J8nAp6LD+Xa8
 LGJnDL4jFdjFcgUujiG5gDFHUvWkbT7YYchMhwzaVqxbcL7T0neaGuiiG
 WVi/9DcNfneGs4GzTu76wrng0NCaa3wjfxGTV74FhPrLpaGG8hJN5MKW7
 beFufkLu/9bd0dvOEap2f4G/Dwa/+W0sgNeEw1AH3QqIHIipyMGpf/ezs Q==;
IronPort-SDR: c7/kVSW6nFMQhwm71VoI8iQU+PwyN+20s/YkWam3JdvXE0xGyR+Xtup/VtAAA3HIS/f42kfQEp
 f0qQ3yPIhqJlZ3+2KkahertqyDjBtzxOrSwyibv1cS/fwa0FXEUd6qt42fQTGR1Ybgin8nFHOD
 jPyZ5xmWO5Z7s2exYgrrxqzLrnKja9G7rbnm7IcPFQSoMdVSG4D/q3DNxjxxIjs9K8HcQ9Fc4N
 4EduXR/bwEwh+3aPlmitj1cSmu8mgChKK+dvKTsJ/9ErlQGjtma1hq5xIaq6RRFaVv3mDNpYip
 1kM=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="158346986"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:36 +0800
IronPort-SDR: ChZJ1QCLLBkgIDjsRPEEVoBuPVHkqwRRyAJv4cKZ+xWbwpD/8ilJVXJ7nqzOOWjM8z9c7LIlv+
 6r2ZowiftOj+hPoXlziNdYZ0AQGnZYPAk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 19:59:48 -0800
IronPort-SDR: nb5WqBJEDzev6Bbho0xCLsxDriknavT5buwPk4zbaeOYOwmzpRPRosFSFyiFKBwhO1T1zPIUrW
 ACs1nuPZch+g==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:36 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 9/9] nvmet: add ZNS based I/O cmds handlers
Date: Mon, 30 Nov 2020 20:14:16 -0800
Message-Id: <20201201041416.16293-10-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231537_927065_ECFC1A13 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add zone-mgmt-send, zone-mgmt-recv and zone-zppend handlers for the
bdev backend so that it can support zbd.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index e1f6d59dd341..25dcd0544d5d 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -453,6 +453,15 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_zone_append:
+		req->execute = nvmet_bdev_execute_zone_append;
+		return 0;
+	case nvme_cmd_zone_mgmt_recv:
+		req->execute = nvmet_bdev_execute_zone_mgmt_recv;
+		return 0;
+	case nvme_cmd_zone_mgmt_send:
+		req->execute = nvmet_bdev_execute_zone_mgmt_send;
+		return 0;
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
