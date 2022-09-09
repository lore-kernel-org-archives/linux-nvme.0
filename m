Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA74ECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=Yidq+6bJizUUOpFe21sg8VOzg2xlBP4OwCijxlQB6Ps=; b=y2jPwFoktoim9Qx4FsA9c+qMoN
	fz1AI/5kmaK5LyGqFL0Q6YyYMt9g1TMnVAi6uoVfRh0+kX6EvhydRTvJBZ6F4JJTnSv5rQHlm+Nyc
	wqaixHm8FQH7lOGft/69mgsz0T6WqPGshgVRsWL+hbHX/oOmfIRN9Yc5yjMPi3b5sFI6xD0USkgyC
	d210rNDsHox9Xs2wfK2cRuoIMxpRvE9Nom1y6i6L4fT5kak6MmZl7RriRnyi4w8GS1U8BF4wfLrG0
	r4PROPO5vcQ3QIVXY1N4233eTci6cNZsJR5Ux1Xp4FZTnYA9fdvxzqlSy9rAKAmGPe97biqJZiy/S
	AxbntZRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWh6L-000Qjo-1S; Fri, 09 Sep 2022 16:43:33 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWh6G-000Qhi-Lu
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 16:43:31 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220909164318epoutp04903815cfcf3bdf2e031d01c5d6807bac~TPtsi6FW72947229472epoutp04f
	for <linux-nvme@lists.infradead.org>; Fri,  9 Sep 2022 16:43:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220909164318epoutp04903815cfcf3bdf2e031d01c5d6807bac~TPtsi6FW72947229472epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662741798;
	bh=Yidq+6bJizUUOpFe21sg8VOzg2xlBP4OwCijxlQB6Ps=;
	h=From:To:Cc:Subject:Date:References:From;
	b=S0ksPCb8z8miuLUquAue7J86vg7dFi7ibw+HE12JJH5VpUcfqLzgkKJIUqSxh288T
	 mVGRQHoSwrg56/MB9udhJH6SmgP3njPC9pzo3+s2ytp26TMANIVW0U5MWl5Z6oDOeI
	 mX1DiFbBreAm8er34xiqpIb1MAFQkV3Rxz72V4iU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220909164317epcas5p3bdca9851c65c7978ef45086f8bd88b3f~TPtrolFrl0326403264epcas5p39;
	Fri,  9 Sep 2022 16:43:17 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MPMHl5vbXz4x9Pp; Fri,  9 Sep
	2022 16:43:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.83.59633.32D6B136; Sat, 10 Sep 2022 01:43:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220909164315epcas5p17de296f5c0796ecf92fe3d0e4a020901~TPtpwjjQQ1453414534epcas5p1C;
	Fri,  9 Sep 2022 16:43:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220909164315epsmtrp2923e52b01146b2755d5a21148fabbc0e~TPtpv1gAH3168931689epsmtrp2c;
	Fri,  9 Sep 2022 16:43:15 +0000 (GMT)
X-AuditID: b6c32a49-06ffe7000000e8f1-55-631b6d23d136
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8C.EC.14392.32D6B136; Sat, 10 Sep 2022 01:43:15 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220909164314epsmtip13221f735361dad78f03990df69675e79~TPtolNwei1259512595epsmtip1a;
	Fri,  9 Sep 2022 16:43:13 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, j.granados@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC 0/2] nvme command whitelisting
