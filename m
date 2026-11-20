Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F886606A6C1
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wiEy9AZh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=y8DfzjudfAvgq7dOPWtYwSKrib1FPyJC+jufCCncUbE=; b=wiEy9AZhzBqpFY
	HM0Ns7p6PWiSY5P0gnGHwVaRGk50UI+qhs0UuWEc15jnzYY9XY3+s2w7Ea7aDs1Fmj6TW4Fw7R1ce
	YPtOcCn/O1/Czy/2rHrfUQVb4uVMHyX1dd+K4ZPE+WE57OvxBwzqRqjvFb2FP4By/NB0L+FsOxLYF
	V2Wh3yItCqZs5D5etuOmk2bY5iQeP2AAwdyeBRZYYuIyF7WbTHZAvB71rco0k14u3LWI/SbTRYvus
	qwsCfZn2bte8TNBCreTH6UVSiXV5SD0W9QJP/rvn5IwTUoEZV0XMMyY3vSv6vMmdtCMvokn0hVtho
	kW1b8ImR9G9wApuFXDlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUhJ-0000000G8uC-3i4W;
	Fri, 20 Nov 2026 19:55:01 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh4-0000000G8l1-0F8p
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:47 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfbKQ4076606
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:45 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4j2bb2p536-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:45 -0800 (PST)
Received: from twshared24494.03.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:40 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id E355B2F4934D0;
	Fri, 20 Nov 2026 11:54:23 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Hou Tao <houtao@huaweicloud.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
        <houtao1@huawei.com>, <xierenfeng@huawei.com>
In-Reply-To: <20261117130743.2871972-1-houtao@huaweicloud.com>
References: <20261117130743.2871972-1-houtao@huaweicloud.com>
Subject: Re: [PATCH] nvme-pci: handle the missed doorbell write due to
 passthrough req
Message-ID: <179520446391.200156.15680567162900590871.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:23 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=KqnYSmWN c=1 sm=1 tr=0 ts=6b00a585 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=VwQbUJbxAAAA:8 a=-Ag2BBKruglH6bV3EtYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX2ZsfvcWMDg+G
 JKDnJXZV/R2CLLMtfxLCZrUpU8bFhmxiGpP2Y+oc2WgRy570FgUmtEzrWOfVnlYjZOU+N6SBhsZ
 AcPgRY7b0y9KHSdOeRtWd7Vg60UB3WAt337jIvt4wHulMUVq9j6rkXsohCjk0PzZEs7vSN3Fop5
 3WlA2wLjHueEcyGPssZVuXKT+86vV4ExiM54r8R/q9hljBEadi97CnqNiROVMLMbMdZ4SkPsnWV
 WyYIvaMbY1dORRwUenWmcOknoFQfu4c8wQHp04vx2NvLMzk13xzQ7iLB7F/ZXZ27J1MUmDvZUOC
 CJEk6iNJbOO6p3RVOEk64Q5jVqMjGylkWJdywvfTUHXdBT2dp0dG14din3L8JtTaPvQV0c5BbNn
 dLiXbVSd2USnHcOJWtLvb8DuTQGAxtvev6S2RB7+fnlXngJEYGDzMMiGVv2pBY9UeP3ANlCq0T5
 8uv2kXRPGdTbpPWkSlg==
X-Proofpoint-ORIG-GUID: aU9uPv5-VO2edrmlEegJsG8aag6IeasL
X-Proofpoint-GUID: aU9uPv5-VO2edrmlEegJsG8aag6IeasL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfXwLbiBgb5A1yi
 MJOEmF6v1mLOL4DYGslB1/86LugdpUeJjr5w3v8UZuN4t0BHPPMv1XY9P6Rr649ObWV6OQP+DKv
 fCFEd19Ac/DKSIrSEleB2E4akGjmYBc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115446_237894_5930545A 
X-CRM114-Status: UNSURE (   9.04  )
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

On Tue, 17 Nov 2026 21:07:43 +0800, Hou Tao wrote:
> Commit 1cc4cdae2a3b ("nvme-pci: fix missed admin queue sq doorbell
> write") lets blk-mq invoke ->commit_rqs when nvme_queue_rq returns
> failure or there are still pending requests in the dispatch list.
> However, it doesn't handle the case when only passthrough reqs are
> queued after the req initiated from nvme_init_ctrl_finish().
> nvme_queue_rq() will return BLK_STS_OK for these passthrough reqs due to
> REQ_FAILFAST_DRIVER flag, and the controller reset will fail.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme-pci: handle the missed doorbell write due to passthrough req
      commit: 4af3ea9d8049d883a912a5fab5eeb483982ad9a9
--
Keith Busch <kbusch@kernel.org>


