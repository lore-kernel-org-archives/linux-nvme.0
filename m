Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B83CDB474
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=KtqgfIlF3VPq2aPtIlYgKrww64qvxWwxCLzadkF+9Iw=; b=A1XOckYNfYxfa3ghYoxniCyH7r
	NuDggdFXsP+KHtqzShL/UNYR0N6d67xJUkcomg/Yxi0HYWUuiaHFaTIaXPBgEpn8bUByAVhYsL5Y6
	ZOrZPxtR9YFfyVJ1s7gHCAXEGlPrVMDhLKJD28SP4SyuWCtcq7HoH5xqsvGse1po4IS9ZzpwqnYQW
	lDaD9EZuGspuzbETgMnLN5g9NeZmxiHn2HN1rhpUUUhlQmVQSb0Wt1anZpq7HIPSiOV2e3ilwZ05W
	V99Pv7iZIaRDXcwQkO2wH3Y5Rs7ss4me8QJSg82NsIS4h8sr77fYMANE1rffGnh2KvTSA82vvRAn/
	r/vo1geA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpek-002NjK-0r;
	Fri, 20 Oct 2023 13:35:14 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpef-002NiC-0V
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 13:35:12 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231020133500epoutp0305e5bf5c443cedcba27f0ce36d874b3a~P1DMkrp7C2096120961epoutp03I
	for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 13:35:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231020133500epoutp0305e5bf5c443cedcba27f0ce36d874b3a~P1DMkrp7C2096120961epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697808900;
	bh=KtqgfIlF3VPq2aPtIlYgKrww64qvxWwxCLzadkF+9Iw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=BgLvw9xOe/4u+lwSkjEKBBPAtETsj9pCJDTMisp0v45+WXtSV2w6q1juvN+unQ7Dq
	 w6Fi2k7Fwnq28DhzkaNJmuDQhlr/8JU8JZ9/fX+Heyz6r/2I1WPMuR8oD5O3TV3Lek
	 fc7zvq0m26tFbG9+nHvjdEW1JB/Vu/+99EdZogPQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231020133459epcas5p4dca5a61bfe17dff617e66d18c8ef7bf6~P1DLx2R6A3260332603epcas5p4I;
	Fri, 20 Oct 2023 13:34:59 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SBlv61qSFz4x9Pp; Fri, 20 Oct
	2023 13:34:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FE.32.19369.20282356; Fri, 20 Oct 2023 22:34:58 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231020133457epcas5p2107feb6cf7bdf36500e8fc7886effdc4~P1DJ-nsqY2325723257epcas5p2_;
	Fri, 20 Oct 2023 13:34:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231020133457epsmtrp22d5d748a1e2468ef216e245fc536696c~P1DJ_8LjG0487504875epsmtrp24;
	Fri, 20 Oct 2023 13:34:57 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-a5-65328202fead
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.71.08817.10282356; Fri, 20 Oct 2023 22:34:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231020133456epsmtip19e8623a02fa47eed08e58d32c1959009~P1DIxF3la1780717807epsmtip1c;
	Fri, 20 Oct 2023 13:34:56 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	joshiiitr@gmail.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 0/3] Restrict non-root passthrough
