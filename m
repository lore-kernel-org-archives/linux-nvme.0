Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B9BC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 07:10:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1893661076
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 07:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1893661076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KpoX/e8lE+CTQI74MlLZJ//myU3e+IlG7gmUfQX339c=; b=OS7ClFxwE3quPnUzrUoVwTSkD
	HgQG4WI2WeCIRlsWBhJ08cPLvRH3bsUHVETBmoj4DgRLflny1zWTLsnCYAXihBOcAIJpaNO94cxaa
	g+0zdZiUxqRz1j1Kgp9obW5zvrNOxe0xwd4Cc+f1A2QAxPUd5sH9DYQrVr0l/47mEK/J+Evq4cfZz
	PYRDqCx8MGwHqPLb5bxyDtM6HhFq2B+u9tu5vC3Jcs6UV4RFI+HJoOJ9YewmYLKkAFnIvZ0x2ej3I
	O4HFAidQ3ysZUYAmsy/K0VBQrkX/Yp1P8fWw+xNpwfa7draBScHxDwrponTdCWP450B6CeJ4Ku2cb
	/KRA2orUQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbHrm-000vf2-6O; Tue, 27 Apr 2021 07:10:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbHqY-000vSR-Rc
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 07:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=ENtXsr/nuS6nUr8nLfBq53eYuIjDJ/Zhylma/XJfA0M=; b=o61ci5OA2giAqTDRxbjaIXpRVe
 Pt53DYLSrpyG3i49cXl7NKSPUPR4+5KGXN6Rh6NeaEkfjdsyJiR4v9zFRyb7/wwtIhmJtZH577w+d
 YrBXXa/7a9b40kTQu80GvA+smrxVvcV7xgJ1pMz7Vt7RDu/kWdaJhFAUwMk2TJfEslc7T/By6iZuB
 4Xaagt4LthPqfChpmzw2Q3qZfKjESmOt7OWgvhfEP/Qw2zkZRAImxknofpXsv0KNtvm1cAMXpUwuc
 M9v9/CZB9hNUqSvirtC92g5hu3Sx5DbrDwfBeqr05dn4S1Wr6LK5m4nq2OAH8ogdqywDcpN2NcSdH
 4zQi1Ttw==;
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbHqV-00GUfN-02
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 07:09:25 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210427070919epoutp0463f56014913477de68488bfbbe60ed94~5pVztcssL3183631836epoutp040
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 07:09:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210427070919epoutp0463f56014913477de68488bfbbe60ed94~5pVztcssL3183631836epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1619507359;
 bh=ENtXsr/nuS6nUr8nLfBq53eYuIjDJ/Zhylma/XJfA0M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P/IFrr0JUCe2VjIQl2wlEq8MxhQRVHEQt+RmzffomB577YgPBciSWimuvLMJTRVGS
 4Z9oxh3LMcUsZLU7q0ljqiOC4oBD3fAYPuyjcWWqaPmirpXKxoKiDuBWo9pAata+9m
 0mO7mgD8dVm49LthkVqEds75FLgZEafr1QkCELUU=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20210427070918epcas5p4eec2411a5259e21797aaecccc3f2eae0~5pVzAlN_Z2359023590epcas5p4t;
 Tue, 27 Apr 2021 07:09:18 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
 epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 B4.B1.09697.E98B7806; Tue, 27 Apr 2021 16:09:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210427064858epcas5p316a9a67eee1e49fe0d21351aee8a9704~5pECYPGZt0174901749epcas5p3O;
 Tue, 27 Apr 2021 06:48:58 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210427064858epsmtrp1a7c56e6e719cd83ee0d0f733870602d0~5pECXWULR0906509065epsmtrp1C;
 Tue, 27 Apr 2021 06:48:58 +0000 (GMT)
X-AuditID: b6c32a4a-64fff700000025e1-b7-6087b89e3e6d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 34.0F.08637.AD3B7806; Tue, 27 Apr 2021 15:48:58 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210427064856epsmtip109dc23918b703c49cd2c95e34429a852~5pEA2oTSS2337223372epsmtip1Z;
 Tue, 27 Apr 2021 06:48:56 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, chaitanya.kulkarni@wdc.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v3 2/2] nvme: avoid memset for passthrough requests
