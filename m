Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22582606A332
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 18:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AVv5q/Dx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7cDWiUbcFlhnKGjqNM2nYKV6Y4p9T6n4qbUjHUCHRdQ=; b=AVv5q/Dxahs2k7
	0Mn8tWPGQSoA44eCO8NgTJTRQraQHObLJoURK6awIBQu+hLTcoDqYMz31JPrENtWm1ye2KBGtEoL3
	guvpv0rXEH3ijcpIJCmGlVrF9c5kGNCjgtESzQ42N/SHqJUNRYGIMWPffEiBeSPxstiisDHwD7iC1
	xey6WgnDzjLK9HJ2/b7xw0eWlA48E9y3h78e6stbSN8GgrqR92itdM+TeuHWhr7Pz0172fLDw1CWI
	KBbCMhwDdsGDB+edTdGk62eAsbnAxWbXcxk/FLVHxe3j3N4HTbrwvZflpPoL/KP7n6SfbQJ7BUr3+
	XJ+LraPBaFe5BvhmPgHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOuO-0000000DQix-0w8X;
	Fri, 06 Nov 2026 18:43:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOuL-0000000DQhz-3GEs
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 18:43:27 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ie3Ri4132793
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 10:43:25 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3rb6a7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 10:43:24 -0800 (PST)
Received: from twshared98006.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 18:43:24 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id CD7B42E8EFD4D;
	Fri,  6 Nov 2026 10:43:07 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
References: <20261106230013815Squ68I1R3ds7pODmhHTwr@zte.com.cn>
Subject: Re: [PATCH v2 0/2] nvmet: fix stale log page data and a ZNS
 Identify error
Message-ID: <179399058783.513959.1663411821731805278.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 10:43:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: vZBUsHrpE85NbgN91NpjmlVcILiwla-h
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfXz7hAMEGrfHJT
 EkI24JNcjJCv7/mgaHEgPRKBGtEFXy5r/59p76i8F9dYWmWzQXRjvcv1d1A7HxJi3x/B4Oetwqc
 PKlScnP46onQHJ5yHmnsdupzHLaD6c8=
X-Proofpoint-ORIG-GUID: vZBUsHrpE85NbgN91NpjmlVcILiwla-h
X-Authority-Analysis: v=2.4 cv=TLPQ2Fla c=1 sm=1 tr=0 ts=6aee1fcd cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=W_VHsVsul2iShNWWr0sA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NCBTYWx0ZWRfXwrrXedhsJBLJ
 OlVSiiQa8pmXLoJvYU+i2s/iZxYDO11doi1Miyka/QFg2pxdnzEfddNMk8W2dSPWLPiap3i7C0I
 uYGJL0RPv3qT1DpL+rtVOCD6K5lAneKtrSsRRQ0m/i/dtuhp09VCXRR4fuef+cTU6wsaHs29exT
 nKWK8k/+qaIrxsBu8i6ZdhwE0BnGxaBvU2qlNn6yNZJQxKzIpyrI2Ezodpa/PVKswdgvfShnPXC
 MMbZczSAdWra+BhhVmu/c6AOeJRRe2zUzNq/hV1nFf7WUQF51e+Z+MkXRbBAHgf48xAFJMFF9lc
 kFyhdH7SzrSc4CoIj+TQcPyFZ6X+9Jek5FSMm29cF5NZezYEowueM8eHbx2LQDMBsXkMGWXO7Cs
 VOVGcTgp53HcmcW0mmMyiU553yyF2uild2PPwOUIdzm1luRXM4ZzRGKNggRULW5NfpdkPjL1j1t
 sYpfB7EKf5jhisCVu+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_104325_825279_FEA9854F 
X-CRM114-Status: GOOD (  11.35  )
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

On Fri, 6 Nov 2026 23:00:13 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> This is v2 of the two-patch series.  Patch 1 now follows Christoph's
> suggestion to zero the whole transfer buffer instead of only the unused
> tail, and both commit messages are shorter.
> 
> Patch 1 zeroes the entire Get Log Page transfer buffer before filling
> it, so a host that requests more bytes than the fixed structure no
> longer receives stale kernel memory.  The Error log also clamps its
> ring walk to the requested length instead of relying on a zeroed tail.
> Patch 2 returns the namespace lookup error for a ZNS Identify on a
> missing namespace instead of overwriting it with a successful copy.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/2] nvmet: zero the entire Get Log Page transfer buffer
      commit: ad606ae5635b68e324005aaa06421be752619dab
[2/2] nvmet: zns: return the namespace lookup error for Identify
      commit: 687f3014afcd5826fa3d8f40b445f647b5a379b6
--
Keith Busch <kbusch@kernel.org>