Date: Fri, 20 Oct 2023 18:58:34 +0530
Message-Id: <20231020132837.151037-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdlhTS5epySjV4O1kTovVd/vZLG4e2Mlk
	sXL1USaLo//fslmcf3uYyWLSoWuMFvOXPWW3WPf6PYsDh8fOWXfZPc7f28jicflsqcemVZ1s
	HpuX1HvsvtnA5tG3ZRVjAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJe
	Ym6qrZKLT4CuW2YO0FFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi
	0rx0vbzUEitDAwMjU6DChOyMlRNuMxds4avY0XGEtYHxCXcXIyeHhICJxI8fC1m6GLk4hAT2
	MEo8nH+fEcL5xCjxsn8JlPONUeLJ/zfsMC1XT79mh0jsZZTY23eTFcL5zChx59IEIIeDg01A
	U+LC5FKQBhEBF4mGf28YQWxmgRKJA7MmsoLYwgKmEr/XPgKzWQRUJdacWsMEYvMKWEp8mryT
	BWKZvMTMS9/ZIeKCEidnPmGBmCMv0bx1NjPIXgmBR+wSVzb9YoNocJF4fb2fCcIWlnh1fAvU
	1VISn9/thapJlrg08xxUTYnE4z0HoWx7idZT/cwg9zMD3b9+lz7ELj6J3t9PmEDCEgK8Eh1t
	QhDVihL3Jj1lhbDFJR7OWAJle0i8uDYdbKuQQKzEp7krmCYwys1C8sEsJB/MQli2gJF5FaNU
	akFxbnpqsmmBoW5eajk8MpPzczcxgtOjVsAOxtUb/uodYmTiYDzEKMHBrCTCq+phkCrEm5JY
	WZValB9fVJqTWnyI0RQYrhOZpUST84EJOq8k3tDE0sDEzMzMxNLYzFBJnPd169wUIYH0xJLU
	7NTUgtQimD4mDk6pBiaD2pbsTZuTRZdtlF1//t+kDYcWPfnwaOo3ncNbc27rPc89vX+Oyv3k
	8JXchxrehMTkHJ8ZuO7wotxW0Qh+pXsnbk9J2BV1cPW11P8Ltj6OfWDJHdeYUVl+nMmA5WWj
	qNaHwoI32aVqFzm8Wax3HUuJqtb6/vtqJt953wmui7lK7WY6sG1cp7C4oInFKDvmhoDhoc0b
	3vy18drYe/PKCW6zCfPuPl54Vo6/z/bHNcG7JU8XT9fQWrTDoS2ypMRZgUlKsfBiTdCfNdHN
	xerKd+/98Uj4/Fxu/nuV/rJ1juoiZ06cvPNGyLX+i41gLHv5T9+uM/uklhx+MoHLQXjTtBbt
	WeLaRVrfVVLjcre/XTtLiaU4I9FQi7moOBEAONXCZxgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnC5jk1GqwbJ1hhar7/azWdw8sJPJ
	YuXqo0wWR/+/ZbM4//Ywk8WkQ9cYLeYve8puse71exYHDo+ds+6ye5y/t5HF4/LZUo9NqzrZ
	PDYvqffYfbOBzaNvyyrGAPYoLpuU1JzMstQifbsEroyVE24zF2zhq9jRcYS1gfEJdxcjJ4eE
	gInE1dOv2bsYuTiEBHYzSjxb3MAEkRCXaL72gx3CFpZY+e85VNFHRollhx4wdjFycLAJaEpc
	mFwKUiMi4CUxb/YCFhCbWaBC4v/rl4wgtrCAqcTvtY9YQWwWAVWJNafWgM3nFbCU+DR5JwvE
	fHmJmZe+s0PEBSVOznwCNUdeonnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm55bbFhglJdarlec
	mFtcmpeul5yfu4kRHMBaWjsY96z6oHeIkYmD8RCjBAezkgivqodBqhBvSmJlVWpRfnxRaU5q
	8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1MxVdtI0pqMrYpG143+yQa0BzKcTTv
	3SNZXpELfb9KbaPrnqvYX/xYHZEtLFbUwatrP7f0cGFjrsHCcO17Z9icS82TmFcdmGFftixu
	z9Znkt+YHs3QnmbAdLRUZEan7RZxfV5D3/A4mdqUP1pCD8LNt6zMWn/Z/KnXK7apn5ijJTY0
	hP8STmtOMSzfoyI2OZJtZ4vNLvnnq7YZhwRZL0lwm9XwyE99+5cS7+v3Xsu59BismjrjkkVD
	ROK05X/fbU3Qm7l9opncDeP0gltHXUx/Tt39+tDjGzysSa9FrWaISvxKDdCXDKpZMa97557H
	WssXW0g+W6ZZf7vh8ZbP02u0vj3alzjrSdpng38WB6OVWIozEg21mIuKEwHxhbBUzwIAAA==
X-CMS-MailID: 20231020133457epcas5p2107feb6cf7bdf36500e8fc7886effdc4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231020133457epcas5p2107feb6cf7bdf36500e8fc7886effdc4
References: <CGME20231020133457epcas5p2107feb6cf7bdf36500e8fc7886effdc4@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_063509_689297_C1D22A01 
X-CRM114-Status: GOOD (  13.90  )
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

The series restricts i/o commands (that transfer data/meta) of regular
user to use SGL.
This upside is that kernel can offload the buffer sanity checks to the
device. The downsides are: (i) users are restricted to SGL capable device
, and (ii) performance may reduce depending on the device/workload.

I have not tagged 'Stable' on patch 3 yet since it is not yet clear
whether to go ahead with this.

A short performance test [1] shows this data.

4K randwrite workload
*********************
(a) Data PRP, Meta PRP: 777K
(b) Data SGL, Meta PRP: 776K
(c) Data SGL, Meta SGL: 667K

32K randwrite workload
**********************
~131K for all three cases above.

So there was ~14% decline for small IOs on this particular sample.
At this point I am not sure how common/general this situation is.

@Jens: I confirmed that above decline is not because of extra 16b
dma_alloc/free that I had to add (patch 2). Preallocating an array of
required entries did not change anything.
That said, I am not sure if this can show up in a very high-iops
scenario.

Changes since v1:
- Prepared against for-next (therefore reduced code size).
- Move the SGL checks to core rather than pci.

[1]
fio -iodepth=64 -rw=randwrite -ioengine=io_uring_cmd -bs=4k -numjobs=1 -runtime=30 -md_per_io_size=8 -group_reporting -iodepth_batch_submit=16 -iodepth_batch_complete_min=1 -iodepth_batch_complete_max=16 -cmd_type=nvme -fixedbufs=1 -hipri=1 -filename=/dev/ng0n1 -name=t

Kanchan Joshi (3):
  nvme: flag to force SGL
  nvme-pci: data/meta transfer via SGL
  nvme: restrict non-root passthrough to SGL

 drivers/nvme/host/ioctl.c | 11 ++++++++
 drivers/nvme/host/nvme.h  |  6 +++++
 drivers/nvme/host/pci.c   | 54 +++++++++++++++++++++++++++++++++++----
 3 files changed, 66 insertions(+), 5 deletions(-)

-- 
2.25.1


