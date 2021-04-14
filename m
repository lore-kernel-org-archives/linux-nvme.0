Return-Path: <SRS0=IcOG=JL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E08C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 05:18:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0027761153
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Apr 2021 05:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0027761153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4G6M5Wdz5LMynfLOmr8RkXHYzDiLM4uutNumbzsjoYA=; b=rDepk2bjUgxsxTDBY7Y7/26H4
	BAWs09b2skN4Bv/akuDWmcIuTxXcaDac9d5CKr47naburREJL/mLS3AjdldZJ/xlle7FWorgyy11Q
	83367pJamXTOQBZYBhEemZrarcB/1pP/9BdEEo4V/KgNhwqVjkDq05yxhdoAHKG98bHFLM80atZx7
	tDW0EXorEk7VPE4VYBkSNxg84+yD9m/gIngdupeHCKvl4r1im2nD3mgmYgNCBAGR1j9hfJmY5u4wl
	KOtHKljXL44YDITz52E8Lmp1A5rB75ujkdj+C/PLzQ4MaPB/MR/4Kub1mQHHtYtz5DUhep6BwrQo1
	zPDaNV0Mg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWXuo-00BVZj-1A; Wed, 14 Apr 2021 05:18:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWXuY-00BVZ4-0G
 for linux-nvme@desiato.infradead.org; Wed, 14 Apr 2021 05:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:Content-Type:
 Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
 :To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=NWiGJM3MplND13oIhp4R/pDSSzRqiIwgcfrq2mp8CpA=; b=XzOoM9914lluWSit0ly5ZIXt1l
 GPq/DlYSXZ7eaKpdRyRDl+Qltr8VpIKJVEHQTqOpR3xtDhf0t2gYm1AfK0WIIZELSJ1+PY3zTteZ4
 J/rFT6KXO0VLqR0+tVhod8QbfAAIlrcuzze3ZDodY03lBx+J7vFDjii9VyPXrBhSkc3hY3g+8Ujfl
 eOFy+muY28Z+6/KApHh65V5zVyKRXEQ8W0XtZZG8HohMqkU5AHq9AZh7lYZYt10tfv7MkkCmyA20H
 Xth4s0qiNYBNIebZyDMcuoBsu1lTn3GgZC3G71KykovDFQ0O/kp38vl35KWOciZEHS+ZCaXJba2Ov
 8QergoIA==;
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWXuV-007UUN-14
 for linux-nvme@lists.infradead.org; Wed, 14 Apr 2021 05:17:56 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20210414051745epoutp042101a61077b51b0aaa5a22066a47803a~1obr0l7iR3098430984epoutp04Z
 for <linux-nvme@lists.infradead.org>; Wed, 14 Apr 2021 05:17:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20210414051745epoutp042101a61077b51b0aaa5a22066a47803a~1obr0l7iR3098430984epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1618377465;
 bh=NWiGJM3MplND13oIhp4R/pDSSzRqiIwgcfrq2mp8CpA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hlzYZEw92liTBTZG2Kvk7+ue7NqmYN0N95qRBAxXp69tK7m3x/y+DWG95GsFmKlOz
 3jNgJiW6KflRMy3jFGiEOZhA8eVSW0EsKcbByXnSKZ3gUVE6LAi+6xGaW+Nqp84Ncd
 YnGsOpP2YgY9Gv6s8goRVD7tu5tNYInYRlLVONyA=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTP id
 20210414051744epcas5p338bc3db81861b5664c74fec39485e594~1obq_cgsV1454814548epcas5p3-;
 Wed, 14 Apr 2021 05:17:44 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 39.92.15682.8FA76706; Wed, 14 Apr 2021 14:17:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20210414051743epcas5p3f5371b68b066e5093d91f598b0803e9c~1obpvIHwT1675616756epcas5p3y;
 Wed, 14 Apr 2021 05:17:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20210414051743epsmtrp15883c17ba56837f765a6f23ed5a9f122~1obpuXamK0782207822epsmtrp1g;
 Wed, 14 Apr 2021 05:17:43 +0000 (GMT)
X-AuditID: b6c32a49-8bfff70000013d42-cf-60767af859bc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 E7.9D.33967.6FA76706; Wed, 14 Apr 2021 14:17:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20210414051741epsmtip1294d5cd998957ca5a42302dccba4816c~1oboGDgL82204722047epsmtip1k;
 Wed, 14 Apr 2021 05:17:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/2] nvme: add nvme_get_ns helper
