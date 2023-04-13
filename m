Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF0F5C77B6E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1x3L8c64sT9IQ+EX3Ery3BRF6jYq+O+48Pi0EdVwz0=; b=dDls1r0EDsPFDmeF38H/OetsYg
	X0DFrOxO9Ip5FCqyHm4X7fn5cVtZaYxUwvZ6vM51Z3c0FmcjrHKiem4uSDvb3XgPiWqrqZDYpQsSs
	coy5J8HHX0ljF8uNwJAWODVkqUNTlhnh/0aviBVv5e5kthO4vJ3V7BBfHJ784dhZbLY1f9wAWsttK
	8eVuJttCWwRreF5PLmRzAmX3hub4Je5ltzHlGKgDfenQc0IkMmpA+rYewwz94K2KXjiIgajSV5kCq
	OZ4uEM+5PmTk3QDPxnHKXkORB98YXUb8AE3SP+pVW08w8bWNFCUZgutfn4LZjfX5VoPrDSw3xw0Y3
	QEYDPYyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmsg7-005SSZ-2y;
	Thu, 13 Apr 2023 08:51:39 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmsg2-005SQx-2y
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 08:51:37 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230413085129epoutp03f36d74b7e36c6f258150b999fe14a825~VcnZ-tr6b2264522645epoutp03e
	for <linux-nvme@lists.infradead.org>; Thu, 13 Apr 2023 08:51:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230413085129epoutp03f36d74b7e36c6f258150b999fe14a825~VcnZ-tr6b2264522645epoutp03e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681375889;
	bh=T1x3L8c64sT9IQ+EX3Ery3BRF6jYq+O+48Pi0EdVwz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ng4AHbOkT0m4AStBjAzwzmCHCxfHkqlSzyPOkXlxfIfb2OFLMzFx0ZQp3Qr0C4dxo
	 ykU8xqVdaWUqFAicp1DwOCzRodyvLJrmgivsKgo3F9tGuhCEYKLbivgohwqA5smYG5
	 DZGrEbNKU4pJUkVkRYLz/Tlt7wsMnjOQP3kHyil8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230413085128epcas5p1c6bea41410b85f77b14f9f79e23e5272~VcnZeu0ip0717707177epcas5p1I;
	Thu, 13 Apr 2023 08:51:28 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Pxtbf5gZLz4x9QM; Thu, 13 Apr
	2023 08:51:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.E3.09987.782C7346; Thu, 13 Apr 2023 17:51:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230413085119epcas5p4e23303b256feab00bd6c2c532296126e~VcnQleWYf2564125641epcas5p43;
	Thu, 13 Apr 2023 08:51:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230413085119epsmtrp2acf1db56bb7366a06dd8bc24836c6436~VcnQk4g0J0438904389epsmtrp2a;
	Thu, 13 Apr 2023 08:51:19 +0000 (GMT)
X-AuditID: b6c32a4b-a67fd70000002703-30-6437c287e551
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AC.6C.08279.682C7346; Thu, 13 Apr 2023 17:51:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230413085118epsmtip1536a117cd3933540164673b0708ed482~VcnP8mFok1295312953epsmtip1t;
	Thu, 13 Apr 2023 08:51:18 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH blktests v3 1/2] common,fio: helper for version check
