Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAC4C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 13:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NzsQcVGR4sARDClisT40MAPNktIxThC27Aw83jqlWko=; b=K+DlleJmEsdbot1TSdM5Fu1Nbv
	DRuhT8wx28DpfSo3COIrDjH729Q+yVL/gKiF8Du2tk21eoih/DTzAYUZM00UezzU5F9MZ/xBsJsgI
	l7eFAvitp8XIVDvqYNJ/X9axiBfsItsu0DhRJBSVLnaRde2enqtooddaK2sgiwt7lnqEFdHR7hjBD
	AoaQjpLRcsfgq5iqaz45n5EUqTB2TcoYiMhjM1UtYXp6TqntR8M/UWs3f7pglcHe3yvsj60WxzspG
	OPKY08sqaSPqT8YeFjzvhPi3+D3q0JXo1zX/RZxo8kgU6GNl7StQiiXGVA5FdEYMyiQZjH8qlmjhz
	nA4Cs24Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ognNZ-0095uu-7U; Fri, 07 Oct 2022 13:27:05 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ognNK-0095rB-1s
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 13:26:54 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221007132637euoutp02f1551ff0fdea06af2271d390a128ba48~bzF95UYJw0797607976euoutp02b
	for <linux-nvme@lists.infradead.org>; Fri,  7 Oct 2022 13:26:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221007132637euoutp02f1551ff0fdea06af2271d390a128ba48~bzF95UYJw0797607976euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1665149197;
	bh=NzsQcVGR4sARDClisT40MAPNktIxThC27Aw83jqlWko=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=QvDc3+MfBpNG+Tl2ic8E4Tpo+S5weAs4IhdROKnxQMOab0Fdzv4efFFU3yrtjHja0
	 Bp8zP/fIPaOK+1Bpl3qegnEHxncQ/fyG5JF6W6/1g78dKJkDBsoaoOqQmEjjw9MgId
	 dr9EW8A6F9NHGQWubFW7pmmAiiWtmQ7JI/oefEL8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221007132637eucas1p1c314eee4b27912b6e86409b5c621f940~bzF9mlWY51475814758eucas1p1t;
	Fri,  7 Oct 2022 13:26:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 41.99.07817.D0920436; Fri,  7
	Oct 2022 14:26:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221007132637eucas1p14146d877f7f0765fda24b2a79b171d91~bzF9Rua7e1758517585eucas1p1y;
	Fri,  7 Oct 2022 13:26:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221007132636eusmtrp216885193ffe0b415f17c9ef5035ebbf8~bzF9RB_dt2142821428eusmtrp2C;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
X-AuditID: cbfec7f4-893ff70000011e89-da-6340290dd53a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 52.57.07473.C0920436; Fri,  7
	Oct 2022 14:26:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221007132636eusmtip2bb61d06ff4c7aacbc31c526ec4d2b677~bzF9DIo9X1419714197eusmtip2k;
	Fri,  7 Oct 2022 13:26:36 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 7 Oct 2022 14:26:32 +0100
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <javier.gonz@samsung.com>,
	<gost.dev@samsung.com>, <joshi.k@samsung.com>, Joel Granados
	<j.granados@samsung.com>
Subject: [RFC 1/2] nvme : Add dynamic whitelisting for passthru
Date: Fri, 7 Oct 2022 15:22:55 +0200
Message-ID: <20221007132256.2543136-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221007132256.2543136-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djPc7q8mg7JBme/CVmsXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoLpuU1JzMstQifbsErowlyx+z
	F0yUq7j1+hxbA+NiyS5GTg4JAROJ+w+mMHYxcnEICaxglLjS+hbK+cIoMf3hXlYI5zOjxNnl
	V1m6GDnAWg6844OILwcq+jWBBa5o9b7jUM4mRomnX06zgSxhE9CROP/mDjOILSJgKXH4ymUm
	kCJmgVmMEvMPTgRLCAvYS/yb1wnWwCKgIjHrUQs7iM0rYCuxou0EK8S18hJt16czgticAnYS
	f19MZoOoEZQ4OfMJC4jNDFTTvHU2M4QtIXHwxQtmiF5FiS1zvkPNqZVYe+wMO8gREgJXOCTm
	Xv/FBpFwkfjTcpARwhaWeHV8CzuELSPxf+d8Jgg7W2LnlF1QQwskZp2cygYJF2uJvjM5EGFH
	iaXtL5ggwnwSN94KQpzDJzFp23RmiDCvREeb0ARGlVlIHpiF5IFZSB5YwMi8ilE8tbQ4Nz21
	2CgvtVyvODG3uDQvXS85P3cTIzCNnP53/MsOxuWvPuodYmTiYDzEKMHBrCTCu3OnXbIQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXrYZWslCAumJJanZqakFqUUwWSYOTqkGpmWuS+apOunFvZub
	32zz4u7pWo0bDX73BbxXssiePdyvHsKTFHestE3CRfXTuY6VfmZ5MzovVk1/7rB/UnFHj/O5
	5fsLv845W/bOY9mhXwnSF0NNfu0T/eQb+q7iAFudIMeDwwu1XV2OzihawbhNbZ7otoyc9W0P
	/p7xElTM/nO2Zur/7zbbdrcc/i96vSOmxUi4y193SiyLFHv2DVbPGzF3Y55IhMncTtk0sSpT
	3UH6mcqjr3Ne3u7LM+qZK7elX/+ifumOg9NCXOPvvX8rN/PC55QemxfyD7cZxK/+MyW74NQT
	fq6/hj6B2poP5h2b3u5lKHSpXeFTsYdNufzcSSoG/xzefrrbfUn2i49ZgRJLcUaioRZzUXEi
	ADsf/HuSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7o8mg7JBlvnmVqsXH2UyWLSoWuM
	FvOXPWW3WPf6PYsDi8f5extZPDat6mTz2Lyk3mP3zQa2AJYoPZui/NKSVIWM/OISW6VoQwsj
	PUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwlyx+zF0yUq7j1+hxbA+NiyS5GDg4J
	AROJA+/4uhi5OIQEljJKtFy+xd7FyAkUl5H4dOUjlC0s8edaFxtE0UdGiQPbZrKAJIQENjFK
	HFwnAWKzCehInH9zhxnEFhGwlDh85TITSAOzwCxGifkHJ4IlhAXsJf7N62QDsVkEVCRmPWoB
	28ArYCuxou0EK8Q2eYm269MZQWxOATuJvy8ms0Ess5VouXCfDaJeUOLkzCdgRzAD1Tdvnc0M
	YUtIHHzxghlijqLEljnfoWbWSry6v5txAqPILCTts5C0z0LSvoCReRWjSGppcW56brGhXnFi
	bnFpXrpecn7uJkZglG079nPzDsZ5rz7qHWJk4mA8xCjBwawkwrtzp12yEG9KYmVValF+fFFp
	TmrxIUZToD8nMkuJJucD4zyvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaP
	iYNTqoFp97K5mmuc9Xlunor+pvLIcNPXuWus+JUu/OUymzOj7Xncut1GOwz03tyUPR1hODND
	ZqWz5vrfa5+6uifNdl90/UmISsnyK0uv5sznackylfU7oyZ/1GLHhz3dlWzBSvsbVqfHuSSy
	PuwoOv4qaHWntWD+c4tPD3etKgjc+63hmlx4i597i1Cnk83sGuNbjw/IXGh71ixb7OMeuGzu
	PfEe5vP503b+Ytl8Zg+vll9hgeI2pZzrOc8u/j/ocLXwnncBo5bgPsXtriwBZswnr0WEi84N
	yu08VZT93TaBveg3S3vj5rLFkZwXLI6LNH9q+sqa8eqPm5imhUjTys7FFRP2sLSstRO45yq/
	+MtCvj4lluKMREMt5qLiRABsSSMPOwMAAA==
