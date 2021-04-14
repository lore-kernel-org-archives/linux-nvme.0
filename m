Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50710C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 05:18:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39CB6120E
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 05:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39CB6120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fo8+Lcv02izXWVf1ulLIaaLAWArbZfY387CqWgn/oyk=; b=K97G2tC8AG94ow/6Rb2GQZyfv
	1JJ+Bjm2mx5e54pQLzv86zVSjbhflxR7ZBuyS9JmqPUMyT/TYAG1TU4HeYEEdtdq6K+3bkR3YI/ew
	ib23c759eSZs/2zN3FSn2p3ADMyUtyTwwKgPY+4q/ZrYgPbxuYaD130YeoCHe5ckrfYWEWVm7/DJU
	wDM8dMiZIXbsP+RL5iq6Eg/ZfCZ6jryTaZ/qi0C+XOZKNlDZBunK4rl+K1Jk54IKvtn8BTFguS0Jm
	U9ivSvkdOj/yDVapsUdkjmzMMDhPSTBph0tYOCiAoXXTHOhy1LFhJ7EIZg9b2GCUgn/MCTNO6K1wd
	/M3r0M0qQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWXv1-00BVaa-AK; Wed, 14 Apr 2021 05:18:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWXuY-00BVZ5-3d
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 05:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=4EFN46su2AQPDlc81WMS9w0n3d83BTZI0D+vvEXeAcc=; b=FNgHd52zn5HD6U7QeUuzn/3Ul3
 FTUkBbjv/YFtNg409e/KU4hIW2dIKSw5APXiFmdXiYr9cFVOeO8jamUe0QEKGWgMU1Jh99yAjOUzp
 sl/NFMV+X0Ks3XJJ6kYWlH6BRFcreiIs+S5OUijR+b546z5JoWTjidAtHqdSwksy7d5UEdYwRNLPy
 1ulr4ISekfgqdmvjFnpSMih7aCToont/bxaCuaWa0JT8D+F3BKnflYmKwz6BCTzYHyWBV0EsZRaNa
 effmitgHnUKD+1EkQERBt5vKQf2cUVbZZlV8ZZVBUe9xWVQ3e3pqZdQmTMQHHNz/7v0LqKEubJ7WM
 Zlo5u9JA==;
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWXuV-007UUO-14
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 05:17:56 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210414051749epoutp0455bdb4ea41a077544044383fb33135bd~1obvjnKWG3181031810epoutp04U
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 05:17:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210414051749epoutp0455bdb4ea41a077544044383fb33135bd~1obvjnKWG3181031810epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1618377469;
 bh=4EFN46su2AQPDlc81WMS9w0n3d83BTZI0D+vvEXeAcc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hHIZH5CrAYg7Fw9hNEBjbNfqbF5Q359AKnBUwZWOKQEkUNmzraF02sEu0IIfWZfH6
 BfiWyA8E9IYpnYr85MMlN3m/XG3mvQ/Levq5nVmFAGJN83b8eDvy6uDhaeSileqhu5
 wS95tSw9TtWmvAx3P/91ssA/yYmKUIQkKYfzpRLw=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210414051748epcas5p48046adda6c9ea04f3a492ae703d5a0cf~1obutaGXi2955829558epcas5p4M;
 Wed, 14 Apr 2021 05:17:48 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 A3.82.41008.CFA76706; Wed, 14 Apr 2021 14:17:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210414051747epcas5p265826317a971aaa3337efb6472a9df7c~1obuDgWfq0197501975epcas5p2V;
 Wed, 14 Apr 2021 05:17:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210414051747epsmtrp1026dcb983c04ccef3b37b793f7f20886~1obt9Hz9d0819308193epsmtrp1E;
 Wed, 14 Apr 2021 05:17:47 +0000 (GMT)
X-AuditID: b6c32a4b-661ff7000001a030-ca-60767afc1d5d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 0B.AE.08745.BFA76706; Wed, 14 Apr 2021 14:17:47 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210414051746epsmtip1f76080fa2a7c89ab3d5b147968571a9b~1obsZLOJl2456624566epsmtip1m;
 Wed, 14 Apr 2021 05:17:45 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 2/2] nvme: avoid memset for passthrough requests
