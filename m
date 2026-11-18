Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0CD606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EKnASKER
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jsJeHMkPdNev+Xkq1iaFXCxN4ARySNZFCQlN5OjLmNo=; b=EKnASKER6N/eA4
	JoO0M2d4Py1DeLXzwFvvZ1bgmgFdPCUF5JmnRHB8kvAwmYuJaXHJGih32XpqkvgjfcD5uN58qTIvq
	Kk+aUHDysM9WY0E+V52QkjP8QKwogqUuDxgrrftf72+51lcUGZL2hP9u4deZliLmX4BaS3JNc2/fo
	HHjK8fzbE39tegNmhYh4f7ZMH7dHSbTBPtXQNhUEMhEeBHGriqFcxTFQtOGwE8BsdJr/uG9Sqi0tf
	v73KWOZbMlXAjpP/e4+5BFe1PTjATPyqopAO+uHjbcb0LU43uIqLcObwP4nWd+k91bL7nAKKdIQd/
	b4U5gPC0m1HC3vTFnFLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTi8k-00000009Ozn-1IMh;
	Wed, 18 Nov 2026 16:04:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTi8f-00000009Oxo-193D
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 16:04:02 +0000
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIE4gtj3100562
	for <linux-nvme@lists.infradead.org>; Wed, 18 Nov 2026 08:03:49 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu66d13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 18 Nov 2026 08:03:48 -0800 (PST)
Received: from twshared18199.01.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 18 Nov 2026 16:03:48 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 673312F281A21;
	Wed, 18 Nov 2026 08:03:36 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Ankit Gupta <ankit6791@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        <stable@vger.kernel.org>
In-Reply-To: <20261117011230.10288-1-ankit6791@gmail.com>
References: <20261117011230.10288-1-ankit6791@gmail.com>
Subject: Re: [PATCH v2] nvme: limit Write Zeroes to 65536 logical blocks
Message-ID: <179501781641.1620426.13226357559228704463.b4-ty@kernel.org>
Date: Wed, 18 Nov 2026 08:03:36 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX169ZzoG9iHi2
 /iBPfLTsUEFOpFF5/tyjgfw197lpbD9+mJK6g6ST3dDjTWjeaR1lF0BES46mDIpo4/jA4FmxWJT
 tXkiA4cESsvoC3SjHA/oM7x8x5B1Y9KjrTYshLdOLTFDLDsoqvtdyD8C17a6ajNewuhf559wv0U
 ifBxF/yRnkr/H7gTgAjTK63f4fomPBunh5NaX8aSlX0yHrwkd26HE8Ywx4pCIdX765T09v9vXJo
 f1SSTQ89Qkhv+GyjJRpaJVyivXz0QO5AfNtmhHVFLfbChotnIB4xbBfxsKfW8HayCs9934/9b/a
 rw2ISY5xnPZkzoCkWI6Z8sPB4R9sFKkd8jrFJ5q9K8jw593ufiY2QQsUT3vVQwKkUuGqgAUoQAn
 fUDXFJpUcO3vL4GYa5uldbIwX/tbHPHMEWLVIdhoOcBiF1lGCBAzT+ESnCxhnLL1xSwKaIJONj0
 kwj8wQm5FNOhy+kenSg==
X-Proofpoint-ORIG-GUID: nHVGxc0-vViuv6RiEip0QBZPZUk48DDM
X-Authority-Analysis: v=2.4 cv=DrnDa2/+ c=1 sm=1 tr=0 ts=6afdcc64 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=VwQbUJbxAAAA:8 a=qFBJAfofNFoZCmylNHQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX+6tbopfi//k2
 ui0N5xTIw042z5ZjFV1ZFVLp2Zz4W4oDuB1xCLLc4ksg9rDO4CH6O+AQYemQksnHzKgDsPCYcIL
 XOfX5zC0t0YlxRTO5TdVmOztp0YCebk=
X-Proofpoint-GUID: nHVGxc0-vViuv6RiEip0QBZPZUk48DDM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_080401_438274_27F3CB3F 
X-CRM114-Status: GOOD (  11.01  )
X-Spam-Score: -1.2 (-)
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
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 17:10:49 -0800, Ankit Gupta wrote:
> With nvme-tcp connected to nvmet-tcp at default settings, the target
> reports MDTS 0 and WZSL 0. A 33 MiB Write Zeroes request on a
> 512-byte-LBA namespace then completes successfully after zeroing only
> the first 1 MiB.
> 
> The native Write Zeroes command encodes the number of logical blocks
> in a zero-based 16-bit field. The namespace queue can advertise a
> larger limit, either through the MDTS fallback or through WZSL. In
> that case the host truncates the count when building the command and
> reports success after zeroing only part of the requested range.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: limit Write Zeroes to 65536 logical blocks
      commit: 49a768272ae1445714efc6ab2b23f9de1398d61e
--
Keith Busch <kbusch@kernel.org>


