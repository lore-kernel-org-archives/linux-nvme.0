Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6360C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 03:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1xxcviCzwplVYwof4YqPkHybqVAQfpPegoq5Qwuh5DM=; b=AP9JrM7t8zlzUD7pnebFOytl4f
	kdBVAm8bnBBMD706zzwajlRGgx3FWNohj/E1Pz1k3japDJoTZ/amgGA/8lVXoVOPeDKQdeE3+g4gR
	AzUIGR2Ofuc1QUyT3lU0vJN63SqKEWnnK2CNazXR58mczm5lZDRI0jfdZzIFt68/u32QTqDwEMptd
	1WRrJbHenIkByvuwOQXk4n8v3UwrVmP7L37NWwDF7ZnHcvNQdTt6CQWwjdIpZdJmkp7rTYaDSOYfl
	ilIa4oBhUs69lrNjAXr3GT4PLsY1HbORG4XLRgSsK4EVL43R5pTTdNxoSwzJry2lW3oTVuyfvGrcV
	exOQ0sXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Arh-006tHL-2D;
	Wed, 29 Nov 2023 03:03:53 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Are-006tFO-1W
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 03:03:52 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231129030345epoutp039696470e5dfd24066169e677fb932696~b_PdSm3fS1171311713epoutp03X
	for <linux-nvme@lists.infradead.org>; Wed, 29 Nov 2023 03:03:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231129030345epoutp039696470e5dfd24066169e677fb932696~b_PdSm3fS1171311713epoutp03X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701227025;
	bh=1xxcviCzwplVYwof4YqPkHybqVAQfpPegoq5Qwuh5DM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DpT/q3xMbc4oTuvsUuz07ueC5MeY526zHQFnXiXfCrMcocptTDrDk+j1YMjxByPQa
	 RJbn6WZcsphR/ghxgednEv8wFAo2r0fHJ3t8WG7Dz+mPC2hM+KwAmnVAwB+mSZ2Re+
	 kEmUgH67RvV00GBy31Q9VVas1eljXMNSZvmnHNI4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231129030344epcas5p4f9261482a7b6ce51f84fa7318760d94d~b_PcmWPE01349813498epcas5p4H;
	Wed, 29 Nov 2023 03:03:44 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Sg40H2y83z4x9Pr; Wed, 29 Nov
	2023 03:03:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	45.E2.19369.F0AA6656; Wed, 29 Nov 2023 12:03:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6~byaUEM9fi3276732767epcas5p2F;
	Tue, 28 Nov 2023 12:36:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231128123634epsmtrp2f314d812b7ad3af5576c1348d52796e6~byaUDiCJB3270432704epsmtrp2U;
	Tue, 28 Nov 2023 12:36:34 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-59-6566aa0f6c4d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.E7.18939.2DED5656; Tue, 28 Nov 2023 21:36:34 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231128123632epsmtip1ed1f5bef850d4524e25f2dbb5bee7d30~byaSSu3Ba0450104501epsmtip1Z;
	Tue, 28 Nov 2023 12:36:32 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: error27@gmail.com, gost.dev@samsung.com, nitheshshetty@gmail.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme: prevent potential spectre v1 gadget