Date: Thu, 13 Apr 2023 14:20:23 +0530
Message-Id: <20230413085024.49750-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230413085024.49750-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmpm77IfMUgyVz+C2O/n/LZjF/2VN2
	i32zPB2YPTYvqffo27KK0aP9QDdTAHNUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6h
	pYW5kkJeYm6qrZKLT4CuW2YO0B4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJ
	gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG/hsL2QseslXceKPSwDiXtYuRk0NCwETizo9HYLaQ
	wG5GiaXb0roYuYDsT4wSG//+Z4VwvjFKtG+5BORwgHXsuMwPEd/LKHH+8xJmCOczo0Tby43M
	IEVsApoSFyaXgkwVEZCXWDm7GWwDs4C7xO0nPUwgtrCAq8TP5/9YQGwWAVWJplPbGEFsXgEL
	iQsrPrNDXCcvMfPSdzCbU8BSYtOFl8wQNYISJ2c+YYGYKS/RvHU22A0SArvYJZY862OCaHaR
	+H3lPyOELSzx6vgWqKFSEp/f7WWDsJMlLs08B1VfIvF4z0Eo216i9VQ/2C/MQL+s36UPsYtP
	ovf3EyZIOPBKdLQJQVQrStyb9BQaoOISD2csgbI9JFZ/OsMGCZ4eRoknx1vZJzDKz0Lywiwk
	L8xC2LaAkXkVo2RqQXFuemqxaYFxXmo5PFaT83M3MYLTmpb3DsZHDz7oHWJk4mA8xCjBwawk
	wvvDxTRFiDclsbIqtSg/vqg0J7X4EKMpMIwnMkuJJucDE2teSbyhiaWBiZmZmYmlsZmhkjiv
	uu3JZCGB9MSS1OzU1ILUIpg+Jg5OqQamp8Zdc9gCp0b+Nv7tmcOq63hd7m0vy68rU/5/Z15/
	rc9/7st7R880vzZ69yh81cENqounqPmfXlp8mvNnqIL+h0TrTr/bTjIPGu888ZkiYfPCV3SR
	NpfI1/NvljAGpu9UFl04UVxWTEA2LnvpWyXl5ltOV94e2xj8TbvvnO35gADO7M9yXDzBDfO0
	bE+Jb2aqaFn/2/ckv2bNvYU5V5YLyn+++TnmTnvdahaNhOWHA+aIc/ktPP7mzYsc+beLD1uI
	JXpdlS/78J0vo0HyZtc35lUyh0ofSKn9LPlWXbDC0qkx0HjxJvGyfF+hvSVSco+mFryqnRw6
	76hMAWfK3/V3+h/W74x6uPLqbJ8X6zQilFiKMxINtZiLihMBZ+1ZRPQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSnG7bIfMUg38vrC2O/n/LZjF/2VN2
	i32zPB2YPTYvqffo27KK0aP9QDdTAHMUl01Kak5mWWqRvl0CV8b+GwvZCx6yVdx4o9LAOJe1
	i5GDQ0LARGLHZf4uRi4OIYHdjBLTelYwdjFyAsXFJZqv/WCHsIUlVv57zg5R9JFR4tzE4+wg
	zWwCmhIXJpeC1IgIyEusnN0MNpNZwFNi/UR5kLCwgKvEz+f/WEBsFgFViaZT28DG8wpYSFxY
	8RlqvLzEzEvfwWxOAUuJTRdeMoPYQkA1H56+Y4OoF5Q4OfMJ2BxmoPrmrbOZJzAKzEKSmoUk
	tYCRaRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnBAamnuYNy+6oPeIUYmDsZDjBIc
	zEoivD9cTFOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRq
	YJJj3rJfK+dlRpT0gtWTDGKyfiiIcn/5K+gc/Cvttf1nJf/TN66qv3yudeRJwErHkyXHWwxd
	+tyYCg6WFbaXHPj94oxq7YduhYnJzHuSQ/p3q7ceqgp+sUNj8xxXq1mesjdP3tn+bsLbn03G
	YSIctjHc16/vtPP9/eRtcdUqhescCnOSdk22r97x5ZnWz1X2n806Tjl94gw8V/xo08NVS76q
	1c+uZf874+TF4udrmibNa9bjZldqditfFZbKuFbT/Z0+y6zEyalaOjub/tXv0wxRLvk5qVZk
	RuC0H8kyzHoXc0J7Fm1qkA1y3pIiuvaI0gxuvotaCof2Tqpfwjgp59/W37xc7d4/OgQ2hQV2
	PFNiKc5INNRiLipOBACKuUSptwIAAA==
X-CMS-MailID: 20230413085119epcas5p4e23303b256feab00bd6c2c532296126e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230413085119epcas5p4e23303b256feab00bd6c2c532296126e
References: <20230413085024.49750-1-joshi.k@samsung.com>
	<CGME20230413085119epcas5p4e23303b256feab00bd6c2c532296126e@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_015136_068698_C460775C 
X-CRM114-Status: GOOD (  12.95  )
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

Add new helper _have_fio_ver which checks whether installed fio version
is greater than or equal to input.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 common/fio | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/common/fio b/common/fio
index bed76d5..67c5339 100644
--- a/common/fio
+++ b/common/fio
@@ -25,6 +25,20 @@ _have_fio_zbd_zonemode() {
 	fi
 	return 0
 }
+# Check whether the version of the fio is greater than or equal to $1.$2.$3
+_have_fio_ver() {
+	local d=$1 e=$2 f=$3
+
+	_have_fio || return $?
+
+	IFS='.' read -r a b c < <(fio --version | cut -c 5- | sed 's/-.*//')
+	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
+	then
+		SKIP_REASONS+=("fio version too old")
+		return 1
+	fi
+	return 0
+}
 
 declare -A FIO_TERSE_FIELDS
 FIO_TERSE_FIELDS=(
-- 
2.25.1


