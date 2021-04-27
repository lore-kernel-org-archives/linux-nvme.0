Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A89C43460
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 07:10:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65ACF611ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 07:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ACF611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W1kBaoMTGqlSNJSWqJnWlD74HMLrp2mF473YVx4habo=; b=QeFFHWoEv3omNdRTIdydCIdVD
	SraA7jaAEUSD8HRcFNF5WR2A9/vCxfpYuuelvPyQKpifGkA1an0AWhFKLV5TEENumHLbDyPyNAC2Y
	Pw3hqWT69siCDJtcf+f/iqfCiXL+CSlqkzE9lTiZJXjOlhQlDKMVVCsEblz5p256sRrx15gezYPLm
	TbnMxqot9OF4VpKs9agLH26pNaqJS9ZiAASwmSJdPEdFglYeqRYtmqrG74NJnh1qcmaELYZN1eUL/
	AD6ogv/CMTNfj1w9hIyV2YnaJ6b6sGPqpmWrUa2QjNED+S8G1IrLPIl1yIfWYS+VnoaL1+JEpKpmm
	gWuVMiUsA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbHrP-000vaj-Qh; Tue, 27 Apr 2021 07:10:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbHqY-000vSQ-Pp
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 07:09:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=0ECWt3iOYEqdEc4tzsgrEgX5PlYnOc7Sxm2EJcwtAA0=; b=qwDLVN2SCQyInjlEINOWX9RlxS
 MBz9UaV+flIe4E4QgJ+3cVl/NqEWe3ycin+tqby3XPkP7jzx92IlvMzLtyKJ7S1k34G6CJ+menxTp
 d3u+TRzb7LOsf8LdDXinUfgmR8zCKAtFIpWpb92sO3pEiorc7OTPThI3bKXi9rh6YreWgMPZyN9AN
 K/HQSY7W9vgk7pD3FmNVwqySwTr9xY3PQs24IDEqFYCCKnUHoe9JfDLeLrJSZ7yb8VfwF42lYFfy3
 ZHtACKFSaxIJvmregHakqLKYRDkIGOGr2+cpbbRxlZ5+UWWkoAvvtyclDxutxxnNyr25gzwNaKJOf
 53C6H5UQ==;
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbHqV-00GUex-02
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 07:09:25 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210427070910epoutp0401f81c25a279284e22db2001bface269~5pVrF-H8f3069630696epoutp04d
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 07:09:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210427070910epoutp0401f81c25a279284e22db2001bface269~5pVrF-H8f3069630696epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1619507350;
 bh=0ECWt3iOYEqdEc4tzsgrEgX5PlYnOc7Sxm2EJcwtAA0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dyq8iZHx+1MC/wwRxGCYoMP+g6mz1Ar6PCMOXRMnskfEV2xl4KFeFgHCuyIZ4eLSC
 gAZpC3WBt9uo7Qh3w1mE6n+SIc9ildIMFdHSK9m5SAlacaAl5rHFENwr9W/FPucPP0
 6BS1eKs26M1pkTAmTfCGeg1+JYqg5IoGK4FswSlk=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTP id
 20210427070909epcas5p1b14056330ddc3b7f42b5ca1a878c0881~5pVqZa2in1281512815epcas5p1N;
 Tue, 27 Apr 2021 07:09:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 17.37.09606.598B7806; Tue, 27 Apr 2021 16:09:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210427064854epcas5p3fe76f88cc1e2b86f1f1ec69101fb04ab~5pD_3Z5K-1995719957epcas5p3b;
 Tue, 27 Apr 2021 06:48:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210427064854epsmtrp1c8c3d58dee2931de5390165de79ff4dc~5pD_1U5_c0877408774epsmtrp1t;
 Tue, 27 Apr 2021 06:48:54 +0000 (GMT)
X-AuditID: b6c32a49-bf1ff70000002586-70-6087b8958541
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 D0.0F.08637.6D3B7806; Tue, 27 Apr 2021 15:48:54 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210427064852epsmtip1aa4edba6d2c8662c5ece00b2312deca9~5pD9WmaWr2337223372epsmtip1Y;
 Tue, 27 Apr 2021 06:48:52 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, chaitanya.kulkarni@wdc.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v3 1/2] nvme: add nvme_get_ns helper