Date: Tue, 28 Nov 2023 17:59:57 +0530
Message-Id: <20231128122958.2235-2-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231128122958.2235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmpi7/qrRUgw/XhSxW3+1ns3i0zM/i
	5oGdTBYrVx9lsti98COTxaRD1xgtnl6dxWRxedccNov5y56yW+x40shose33fGaLda/fszjw
	eMy6f5bNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbGDz6G1+x+bRt2UVo8fnTXIBXFHZ
	NhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAVysplCXm
	lAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxMgQoTsjN2
	PlvDWPCAq2Lv4lmsDYxzOLsYOTkkBEwkbrb2MoHYQgJ7GCWO7qzuYuQCsj8xStz7MpcNzlk6
	cQMTTMeZff0sEImdjBIvP95nhHBamST2Xu4CauHgYBPQljj9nwMkLiJwhVFi9sOnYKOYBdYy
	Slx7fZgdZJSwgJ3ExpWbwMayCKhKNP+fzQZi8wpYSjxdfpcVZJCEgL5E/31BkDCngJXEi8PL
	WCBKBCVOznwCZjMLyEs0b53NDDJfQmAth8T61ytYIU51kfi1ax8zhC0s8er4FnYIW0ri87u9
	bBB2ucTKKSvYIJpbGCVmXZ/FCJGwl2g91c8McgSzgKbE+l36EGFZiamn1jFBLOaT6P39BBos
	vBI75sHYyhJr1i+Ami8pce17I5TtIdH1/xIbJLB7GSWev5WewKgwC8k/s5D8Mwth8wJG5lWM
	UqkFxbnpqcmmBYa6eanl8GhOzs/dxAhOyloBOxhXb/ird4iRiYPxEKMEB7OSCK/ex+RUId6U
	xMqq1KL8+KLSnNTiQ4ymwACfyCwlmpwPzAt5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeW
	pGanphakFsH0MXFwSjUwZdau+LilOiBQx2bVX8ujl3Yzxc4MFdQ+53ZAQs9y7vQ/shNEHqV0
	Ki62PmcfLrfcJvdJLfP+BdGhc+IVwtc6clnl7zGZ2qjw7+GlA7mqDEpKKTeev2QMso54s+2m
	/ab8I6eE7zwOKdGZsqLw1aP3Pv+ee2zSEJHfWbf6V8LSlARdbsWolK1ndu5bqbmr5umrb+Y+
	Wh8Y8jg4Wr9f2ndj69UO6X5rk+YLK+dW+7q7JU3IPXFtps+B9NtebNcCAwsPnfgsmOXdZcHj
	a3Lz/uZv8Srrl1/wLT/mUzd12tePoQnB2ywVlK78+9lcOG+zUOTbOS5TtHW57GR4AjLFfxi1
	7RI0+6KvqCLMVJ/+ofmHEktxRqKhFnNRcSIABTmD5FMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnO6le6mpBpdOaVqsvtvPZvFomZ/F
	zQM7mSxWrj7KZLF74Ucmi0mHrjFaPL06i8ni8q45bBbzlz1lt9jxpJHRYtvv+cwW616/Z3Hg
	8Zh1/yybx85Zd9k9zt/byOJx+Wypx6ZVnWwem5fUe+y+2cDm0dv8js2jb8sqRo/Pm+QCuKK4
	bFJSczLLUov07RK4MnY+W8NY8ICrYu/iWawNjHM4uxg5OSQETCTO7Otn6WLk4hAS2M4o0dv5
	lh0iISmx7O8RZghbWGLlv+fsEEXNTBKfr7xj7GLk4GAT0JY4/Z8DJC4icItR4vn2BcwgDrPA
	ZkaJaU82gU0SFrCT2LhyExOIzSKgKtH8fzYbiM0rYCnxdPldVpBBEgL6Ev33BUHCnAJWEi8O
	L2MBsYWASv417mSBKBeUODnzCZjNLCAv0bx1NvMERoFZSFKzkKQWMDKtYhRNLSjOTc9NLjDU
	K07MLS7NS9dLzs/dxAiOFq2gHYzL1v/VO8TIxMF4iFGCg1lJhFfvY3KqEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV7lnM4UIYH0xJLU7NTUgtQimCwTB6dUA5Psw//LE5UjjLp8M0QPv9xhXZYl
	90WRwcko+NrxxH0zNQ7EZNrrHhTVOxL2eEJ+W/DhpGOfa2ILtty8eWfZoS91N0ynXXe7W6aR
	EqpqdbNfZFbIuSk13F6SNbP7L+5M6DzvyHy39lHUdMaU79dq7vIudBPnvbM9Pv1QW5/5ga+a
	Kb4veRLvx5VvNElw3Rt543RucvfnXYJZ9dYaLks41Ir/Cq215np519POR/3rejnurmmMXl0h
	Uc+e6M78n/rR4/Hsc7vjUuNEHfNjVr/w/dn9+KdVW7rGvOX/dno8E+5Ys1B8qYcmp9Kn5KBj
	G0P9zhcfDz0jsOxoZV/lIe0lje98izMXt38za9Q4Wbt5nRJLcUaioRZzUXEiALe9M4IFAwAA
X-CMS-MailID: 20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6
References: <20231128122958.2235-1-nj.shetty@samsung.com>
	<CGME20231128123634epcas5p201af168ff4ef4a8a129e5448bccca1a6@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_190350_819852_C5905AC2 
X-CRM114-Status: GOOD (  16.38  )
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

This patch fixes the smatch warning, "nvmet_ns_ana_grpid_store() warn:
potential spectre issue 'nvmet_ana_group_enabled' [w] (local cap)"
Prevent the contents of kernel memory from being leaked to  user space
via speculative execution by using array_index_nospec.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/nvme/target/configfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e307a044b1a1..d937fe05129e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -18,6 +18,7 @@
 #include <linux/nvme-keyring.h>
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
+#include <linux/nospec.h>
 
 #include "nvmet.h"
 
@@ -621,6 +622,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
 
 	down_write(&nvmet_ana_sem);
 	oldgrpid = ns->anagrpid;
+	newgrpid = array_index_nospec(newgrpid, NVMET_MAX_ANAGRPS);
 	nvmet_ana_group_enabled[newgrpid]++;
 	ns->anagrpid = newgrpid;
 	nvmet_ana_group_enabled[oldgrpid]--;
@@ -1812,6 +1814,7 @@ static struct config_group *nvmet_ana_groups_make_group(
 	grp->grpid = grpid;
 
 	down_write(&nvmet_ana_sem);
+	grpid = array_index_nospec(grpid, NVMET_MAX_ANAGRPS);
 	nvmet_ana_group_enabled[grpid]++;
 	up_write(&nvmet_ana_sem);
 
-- 
2.35.1.500.gb896f729e2


