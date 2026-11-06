Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F4606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SLGUUdmt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6uvy8Y5PB5BogqHXs5KLBY6brLmXOD/GskiecvLqIDE=; b=SLGUUdmtVP+5i4
	BR58y1RQ/SvwU+pJZ6vUJHEEV7d1Ai5J7j2bSg9oBOFvwBYNzsE9jON004Xij4TaMLD0U4C1SYLHw
	Mc4rzIXL4hto4obJcKHh6GyZB5jwua8C8vVJ85SaY1ZNE+dvSO54jaU0VGVNXT++zsQUaGtg5iudS
	yQEroO90ZGxozl0Tb6n1kLf5L/XMfPI10RQuttC6ZqHQFyvJ6b5tJpi+h3ul8rWeETRsKS1YV7mLi
	oo+SnVcihskVodPlgG9qq2sOp5gOhoTc1Ko80RbGe5V8KguOxsdjrMitNV+MU1uFLsBGRg8rD7/yN
	rQXibq/kR47GWllhDNXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPN5q-0000000D6vp-1nOT;
	Fri, 06 Nov 2026 16:47:10 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPN5o-0000000D6vQ-0zWW
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 16:47:09 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GX1tb2699763
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 08:47:07 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r1cxme-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 08:47:06 -0800 (PST)
Received: from twshared16865.02.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 16:47:03 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 25F732E8C811A;
	Fri,  6 Nov 2026 08:41:35 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Qiliang Yuan
	<odys.yuan@gmail.com>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <hare@kernel.org>,
        <tom.leiming@gmail.com>, <nilay@linux.ibm.com>,
        <shinichiro.kawasaki@wdc.com>, <stuart.w.hayes@gmail.com>
In-Reply-To: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
References: <20261103-bug-nvme-remove-ns-async-v2-1-44e43766e44a@gmail.com>
Subject: Re: [PATCH v2] nvme: remove namespaces in parallel
Message-ID: <179398329515.3869217.15545511916631956024.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 08:41:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: Vw3aZsffbS3y0CCnLQC5JVH6Vk6DBOKc
X-Authority-Analysis: v=2.4 cv=RboFmFtv c=1 sm=1 tr=0 ts=6aee048a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22
 a=VwQbUJbxAAAA:8 a=795gGRjyxyIWziuDvicA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vw3aZsffbS3y0CCnLQC5JVH6Vk6DBOKc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX2n1RHfCFpSlD
 1nfJK2bhdMlhWJUES9zrZGSW9yf1xyWKSHVosdB2IEFH21oTSyR7pllfPAkDG9Sl/HvjUEAgj7k
 p0l5im/5Blx1p4qTBhHP9CBofSOdJ3g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX3HbxxNYv25Lu
 9r0nmdRMB7cmN9C8N4+Fq8WOVPNNWgcjkH2RGCwZkNt7t7eeqNOkfxjgeYGI0Z0hrXbCuvHjV98
 ACTV0tMtpIeSyEbwp/+t1oBLfAeqGfUv//iygSKSWMOtTFgphBD1wwNcoWBZ4rN77mIOwsA3pbH
 I0EcWAOIKkBU6EJudFLlkJuTnqXby4leymVeio+GnIN/2OiDwy5TNA2RDDavVl0hfHpoyNUfWZC
 AdFglPrnmdSk/Qt705mhJlu0UeqFNa1ISjPifTEb/b1xf1V4XvOZaXVWLX/9xdmlU/9tNRbrdsD
 p2MTONJjck2U1a8KIUyik9xRNT7TXpD/GStXIqIVOz0sR1LAT+KT3WKcaA0apHmQqRtsi+kyxs3
 2SkJSJAL2/JKry77pobe7OyCNWIQ20GuSl5upIvaaEmmCuS0bqDmNVZP6GzdMmZDxPE6qBJROvN
 BKfYPhs8h+AqmDQnd4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_084708_419652_ED069096 
X-CRM114-Status: GOOD (  10.46  )
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

On Tue, 03 Nov 2026 01:28:02 -0500, Qiliang Yuan wrote:
> nvme_remove_namespaces() removes the namespaces of a controller one
> after another. Each removal waits for RCU grace periods in
> del_gendisk() for the namespace and for its multipath head, about
> 20 ms in all.
> 
> Deleting a controller, such as disconnecting from a fabrics target,
> thus takes time proportional to its namespace count, over a second for
> 64 namespaces. Scanning had the same problem until commit 4e893ca81170
> ("nvme_core: scan namespaces asynchronously") made it add namespaces
> in parallel.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: remove namespaces in parallel
      commit: fc991838ef25f1cab9ff34b55b39f16d95ed39b3
--
Keith Busch <kbusch@kernel.org>


