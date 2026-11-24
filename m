Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAE4606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=e18n2jYw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=i8gBmj3XYyzsRr7KJPE93Yb8qESHdXlQll/ig3WZiQg=; b=e18n2jYw9/qDLH
	oHw+rfMXPKAyUSo2XTHpbBzO76JbDlYz6TH4ByzjZKhYYys6350ovzH1ldBsru4siWM+sddRiDlgl
	HZuMITtTspuiXsjVSI+9pWrwJhHsRAiCvP15IIIaPsU/VP2a0nNB2y25Nv4zaSEjxc4+IUb51f8UU
	rK0WQCpZIBE058McoPaYzohYiuHGgWgjaA8h3Z47En1mYTRvTgpCW/5DZMDfrrkFXzPGKIhUZPJDh
	wXV/QYUt7BFNqGt2nYXbHd8m6fb7xmLeUAxLTc9fL5ERMc9EFJ3jHVixzT0mDgVOaxV6PsSnURZyD
	QpcehZopaqTUKDLjlYkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVuN4-00000007Ml3-2zFG;
	Tue, 24 Nov 2026 17:31:58 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVuN1-00000007MjU-3g3t
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 17:31:57 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFarlY589780
	for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 09:31:51 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j5dcn140u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 09:31:50 -0800 (PST)
Received: from twshared14188.04.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 24 Nov 2026 17:31:50 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id D267D2F803EFE;
	Tue, 24 Nov 2026 09:31:32 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>,
        Zhenwen Liang <zhenwenliang@google.com>
CC: Shao Mingyin <shao.mingyin@zte.com.cn>, <linux-nvme@lists.infradead.org>
In-Reply-To: <20261124051041.3099796-1-zhenwenliang@google.com>
References: <20261124051041.3099796-1-zhenwenliang@google.com>
Subject: Re: (subset) [PATCH v2 0/2] nvme-tcp: fix the R2T send/receive
 race
Message-ID: <179554149285.3972980.13710554314293175293.b4-ty@kernel.org>
Date: Tue, 24 Nov 2026 09:31:32 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2OCBTYWx0ZWRfXykPngPstagqb
 NykH+zAY85xHQly7P1zDAMAm5RRHDqpJkZ7DYmI6pzAju1o1tznpHoHq8UjtnwkoAj7lSL1Y6eT
 KqLYrvrT2YPFGrhsmWIriW2b7lnTvWg=
X-Proofpoint-ORIG-GUID: iIcOtlIJjAJtqQlessZ4MY4tGNv-Abw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2OCBTYWx0ZWRfX3tfXBWh9yWDp
 E+P+5FrJ/NFEezmqzQjH/cXVsvSUQpe/S74bVEg3xBbvDwNvuhoeuMZm20RYINe+yVmjNSQGQC7
 Wk2spJX+6OFhkKGi02DnM6cqZHC8UEU/sJmUq2uGkzCB2084Bvm5gkbJA7LLfzgYySpl7iE4gr+
 GMq/ca5HxQOgByEbkNl1QHFftBmrYZVSi8AHMWvdZP5Do+g/R1en2+xEw+T9k81326BsYmYb0xa
 HlYrcgRoXCstz8lfWRDI9lcKn05E9qeCYCdiA1+Zw7s0A/qRxBXMvjIAWGHh/waAcFni7T37QbD
 yUi/89g8r1ugwzqZ3x8Itwj2MDkhXsLrc/OwryufbCfaJGw3mgTyFhABdM7gHQfSZ+YqR2KVSpW
 CkDPS7h3qZabYIbC+Ya4MZyB+RbKLfF80iga15TFvUV3g6hljKhZpZlmZHDCn8NIg/bjkKdsPHZ
 eK7hCA2KLpXF6BwEz/w==
X-Authority-Analysis: v=2.4 cv=Ku3YSmWN c=1 sm=1 tr=0 ts=6b05ca06 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=IwfdA_ds1OLAHEIX7k8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: iIcOtlIJjAJtqQlessZ4MY4tGNv-Abw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_093156_037283_9716CF49 
X-CRM114-Status: GOOD (  11.07  )
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

On Tue, 24 Nov 2026 05:10:39 +0000, Zhenwen Liang wrote:
> nvme_tcp_handle_r2t() sets up the next H2CData transfer while the send
> path may still be finishing the previous R2T of the same request. On
> stable kernels (with the "<" offset check) this leaves pdu_sent wrong
> and the write stalls until the I/O timeout; since 347d50d92e25 on
> v7.4-rc4 the host rejects the valid R2T and reconnects.
> 
> Patch 1/2 fixes a 32-bit overflow in the existing R2T length check.
> Patch 2/2 moves the R2T setup to the send path.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/2] nvme-tcp: avoid overflow in the R2T length check
      commit: 08be423d20e892e2606172cf69015d34ac170786
--
Keith Busch <kbusch@kernel.org>


