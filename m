Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A718606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UHiChK9Z;
	dkim=pass (2048-bit key, unprotected) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=Xs2Qsy3b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YaoPxe+/5/SGWGLLv6ukiV9xF08hHeAvEmpAkUT9KdI=; b=UHiChK9Zm8jcc198kY/hlQ8iOK
	ONlhCsv15bXp4y6i3EnzVvj9+u/80pE4WxvvnZ4T7BKjyMchdnAyuumFteuABfmnrCPWV4MSKbY+t
	aGiJQrQxJ81NHjWisexmcciJAw/DO9Cb7qg5FFlapKNVCReMuLyTnvG9ITVnWvwAV+BP9fwAn1Odp
	k6c1cykP7ySzIjJEFnXPAXHQZo6iMhHorV53qbzAR6IkDyXu+L3uGiHPMP+qc4zfGPE0ql77lpB67
	LkkquBs/ZNbWOHDPfZzwW22jhd0aSoyVm0wsLC+Tv/W7vU03HJY5N5CdXTV+pvKGNe4PBaYiU8exJ
	pjAJHUyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbLN-0000000CgLD-3lzK;
	Wed, 21 Oct 2026 18:47:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJbLK-0000000CgJt-3aGh
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 18:47:20 +0000
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LHrvQp2288347
	for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:47:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=YaoPxe+/5
	/SGWGLLv6ukiV9xF08hHeAvEmpAkUT9KdI=; b=Xs2Qsy3bhLKnq75xF3PRwEb5S
	W3yVyX/q7z+xCKJZyKUa2yBHRhbWbnm49xFyk1hFNY/O5lDKEamYx9h0HfMyL+Ma
	pv8YyJjkyT3ylgzVBFFmVE4fAjN3I+rwC+64WgwMsBQ4ceTT+leAxDd/Axw3vZZV
	dwKIe/YKzrT0hDdkvABXMdjCg5kX6VWzNdJicT7CKbUomkFNcnJlYK7YqR8rtt6v
	NWkd0L9i54MRDO8cYAMKKOrdmsxd/yCzKtUtQathUqlR9w7+kxf2RaBtvwqHX52c
	OCThjH1K7Pl0E4VWJdmqfEdaGXXQfWZy9k2tzmXVJnE0fd13B6H/hwsNpgGvw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hdw50euc1-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2026 11:47:16 -0700 (PDT)
Received: from twshared31846.02.snb1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 21 Oct 2026 18:47:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 972612DBB477C; Wed, 21 Oct 2026 11:46:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <asml.silence@gmail.com>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/2] block, nvme: minor fixes to dma-buf support
Date: Wed, 21 Oct 2026 11:46:56 -0700
Message-ID: <20261021184658.644645-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DMgacCNb c=1 sm=1 tr=0 ts=6ad908b4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=feg3AUGto1_ON38LRJ0A:9
X-Proofpoint-ORIG-GUID: 5o6zm-AMBKC4h6sMFKEx49EmhwFUKU2H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX5b2bA/WiYgr1
 2uwtF4ooPRXtD8KjXzYgK75cHBu/3VFt3b9/F6SfgOxk9FhzylxvuTmG4HUkzPIypxDuiP3RXx6
 pcQuFr4rsfyyWxpV9joBxuC5CwiikZHN5khzKFf4gXuR+k0CEsnIKOW9wXamoURtPmSiloRZrpN
 D9McFZROA2ob6ECAhF2lewfsI0hoI+FnuJeX1oNgpndWt8L68LVFNpvJhZSN/TqhhDgKzktXOdE
 zoKwpPqVecFA/55FpEGBu6T7tQXL2YhqdBIgTJSJpqJO3snPnI5w19IjEMv4GlmJm1aGeZg7nQL
 N/uVtnn4cvgFgDW9DiziBhoYi45H41kUrkkhF0lzC2jhTF6Q6qmI/CFold1mISv74JEt+HlnyVS
 UM7be1qAi1MmmwhgDofUooeM7Qbf+HPBGBmciD9WXYj+Q59FYb52WAHnYWmun/y5SKrzqFMfUN7
 DkrF08DvERJOS2tVIcA==
X-Proofpoint-GUID: 5o6zm-AMBKC4h6sMFKEx49EmhwFUKU2H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3NCBTYWx0ZWRfX0M5tUgszzQpY
 sL/jXrRIkRdjUNYm/kVaw8rrTBBVhiqDxM3cdRaC4Xc3PmYzgikg0w3+TYvEYp4nAWoO6Ycij2e
 1joAgyVmCwUQdhDcyv4Tfl/X98OG9+w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261021_114719_028234_67F771D2 
X-CRM114-Status: GOOD (  10.78  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Busch <kbusch@kernel.org>

Just a couple minor fixes. I wish I could say I caught the first one
myself, but no, I prompted an LLM to look at it.

I am assuming changing the bi_offset type to accomodate large offsets
isn't acceptable as the bvec_iter's size appears to be packed to be
small. I think there's a path to accepting larger offsets through
bi_idx, but the patch proposed here is a safer quick fix.

Keith Busch (2):
  block: reject dma-bufs larger than 4GiB
  nvme-pci: detach dma-bufs only on removal

 block/fops.c            | 4 ++++
 drivers/nvme/host/pci.c | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

--=20
2.52.0


