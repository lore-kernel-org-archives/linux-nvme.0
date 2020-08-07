Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44235C433E3
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 19:30:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0193B2177B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 19:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KDnSImZX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r0Z/tqH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0193B2177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DfqCWVomHzWjMe2uFTxnU9832KzjzL6SolVVpJbhjfA=; b=KDnSImZX7FFOeoHsa4ctM1B7L
	GI7+6/n6TJ6GW+jzecZJg4Iavg/NCu1stI3FVFRO3erp5KC17X9xSGnCgj63npx5Tyzs6UQ+pmMbO
	9U3RmUsoM2qmnxgm0b6UhIepcScRdb2tTJM8lAXUyDlRwnO2YDWaK4E37UVLay9gjheykKTLnupPx
	+5yH2ECYaWXYFKtHqs+Be2D0rsN91PqGiuzPjlmv7QD8SVFSA/NYazqDAH3xGegoCKt0FsO2Sx0rc
	riP7eGxuy4izHKl1pZfPMilmXUr9WmOlaMbuo2AfFgSRfrhW1dh/curcA6b+29TT62PY4cvg6uB07
	zBNm8G8ng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k484c-0004Rp-5d; Fri, 07 Aug 2020 19:30:38 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k484U-0004Pq-Ir
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 19:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596828630; x=1628364630;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WKAksGed/xkMNpC2O/QGKRE0rOr6vc6DDfpH1sbPbWc=;
 b=r0Z/tqH+aIXttljcw7IqqVSXp6vzgtOsrZ5P6LO0pHpGqy6+W2kpboTV
 6+C/Ia5h9fmT/U2v2WzvoPQz/wk7aqebWxMKZQ5KWNnYezZL+hqv8Y3R4
 jpw5TSZarc1YsSb5F/WMjBrnh5XY7zKURKYmresAP7lFS+kiMzy7runrv
 rEVXKTelXpT1H1orPJNYewlgAupQDnTSO4FkEHId+ZF1pDgC//jtf/PkM
 paVzvkLxpTPLWFEF/tnB7ND9Chxhrc0yxlzm5SktWCxWOQNu3jyGV11fM
 tSYm6a+YN8w6vni7x+mPLYCpZxFP//qAwqMk6aRbKdjMC660ppRDFvRfb A==;
IronPort-SDR: zl05GU3Yr+Lkyiivs3Pxoe5CSfoQ+FouVtgITDpfWw/CgFnlHZZ/2kbdSemHgf0+lnOoWK6Qwb
 Yk9gEXp9Jm7u2leaSbRy2Zbk2Q2GHjv/S1S5jM0Ut/PvnwSDV2YzCuB5uko6Iy+VTuz6rKmLVx
 mnviqWGArXd/o6n3Wwx01uP1uWTTwltxSVuzY/TCueVx2fPTFwbzpok9dQBXFLVWwTG/7fIRiv
 Ju/dn9xPRZVMRHABguI46ce6r/Nc6uEQEA+oLjT0hFa6vfM+HxoFE+NfZpGBEyLUTzjCwC06PG
 lSE=
X-IronPort-AV: E=Sophos;i="5.75,446,1589212800"; d="scan'208";a="144423141"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2020 03:30:29 +0800
IronPort-SDR: JDcgeoHo9oAwtOGkjnrUAoCOMA+vKHbPHp3r6zEMhFbcaA5H1k5Ee6lJSucoqH+y9bS2UGpyMA
 jfjTFYHECyyg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2020 12:18:26 -0700
IronPort-SDR: e21S66yTBw2x34i8rQW4WErFqd6DqTRsyrs5i2Rf1LW7HgWcXkeIjXtj/VckIw1m/qqpKS1CHM
 UOg+8Bhe6rXw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2020 12:30:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATVH V2 1/3] nvmet: add ns tear down label for pt-cmd handling
Date: Fri,  7 Aug 2020 12:30:24 -0700
Message-Id: <20200807193026.9129-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200807193026.9129-1-chaitanya.kulkarni@wdc.com>
References: <20200807193026.9129-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_153030_755946_61546F30 
X-CRM114-Status: GOOD (  13.47  )
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
Cc: hch@lst.dew, Logan Gunthorpe <logang@deltatee.com>, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: multipart/mixed; boundary="===============4784587734676548715=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============4784587734676548715==
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

In the current implementation before submitting the passthru cmd we
may come across error e.g. getting ns from passthru controller,
allocating a request from passthru controller, etc. For all the failure
cases it only uses single goto label fail_out.

In the target code, we follow the pattern to have a separate label for
each error out the case when setting up multiple things before the actual
action.

This patch follows the same pattern and renames generic fail_out label
to out_put_ns and updates the error out cases in the
nvmet_passthru_execute_cmd() where it is needed.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/passthru.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 89d91dc999a6..e7dbca12785d 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -230,7 +230,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		if (unlikely(!ns)) {
 			pr_err("failed to get passthru ns nsid:%u\n", nsid);
 			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
-			goto fail_out;
+			goto out;
 		}
 
 		q = ns->queue;
@@ -240,14 +240,14 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	if (IS_ERR(rq)) {
 		rq = NULL;
 		status = NVME_SC_INTERNAL;
-		goto fail_out;
+		goto out_put_ns;
 	}
 
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
 			status = NVME_SC_INTERNAL;
-			goto fail_out;
+			goto out_put_ns;
 		}
 	}
 
@@ -274,9 +274,10 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 
 	return;
 
-fail_out:
+out_put_ns:
 	if (ns)
 		nvme_put_ns(ns);
+out:
 	nvmet_req_complete(req, status);
 	blk_put_request(rq);
 }
-- 
2.22.1



--===============4784587734676548715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============4784587734676548715==--