X-CMS-MailID: 20221007132637eucas1p14146d877f7f0765fda24b2a79b171d91
X-Msg-Generator: CA
X-RootMTR: 20221007132637eucas1p14146d877f7f0765fda24b2a79b171d91
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221007132637eucas1p14146d877f7f0765fda24b2a79b171d91
References: <20221007132256.2543136-1-j.granados@samsung.com>
	<CGME20221007132637eucas1p14146d877f7f0765fda24b2a79b171d91@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_062650_527995_3A217569 
X-CRM114-Status: GOOD (  18.62  )
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

Drive information such as block size and total usable LBAs are needed to
send IO down the nvme passthru path. Currently only privileged users can
get these parameters.  This patch implements a dynamic whitelist that
allows the privileged user to define what nvme opcodes are available for
the unprivileged.

A bitmap is added at the nvme driver level that controls what opcodes are
allowed. The unprivileged user will be able to execute an nvme opcode
(using passthru) when it is whitelisted and if mode matches FMODE_WRITE.

This contains only the whitelist implementation and is a preparation commit
for the ioctl calls.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/nvme/host/core.c  | 10 ++++++++++
 drivers/nvme/host/ioctl.c | 11 +++++++++--
 drivers/nvme/host/nvme.h  |  1 +
 include/linux/nvme.h      |  1 +
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 13080a017ecf..05d1e6fd633d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -107,6 +107,8 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
+DECLARE_BITMAP(nvme_admin_whitelist, nvme_admin_last);
+
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -125,6 +127,12 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
 
+static void nvme_init_admin_whitelist(void)
+{
+	bitmap_zero(nvme_admin_whitelist, nvme_admin_last);
+	__set_bit(nvme_admin_identify, nvme_admin_whitelist);
+}
+
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
@@ -5231,6 +5239,8 @@ static int __init nvme_core_init(void)
 		goto unregister_generic_ns;
 	}
 
+	nvme_init_admin_whitelist();
+
 	return 0;
 
 unregister_generic_ns:
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index ebe04e977baa..73e4287d2c44 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -20,6 +20,14 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
+
+bool nvme_admin_cmd_allowed(u8 opcode, fmode_t mode)
+{
+	if (test_bit(opcode, nvme_admin_whitelist))
+		return (mode & FMODE_WRITE);
+	return false;
+}
+
 bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
 {
 	u8 opcode = c->common.opcode;
@@ -27,9 +35,8 @@ bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 
-	/* admin commands are not allowed */
 	if (ns == NULL)
-		return false;
+		return nvme_admin_cmd_allowed(opcode, mode);
 
 	/* exclude vendor-specific io and fabrics commands */
 	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 216acbe953b3..18a55e3483bd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -46,6 +46,7 @@ extern unsigned int admin_timeout;
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
+extern unsigned long nvme_admin_whitelist[];
 
 /*
  * List of workarounds for devices that required behavior not specified in
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 8396eb7ecb68..18a75496299c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1123,6 +1123,7 @@ enum nvme_admin_opcode {
 	nvme_admin_sanitize_nvm		= 0x84,
 	nvme_admin_get_lba_status	= 0x86,
 	nvme_admin_vendor_start		= 0xC0,
+	nvme_admin_last,
 };
 
 #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
-- 
2.30.2


