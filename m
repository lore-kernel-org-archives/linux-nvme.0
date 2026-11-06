Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BE606A33F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=T4mEPWcA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qi4tRF3VXUVHtFMLZxctH/E7kZ4hP3nNCWedSjBpTnI=; b=T4mEPWcAl2cZzg
	z1nlHnqA2MiJq5vvuO3JcIJd8CqDGvZLJpfIEYXQ8wvNYRV3/LjNR6+5ow7jNNk0BaV2Ygj6TGVUO
	lq3WFODmNN9/Qt8j/tqqbKOGQSFgIFJTjY0A5M1TaSsSwnK+SdDca3hgacbQCPiKRpOLVIG+xh9mX
	RSVe1Tk1H+Mte4NMUlfr8CwyZTgkerqJ4QdEqbEgbgj1MKTei5J4kewHYNVktT+h2OPY+Zffadikg
	Mkym8Ioh6+ggUhHDCjt7h3FbbV2RktI9WbxQ41ijYLxEQXjyFoh0googObcU7VmEdnFYiu+DePW83
	7KED4Clu96aWQP4O9V8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPN0i-0000000D6On-44xe;
	Fri, 06 Nov 2026 16:41:52 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPN0h-0000000D6OR-12zA
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 16:41:52 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GXAvm3808105
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 08:41:50 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3rb549y-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 08:41:50 -0800 (PST)
Received: from twshared16865.02.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 16:41:48 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 1111B2E8C8119;
	Fri,  6 Nov 2026 08:41:35 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Yaohan Li
	<shunsheng1218@gmail.com>
CC: <mkp@kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261105114149.970315-1-shunsheng1218@gmail.com>
References: <20261105114149.970315-1-shunsheng1218@gmail.com>
Subject: Re: [PATCH v2] nvme: stop asynchronous event work before ANA
 teardown
Message-ID: <179398329505.3869217.16360449942486789550.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 08:41:35 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: Z_qNVoJUBVHUnMNatLZRkC4-_EXyCRJs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX7Lj4557FxCCL
 1GjFSa++5jRlOJGyoOagUdHo73f1KBHw/FvMvoc5aD9HBm2hWz1Qf/lNhUSjEKOfoceak11EwDQ
 9mRFGb/UG0nc7OBLzpxSFY9WdE+8MYY=
X-Proofpoint-ORIG-GUID: Z_qNVoJUBVHUnMNatLZRkC4-_EXyCRJs
X-Authority-Analysis: v=2.4 cv=TLPQ2Fla c=1 sm=1 tr=0 ts=6aee034e cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=NhGQEf4IzQLqQlViRykA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfXyPB6aWpn9ZQt
 hBrRlbXdSf+uZ87CNapVn54KSS0UuEodNuUG9gWecAkXr1UjXEIfm32Vl9gHDrn/ZugNfqJGMGi
 VNL6iOcHku3JQKo0MtDdOWbmdiCHI+kVARHE0k8NEVN+FmStdZrXx71drA8dzJ5oA8UNySySdCn
 805R/15yL60dFMifhXsaBUMU+OWVYpqTnkYx5jeqzPOUnKRhR7UF1Dx72iPlH3DWsOqrM9eTdaG
 EOYLr/CT7hGjd1y3tToq3GOQ/e0fl/tvThyVdrM2D9LaoJNgV5TahE+ANE+AbZqaVRJ0uPUtPw5
 uCST2OO8mixbUlfuHYHgWD1AICwIFi1pgWScJqrmqrHNl0wXT7pGpC8O7Ya/xU2yQ+OYVBAVt34
 2LLxVqfQs30BSKPeg4FLjgK/IwgN87t5FFuA+nbnmfF9YZpIkAUzrqU23UA2le8f20fLK2ht9AQ
 yG617Vv0kkWipYxkSXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_084151_301332_6D18C892 
X-CRM114-Status: UNSURE (   6.57  )
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

On Thu, 5 Nov 2026 19:41:49 +0800, Yaohan Li wrote:
> NVMe ANA work has several producers, including ANA AER completion,
> namespace scanning and failover processing.
> 
> An AER completion can queue ana_work for an ANA notice and can
> separately queue async_event_work, which sends the AEN uevent and
> submits the next asynchronous event request.  These work items access
> controller-owned state during asynchronous processing.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: stop asynchronous event work before ANA teardown
      commit: 9b657c565984f28976b1e471e3ce2f81cc269238
--
Keith Busch <kbusch@kernel.org>


