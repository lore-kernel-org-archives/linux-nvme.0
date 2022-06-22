Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13A5CCA47D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFlyfKRVMdPmSJYFb4HJbjx3JXgjlRCIl94brJ6Ls/0=; b=VkPoITH+3a31vfr5UV4Wbps51c
	aMLsL0xlSkk182aUrr/ZQ7eKw5YvQBzJmRwKie2RvDrPpdX/LJ0/uACRs1Biteb0P+8xGWCbs4xzp
	fEA3YPRsfp+oYrO0MJ7RLFY9gpjzSwOfalME3e7CM0iwP50OOzOJPlGnQTQd0ySxAec99utVJoXUH
	uI0GQZGZbmqCzU6Oaervd6p7l392ubo8u6fE4llQT8bEdwINLQ2DVdkL7P1amwZKcJFD7fA9pRXeA
	GvxpuqIDlgth19nJxXv5ZbuAnZ349dcLjC6t4E1Nm5OIyjpGOKfMrdMeXENBiYdAmMMxw5lEznNkU
	MVTr4ITg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3w5J-009MH2-GA; Wed, 22 Jun 2022 08:51:37 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3w59-009MFd-RD
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 08:51:31 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220622085124euoutp0209975bb87ab44db75f20fc49cebeb662~65UITCwOZ1813718137euoutp02i
	for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 08:51:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220622085124euoutp0209975bb87ab44db75f20fc49cebeb662~65UITCwOZ1813718137euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655887885;
	bh=qFlyfKRVMdPmSJYFb4HJbjx3JXgjlRCIl94brJ6Ls/0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=WSBSYfPxmpqLyofnmW/ITKjameGXWv1hvpWmW4l20iNpmTCkZTIJ0ZSotzinY3FEO
	 iuP9O9rqI7+ZHesLNxIHqrnM7YDMOOuklDiE3pbzJlzbyomj2A52S1DjXKLxu/RiZm
	 0CvdNx7dYp0A/dVjdbbFasvFeLJ1n2EquTZGtEcc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220622085124eucas1p2087c64e886bbd0380ec3b9ae6decd1c1~65UIMJiGV2752627526eucas1p27;
	Wed, 22 Jun 2022 08:51:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 71.06.09580.C08D2B26; Wed, 22
	Jun 2022 09:51:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220622085124eucas1p24243c811046ef1da9d10212077ac8cc0~65UHw1Yhc2763127631eucas1p2Q;
	Wed, 22 Jun 2022 08:51:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220622085124eusmtrp2eae605691f9be938ccc5344a3a38dbd8~65UHwFmXB0824208242eusmtrp2q;
	Wed, 22 Jun 2022 08:51:24 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-9c-62b2d80c1386
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.A6.09095.C08D2B26; Wed, 22
	Jun 2022 09:51:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220622085124eusmtip186aac44a4782735f76b50d51c84684e0~65UHnKSf30900009000eusmtip1B;
	Wed, 22 Jun 2022 08:51:24 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 22 Jun 2022 09:51:23 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, Joel Granados <j.granados@samsung.com>
