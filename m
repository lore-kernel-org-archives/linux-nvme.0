Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089E606A331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 18:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k92XaK2m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wPGqgpq4ILhntLdO389LmeXWfjnrM37fQMQ8Ob9CkJw=; b=k92XaK2mQkMUhH
	5bLBTP/rt5D8ToeQSQkyoHB/D+GBAjbk0xJz3VK/zPy+TLbjK34FtI7eyETA3XTjXEWWMv9kMBcUR
	ZDwslXqx1vhgPkg3KPBgIznJUVy2OZlTIDq3qgdyPMOUMhWvJqW2pcyBax9rPb2i1MkZDQkLkKPbL
	Ri82essInE+nqMiJT+G8TfGgNblVWqqlBhnK7e2JCuFJxA16KjSryht26hKZhXft7KwzAseMsO0tm
	7chCygcFGyrzArXWERGlzqdXry1Z9SMGd3d4SlmOn2BLPWU0ZxHgdU6JVdoxEHhwroq9SYdvLoo5F
	LYqdD1zbvRcEvRSnDpJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOuN-0000000DQid-0WFp;
	Fri, 06 Nov 2026 18:43:27 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOuK-0000000DQhw-2ttT
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 18:43:26 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A6IeLQB1544155
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 10:43:23 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4hs3r0x1ex-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 10:43:23 -0800 (PST)
Received: from twshared9449.02.snb2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 18:43:21 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id C5E5E2E8EFD4C;
	Fri,  6 Nov 2026 10:43:07 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>, <linux-nvme@lists.infradead.org>,
        Andrew
 Stellman <astellman@stellman-greene.com>
CC: Yuehong Wu <wuyuehong@cmss.chinamobile.com>,
        Nitesh Shetty
	<nj.shetty@samsung.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20261106134313.34829-1-astellman@stellman-greene.com>
References: <20261106134313.34829-1-astellman@stellman-greene.com>
Subject: Re: [PATCH v2] nvmet: accept ANA group ID NVMET_MAX_ANAGRPS in
 configfs
Message-ID: <179399058779.513959.11542324887752959416.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 10:43:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=Cucq4X4D c=1 sm=1 tr=0 ts=6aee1fcb cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=-y6Pi5ZMLliYdh8cQ_kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5MvtrQybJWbrpepAGTsoSnkRF8AmpgN1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfX2HwKRazy64an
 udsDkOiPL4P2myKIVp4wl/ra2AoigOndjG/3Bq/EtPDpV1+9rEM/qIO5gA5vsuilduMlc2ACQHW
 +ygRShQmSvvLnj8LbHnk0QEqeJWKQ7w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfXwmt9GUGyQCoS
 brCaZhNeGxN147jKgLPzDd68UZ1zLIfFMdYTaBpFdy/WQdzD6P1kz1XabgwndGBQIQ2CNZLdeWC
 Y+gcO1E+OvFCXHmq7krK45ph6xJKhywfiW9TtMyL+Z/7W4cumbQNx+AwVXOoCztZQ1JataGI0Xr
 aMWf3NVNzR6+hJFvt3RHSI7t54RRWOGI7ObhS7whTeP7KU16Nj/uP3KDhDfrZL6bvHWv5AIxhEx
 AqOieOyMpvxb4M2Gpfzi25m1+ILPcAtN5mvjQ05fiJs/qV9zuSsJ7R5DUHx0D2T8BCcG6H2yjIK
 2xVeq/sL9T5annAc2fG15kcRXpF1A11mdN2bRnNTYgQDk767vG87JoXRWwoM9pUe8GYR6nhXrDS
 V4er7FtHnNY45r+uAa/aMn8C5hn4lRM8EqAZjTIHKwtWuFiaqNzkX6v1gN07mIEKZuDObwJx/8a
 Q8rZOYPscO82hombcPA==
X-Proofpoint-ORIG-GUID: 5MvtrQybJWbrpepAGTsoSnkRF8AmpgN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_104325_395976_704E7938 
X-CRM114-Status: UNSURE (   9.49  )
X-CRM114-Notice: Please train this message.
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

On Fri, 6 Nov 2026 08:43:13 -0500, Andrew Stellman wrote:
> nvmet_ns_ana_grpid_store() accepts an ANA group ID in the range
> 1..NVMET_MAX_ANAGRPS, and nvmet_ana_groups_make_group() accepts
> 2..NVMET_MAX_ANAGRPS (group 1 is the default group).  Both then pass the
> ID through array_index_nospec() with NVMET_MAX_ANAGRPS as the size.
> That helper treats the size as an exclusive upper bound, so the maximum
> valid ID, 128, is rewritten to 0.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvmet: accept ANA group ID NVMET_MAX_ANAGRPS in configfs
      commit: f3c20e42ff5628b93ed0084154cf62082a2157b2
--
Keith Busch <kbusch@kernel.org>