Date: Wed, 14 Apr 2021 10:46:28 +0530
Message-Id: <20210414051629.103383-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414051629.103383-1-joshi.k@samsung.com>
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7bCmhu6PqrIEg74+SYumCX+ZLVbf7Wez
 mHX7NYvFytVHmSyO/n/LZjHp0DVGi/nLnrJbbPs9n9niypRFzBbrXr9nsXj94ySbA7fH+Xsb
 WTwuny312LSqk81j85J6j903G9g8+rasYvRoP9DNFMAexWWTkpqTWZZapG+XwJUxd/Ex9oIv
 XBVvFpxka2Bs5exi5OCQEDCReLsnoouRi0NIYDejxNbzT1ghnE+MEp3v7zFBON8YJZY/Pc/e
 xcgJ1vFmZzM7RGIvo8TMDV3MEM5nRolP86cxg8xlE9CUuDC5FKRBRCBJoulFExOIzSzgLnH7
 SQ+YLSxgKLHjywMwm0VAVWLm91vMIDavgKXE9Dd32CCWyUvMvPQdbDGngJXEpF0XmCBqBCVO
 znzCAjFTXqJ562ywGyQEejkkzj3uZ4H4zUXi0KMYiDnCEq+Ob4F6QEriZX8blF0s8evOUaje
 DkaJ6w0zWSAS9hIX9/xlApnDDPTL+l36ELv4JHp/P2GCGM8r0dEmBFGtKHFv0lNWCFtc4uGM
 JVC2h0TTmzPQ4OlllNh1bAX7BEb5WUhemIXkhVkI2xYwMq9ilEwtKM5NTy02LTDMSy3XK07M
 LS7NS9dLzs/dxAhOSFqeOxjvPvigd4iRiYPxEKMEB7OSCK/blJIEId6UxMqq1KL8+KLSnNTi
 Q4zSHCxK4rw7DB7ECwmkJ5akZqemFqQWwWSZODilGpi05hpExBjnK9w8fFzQ4cPrj4F7dlv4
 9gt7v7az+1KRITaj53Lb/W6rbbMELxb9Tvb0Z7tT+Yv//wMjmeCUN05Hvit4dDW1lbhl/75h
 u+akjyWvYO+Hs9PcrghGy39NETNfnJrLKCha/Z3lg6H8fLdtngIvFpy/Fx+0KNbBclFV7Qm2
 tXH+Zxf8cQ7quWdkyWa0iqfmmZysQtylHYed1vnz+QuYMhi7GZ3adX3Ruubnebeu2RyNDJmu
 kL+qMJFJ48y+jdzTetUutB4TLm/lZZ1/9hNL3Bc5w+OCgVriwn/nHHeOWqjCFDU5exHfsmV7
 Lpwr0ay4vHjO5vtbp89l1VXffcHw8HN1xY9C6qvfGyixFGckGmoxFxUnAgAlb7wItwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnO73qrIEg3WLmC2aJvxltlh9t5/N
 Ytbt1ywWK1cfZbI4+v8tm8WkQ9cYLeYve8puse33fGaLK1OAite9fs9i8frHSTYHbo/z9zay
 eFw+W+qxaVUnm8fmJfUeu282sHn0bVnF6NF+oJspgD2KyyYlNSezLLVI3y6BK2Pu4mPsBV+4
 Kt4sOMnWwNjK2cXIySEhYCLxZmczO4gtJLCbUeLnIRaIuLhE87Uf7BC2sMTKf8+BbC6gmo+M
 Eo+nfARyODjYBDQlLkwuBakREciQOH+qlQUkzCzgKbF+ojxIWFjAUGLHlwdMIDaLgKrEzO+3
 mEFsXgFLielv7rBBjJeXmHnpO9gqTgEriUm7LjBBnGMpcW3LJEaIekGJkzOfgJ3GDFTfvHU2
 8wRGgVlIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOBS3NHYzbV33Q
 O8TIxMF4iFGCg1lJhNdtSkmCEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NT
 C1KLYLJMHJxSDUy2x/R29P96fDFsyy1Lnp/HBMPOTP+24+FWi9oH7+0KNeccjMoP4bu8sXz2
 B+X/MilvjudN/DfPVejHF8E3cx8paDb9uJjJuiW7beXisoVGAvM0iyNuvr2inPE/ypB/s7CZ
 Fv+D51uPXp2/5KPJfSAI/FcZOLfzw9qA2GcnlHilGq++KZk4+SCTN9v/16Z91y9z3bJ59vF6
 3MWgLJvKPQZz98WoChc+7XFkeMHZoyv/NSI7WPbTpI4Tk2/l62zzqNz06XTgmSQZxidB7xUZ
 T518Wcv7TPLM/tQzPxar7Dm2JC+7doNIjJxK/nO/C3IVDuJ3BQtiK+7w1zr0etonuVgsM98c
 dCH4kJqWWtkmJSWW4oxEQy3mouJEACeEP4v0AgAA
X-CMS-MailID: 20210414051743epcas5p3f5371b68b066e5093d91f598b0803e9c
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210414051743epcas5p3f5371b68b066e5093d91f598b0803e9c
References: <20210414051629.103383-1-joshi.k@samsung.com>
 <CGME20210414051743epcas5p3f5371b68b066e5093d91f598b0803e9c@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_221755_454210_672F6AB2 
X-CRM114-Status: GOOD (  14.38  )
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
---
 drivers/nvme/host/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 288ac47ff5b4..ea5b40e469d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -572,6 +572,11 @@ static void nvme_free_ns(struct kref *kref)
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
@@ -1489,7 +1494,7 @@ static int nvme_ns_open(struct nvme_ns *ns)
 	/* should never be called due to GENHD_FL_HIDDEN */
 	if (WARN_ON_ONCE(nvme_ns_head_multipath(ns->head)))
 		goto fail;
-	if (!kref_get_unless_zero(&ns->kref))
+	if (!nvme_get_ns(ns))
 		goto fail;
 	if (!try_module_get(ns->ctrl->ops->module))
 		goto fail_put_ns;
@@ -3544,7 +3549,7 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
