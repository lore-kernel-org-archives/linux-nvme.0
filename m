Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1DEC76196
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 03:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=6xqChb8rYL0P66r9oyolvyFiRZohOH4Bg47/VRoUBB0=; b=pbYjJWm+Ma1tKbDuDAjphI+R5U
	WDygYiclZfTrYV4lOEok8x9npSZC5eljEGpdXeSglo5QjspPQNj9WupLHUXr1rlPikRvYGtFppJ23
	Qk7368L32jtVVLim1V7abtG+JEEdKA6GzUPSY5qXu00MUFZ8KtXLNaQ9gHXiZIxYHuxmluRrJTnU0
	cJER9pOqk8IEUJFzFO6JhnkPOKQ+1lToN2xeVJgs1203xGPEh/dUy7vy3AJG+ti3NnOkCWP2qQgG6
	iE48mukWwvUGWdI5cKztwaq4nVjlA+cKCd21EakfkWpGIQSQ3+HVGTyCHVBOp27e8cFlEN8Bz2ebn
	Y8vOl+Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi5sJ-005kgT-27;
	Fri, 31 Mar 2023 03:56:27 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi5sF-005key-2C
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 03:56:25 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230331035617epoutp01fd7225c2896cfa771ac2a81394d33136~RZM9SMVQT0145901459epoutp01D
	for <linux-nvme@lists.infradead.org>; Fri, 31 Mar 2023 03:56:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230331035617epoutp01fd7225c2896cfa771ac2a81394d33136~RZM9SMVQT0145901459epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680234977;
	bh=6xqChb8rYL0P66r9oyolvyFiRZohOH4Bg47/VRoUBB0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=tVaVVmk+PruEfWcW/E1x30V+OHhMJZ2PoxTEJ6iOM485qZOQnY0Mb/+cguJaREttt
	 XkJmLgRyGsN7ZnNbnYrEb8bqF/uC9qqOfbUB89HpCk5kxlPCuIF4LNhzyQLnFmvrpb
	 OlkTNvFi45Nn7AOLI8hps94WIsRuvFLR3RM6Mo+k=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20230331035617epcas5p2af6e2fd59d6edda43392cb518ca3922e~RZM9AgK3M1770317703epcas5p2A;
	Fri, 31 Mar 2023 03:56:17 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Pnmg31z4Kz4x9Q9; Fri, 31 Mar
	2023 03:56:15 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	61.07.55678.CD956246; Fri, 31 Mar 2023 12:56:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230331035611epcas5p32847bd838cd6a8d9abbdd41e6c2df282~RZM4BDESp1387513875epcas5p3J;
	Fri, 31 Mar 2023 03:56:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230331035611epsmtrp101adc874a63ca60de24153505f1d46bd~RZM4ATwjD2409524095epsmtrp1_;
	Fri, 31 Mar 2023 03:56:11 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-5a-642659dcd85e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	FF.43.31821.BD956246; Fri, 31 Mar 2023 12:56:11 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230331035611epsmtip210127d01cf1987b2780e47073d7ea10c~RZM3Rwyn71411914119epsmtip2V;
	Fri, 31 Mar 2023 03:56:11 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-nvme@lists.infradead.org, mcgrof@kernel.org, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH blktests v2 0/2] nvme uring-passthrough test