Date: Wed, 14 Apr 2021 10:46:29 +0530
Message-Id: <20210414051629.103383-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414051629.103383-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7bCmpu6fqrIEg75rshZNE/4yW6y+289m
 Mev2axaLlauPMlkc/f+WzWLSoWuMFvOXPWW32PZ7PrPFlSmLmC3WvX7PYvH6x0k2B26P8/c2
 snhcPlvqsWlVJ5vH5iX1HrtvNrB59G1ZxejRfqCbKYA9issmJTUnsyy1SN8ugSvj5N1VLAVf
 eSu2HvzH3MD4jLuLkZNDQsBE4vHTDYxdjFwcQgK7GSUWbv/OCuF8YpR4f6CVFaRKSOAzo8Tv
 +XowHQ1LDrNDFO1ilDjxcgEzhANUdH3KZZYuRg4ONgFNiQuTS0EaRASSJJpeNDGB2MwC7hK3
 n/QwgZQICzhIrP/lAhJmEVCVWN/Zwg5i8wpYSlw49ZEZYpe8xMxL38HinAJWEpN2XWCCqBGU
 ODnzCQvESHmJ5q2zwU6QEJjKITHjzUkmiGYXiTnPPrJA2MISr45vYYewpSRe9rdB2cUSv+4c
 hWruALq/YSZUg73ExT1/wQ5lBvpl/S59iGV8Er2/n4CFJQR4JTrahCCqFSXuTXrKCmGLSzyc
 sQTK9pD4uXwJNEB7GSVWrjnNNIFRfhaSH2Yh+WEWwrYFjMyrGCVTC4pz01OLTQuM81LL9YoT
 c4tL89L1kvNzNzGCE5KW9w7GRw8+6B1iZOJgPMQowcGsJMLrNqUkQYg3JbGyKrUoP76oNCe1
 +BCjNAeLkjjvDoMH8UIC6YklqdmpqQWpRTBZJg5OqQamsMhlfkf9d5+/d3/ZoSIBL6EdnU8j
 hRcfvRS02mi92g6tdeIfHmXta5nesf2dcJBDs0f+ikVe4k8fTn7pJVh1YNWUeb1tz8OP+PjM
 XOHEKvTO8aPyoplfQuZnmx1KnBX8bm9f03uR7sQ8rhyVaer+W1deXfWh4LaK2p8jNUrPlVPn
 Z5oENV1fvLP2ZfOyxXmZSofW5pVd2F51vONoTOybLZ8T/spOt/r/MdFiwvl115qO1fSpWj/O
 bqo17jI7vWL6kQyfW2onvYw3r6ut56lu0Jc7nC/1/1pSz/K4eRmbqt6JrRBaxDUnPauBf7JQ
 +OqZ20UD7Pd5qjFItla48U7Z0iTBxtja0qxxxGP9/OBIJZbijERDLeai4kQA0YL8h7cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnO7vqrIEgxU3NSyaJvxltlh9t5/N
 Ytbt1ywWK1cfZbI4+v8tm8WkQ9cYLeYve8puse33fGaLK1MWMVuse/2exeL1j5NsDtwe5+9t
 ZPG4fLbUY9OqTjaPzUvqPXbfbGDz6NuyitGj/UA3UwB7FJdNSmpOZllqkb5dAlfGyburWAq+
 8lZsPfiPuYHxGXcXIyeHhICJRMOSw+wgtpDADkaJzVP9IeLiEs3XfrBD2MISK/89B7K5gGo+
 Mkos/rmerYuRg4NNQFPiwuRSkBoRgQyJ86daWUDCzAKeEusnyoOYwgIOEut/uYBUsAioSqzv
 bAGbyCtgKXHh1EdmiOnyEjMvfQeLcwpYSUzadYEJ4hpLiWtbJjFC1AtKnJz5hAXEZgaqb946
 m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIER4KW1g7GPas+
 6B1iZOJgPMQowcGsJMLrNqUkQYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6Yklqdmp
 qQWpRTBZJg5OqQYmhQvFqec4TZyOnhBtS3beFeQqcOWlk4b874TuecrWfYbTz/yL4nv0fGnK
 qw02m0Ks3p3SOvnsWPrBHt2obdzPD3ctytsjGdO9e3fUyT9z83rPaqTMehP99CrH5jankMPP
 m1dsu6D18cjjytt8W7ZbZsrGbBUTaDtiNsfH46cH0/UUuQ936g7Lx9zcs6/t/W7rRbsDTgas
 XNmjIr+b7+/1rf3LLV8u23l6nlB68jyND/7zXirvYZ3Yw/fPwf39erlnE55knvf9eaDxV91O
 sXaBA4sqr77a99UkeEr9381S3zze/vy104+RK6Ztgk+ffkfO4xIhe75w/blXJKpnLueXXHpp
 HZ9/Tldx9oppn9PfrlFiKc5INNRiLipOBACVwcyv8wIAAA==
X-CMS-MailID: 20210414051747epcas5p265826317a971aaa3337efb6472a9df7c
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210414051747epcas5p265826317a971aaa3337efb6472a9df7c
References: <20210414051629.103383-1-joshi.k@samsung.com>
 <CGME20210414051747epcas5p265826317a971aaa3337efb6472a9df7c@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_221755_435116_DA576344 
X-CRM114-Status: GOOD (  14.46  )
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

nvme_clear_nvme_request() clears the nvme_command, which is unncessary for
passthrough requests as nvme_command is overwritten immediately.
Change nvme_clear_nvme_request() so that double memset for passthrough
requests is avoided.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea5b40e469d6..5f6b742aa32c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -583,14 +583,13 @@ void nvme_put_ns(struct nvme_ns *ns)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
 
-static inline void nvme_clear_nvme_request(struct request *req)
+static inline void nvme_clear_nvme_request(struct request *req, bool clear_cmd)
 {
-	struct nvme_command *cmd = nvme_req(req)->cmd;
-
-	memset(cmd, 0, sizeof(*cmd));
 	nvme_req(req)->retries = 0;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
+	if (clear_cmd)
+		memset(nvme_req(req)->cmd, 0, sizeof(struct nvme_command));
 }
 
 static inline unsigned int nvme_req_op(struct nvme_command *cmd)
@@ -610,7 +609,7 @@ static inline void nvme_init_request(struct request *req,
 	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
 
 	req->cmd_flags |= REQ_FAILFAST_DRIVER;
-	nvme_clear_nvme_request(req);
+	nvme_clear_nvme_request(req, false);
 	memcpy(nvme_req(req)->cmd, cmd, sizeof(*cmd));
 }
 
@@ -900,7 +899,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	blk_status_t ret = BLK_STS_OK;
 
 	if (!(req->rq_flags & RQF_DONTPREP))
-		nvme_clear_nvme_request(req);
+		nvme_clear_nvme_request(req, true);
 
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
