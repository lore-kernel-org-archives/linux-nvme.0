Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BFFC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87D0564E3E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87D0564E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JJIzVrhz6i5N7FbIUON81FWEZexBQsuoshtdQ45su3o=; b=uJQkniyaj1wBDCKNluKSu7dI7
	CiI5O6zLASc9fQ2WF8o3eFtFryZNxZjfaHuOI1DmSrGkU3SMdG8L2zyRu5ZC4exvNREJxueUl8f6M
	n1EwNDvthtLh9usiHR/KYSToSH+jklO1n+pfVVBKk9LGk7YUR7EfR21ZTrFq2Jj7SqAM1KKs0qmaR
	9pZIol1RdKfmVVWh4FbRqdmKuZ8YGLKvxMgkbYB1tbtSl5Sxv63y0xTTabqSZPpmKq0toXEqeo2i2
	N+owAtVe0AhiYkrIHPvZifzrme1zcIwg8ukXCHld1nVVihCXNkNbZp0gzmnSYtK7AhoRHHSdLFC86
	LWuv2m2Jg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iMz-0006wG-4O; Wed, 10 Feb 2021 05:48:57 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iMv-0006vE-Rq
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:48:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936134; x=1644472134;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bg3R1rWLO35WyKYY3Buo3HOjMqzJFRMc/OIHvh8ow/w=;
 b=Z2LS4Y5jpW1GRo1V07Hck3JNx7/bym1o9X5c/Jtsl8Re/6LfgpkHQ4lE
 Eumhiu8BqV15+b8LvcKS7l83AD4vh9l2O2SEL2g/QDj5qdt0XZY2Ls3hX
 AnDmNcmtznGhdrX1LlMChok0p3nB4TVmsIjlSS9e9nU3Bd02ehqkSCF0Q
 Efc8j1iLsD3q6rQSkhBshgmOvn9dkCH/wIwefjvqHHWDQNWGISgudk0Pm
 vxjFaQ2Q+km3zhhj5g29e5OamJXWUUBuY2Oce6XEQdkejrnCyr+DJ5vux
 h/pqrvbeT3HRWgEry2ozuByEtABVwNpRQ2b+QYBSwkKzLg0EUdvE5faFK A==;
IronPort-SDR: zwflu0QSSoaYOue+fPMXLm0t0TVuW3iNGXcu8u/1PMj7qsp3w1hAodHP6560aoh4vOqSz8QcF4
 qlMBpN9jBMtYKzwAI2jJ+WJuxldSjd2u0vy+KxPMLBcT3Tk8bME5SUxgigWzoswXOo4j1vhDd2
 cIU8Rt12DOau1kiQvwuoyL9PCrETqPSMwl0yJ741W/YKWXSAc6Xajanw7gvi8zQiT9GBVuzaqN
 XM7qLVALsa3Ej6Jkt+89RKrdHEEOZD4sKMUXvJzxOogQKZYmfn6b87GkxoSaV5SJhL915gAMKN
 ra4=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="160778667"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:48:53 +0800
IronPort-SDR: yf8YLPZdQe1WoW/q+XhVMut/oCzyf7MFhB7Nj9JwfVUPgB48J5JeirEZ9tiJUXcrgESbqw4Fpc
 jE8kdanqA2wWb20gRKmGvg+WrcBRv0wwX4eglFy62dSegKTdNxKQ/iE4NPzFy1pXTe5din3Ml4
 8ZvmNE0IJISN09z0Lv9Dkd1A0WMwLPP8zbSDdqqrmIpm6IDkzjZ7c3JHVFP3/G6nENVbzQllOO
 v9jmy3L70+5kT2XGR527c1cvYxRHhUO3W+U/oWu1FMFWqZLsw1wzL2OIFICoCTFTCvNTR1S7E8
 mbuuiNlYA+NATqRenHOoLawl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:32:36 -0800
IronPort-SDR: xgLZITHCxNKXSv/2MAgp52avaz6CEgQT2EateJfWHt+EIeqr+gY4AIVeWP9/H7KuS/dbeqeb8A
 3/6Ada8JhrO/vYSBxElkHs1JI8mhGTKSGkS8tbeVGi1C98UuLDHPdYVUcxEfRNgZiofayEXYDn
 wQUGgFjtL9IeHMxbpvGOUh88plgXk19VRwscWflADeSWwk7R6yH2Q4B/vPa73CpIlf3bajMj2I
 oarjWfwMTfUY19ZPdHRdWKcKrpxlZJtFdpSev12xH3Fy8uyj9sk8lSP0GT3JDFSPqctQD5wtrE
 7Gc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:48:52 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 06/11] nvmet: use invalid cmd opcode helper
Date: Tue,  9 Feb 2021 21:47:57 -0800
Message-Id: <20210210054802.34269-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004854_301467_6F575AFC 
X-CRM114-Status: GOOD (  13.57  )
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

Use the previously introduced helper in file backend to reduce the
duplicate code and make the error message uniform.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..715d4376c997 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -400,9 +400,6 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
 	default:
-		pr_err("unhandled cmd for file ns %d on qid %d\n",
-				cmd->common.opcode, req->sq->qid);
-		req->error_loc = offsetof(struct nvme_common_command, opcode);
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
