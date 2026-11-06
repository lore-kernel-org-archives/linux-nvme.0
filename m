Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1E606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KonL85gQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=obMKEwgEXqw8e0jQPkLIcV5XJ9Ah9zsZW5aCZOT9O9c=; b=KonL85gQpX4UMK
	bHTNoUVl40qVaGmLkOlHpbolqJzP4w9ypUEhzqhe8HGbZHYvkvc6gDh0LsJtiEsmuPnm6x6y1Db+L
	ySIMxd2X9Rr5aVjLBkSe59lIuqx3zJ7EhFqRkp0ine2EvVDHhSlZND4sGeewaXWMAKZCmuyGfXE1y
	m8I9EYzHz3MFk2dKw4XMmU3aApjgtPvtS6jwLFgLppUNd0rkLRXxUYjVZUlsY5qyQCVEulheIOK6G
	Dix+RZHDjO094C5Q7wUG4HpgP5QkL6Cv0jeCgWzISar1o1jxRDOeIsqIHdhfFmqZj699GI75uRvvi
	MYZdrNVUD+GATeKWk8WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMZe-0000000D0HB-0rjR;
	Fri, 06 Nov 2026 16:13:54 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPMZU-0000000D0BW-3XvT
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 16:13:52 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F2JS12950992
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 08:13:43 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r1mvcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 08:13:43 -0800 (PST)
Received: from twshared119346.16.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 16:13:43 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 8A9752E8C4A3D;
	Fri,  6 Nov 2026 08:13:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-kernel@vger.kernel.org>, "Smith, Kyle" <kyles@hpe.com>
CC: <linux-nvme@lists.infradead.org>, <axboe@kernel.dk>, <hch@lst.de>,
        <sagi@grimberg.me>
In-Reply-To: <DM4PR84MB1590C08CB556D28CBA707E74A0772@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
References: <DM4PR84MB1590C08CB556D28CBA707E74A0772@DM4PR84MB1590.NAMPRD84.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] nvme: Fix potential gendisk leak in nvme_alloc_ns
Message-ID: <179398160956.3651019.17847243207833237031.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 08:13:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfXw0kFqDoIAQBt
 FqzGcGnbjsV81cNOOTjw50OJXyJE/2uxGokT+U6092353Zvuxh8mPShZO8lSe0ip9iSSQ0wiV36
 ZinZZRLcdI9pE+yfwz94oMP3QXhy5zc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX4E1gWxCtUN4M
 Iq8NmzxRcIxm9V+PEItt+yC1titXF/Dgwx8nFKkgf/jDa/vOtUbrnmOQ/uaYYQVv202n89eXhjI
 7c/uHYQOnz1+nBGCeuiVHqG+intfMuOgW0QojvWtuGaMz1mtb09WVNCqPOre3n+2Sd0Cro08QuK
 Ii45LYglVvtjGfOs0wFZ9xsb6WQgSEkbssz+/us/Qoo5bHegDljq95AwycdeulaQ3FheWuK8UdK
 omWJSU+3FXeb0Gy9cPk4SvdRLqs47AUrmnjVgbJGkW2fYL/Lm1SnkXKMUakQsJlhWySU4OZyeg9
 U1lpgmJvun3JcwQC4Ax3EZ3nRXsI6gsppujs9YISxWCcGJ+53plRjYobTAH7Qa0LIuBRMywvr+t
 dBMGZlwFEz7yltmY2LwPXMVLvJbdAv2u0QzTV4iZ+/brn/KSF1iBHAdmtmcC/jLs4xbqwrsnLsc
 AkLSjc+Zt1KuwqC0R4A==
X-Proofpoint-ORIG-GUID: Xvwcz7GUiFmhZEp0TOWL4LC9th4Z12Q_
X-Proofpoint-GUID: Xvwcz7GUiFmhZEp0TOWL4LC9th4Z12Q_
X-Authority-Analysis: v=2.4 cv=V4HoQuni c=1 sm=1 tr=0 ts=6aedfcb7 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=tpM8CJlwf7uhpglF1g9U:22
 a=VwQbUJbxAAAA:8 a=rLEU9whwvvocQAz3oXsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_081344_904903_B4931B8E 
X-CRM114-Status: UNSURE (   9.27  )
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

On Thu, 5 Nov 2026 21:54:38 +0000, Smith, Kyle wrote:
> Multiple BUGs were seen after the following sequence:
> 1) ctrl A in subsys A allocs ns nvmeAcAn1 and ns_head nvmeAn1 and sets
>    both as live
> 2) ctrl B in subsys A allocs ns nvmeAcBn1 under ns_head nvmeAn1, but is
>    interrupted or stalled between nvme_init_ns_head and healthy return
> 3) the namespace is removed from subsystem, triggering rescan
> 4) nvmeAcAn1 completes nvme_ns_remove
> 5) nvmeAcBn1 allocation returns through an error pathway in nvme_alloc_ns
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: Fix potential gendisk leak in nvme_alloc_ns
      commit: 1e1d36e7610fc2c2c425ea246caf8ea0380d5fd6
--
Keith Busch <kbusch@kernel.org>


