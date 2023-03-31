Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97CEC6FD18
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 03:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T1x3L8c64sT9IQ+EX3Ery3BRF6jYq+O+48Pi0EdVwz0=; b=RQwfHYH4pYvHTq6mb2g/KfzMVO
	fdGtYzRI289en+AHPZkdMgRRITSHxMiAl6bXmavxY79orHP0JCm0rkGGgdE6rTLTcovxzfynavFmR
	fZFH5VUB3p/O+cgWXTXb3OtDOqPpVcH8sw1gPoG+qL0lq/pWshYHJGHHlJ8J5u9uX6RaRoqkyG2Hz
	fbFESTqh9scAbxmCvRm8JfG1Iic4sJOQkq+RHbKWO8QLMwiPlwd1fq61wzROerkPBKG1Mafoh7Dam
	JnGR+orC2EQfc71uebaVwSP4wHBa5jrPrRadsXsoJtbfR0jKHUBgtH/D/FaxVzxdDjiHNMpT9w44I
	pfZroa7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi5sL-005kh4-2F;
	Fri, 31 Mar 2023 03:56:29 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi5sH-005kfh-1s
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 03:56:27 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230331035622epoutp015ee8324bd3b063878dcc18b5f060da26~RZNCITSVP0145901459epoutp01H
	for <linux-nvme@lists.infradead.org>; Fri, 31 Mar 2023 03:56:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230331035622epoutp015ee8324bd3b063878dcc18b5f060da26~RZNCITSVP0145901459epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680234982;
	bh=T1x3L8c64sT9IQ+EX3Ery3BRF6jYq+O+48Pi0EdVwz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vv9+Xelo+Rar7Ea6d0sT06cbgSNcw8+Puymkcos87+MhqjodK57j54pCJfdQHwA+4
	 XRZ7PkOySXy+EAOiJPtQre+bgTyzbZ0mClc/7gCrjGVhLzggVujs/ENvoSvU13YQaz
	 QkxeJUNZh8i1z9UE+dUTZZNBM40LZtwSCRlDCSfI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230331035622epcas5p1b55bd66711029d226cad78b4c1937fea~RZNB2qtsb0795007950epcas5p1J;
	Fri, 31 Mar 2023 03:56:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Pnmg72X4bz4x9Py; Fri, 31 Mar
	2023 03:56:19 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E7.81.06765.FD956246; Fri, 31 Mar 2023 12:56:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230331035615epcas5p2b6a3d51230683acdd2a02c527753b9f6~RZM64rS0s1770317703epcas5p26;
	Fri, 31 Mar 2023 03:56:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230331035614epsmtrp1057b768475e29216d7599fcf8179e097~RZM6363w82409424094epsmtrp1C;
	Fri, 31 Mar 2023 03:56:14 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-ba-642659df6bf0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	34.A7.18071.ED956246; Fri, 31 Mar 2023 12:56:14 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230331035614epsmtip20c741b7cbace2759d3df2fe11b15b849~RZM6I0Ua81443614436epsmtip2k;
	Fri, 31 Mar 2023 03:56:14 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-nvme@lists.infradead.org, mcgrof@kernel.org, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH blktests v2 1/2] common,fio: helper for version check
