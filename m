Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A686C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 06:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y6eU8gXdSDyGpk0CFHu/m5477ll3V22Pel3mdMYIG5w=; b=i8gSA5MFnSORGRp4zrcweTd4g0
	LGEuwDdkLI87vc7bakvGWzmUXkHJALN6MT5hXbVws7NQM/0Ts/iSggQPwSCnlGctplBGgQFgc40JG
	vBlLi0dXnsI/fjBy4p9zfOrOsXk1QRKxQqFaG3RC1+Yu3D2alAfnz9kn7W67p7C8RmbcAsGYXnOZs
	oawCXxp1H9o2FD06FWMjDftI2d+/wxh+najNACYEDjCKHzQSkJ410K+D3Hd4e+E5N1V6e9H1DWDrs
	3dhPAx4kohcT6NH6d2+FbD5wOjiLi7o1dKI9XVm/kC+SN1T2le55CPD7bCRlNTQNL+yI6gyQT45Hi
	r0/fyykQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9oX-007bzH-F2; Fri, 30 Sep 2022 06:48:01 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe9m2-007ajt-Ey
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 06:45:28 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220930064523epoutp01b726c3e6bcf45a3da4a32b1816315c69~ZkGo0v16M0097300973epoutp01g
	for <linux-nvme@lists.infradead.org>; Fri, 30 Sep 2022 06:45:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220930064523epoutp01b726c3e6bcf45a3da4a32b1816315c69~ZkGo0v16M0097300973epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664520323;
	bh=y6eU8gXdSDyGpk0CFHu/m5477ll3V22Pel3mdMYIG5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eraHUqrVxpSVUvng+aT2/stGVQIu066XqHA4RaeoT1ce/UO1GTmZKUZfbsq/+U7uj
	 GHjKvLBfmrebkGfAFLGICDp64wj05sGFDdmbPPT5m2d0Up6f0QT3TsHB/hl8lYhznN
	 dy+GXtTq4LjFt6kiEqULRdQ1mk/6Cimw53YQp25k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220930064519epcas5p1f4b6305c843b30af21c038ed2d3f9455~ZkGljPZUL0319903199epcas5p1D;
	Fri, 30 Sep 2022 06:45:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Mf1253hSVz4x9Px; Fri, 30 Sep
	2022 06:45:17 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	14.76.26992.B7096336; Fri, 30 Sep 2022 15:45:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220930063835epcas5p2812f8e3d0758b19c01198034fcddc019~ZkAtkt3FD2490824908epcas5p2G;
	Fri, 30 Sep 2022 06:38:35 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220930063835epsmtrp1f220e4263663f078bb6eb40068e11d0b~ZkAtjykoX2657326573epsmtrp1k;
	Fri, 30 Sep 2022 06:38:35 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-e3-6336907bb16d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.42.18644.BEE86336; Fri, 30 Sep 2022 15:38:35 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220930063834epsmtip255a8b7b75bd5e31699222aef48896eff~ZkAsEqGso1763417634epsmtip2R;
	Fri, 30 Sep 2022 06:38:34 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v12 12/12] nvme: wire up fixed buffer support for
 nvme passthrough