Subject: [PATCH 1/1] nvme: Remove unused enum constants
Date: Wed, 22 Jun 2022 10:48:59 +0200
Message-ID: <20220622084859.1937878-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220622084859.1937878-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7djPc7o8NzYlGbxq1bFYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR3HZpKTmZJalFunbJXBl3P56l7XghETF9LtNbA2M
	J4S7GDk5JARMJM496GDqYuTiEBJYwSix/+QXVgjnC6PEzK9zoZzPjBLdB78xwbScerCcDSKx
	nFHi0Y3pLHBV27cfYIZwNjNK7G59wA7SwiagI3H+zR2gBAeHiICqxL4WW5Aws4CPxM9ph5lB
	bGEBc4nlD6cxgtgsQCX3X/WBxXkFbCW62h+yQWyWl2i7Ph2shlPATmL1yh9MEDWCEidnPmGB
	mCkv0bx1NjOELSFx8MULZoheRYktc76zQti1Eqe23AJ7WkLgAIfE5Ym7oV5zkdjzto0RwhaW
	eHV8CzuELSPxf+d8qJpsiZ1TdkENLZCYdXIqG8hfEgLWEn1nciDCjhIHzm1jggjzSdx4Kwhx
	Dp/EpG3TmSHCvBIdbUITGFVmIXlgFpIHZiF5YAEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS9
	5PzcTYzAhHH63/GvOxhXvPqod4iRiYPxEKMEB7OSCK8N94YkId6UxMqq1KL8+KLSnNTiQ4zS
	HCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUxhYd47Jk/TDjvLd6wuynnLnlpVweonOptf
	3jC3OiOnqlbLYe3w1nPpZIFdvNM7v9ZsP2T09MKCh1VW/mLuBtKM3fEzJLiywr9m/fCcd+3k
	yj8eJ52rTvSxXQ1kcJPr9e1+WpiU+iB/Yo7mpyl82iKna5dfPaS8YdZarVeFezwX6v/ee+u4
	r0n+5roTE5T4ivmufjhhvtLS7XzppScr/fYHSzDfe1D0bklLSdHHQDuh8A2lZ03di/cHqocd
	YvwyW+y4nVt0raP3vwVP9SXWVMuWNAl+mVPHkmhxlTn2buqJwoI6ga61Gp7P0uIj/wteOHPi
	yn6DW1acTef/Nii2+c40KFsT3LXoA7eX7ZejK5RYijMSDbWYi4oTAUKefWiHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7o8NzYlGTR0ClusXH2UyWLSoWuM
	FvOXPWV3YPbYtKqTzWPzknqP3Tcb2AKYo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQybn+9y1pwQqJi+t0mtgbGE8JdjJwcEgImEqceLGfrYuTi
	EBJYyijx+v1RNoiEjMSnKx/ZIWxhiT/XuqCKPjJKdDb/ZIdwNjNKdEw6DFbFJqAjcf7NHeYu
	Rg4OEQFViX0ttiBhZgEfiZ/TDjOD2MIC5hLLH05jBLFZgEruv+oDi/MK2Ep0tT+EWiwv0XZ9
	OlgNp4CdxOqVP5hAbCGgmjuN+9gg6gUlTs58wgIxX16ieetsZghbQuLgixfMEHMUJbbM+c4K
	YddKfP77jHECo8gsJO2zkLTPQtK+gJF5FaNIamlxbnpusaFecWJucWleul5yfu4mRmBEbTv2
	c/MOxnmvPuodYmTiYDzEKMHBrCTCa8O9IUmINyWxsiq1KD++qDQntfgQoynQnxOZpUST84Ex
	nVcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwDT3BafUGTPmjOOz
	PBxWSx268+rz/iAv094Feznkfl74FqlinSr9OrpTvchEpfEgm4H7E8PIZ9ZtOuv04u5fOhdy
	dtP9s9L88xy+xLy9/FpnXkr1xbodYvo5zyVibl3MXrCu38fHdr5X5PUFFUf0627zr+i5cv+F
	SeK9J8UX5I/1cHfd7zZ1aHz+oveHp/iHuqMsi9quyH8yZVmaWBt91+ns+0D3f3HbjxSr7NpV
	/X2PvOuliEa9okmCijxnHawvvZVl6i2QeVVYGtn26p3y/grJZe39vA8nvtr1w49PLOZ5i/sV
	tx3xT5tbNTq9fnLk3nXu+9l9bcqGJ62x2rtn9VyaFPqxqvTmxA0fl505+V+JpTgj0VCLuag4
	EQDmE8EwMQMAAA==