Date: Fri, 31 Mar 2023 09:25:18 +0530
Message-Id: <20230331035519.42728-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331035519.42728-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmhu79SLUUg4XnTS2O/n/LZjF/2VN2
	ixsTnjJa7Jvl6cDisWlVJ5vH5iX1Hn1bVjF6tB/oZgpgicq2yUhNTEktUkjNS85PycxLt1Xy
	Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
	Ly6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzth/YyF7wUO2ihtvVBoY57J2MXJy
	SAiYSNyddoOpi5GLQ0hgN6PEt4dHWCGcT4wSX57Nh3K+MUo87ulihGlZ2/IVKrGXUWL5u5+M
	EM5nRomvcxcDDePgYBPQlLgwuRSkQURAXmLl7GawfcwCMRITGtYwg9jCAq4S/xqPM4HYLAKq
	EhOu3AWr4RWwkHhxexs7xDJ5iZmXvoPZnAKWEnt/NrJD1AhKnJz5hAViprxE89bZzCA3SAjs
	Y5f4uOIJE0Szi8Tj1T1sELawxKvjW6CGSkm87G+DspMlLs08B1VfIvF4z0Eo216i9VQ/M8gv
	zEC/rN+lD7GLT6L39xOwFyUEeCU62oQgqhUl7k16Cg1ScYmHM5awQpR4SNy6pw4JnR5Gidc7
	prFPYJSfheSDWUg+mIWwbAEj8ypGydSC4tz01GLTAuO81HJ4tCbn525iBCc7Le8djI8efNA7
	xMjEwXiIUYKDWUmEt9BYNUWINyWxsiq1KD++qDQntfgQoykwiCcyS4km5wPTbV5JvKGJpYGJ
	mZmZiaWxmaGSOK+67clkIYH0xJLU7NTUgtQimD4mDk6pBqbmox+tDFrYUnYpc82RXi7n79A+
	9yhbxL5FRfKGk4RePU06dbzRyF1Nuup3hLbFA4EgwcZrt5dptC5ukhL/EN/vulDzi/aj1uqa
	eUZBW/59Om2R27Rv/msz+bar/9LjErPs+T1YzEwXhC1cY7pW+rS9269rfj4zXkhHvTj9+03Y
	ZNffc3gOTtYS9eD/tGPxq3CDik9R+y1D4+yzwzIT29e/mPtAdCm/sF/HgkKue7W5kuqbXRbd
	NqnJ3aRhv31VT2jrcae9MvvUFP7NfTM7Xqpg67t/u1UnSlfeyV2/NOb/M8+zv+Yv+c63t6vm
	+Ltvra48Bsry5v6zZzs3b4hOe3PrRknS+1TjRTM2PpdcF6bEUpyRaKjFXFScCABBRuNK/wMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO69SLUUg1tLzC2O/n/LZjF/2VN2
	ixsTnjJa7Jvl6cDisWlVJ5vH5iX1Hn1bVjF6tB/oZgpgieKySUnNySxLLdK3S+DK2H9jIXvB
	Q7aKG29UGhjnsnYxcnJICJhIrG35CmRzcQgJ7GaUOP53OztEQlyi+doPKFtYYuW/5+wQRR8Z
	JaZObmfqYuTgYBPQlLgwuRSkRkRAXmLl7GawocwCcRJHuz+xgdjCAq4S/xqPM4HYLAKqEhOu
	3AWr4RWwkHhxexvUfHmJmZe+g9mcApYSe382gtlCIDVLL0HVC0qcnPmEBWK+vETz1tnMExgF
	ZiFJzUKSWsDItIpRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzhQtTR3MG5f9UHvECMT
	B+MhRgkOZiUR3kJj1RQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbB
	ZJk4OKUamHa/0mJt62ARvrbb/lkj48fPPT9vxkZ11NWpMBXIfl7Z0y5Wfb9uaahr3W0NxZzz
	CdeKXq2x2DT1+3LltCspm/jq871X3Sk11bB8+fj+548zQ1/df58WtIvnoeOpfR12/k6heZ+r
	xKpifswJWiPVK8D93UzU2Cj6Rvy3ZaWHHz2QbuvmfjHToVn/ltVXNsZn1VZLHj/p/Zdondjv
	4bo/+EHXvkVCC8zv5BxiN+Je9oKpYaHkzgDmQLvY5TtcPnNs2T5T+ft0zV8K+gWXgr8EPDVL
	vrPkzn3BBMavCzYyuk5PEhRh+15nExPy2HXjfobdO1MnW0yalHJpY4mAgUS7PYuw3I4LJ9c7
	r/y12Kr9ghJLcUaioRZzUXEiAG0r6HjDAgAA
X-CMS-MailID: 20230331035615epcas5p2b6a3d51230683acdd2a02c527753b9f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331035615epcas5p2b6a3d51230683acdd2a02c527753b9f6
References: <20230331035519.42728-1-joshi.k@samsung.com>
	<CGME20230331035615epcas5p2b6a3d51230683acdd2a02c527753b9f6@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_205626_211915_D9BB40E3 
X-CRM114-Status: GOOD (  15.85  )
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


