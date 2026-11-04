Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFD606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pZJb88r3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1t/7T0faC2SM19oIUCWuL5pucy0UjfML+/dd6L6UdM0=; b=pZJb88r3aVB/BL
	TqWReBidTBBzBk6Sm5UQkTQHt+KQSj2snVTye1lp8YH6/mjGaikSSCNTnl6RSc6r/aeDvDhS85gkb
	AZsHBDaF8RZuuV3ZImU49M0lpK/poJyFNdQ1y0x9dT1Uqtd7uIzGv0yhzGFVSg6cBf697gB7hgcxB
	WY9ikzVf2DQCwAHjikZ+vVymGztx8aKHL94BzZPbHdmHCTdeWYtth6jXHwQBZh2kuWh1F8YUZlrBE
	+705NRw+8b+vDGKUX4pXjj8ZLwmwUWKX61YDBrObzXz6cLb/9kK/pviDuFhkNa0jRjtZa02VpZGWu
	F8bYXKwlMGuOBYM2xNRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfnl-00000006PN8-053A;
	Wed, 04 Nov 2026 18:33:37 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfni-00000006PMV-2jDH
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 18:33:35 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4H2Tjm1270935
	for <linux-nvme@lists.infradead.org>; Wed, 4 Nov 2026 10:33:32 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqkba9nk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 10:33:32 -0800 (PST)
Received: from twshared15328.03.snb1.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 4 Nov 2026 18:33:31 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id B110D2E743740;
	Wed,  4 Nov 2026 10:33:17 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Sasha Levin <sashal@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
In-Reply-To: <20261104121816.3726177-1-sashal@kernel.org>
References: <20261104090332.GB30750@lst.de>
 <20261104121816.3726177-1-sashal@kernel.org>
Subject: Re: [PATCH v2] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for
 KIOXIA XG10d
Message-ID: <179381719771.2628530.5898616470784941042.b4-ty@kernel.org>
Date: Wed, 4 Nov 2026 10:33:17 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=dsdOmFg4 c=1 sm=1 tr=0 ts=6aeb7a7c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=OU0u9AfXHRIHD09MzroA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MyBTYWx0ZWRfX/3a8qBJL0W/K
 hEGI7NJXERO8WR6xNJcs1n9DzrQpqSwCQUCSU4qrHnCd5lJphKCrg1nVugP9mXA5AvdaDQosRhL
 U+AqsxzQA7Ew/CC+N9UTV3fMY120hsSgWuGv+X0rQTsR/1wztRug6zxhbbwJFvSWOdVYWPohUG5
 DTwlYGzRzdApsl9pOcir4HvfFxO1/1DOmEgdxz/ddT4f9a1Gf7Lz7rbX2HfcGP0FxtoYwPEsq3A
 n6drDDHpjQimBtLZMpSp37LrHdQrkQkdJ8/OZbox8GhnCimANsLJGhVWEhD1miEDlkIktHslnc9
 rVRKq5YmQI+OfKSQi5EKBxxq7tiIADswpaf10K+XmxOXAmk+0gwcGssE+8SZMRP+luqOqo4w59v
 5uo+xV2Drl9WgR6UwtI6p00ABSwVC3whPaAVRgUahkKTRdV2aM8egukQS8VLkpeNdKtENJR4tAr
 /xAc3vXhfp7qcYgidbw==
X-Proofpoint-GUID: TlvfDjFjHkPZlnR_jCm6SEAZkv9evLes
X-Proofpoint-ORIG-GUID: TlvfDjFjHkPZlnR_jCm6SEAZkv9evLes
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MyBTYWx0ZWRfXxbtcT44GgW/R
 1Oi6cNQPXm8hMblpDyfWehg09b/yJKu3ZjwxH6kgdWnY1hSRp1jeyZS3y4u6x4xEaMT0jdgU/4A
 erTj5Icb07p6stMudWCVZmD+BSM+dBQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_103334_811006_9087638F 
X-CRM114-Status: GOOD (  11.31  )
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


On Wed, 04 Nov 2026 07:18:16 -0500, Sasha Levin wrote:
> The KIOXIA XG10d reads past the end of a PRP list that completely fills
> a 256 byte small pool block. When that block is the last one in its
> dmapool page, the read lands on the next page, which usually isn't
> mapped. The IOMMU faults it and the controller craps itself:
> 
>   arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0001:09:00.0 sid: 0x20900 ssid: 0x0 iova: 0xff7fe000 ipa: 0x0
>   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff
> 
> [...]

Applied, thanks!

[1/1] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d
      commit: d99ba2df0ea5273752787eed10f4c7d1db2f5dfb

Best regards,
-- 
Keith Busch <kbusch@kernel.org>