X-CMS-MailID: 20220622085124eucas1p24243c811046ef1da9d10212077ac8cc0
X-Msg-Generator: CA
X-RootMTR: 20220622085124eucas1p24243c811046ef1da9d10212077ac8cc0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220622085124eucas1p24243c811046ef1da9d10212077ac8cc0
References: <20220622084859.1937878-1-j.granados@samsung.com>
	<CGME20220622085124eucas1p24243c811046ef1da9d10212077ac8cc0@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_015128_193187_154CCB8C 
X-CRM114-Status: GOOD (  11.26  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

These variables were synced to keep up with nvme-cli in
48c9e85b2346 ("nvme: resync include/linux/nvme.h with nvmecli"). Since
nvme-cli now uses libnvme which defines all the structures within itself,
there is no need to synchronize any longer.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/linux/nvme.h | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 29ec3e3481ff..71d7d6afc56a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -129,24 +129,10 @@ enum {
 	NVME_REG_ACQ	= 0x0030,	/* Admin CQ Base Address */
 	NVME_REG_CMBLOC	= 0x0038,	/* Controller Memory Buffer Location */
 	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
-	NVME_REG_BPINFO	= 0x0040,	/* Boot Partition Information */
-	NVME_REG_BPRSEL	= 0x0044,	/* Boot Partition Read Select */
-	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer
-					 * Location
-					 */
 	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory
 					 * Space Control
 					 */
 	NVME_REG_CRTO	= 0x0068,	/* Controller Ready Timeouts */
-	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
-	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
-	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
-	NVME_REG_PMREBS	= 0x0e0c,	/* Persistent Memory Region Elasticity
-					 * Buffer Size
-					 */
-	NVME_REG_PMRSWTP = 0x0e10,	/* Persistent Memory Region Sustained
-					 * Write Throughput
-					 */
 	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
 };
 
@@ -369,14 +355,7 @@ enum {
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
-	NVME_CTRL_CTRATT_128_ID			= 1 << 0,
-	NVME_CTRL_CTRATT_NON_OP_PSP		= 1 << 1,
 	NVME_CTRL_CTRATT_NVM_SETS		= 1 << 2,
-	NVME_CTRL_CTRATT_READ_RECV_LVLS		= 1 << 3,
-	NVME_CTRL_CTRATT_ENDURANCE_GROUPS	= 1 << 4,
-	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
-	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
-	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
 };
 
 struct nvme_lbaf {
@@ -508,9 +487,6 @@ enum {
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
 	NVME_ID_CNS_CTRL_LIST		= 0x13,
-	NVME_ID_CNS_SCNDRY_CTRL_LIST	= 0x15,
-	NVME_ID_CNS_NS_GRANULARITY	= 0x16,
-	NVME_ID_CNS_UUID_LIST		= 0x17,
 };
 
 enum {
@@ -639,7 +615,6 @@ enum {
 	NVME_CMD_EFFECTS_NIC		= 1 << 3,
 	NVME_CMD_EFFECTS_CCC		= 1 << 4,
 	NVME_CMD_EFFECTS_CSE_MASK	= 3 << 16,
-	NVME_CMD_EFFECTS_UUID_SEL	= 1 << 19,
 };
 
 struct nvme_effects_log {
@@ -1185,16 +1160,9 @@ enum {
 	NVME_LOG_FW_SLOT	= 0x03,
 	NVME_LOG_CHANGED_NS	= 0x04,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
-	NVME_LOG_DEVICE_SELF_TEST = 0x06,
-	NVME_LOG_TELEMETRY_HOST = 0x07,
-	NVME_LOG_TELEMETRY_CTRL = 0x08,
-	NVME_LOG_ENDURANCE_GROUP = 0x09,
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_DISC		= 0x70,
-	NVME_LOG_RESERVATION	= 0x80,
 	NVME_FWACT_REPL		= (0 << 3),
-	NVME_FWACT_REPL_ACTV	= (1 << 3),
-	NVME_FWACT_ACTV		= (2 << 3),
 };
 
 /* NVMe Namespace Write Protect State */
-- 
2.30.2