Date: Tue, 27 Apr 2021 12:17:46 +0530
Message-Id: <20210427064747.5988-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427064747.5988-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7bCmuu7UHe0JBnua5CyaJvxltph1+zWL
 xcrVR5ksjv5/y2Yx6dA1Rov5y56yW2z7PZ/Z4sqURcwW616/Z7F4/eMkmwOXx/l7G1k8Nq3q
 ZPPYvKTeY/fNBjaPvi2rGD3aD3QzBbBFcdmkpOZklqUW6dslcGUcuytdsIm7YsXayUwNjPs4
 uxg5OSQETCQezr/GBGILCexmlNjYLdvFyAVkf2KUWLPzKDOE841R4urHqUBVHGAd1y4KQ8T3
 MkosPLWKHcL5zChx890iNpAiNgFNiQuTS0FMEYFAiVOPpUEWMAu4S9x+0gO2TBhozLaTX1lB
 bBYBVYnrJy8yg9i8AuYS7YemMEIcJy8x89J3dhCbU8BC4tvS51A1ghInZz5hgZgpL9G8dTbY
 nRICjRwSs39+YYFodpFYfWA+O4QtLPHq+BYoW0riZX8blF0s8evOUajmDkaJ6w0zoZrtJS7u
 +Qv2MDPQL+t36UOEZSWmnlrHBLGYT6L39xMmiDivxI55MLaixL1JT1khbHGJhzOWQNkeEu/f
 P2OFhFU3o8TbXV+YJzAqzELy0CwkD81CWL2AkXkVo2RqQXFuemqxaYFhXmq5XnFibnFpXrpe
 cn7uJkZwUtLy3MF498EHvUOMTByMhxglOJiVRHjZdrUmCPGmJFZWpRblxxeV5qQWH2KU5mBR
 EucVdK5OEBJITyxJzU5NLUgtgskycXBKNTB1rjT//tZ5zm+Hnrsv5vbHS05IjpjKtW7j0QRp
 JbOT0kG+Cgfe3/vicPCKeaNZ2T/Bo6sLVtl2hX1YOU0rKHcS0+6ya7efzTJaMHe96beX6j3f
 vAXeuB0Xu2q0bXvAMsf6sLaJy3ndji9kXrDfQbBYo1Xtzp7mNW8mTjzjvE7MMX7j5b2sXVdL
 5j0R93n64903LvnX+74JWr1121Xlf6k49rpZhf23r6aVdycwno/vPRW67jLPji0h6srXu+vf
 vpWJPsL04UHtdS7zW/+6r8p++izFUC1a2W1+2Gilzq+47TpWf7Obbs92ingwX3Thzfpg0+c9
 zmsmFTXOKZ39OtNPbsGk6d7Oqmwif2fqnXFyUGIpzkg01GIuKk4EAE6I4Kq5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSnO61ze0JBo9vS1k0TfjLbDHr9msW
 i5WrjzJZHP3/ls1i0qFrjBbzlz1lt9j2ez6zxZUpi5gt1r1+z2Lx+sdJNgcuj/P3NrJ4bFrV
 yeaxeUm9x+6bDWwefVtWMXq0H+hmCmCL4rJJSc3JLEst0rdL4Mo4dle6YBN3xYq1k5kaGPdx
 djFycEgImEhcuyjcxcjFISSwm1Fi6vmDjF2MnEBxcYnmaz/YIWxhiZX/nrNDFH1klOje/okR
 pJlNQFPiwuRSkBoRgVCJ5W+nsYCEmQU8JdZPlAcJCwON33byKyuIzSKgKnH95EVmEJtXwFyi
 /dAUqFXyEjMvfQdbxSlgIfFt6XOwGiGgmr5LT6HqBSVOznzCAmIzA9U3b53NPIFRYBaS1Cwk
 qQWMTKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYLDXktzB+P2VR/0DjEycTAeYpTg
 YFYS4WXb1ZogxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dU
 A9PlS39sWa8o2k3bnvyi+gOz7BtnldamuMJLW9fwuixnFFkZN30dY92L/2dvr9aZKcfTeabO
 Zou7vePSg0/Zl9q/0/jwh73gn7XbyYJ/UlkH81/vTTtSISzDdrCz8B+fuMiDJa6zxPQllUNq
 H3QsP7I8+tctZguX8jfSdyKbmzIt1zdxxrAm8fOs3nZxWbzo5lcCgZuW/vNiizXb091n/fKF
 SqVSDp9eaf/cVxPtMx868kou5HV1n9VTqPz2aqlYQGn4jBknJFhn1fq+CtITO31w5pI36ffs
 vJo+yu+dqLZowhovuzeTbwbcCLzXmrU3Uf4Nn7/tlVa9tiNCwaxvF2xP6Qg+XaDZkfix21RN
 V4mlOCPRUIu5qDgRABorC17qAgAA
X-CMS-MailID: 20210427064854epcas5p3fe76f88cc1e2b86f1f1ec69101fb04ab
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210427064854epcas5p3fe76f88cc1e2b86f1f1ec69101fb04ab
References: <20210427064747.5988-1-joshi.k@samsung.com>
 <CGME20210427064854epcas5p3fe76f88cc1e2b86f1f1ec69101fb04ab@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_000923_436534_5DAFDD30 
X-CRM114-Status: GOOD (  13.86  )
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

Add a helper to avoid opencoding ns->kref increment.
Decrement is already done via nvme_put_ns helper.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2f45e8fcdd7c..f6d7c397f2ee 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -576,6 +576,11 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
+static inline bool nvme_get_ns(struct nvme_ns *ns)
+{
+	return kref_get_unless_zero(&ns->kref);
+}
+
 void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
@@ -1504,7 +1509,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
 	/* should never be called due to GENHD_FL_HIDDEN */
 	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
 		goto fail;
-	if (!kref_get_unless_zero(&ns->kref))
+	if (!nvme_get_ns(ns))
 		goto fail;
 	if (!try_module_get(ns->ctrl->ops->module))
 		goto fail_put_ns;
@@ -3613,7 +3618,7 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->head->ns_id == nsid) {
-			if (!kref_get_unless_zero(&ns->kref))
+			if (!nvme_get_ns(ns))
 				continue;
 			ret = ns;
 			break;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
