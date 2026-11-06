Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F2606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DQ6cusKM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iqr0gA3k4fBcp88VJvhjHLGHZBvjD2Ba/yhfLHVe4y8=; b=DQ6cusKM+W6Pbr
	WV+GeFjy1aB899R6hoXF/+RWeOJJ0IYXsMipqMibq6KaT2ee5cXptqays28ygicykx82X1wEqx7tM
	J9rxsYzXpc+/joazmQ1i4AXGORukyyva0/iVcExe4K1p0LR0UV00QN/2zOApVN7nCBMDwu0nAoGDx
	UrEVmCMXZC9J1rRt1UH+leVxJW8BId5skgrgCKWLUIwYy+h4PHWuof8N1znGmGdabAXXxRVJJpKA7
	8NJC4NxYrggzIUkuBcSxR1kWjqH30J8nV687ZVpI6CMFqZvdVubeTInYfgxXuz1JVhANmbiXXfnkK
	5w1UJEUXlsL5i+3jC26Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOTu-0000000DMpY-1DKo;
	Fri, 06 Nov 2026 18:16:06 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOTr-0000000DMpA-3zpc
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 18:16:05 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6HsVkq1276333
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 10:16:03 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r6p34h-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 10:16:03 -0800 (PST)
Received: from twshared98006.17.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 18:16:00 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 6925C2E8E27CF;
	Fri,  6 Nov 2026 10:15:49 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Yuho Choi <oss.patchbox@gmail.com>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20261022045828.1392332-2-oss.patchbox@gmail.com>
References: <20261022045828.1392332-2-oss.patchbox@gmail.com>
Subject: Re: [PATCH v1] nvme-pci: shut down the controller if disabling the
 HMB fails on suspend
Message-ID: <179398894941.310047.16175275917546934864.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 10:15:49 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfX3cXnwsMVNWzd
 GlliW8hxfx88zKvCCX7OqchhCxb1E9gzMtbumatEgXVU5vpKN/zbF3VIFZR9Qr0M2Ji9TH2/foA
 cD0iKTdQn61xU0e3iRo4wpe9A/h0b7421ngZPsJjhZHphpToeNghdlbiJ0Djxd2q6dUIMcTiSl6
 eDSWeZVOLsYUiN8kK8lKMRULJCaf7Ku1/06oXkbytkX4Ok7SPWe54EhSUBuKnS8gsBIi6n8R2L2
 oQIMSVKr/JTW/XilpLtDV+2ngGEGxju12xY1e1nJjcR5jhAWxRiOs9tnsFrQmkHFOXuU5H6kp7Q
 yHpuxmuU9i3+OBOsO24TJkVrv6t+8HMX4468ogIu5jViPxWBeqNQkx53blKthjJUE4fFgA62Q80
 rpm1hSbH8WcBwbxl2IpZivRxRlKzKMaxrb8xbIEsMobEmnEWvaIINXVSV4CNAry9lxdg6qJjtS9
 2PjrvSsnzZJi2/4KY2Q==
X-Authority-Analysis: v=2.4 cv=IsGL47/g c=1 sm=1 tr=0 ts=6aee1963 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22
 a=VwQbUJbxAAAA:8 a=tS8-BpN5wWsUIuTujoIA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: OI2Y1q66yb9badF2MZszh7K4Hy9xOIWS
X-Proofpoint-ORIG-GUID: OI2Y1q66yb9badF2MZszh7K4Hy9xOIWS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfXxfdlxC3B5klM
 QWqe5PrFyPnETqvWLDD5+UrE8iqe8zL+IxiqJM4a4MC5lTW6BVe6Cb8L/l5W988N5flWluV8j0S
 sFLjIE3rty5s92X/9yMOowtg3bt8JIs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_101604_004913_3633817E 
X-CRM114-Status: GOOD (  12.33  )
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

On Thu, 22 Oct 2026 00:58:18 -0400, Yuho Choi wrote:
> nvme_suspend() disables the host memory buffer before it moves the
> controller to a non-operational power state, as host memory access may
> not work in a system suspend state. It only treats a negative return
> from nvme_set_host_mem() as a failure, though. If the controller fails
> the Set Features command with an NVMe status, the HMB stays enabled and
> the controller is suspended with it in use.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme-pci: shut down the controller if disabling the HMB fails on suspend
      commit: 82dd68297483afdc3be48e9d77f2dc4adb7a6941
--
Keith Busch <kbusch@kernel.org>