Date: Tue, 27 Apr 2021 12:17:47 +0530
Message-Id: <20210427064747.5988-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427064747.5988-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7bCmpu68He0JBnN7dS2aJvxltph1+zWL
 xcrVR5ksjv5/y2Yx6dA1Rov5y56yW2z7PZ/Z4sqURcwW616/Z7F4/eMkmwOXx/l7G1k8Nq3q
 ZPPYvKTeY/fNBjaPvi2rGD3aD3QzBbBFcdmkpOZklqUW6dslcGX03n/NUjCLq+L4gR1sDYwn
 OboYOTkkBEwkdvQ/Z+9i5OIQEtjNKHF4xS42COcTo0Tbo1lQzjdGiVnNexhhWmZsmQGV2Mso
 0bB4PSuE85lRYumjL0AZDg42AU2JC5NLQUwRgUCJU4+lQXqZBdwlbj/pYQKxhQWcJR60QNgs
 AqoSGy73gc3nFTCXODf/KDPELnmJmZe+s4PYnAIWEt+WPmeGqBGUODnzCQvETHmJ5q2zmUFO
 kBDo5JCYv/4HVLOLxMnvH9ghbGGJV8e3QNlSEi/726DsYolfd45CNXcwSlxvmMkCkbCXuLjn
 LxPIA8xAv6zfpQ8RlpWYemodE8RiPone30+YIOK8EjvmwdiKEvcmPWWFsMUlHs5YAmV7SJw6
 vBca1t2MEpeuvWKfwKgwC8lDs5A8NAth9QJG5lWMkqkFxbnpqcWmBUZ5qeV6xYm5xaV56XrJ
 +bmbGMGpSctrB+PDBx/0DjEycTAeYpTgYFYS4WXb1ZogxJuSWFmVWpQfX1Sak1p8iFGag0VJ
 nFfQuTpBSCA9sSQ1OzW1ILUIJsvEwSnVwNQz651tQnuKgeeEN595un946h/Xi0y963+w3OPZ
 3lB9EaWnXW1zLK7N/dL/onOGwtt1T6ZIzV+sbMAaEihwdlNXPaPPfLvD7doPZGrqqv7PKv/T
 qnpLkufea3c2nbkHJO9FzohR2mbFnvWGw++T1oOgy9fSo6SP/J5zdvuWk4pl347+7Ht/5JXS
 VQs2FwGh+8IZrm01XgZ56eu6tp6uq3LuKC1ueqvqF6NwvDqgJGa+4tcbbSJTzvlbL0qTWK8+
 ZU65UO2MeRkvBVanhK2x+LNGrCZ65zT1+1Z1sr5S63498PviKLf6fYlIePe/zvaju0/Od3+y
 cbfd/qlxTj2Z8r7LNR66cH8tjlnHoPB2gxJLcUaioRZzUXEiAOoNuVG8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSnO6tze0JBvN+81k0TfjLbDHr9msW
 i5WrjzJZHP3/ls1i0qFrjBbzlz1lt9j2ez6zxZUpi5gt1r1+z2Lx+sdJNgcuj/P3NrJ4bFrV
 yeaxeUm9x+6bDWwefVtWMXq0H+hmCmCL4rJJSc3JLEst0rdL4Mrovf+apWAWV8XxAzvYGhhP
 cnQxcnJICJhIzNgyg62LkYtDSGA3o8Ty691MEAlxieZrP9ghbGGJlf+es0MUfWSUuHtuAXMX
 IwcHm4CmxIXJpSA1IgKhEsvfTmMBCTMLeEqsnygPEhYWcJZ40NIDNpJFQFViw+U+RhCbV8Bc
 4tz8o8wQ4+UlZl76DraKU8BC4tvS52BxIaCavktPmSHqBSVOznzCAmIzA9U3b53NPIFRYBaS
 1CwkqQWMTKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYJDX0tzB+P2VR/0DjEycTAe
 YpTgYFYS4WXb1ZogxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
 B6dUA1POAxWV7LJzX1s/b/v96+LmvsQ/DK91TcvWL2ZYrXg3RfLX9WXvXs7KC3Mufx98uonh
 6bNvi7maGe8ev1XiuyLtRfPciex9M7bGyOteP703Xpb1rMOR03u0lrRviW7U43RnPnV6/g5m
 48xPr88s6Ss26bSrvPysNiw51v+Wh3GFwqKuG+9fH73Ondbd8PCS5R2X8num/JtsfvWqts8V
 1dPNfrxhvdeNxE2PAxM3Lbt3MFlr80rVbV3rzx9X6PhcaSK9vGXD+/vnNhs+Vs24nXPwar5y
 /VXfsr3dM64E3Pl4tP3YNqPA/i41hwX1iSJvW1f/f2s2P5zXuJ2Jz9jV55uqzpGXeqZLpxZV
 FKdtr3qrxFKckWioxVxUnAgAs7Abz+wCAAA=
X-CMS-MailID: 20210427064858epcas5p316a9a67eee1e49fe0d21351aee8a9704
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210427064858epcas5p316a9a67eee1e49fe0d21351aee8a9704
References: <20210427064747.5988-1-joshi.k@samsung.com>
 <CGME20210427064858epcas5p316a9a67eee1e49fe0d21351aee8a9704@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_000923_398215_FA641DCD 
X-CRM114-Status: GOOD (  13.92  )
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

nvme_clear_nvme_request() clears the nvme_command, which is unncessary
for passthrough requests as nvme_command is overwritten immediately.
Move clearing part from this helper to the caller, so that double memset
for passthrough requests is avoided.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f6d7c397f2ee..9ac28fcafbac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -589,9 +589,6 @@ EXPORT_SYMBOL_NS_GPL(nvme_put_ns, NVME_TARGET_PASSTHRU);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
-	struct nvme_command *cmd = nvme_req(req)->cmd;
-
-	memset(cmd, 0, sizeof(*cmd));
 	nvme_req(req)->retries = 0;
 	nvme_req(req)->flags = 0;
 	req->rq_flags |= RQF_DONTPREP;
@@ -903,8 +900,10 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	struct nvme_command *cmd = nvme_req(req)->cmd;
 	blk_status_t ret = BLK_STS_OK;
 
-	if (!(req->rq_flags & RQF_DONTPREP))
+	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_clear_nvme_request(req);
+		memset(cmd, 0, sizeof(*cmd));
+	}
 
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