Date: Fri, 30 Sep 2022 11:57:49 +0530
Message-Id: <20220930062749.152261-13-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220930062749.152261-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmlm71BLNkgyen2C1W3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8WkQ9cYLfbe0raYv+wpu0X39R1sDpwel8+Wemxa1cnmsXlJvcfu
	mw1sHn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ib
	aqvk4hOg65aZA3SSkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQv
	XS8vtcTK0MDAyBSoMCE74+6/m+wFt7kr7lzia2A8x9nFyMkhIWAisXL3POYuRi4OIYHdjBJ3
	JqxmhXA+MUrsPrCbDcL5zCgx8XYbC0zL8r8rmCASuxglWq9cZYGrenJgBiNIFZuAusSR561g
	toiAkcT+TyfB5jILbGGUaF63mL2LkYNDWCBWYtUKORCTRUBV4t/5EpByXgFriZa2/0wQy+Ql
	Zl76DlbNCRRvXpQDUSIocXLmE7B7mIFKmrfOBntBQuAnu8SEdwvZIXpdJHadWQY1R1ji1fEt
	UHEpiZf9bVB2usSPy0+hagokmo/tY4Sw7SVaT/Uzg+xlFtCUWL9LHyIsKzH11DomiL18Er2/
	n0C18krsmAdjK0m0r5wDZUtI7D3XAGV7SEz5sxYaVH2MEuuXP2aZwKgwC8k/s5D8Mwth9QJG
	5lWMkqkFxbnpqcWmBYZ5qeXwOE7Oz93ECE6kWp47GO8++KB3iJGJg/EQowQHs5IIr3iBabIQ
	b0piZVVqUX58UWlOavEhRlNgcE9klhJNzgem8rySeEMTSwMTMzMzE0tjM0Mlcd7FM7SShQTS
	E0tSs1NTC1KLYPqYODilGpiWvdH+ttZLN33fiyU8jziceeR3CAhzaVblfLy7e8KM9cUMBkdf
	mrinJCQHv7S9rTYtvElZbNHVXyxPFqUFnlWzS7G5cO2a7sR12Y2qBWFb73GZrTlVZFfjz7pf
	bJ9/j9fmk0/tFTj6LtzTi3dYOavaOTy3kCHf5pWR4Lr+qv/Gq17tNVmn3lZ+5vzdcs1f69gK
	m578+MTStEzhmnLe48Izdhd4uyPSGCZy5Bre3b1gZn1idNQqk6Xiop5Fz55wC92+2VWwd9uP
	zRFzbt7mf3l1Sf3JLxd1r6wPEvvq6bt/39xZ59hCbJbvmCfeOvu5kFeAUP8979mGsjIKWk8Y
	bHMsjO+L7+s9+/l+dKZaXo8SS3FGoqEWc1FxIgC0bUjbLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSvO7rPrNkg4ZJuhar7/azWdw8sJPJ
	YuXqo0wW71rPsVgc/f+WzWLSoWuMFntvaVvMX/aU3aL7+g42B06Py2dLPTat6mTz2Lyk3mP3
	zQY2j74tqxg9Pm+SC2CL4rJJSc3JLEst0rdL4Mq4++8me8Ft7oo7l/gaGM9xdjFyckgImEgs
	/7uCqYuRi0NIYAejxIym12wQCQmJUy+XMULYwhIr/z1nhyj6yChx/vMlJpAEm4C6xJHnrWBF
	IgJmEksPr2EBKWIW2MUoMXfrN2aQhLBAtMShDxOAEhwcLAKqEv/Ol4CEeQWsJVra/jNBLJCX
	mHnpOztICSdQvHlRDkhYSMBK4vOe9+wQ5YISJ2c+YQGxmYHKm7fOZp7AKDALSWoWktQCRqZV
	jJKpBcW56bnFhgVGeanlesWJucWleel6yfm5mxjBoa6ltYNxz6oPeocYmTgYDzFKcDArifCK
	F5gmC/GmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBUbVN8
	3cGhbo6bV+NMTvdL1ZMm7XfLVFdnfxV0iT9Jarbhh6gjoUevmMRNzN5UyRuUHPR9RmvenaRI
	6b13pqeY5XSmZXDv4emMW+v1eJn4ToddBTcfxGUFV65iXiZs7zuNgf2owOTTPVe/Hfxdutdj
	63OeD99S/RgNJySkp2Z80S7X2K3XYOIQn6gX4ulSvKtZrNW7UFrwlcvS9pxVE/58fLGz9vmb
	bV2bPaLyOXtPb856PfebX2xx2YKUS+uLI99sOjtnU/R7jZPXz9zyeiuxOdZw29L5d04YbeoX
	7Fohbnxcg/OWkd0Uzw32SzIyw5LECkUWVEk5X/EM85rcohNUPVUgZuLu0Joz3QJxjkosxRmJ
	hlrMRcWJABaeFrvkAgAA
X-CMS-MailID: 20220930063835epcas5p2812f8e3d0758b19c01198034fcddc019
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220930063835epcas5p2812f8e3d0758b19c01198034fcddc019
References: <20220930062749.152261-1-anuj20.g@samsung.com>
	<CGME20220930063835epcas5p2812f8e3d0758b19c01198034fcddc019@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_234526_880390_CCF2F26D 
X-CRM114-Status: GOOD (  20.55  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

if io_uring sends passthrough command with IORING_URING_CMD_FIXED flag,
use the pre-registered buffer for IO (non-vectored variant). Pass the
buffer/length to io_uring and get the bvec iterator for the range. Next,
pass this bvec to block-layer and obtain a bio/request for subsequent
processing.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 7a41caa9bfd2..81f5550b670d 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -95,8 +95,22 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	void *meta = NULL;
 	int ret;
 
-	ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer), bufflen,
-			GFP_KERNEL, vec, 0, 0, rq_data_dir(req));
+	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
+		struct iov_iter iter;
+
+		/* fixedbufs is only for non-vectored io */
+		if (WARN_ON_ONCE(vec))
+			return -EINVAL;
+		ret = io_uring_cmd_import_fixed(ubuffer, bufflen,
+				rq_data_dir(req), &iter, ioucmd);
+		if (ret < 0)
+			goto out;
+		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
+	} else {
+		ret = blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
+				bufflen, GFP_KERNEL, vec, 0, 0,
+				rq_data_dir(req));
+	}
 
 	if (ret)
 		goto out;
-- 
2.25.1