Date: Fri, 31 Mar 2023 09:25:17 +0530
Message-Id: <20230331035519.42728-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmhu6dSLUUg4XL1S2O/n/LZjF/2VN2
	ixsTnjJa7Jvl6cDisWlVJ5vH5iX1Hn1bVjF6tB/oZgpgicq2yUhNTEktUkjNS85PycxLt1Xy
	Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
	Ly6xVUotSMkpMCnQK07MLS7NS9fLSy2xMjQwMDIFKkzIzmh4c5uxYDNLxcIFQQ2Me5i7GDk5
	JARMJPq6prN0MXJxCAnsZpS4cfouG4TziVHiS8d9KOczo8Tn3qlMMC2bvl1lhUjsAko07WWE
	q3q+aB1QCwcHm4CmxIXJpSANIgLyEitnN7OC2MwCMRITGtaA7RYWsJHYf34BO4jNIqAqcer+
	XxYQm1fAQmLFsr+sEMvkJWZe+s4OEReUODnzCQvEHHmJ5q2zmUH2SghsYpeYtXMPC0SDi8T3
	41egnhOWeHV8CzuELSXxsr8Nyk6WuDTzHNQ3JRKP9xyEsu0lWk/1M4Pczwx0//pd+hC7+CR6
	fz9hAglLCPBKdLQJQVQrStyb9BTqTHGJhzOWQNkeEqf3TQGbKCQQK7G7+xXTBEa5WUg+mIXk
	g1kIyxYwMq9ilEwtKM5NTy02LTDKSy2HR2Vyfu4mRnBS0/LawfjwwQe9Q4xMHIyHGCU4mJVE
	eAuNVVOEeFMSK6tSi/Lji0pzUosPMZoCg3Uis5Rocj4wreaVxBuaWBqYmJmZmVgamxkqifOq
	255MFhJITyxJzU5NLUgtgulj4uCUamAKtThsOeHpB6O9kU3sRnn1WRyPK7m42LbPnOtyOSTS
	aXrP97lGAhOfzb54QfFpWbl9jI/knj+hlS1vMvomN+tLv5zdzMAofVWl/evNE1MTNJNrU079
	V76bMGXiCq5pAlv1Jnysmbbe6XnrS0O+669sZQ0nL40sO55/XZ71vYpOVcd3lix++8oHVprH
	muZ3tc946WGntqP92tpFK19mBp2ZJvfUKXR51Rk5je/umy4bqGf9/jJ7Y+sfmW35Tx3qv7i9
	KDB6YW1+j13ssgeP1Ztkmw/erU9PXjTPfPL6yP0k69Yn5apNEWpWjy/6LPuz8M+d6pNnM9a8
	+6C3w2gPyy6FpUU3jhbvM34ucP13TWWaEktxRqKhFnNRcSIAo/g7N/MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWy7bCSvO7tSLUUg2ufjSyO/n/LZjF/2VN2
	ixsTnjJa7Jvl6cDisWlVJ5vH5iX1Hn1bVjF6tB/oZgpgieKySUnNySxLLdK3S+DKaHhzm7Fg
	M0vFwgVBDYx7mLsYOTkkBEwkNn27ytrFyMUhJLCDUaJh5SMmiIS4RPO1H+wQtrDEyn/P2SGK
	PjJKLOpdBdTNwcEmoClxYXIpSI2IgLzEytnNrCA2s0CcxNHuT2wgtrCAjcT+8wvA5rAIqEqc
	uv+XBcTmFbCQWLHsLyvEfHmJmZe+s0PEBSVOznzCAjFHXqJ562zmCYx8s5CkZiFJLWBkWsUo
	mVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERx4Wlo7GPes+qB3iJGJg/EQowQHs5IIb6Gx
	aooQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTKe1XSVd
	bBzttr457jZnmlthyia/31kFbWoSNm/ZYxj/n1t8buWjov3/X57aO+PYYYvZ7gt69mq5nZny
	cv+NHFs+o2hZ9vdRRRs79Q33c+q/3/nlxdoSo5tnFn/qXi6+vf30Ws+1UTWiTqldv12LDLdf
	+b3BRrItxrJC0mKaQLnWyZrCq5IHIo68SFPesNzV4WvU5FzH8hO7Qw4zMt0o9D/Mukbn7wS/
	6F6nFVd1Xnx7F3xk6oTNb89qNlcdf1T84vbDmjlFVf/6Zt972xESrG+QPPHAmicntjF8U7/2
	mu+V6nKzBVUTtPX4tB/0zP3oY39Ow/b6gl/XEqsZ24ulPoWu9tyxMj/2/gv503oMq0yUWIoz
	Eg21mIuKEwFMq/v/qwIAAA==
X-CMS-MailID: 20230331035611epcas5p32847bd838cd6a8d9abbdd41e6c2df282
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331035611epcas5p32847bd838cd6a8d9abbdd41e6c2df282
References: <CGME20230331035611epcas5p32847bd838cd6a8d9abbdd41e6c2df282@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_205624_055151_BA492401 
X-CRM114-Status: GOOD (  14.41  )
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

Patch 1: contains a little helper for fio version check
Patch 2: contains few tests for uring-passthrough on NVMe device

Changes since v1:
- Remove dead/commented lines in patch 2

Kanchan Joshi (2):
  common,fio: helper for version check
  nvme/047: add test for uring-passthrough

 common/fio         | 14 ++++++++++++++
 tests/nvme/047     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 3 files changed, 59 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

-- 
2.25.1


