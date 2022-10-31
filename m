Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A153FA3741
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Oct 2022 16:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TkDchGHmrxv61V5loRHvxwjryicgKS3h1gI1ssuIX50=; b=cUt9i+xLwG2kEjisw4oYSw/2sU
	f0+gh5QErATQZeQLChYN0W2pDX7UQaHqcjF+BJD4EJL7X107U0OES050o2Gi+7SmOyq2iekCmddz9
	Av/k2wY9edGAYo15D/sjIjoBNl40nGtG8+ErUzRYsUyGoXHL9KrCuaYy1UCPxfND4XH1/7+na+iUU
	rC5Y9D9f5RINHzDjOGvxE2mqyIhxoJksNELkiNchu8zgX4SDnOADtpUZFbAL9X2qUV/U4zdxCGJdW
	AFwCQSPUz4oWHS7ejVpEIYBpX1UMffO/6znHTVWUh3dD7eJ85NUU0A4oGMjMoi+HYw2iJgjX2Sl0j
	sx5Zr2AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opXlP-00D0gA-ID; Mon, 31 Oct 2022 16:35:51 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opXlE-00D0dM-Pt
	for linux-nvme@lists.infradead.org; Mon, 31 Oct 2022 16:35:43 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221031163533epoutp0387251f62f1c6d9359c1fbec874ff51bd~jNJx3OX8Y1241012410epoutp03T
	for <linux-nvme@lists.infradead.org>; Mon, 31 Oct 2022 16:35:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221031163533epoutp0387251f62f1c6d9359c1fbec874ff51bd~jNJx3OX8Y1241012410epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667234133;
	bh=TkDchGHmrxv61V5loRHvxwjryicgKS3h1gI1ssuIX50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+3ruEps8yxh9lmXLEvv9EZscArxxfDZQDyzIo9C+5n0LVx3USmUNadvP3SZFhrG0
	 Ti5Mz6UMAnWhY4aVeU/x2J1uSKTeDDQMk/yT5EEAvzZIXPa5rDBsUPJ+OcbIt1aoov
	 94qQwuPdOL8USWMk0r6iMyY8aV41KNhkaFeVCXzw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20221031163533epcas5p2625d0e2979718671aa72b6a75c0fe51c~jNJxlwTKe0269702697epcas5p26;
	Mon, 31 Oct 2022 16:35:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4N1Jfp6pbdz4x9Pp; Mon, 31 Oct
	2022 16:35:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.E7.56352.259FF536; Tue,  1 Nov 2022 01:35:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20221031163530epcas5p283672f2fc5c913bf2e22d4cd86c9153e~jNJu9OBSe0038500385epcas5p27;
	Mon, 31 Oct 2022 16:35:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221031163530epsmtrp1a95190e7af019687598b178a1c677c9c~jNJu8SoIZ2363923639epsmtrp1P;
	Mon, 31 Oct 2022 16:35:30 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-27-635ff952dc6e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	77.56.18644.259FF536; Tue,  1 Nov 2022 01:35:30 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221031163529epsmtip20606ca97aef60cb3d0d56ac44b8cc79a~jNJtvhMQA0075100751epsmtip2U;
	Mon, 31 Oct 2022 16:35:29 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v4 2/2] nvme: identify-namespace without CAP_SYS_ADMIN
