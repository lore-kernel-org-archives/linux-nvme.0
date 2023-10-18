Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEE5CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 19:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=E8Xydc9ABbmZpbPWIux8x7OXuuaTZGkjagbAK32bLCw=; b=p363IjiV0C8kLz/aV1jAkm/Dna
	97papsHDitpmQxEZTIuKsqXCN84y8VGJGu32PMbVdSkt1iFe9PgaLotlRDA+42DErBJmZ8uvb63eN
	ZWgZt40Wy21H+dFOFhu2MKuMsVFUyokA/WJZclNwHn5S71VyEz7pEbbT2e826E40FdP3P7EVj3XN3
	XH8vGvbSC/7RlY/FIaXgtfj/t1Z2b5mQw5ELjQLvhPoLt/sy5pjCVvtJfwwyOCvNCHtbUftFLpg8U
	BOMo/25vPayy+BYgGjxkoZb1O+jclI6eY84hk12xFCBOhJE9XWFyJX+UdDCfvI0ifIbxFu9/eC6wA
	tnIgePuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCG3-00FY21-1K;
	Wed, 18 Oct 2023 19:31:07 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtCFy-00FY0r-33
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 19:31:05 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231018193059epoutp0106aede60ee3cde556bd2c1fd9d484da2~PSnb3Loe12225122251epoutp01-
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 19:30:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231018193059epoutp0106aede60ee3cde556bd2c1fd9d484da2~PSnb3Loe12225122251epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697657459;
	bh=E8Xydc9ABbmZpbPWIux8x7OXuuaTZGkjagbAK32bLCw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=rOQn3hzlCumvhmylEg0IIz0GuzHRb5uU7HFPbyJTrEweiPSi56ek9G5XstVinVYQ2
	 LJqnkBsNfxKP6ztndUTUcPgfVCPpW6hfL3Ay7er0T7U9hCypxRP4P4u6nNk1KEsuSH
	 BZ9l2IwiYEvlJ2kNYjmV6Grye5kjMX7pSqfz2vBI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231018193058epcas5p4d83d7d525d23a6ffd62aba14cd9d4ebf~PSnbAdx000318903189epcas5p4_;
	Wed, 18 Oct 2023 19:30:58 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4S9gtm5SvWz4x9Pt; Wed, 18 Oct
	2023 19:30:56 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F0.A6.19369.07230356; Thu, 19 Oct 2023 04:30:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231018193056epcas5p404b1fb38d3e9037862703690336d2d10~PSnY_ycdQ1246212462epcas5p4j;
	Wed, 18 Oct 2023 19:30:56 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231018193056epsmtrp224ea49cdf31883bf5c9ae040709f8fe7~PSnY_DkcL0102101021epsmtrp2t;
	Wed, 18 Oct 2023 19:30:56 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-e6-65303270e4ad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.6A.07368.07230356; Thu, 19 Oct 2023 04:30:56 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231018193054epsmtip1a2d1a847b1e92d7267bf381d775584b6~PSnXlH6WN0532505325epsmtip1F;
	Wed, 18 Oct 2023 19:30:54 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, Niklas.Cassel@wdc.com
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v2] nvme: fix error-handling for io_uring nvme-passthrough
Date: Thu, 19 Oct 2023 00:54:30 +0530
Message-Id: <20231018192430.43606-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTS7fAyCDV4NFDLYumCX+ZLVbf7Wez
	uHlgJ5PFytVHmSyO/n/LZnH+7WEmi0mHrjFazF/2lN3iwZ/H7A6cHjtn3WX3uHy21GPTqk42
	j81L6j1232xg8+jbsorRo/1AN1MAe1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGl
	hbmSQl5ibqqtkotPgK5bZg7QZUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScApMC
	veLE3OLSvHS9vNQSK0MDAyNToMKE7IwDx3sYCy5zVnzfnd7A2MfRxcjJISFgItF4aTEziC0k
	sIdRYlezfhcjF5D9iVFi+ppvTBCJb4wSG/tD4BqmHWKBKNrLKLF1632o7s+MEm1dQA0cHGwC
	mhIXJpeChEUEPCW6Ll1jB6lnFpjJKLHq1mFWkISwgJdE9+JzYDaLgKrEgRlnGUFsXgELiQNr
	5rFDLJOXmHnpOztEXFDi5MwnLCA2M1C8eetsZpChEgJv2SXaj61jhWhwkVh5YTEbhC0s8er4
	FqhBUhKf3+2FiidLXJp5jgnCLpF4vOcglG0v0XqqnxnkAWagB9bv0ofYxSfR+/sJ2F8SArwS
	HW1CENWKEvcmPYXaKi7xcMYSKNtD4smU+SyQIImVmHnyN9sERrlZSD6YheSDWQjLFjAyr2KU
	Si0ozk1PTTYtMNTNSy2Hx2Ryfu4mRnCK1ArYwbh6w1+9Q4xMHIyHGCU4mJVEeNODdVKFeFMS
	K6tSi/Lji0pzUosPMZoCw3Uis5Rocj4wSeeVxBuaWBqYmJmZmVgamxkqifO+bp2bIiSQnliS
	mp2aWpBaBNPHxMEp1cCUuS1sc+1b5QfpIo/cd8sbuqaenDhhZv+1A5+8FofPfbKiXnXClfDj
	GU2XHM4Zn1JaumRf71+hAPHi8Fen1tVs4/nZ2WrVE7zn1eypjYE3Fc//b+x6pzyxLtKeS/v1
	7+N3zH4GCizSblfbsewjY+D5w/wt67mW9HXJXXmpevne4ffH7D9p+1dm5Bre8jH7K+AcyV7q
	9NnlZoTWxc8z97vH+jC1WaamB03lWr+VuV1I5UVF9uWN3U2LbK4ZbP91iG2hzNo7IaV3jj5o
	32X4IvPYmqVXVmwPOL31k3pAoadkSfChKbpHGY+YPfocvV1y7b30SXoPLPtFKx9lHze6HX5a
	8Om9J1453382L7dNcj//X4mlOCPRUIu5qDgRAOwOOJAaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSnG6BkUGqwd0tXBZNE/4yW6y+289m
	cfPATiaLlauPMlkc/f+WzeL828NMFpMOXWO0mL/sKbvFgz+P2R04PXbOusvucflsqcemVZ1s
	HpuX1HvsvtnA5tG3ZRWjR/uBbqYA9igum5TUnMyy1CJ9uwSujAPHexgLLnNWfN+d3sDYx9HF
	yMkhIWAi0TjtEEsXIxeHkMBuRonts/6wQSTEJZqv/WCHsIUlVv57zg5R9JFRYlP3JcYuRg4O
	NgFNiQuTS0FMEQF/ieUPdEFKmAXmMkr0rJ4JNkdYwEuie/E5VhCbRUBV4sCMs4wgNq+AhcSB
	NfOg5stLzLz0nR0iLihxcuYTFhCbGSjevHU28wRGvllIUrOQpBYwMq1ilEwtKM5Nz002LDDM
	Sy3XK07MLS7NS9dLzs/dxAgOZC2NHYz35v/TO8TIxMF4iFGCg1lJhDc9WCdViDclsbIqtSg/
	vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBibvu+JReYc91Tw2NQSfSwi5
	cuPOjs1f3ygyqkg3T94xP89vXbDx9SuT/OW87wieeiIm73iyZefxlP1aLKefzluVYDY1ZPtX
	0+mb/+yRna8f90muoM9je2hKxRzD2Z8vmwtcMPkwa5+xQk4ia/1Hrwye/a8iX/J8S950V0X1
	x8W7jHfPqy8O2Xm52pu9d52/3d1NNzOf2AbX10pcWrife2db94zoG4XPTELeNJ47P1dte7Nz
	ZXDPl0k98+8Exib9dztSetWP/8nuionHP/yabjPz8V7PDHepe7LrHwjqNcRO/V/e+/FSnNfZ
	58uepfplr9Z+eUNt916Zt3+nvTCvF3lzZU6G18nQudVBQQtafd7WK7EUZyQaajEXFScCABUv
	GnTTAgAA
X-CMS-MailID: 20231018193056epcas5p404b1fb38d3e9037862703690336d2d10
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018193056epcas5p404b1fb38d3e9037862703690336d2d10
References: <CGME20231018193056epcas5p404b1fb38d3e9037862703690336d2d10@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_123103_474312_DABDE882 
X-CRM114-Status: GOOD (  19.05  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

Driver may return an error before submitting the command to the device.
Ensure that such error is propagated up.

Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on char-device.")
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
Changes since v1:
- Coding and comment style change (Niklas)

 drivers/nvme/host/ioctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..92273a5a2202 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -506,10 +506,13 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	req->bio = pdu->bio;
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
+	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
 		pdu->nvme_status = -EINTR;
-	else
+	} else {
 		pdu->nvme_status = nvme_req(req)->status;
+		if (!pdu->nvme_status)
+			pdu->nvme_status = blk_status_to_errno(err);
+	}
 	pdu->u.result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
-- 
2.25.1