Date: Fri,  9 Sep 2022 22:03:05 +0530
Message-Id: <20220909163307.30150-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmlq5yrnSywZS1Ohar7/azWaxcfZTJ
	Yun+h4wWj+98Zrc4+v8tm8WkQ9cYLeYve8puse71exYHDo/z9zayeFw+W+qxaVUnm8fmJfUe
	u282sHn0bVnFGMAWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA3SPkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE74/vaB8wFG3krjry7yNrA+Jeri5GTQ0LARGLqvg7mLkYuDiGB3YwSV9vO
	M0E4nxglphy6wgjhfGOUeLO2jRGm5WnvN6iqvYwS/45Ph+r/zCgxde5BoCoODjYBTYkLk0tB
	GkQEXCTeHdnCBmIzC1RJzLq4HGyQsICOxJkXC1lAbBYBVYmXbTfAbF4BC4kXzUvYIZbJS8y8
	9J0dIi4ocXLmExaIOfISzVtng+2VELjGLnFk9QM2iAYXiVtPH7FC2MISr45vgRokJfH53V6o
	mmSJSzPPMUHYJRKP9xyEsu0lWk/1M4Pczwx0//pd+hC7+CR6fz9hAglLCPBKdLQJQVQrStyb
	9BRqk7jEwxlLoGwPibYd35hBbCGBWInGtwvYJjDKzULywSwkH8xCWLaAkXkVo2RqQXFuemqx
	aYFhXmo5PC6T83M3MYJTopbnDsa7Dz7oHWJk4mA8xCjBwawkwstiKJ0sxJuSWFmVWpQfX1Sa
	k1p8iNEUGKwTmaVEk/OBSTmvJN7QxNLAxMzMzMTS2MxQSZx3ijZjspBAemJJanZqakFqEUwf
	EwenVAPT/LS0++fStj29X2pjZmeZ/ccooVTW1mnWe3u3gjl3L5nYJBk62C5+xMAecXv37vVx
	E8rDd2gs/57P835LwG2V/INZvX/2v32xWqOG2dzNtKh7a7lLVHKH0McvysGTnjVJzff/rxd/
	MO31i/XZSbwJv+dycUU9MOxXPfyTeZHYtAt53IF6s68Y/dtRzFbE7Pxn2tq/v3+cW3tmrT7z
	9EfTNY6/+mwRvC3l37r99u9/yx248fp7V8u7/eqLuRIaFy9hE7j+ceHslj23k5vLI5V+ap0t
	MXjyq4DHmcP3qMC3KlWLKMO5W3VFmh/vfLM8Uebc6+S3hoWrm1Zezuatu3Rty4knf/2DhF3r
	fCc+/mfEqcRSnJFoqMVcVJwIAP8BljcSBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWy7bCSnK5yrnSywfleAYvVd/vZLFauPspk
	sXT/Q0aLx3c+s1sc/f+WzWLSoWuMFvOXPWW3WPf6PYsDh8f5extZPC6fLfXYtKqTzWPzknqP
	3Tcb2Dz6tqxiDGCL4rJJSc3JLEst0rdL4Mr4vvYBc8FG3ooj7y6yNjD+5epi5OSQEDCReNr7
	jQnEFhLYzSjxZbk7RFxcovnaD3YIW1hi5b/nQDYXUM1HRomeC0uYuxg5ONgENCUuTC4FMUUE
	vCTONZaDlDML1EksmbwTrFVYQEfizIuFLCA2i4CqxMu2G2A2r4CFxIvmJVDj5SVmXvrODhEX
	lDg58wkLxBx5ieats5knMPLNQpKahSS1gJFpFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+
	7iZGcMhqae5g3L7qg94hRiYOxkOMEhzMSiK8LIbSyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
	L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUw7Q51LpLyYV5d0lNy7ZCdwZu565mOLrFPO/d0r5mo
	/zyhaYtbvWKLq20jVvy/bx7w3HcPr3aT3CnG6+ZBEW/m+n+NtjnwzXUBt9y8shOVbL2Mzjpf
	D6hw9l6ftFjV0CR6j8xVt11zXZSPltjapnrtUEjvK/NY7/95287p3SvsudcrN+/wmdex9Kf9
	3UUZpppJDh5P9fRkBG873ExZsEM0janm+LoNUcdE9zy6cfWWzeRIL47+5VcO7GVd0z1ZtaBs
	59rT+qkNYuvW5jtYTc25ZfTq/BWv9OcOgnG86xuC88u+vv0cfDsg0uyy3+yrKRFsC3fUFJ3l
	XX6ep11IuXJpgV2lYn59t+Jlvp2bZXiVWIozEg21mIuKEwFqEhWeyAIAAA==
X-CMS-MailID: 20220909164315epcas5p17de296f5c0796ecf92fe3d0e4a020901
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220909164315epcas5p17de296f5c0796ecf92fe3d0e4a020901
References: <CGME20220909164315epcas5p17de296f5c0796ecf92fe3d0e4a020901@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220909_094329_190252_17FAE70C 
X-CRM114-Status: GOOD (  12.81  )
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

Hi All,

Passthrough has turned much more useful than it used to be. Specifically
it has begun to offer
- Availability: via /dev/ngXnY, for any current/future nvme command-set
- Efficiency: via io_uring driven passthrough

Now that user-space has more reasons to pick this path than before, the
existing CAP_SYS_ADMIN based checks are worth a revisit. Nvme-native
applications requires 'querying' certain information (such as lba-format,
namespace size, log-pages/get-feature etc.) to start doing io on the
device.
Currently both io and admin commands are kept under a
coarse-granular CAP_SYS_ADMIN check, even if device has successfully been
opened with write access. In example below, ng0n1 appears as if it may
allow unprivileged read/write operations but it does not (same as ng0n2).

$ ls -l /dev/ng*
crw-rw-rw- 1 root root 242, 0 Sep  9 19:20 /dev/ng0n1
crw------- 1 root root 242, 1 Sep  9 19:20 /dev/ng0n2

This series attempts a shift from CAP_SYS_ADMIN to fine-granular whitelisting,
similar to what SCSI already has.

Patch 1: contains the whitelisting implementation. Patch-description
outlines the policy.

Patch 2: Changes the sync/async passthrough to employ whitelisting.

Purpose of the RFC is to seek feedback on below two points and path
forward hereon.
- Whitelisting scheme as described in patch 1
- Driver-defined static list (current one) vs dynamic list
  (mutable through sysfs or new admin-only ioctl)

Kanchan Joshi (2):
  nvme: add whitelisting infrastructure
  nvme: CAP_SYS_ADMIN to nvme-whitelisting

 drivers/nvme/host/ioctl.c | 106 ++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 32 deletions(-)

-- 
2.25.1