Date: Mon, 31 Oct 2022 21:53:51 +0530
Message-Id: <20221031162351.31856-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162351.31856-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTSzfoZ3yywYMHhhar7/azWbw/+JjV
	4uaBnUwWK1cfZbI4+v8tm8WkQ9cYLeYve8puse71exYHDo/z9zayeFw+W+qxaVUnm8fmJfUe
	u282sHn0Nr9j8+jbsooxgD0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEv
	MTfVVsnFJ0DXLTMH6CglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5x
	aV66Xl5qiZWhgYGRKVBhQnbGwouWBRs4K14fms3WwHiDvYuRk0NCwETiwu1nzF2MXBxCArsZ
	Jf5dPMkI4XxilHj07zkLhPOZUWLa10lMMC23Tv2DatnFKLHk7U12uKr711+ydTFycLAJaEpc
	mFwK0iAiECtxaeNasH3MAvESN/9uBisRFnCT2PTBFiTMIqAq8ePvNFaQMK+AhcThtQUQq+Ql
	Zl76DtbJKWApcbf/MxuIzSsgKHFy5hMWiInyEs1bZ4OdIyHwk12ifdIVJpA5EgIuEjs+e0DM
	EZZ4dXwL1MdSEi/726DsZIlLM89BvVUi8XjPQSjbXqL1VD8zyBhmoEfW79KHWMUn0fv7CdR0
	XomONiGIakWJe5OeskLY4hIPZyyBsj0kzq27Bg3OHkaJ5Xc+MU9glJ+F5INZSD6YhbBtASPz
	KkbJ1ILi3PTUYtMC47zUcnikJufnbmIEp0st7x2Mjx580DvEyMTBeIhRgoNZSYS3/mx0shBv
	SmJlVWpRfnxRaU5q8SFGU2AIT2SWEk3OBybsvJJ4QxNLAxMzMzMTS2MzQyVx3sUztJKFBNIT
	S1KzU1MLUotg+pg4OKUamMoey81Lf/OhvFJ88szLWtLaNWnSm1tsVyUKfZ0RnfAob5kPU5xL
	/b/ZDEZ7uFmjJ1adm7Nw8tez96feyTM7abFgdZo297Q+DrXoXYv2ilg7lnqKrmFodipYnLZn
	3w89q4bj3+5Gm8/8r7r8Y7523SZ1C6flvxQafQxTn7o8Y7gs98r7RrZd3+W719jqJyYxpyr9
	dWqRrJ6xtESp+vt87a8XjyzR/sA0g+mjZ8jxT/V2WzU+pzpP+8oommP2d5urcm+P3Sr10xcY
	dnF/O+13pa//3xUvR4OkR89O7wqaNfPUxrdHb6Wz3gu7cHUpw9mpeZvKn4aLVIl7XZ4t+Htr
	I981j8MTlC6GGjLk+Bkp2SuxFGckGmoxFxUnAgDpsogWIAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvG7Qz/hkgyuTpC1W3+1ns3h/8DGr
	xc0DO5ksVq4+ymRx9P9bNotJh64xWsxf9pTdYt3r9ywOHB7n721k8bh8ttRj06pONo/NS+o9
	dt9sYPPobX7H5tG3ZRVjAHsUl01Kak5mWWqRvl0CV8bCi5YFGzgrXh+azdbAeIO9i5GTQ0LA
	ROLWqX/MXYxcHEICOxgl5l3tZYJIiEs0X/sBVSQssfLfc3aIoo+MEgsXbAdyODjYBDQlLkwu
	BakREUiWOLX9E1gvs0CixPujj1lBSoQF3CQ2fbAFCbMIqEr8+DsNLMwrYCFxeG0BxHR5iZmX
	voNt4hSwlLjb/5kNxBYCKrmz8TTYRF4BQYmTM5+wQEyXl2jeOpt5AqPALCSpWUhSCxiZVjFK
	phYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBIe6ltYOxj2rPugdYmTiYDzEKMHBrCTCW382
	OlmINyWxsiq1KD++qDQntfgQozQHi5I474Wuk/FCAumJJanZqakFqUUwWSYOTqkGpnRO1d6Q
	GN/3Dza/+tQ72+5v2d5fOxzr3U7rspa7uB+pnTZjws1pzIaxMlI/dP2VhJ03OJZ3nV+xV/TU
	96k+uqtSJiYfeN3WkbZWxDv4oukB13xdk6zEU1sz/H5/1CiucGxtbzyY4KCRz1S43KODOY1d
	zSMv803A4SgFvuqsVatEmsT/ay6O2c7wVu75588rl26rKD+1uXwR/4tMxZhjdSczPobUB30u
	25wQI7btTZTtg2d2MdtmK8RbX9xgoX1/i/KBGUwWczyb9vFq2MbGW+1osWgxuaXSYXY19oe2
	xR2BJVtkd5U+v3TVY//aCqNqKY7FUX1T9ydzfr3FUCZU84U5nXFdfvWdDWn5mtJKLMUZiYZa
	zEXFiQC8Npcs5AIAAA==
X-CMS-MailID: 20221031163530epcas5p283672f2fc5c913bf2e22d4cd86c9153e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221031163530epcas5p283672f2fc5c913bf2e22d4cd86c9153e
References: <20221031162351.31856-1-joshi.k@samsung.com>
	<CGME20221031163530epcas5p283672f2fc5c913bf2e22d4cd86c9153e@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_093541_171692_121E9F15 
X-CRM114-Status: GOOD (  15.15  )
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

Allow all identify-namespace variants (CNS 00h, 05h and 08h) without
requiring CAP_SYS_ADMIN. The information (retrieved using id-ns) is
needed to form IO commands for passthrough interface.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/ioctl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9c581b1a8956..4b11e247063e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -15,9 +15,17 @@ bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 
-	/* admin commands are not allowed */
-	if (!ns)
+	if (!ns) {
+		if (opcode == nvme_admin_identify) {
+			switch (c->identify.cns) {
+			case NVME_ID_CNS_NS:
+			case NVME_ID_CNS_CS_NS:
+			case NVME_ID_CNS_NS_CS_INDEP:
+				return true;
+			}
+		}
 		return false;
+	}
 
 	/* exclude vendor-specific io and fabrics commands */
 	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)
-- 
2.25.1


