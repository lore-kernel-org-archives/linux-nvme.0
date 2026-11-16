Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B133606A32C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3Zh/F1w8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/zlLFbbw70FmmMU5YwAZUhTdFqzqLjECMTWQsCYZR+8=; b=3Zh/F1w8bY+zLb
	osH8H92IYKbaK2jCdxc9M+Aq30b9lxKJBUIbcGknve2EJZJSLIeJtS6UVX4NmTJBC4ZxYW0mnhWT6
	I+Hi5IkX9ADyj79sMSoJpleA37n3pICVeVmk7XYS/rPf6JMxs0/uIfAb623xpU2ynxe85S3+DLwxt
	3XYMBOgP9NiYczFBBLEbCEtoMqHjSlQP6mV0b48ajcfW0YWNtn2aNtw9FpVKnbFf3cCtlejn7XoHY
	IX6YwP35mQi3Cg6JEET9qwRbYTsV67N0I/GThYrtWdyHpuSyAJsP+gEuz12AQ3AeZUZFBJgfARH3w
	tQsHadmKPrLzq4NHRm+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSyS8-00000003192-3ljH;
	Mon, 16 Nov 2026 15:17:04 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSyS7-0000000318g-0NaT
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 15:17:04 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC0fcJ2119921
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 07:17:02 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxnmcsfts-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 07:17:02 -0800 (PST)
Received: from twshared77744.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 15:17:00 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id F1E6F2F083071;
	Mon, 16 Nov 2026 07:16:48 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <hare@kernel.org>, <hare@suse.de>, <hch@lst.de>, <kch@nvidia.com>,
        <sagi@grimberg.me>, Sreeraj S Kurup <sreekuttan2156239@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
In-Reply-To: <20261110113502.3235-1-sreekuttan2156239@gmail.com>
References: <20261110113502.3235-1-sreekuttan2156239@gmail.com>
Subject: Re: [PATCH v4] nvmet: clean up DH group state on initialization
 failure
Message-ID: <179484220897.249619.16009819575182400523.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 07:16:48 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: UhuUVtYRFwn9h29M5fh0NV_PtubAKZpP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfX4tXinqFQ7mSU
 B9Sq5htIOIcRPK4P57Nl5dQa0u0nOLlXCxxe0NINpA12ieGTtsBl/QOoUwiXg7UtSCgcSbp6Pvv
 qC8/s/xqEdUlpwoW0wfFtbpYl9llQ7U=
X-Proofpoint-GUID: UhuUVtYRFwn9h29M5fh0NV_PtubAKZpP
X-Authority-Analysis: v=2.4 cv=EMKTQFZC c=1 sm=1 tr=0 ts=6afb1e6e cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=VwQbUJbxAAAA:8 a=8o7LMmOxS-Ld041RKNUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfXwWgH6PgNWtuk
 uMPuAEL2HnhwhytXHIw1ES+rRy6yq0OmqXuKtcOMGSDcoGQpQs1MoJh4AsA8OU8HsLea/MW9AhK
 u6/gex6rJTrZ+RK7eX1LWz9gWC8dNI8knlJccfqod+WGIGO9FgANVxzfOYKkHVL04PY6r09A1aA
 PkSSumg1e1rPP1vOguSFw6LFfEWO9KZJfBlSd1d+vSuqeB9KuzNDRrFA6gbJRJcySS1OJJ4Zd0J
 xDK/CsdiHF8qSUrVP6YATR0nYtk77LQKyj3MDwXzq37eN4d6zSP8lyjp4X3HugDdk5eWRqFOHUO
 PSqWFm9COgp3DKBH2uoXrtI96V5u3VxoPTDeGCuR1TLzOceLK7LwgaSL3Ifk9w73imTmzTlOD2+
 qBOl2vJYqsxtdpKPizayr5fu6lOsIbI5llIZQ0n/ESbj5S57PI35X0oe7utY+jVxP51uj085vDI
 IavKoIksmhMfFSAit8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_071703_132275_FF231EE8 
X-CRM114-Status: UNSURE (   6.95  )
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

On Tue, 10 Nov 2026 11:35:02 +0000, Sreeraj S Kurup wrote:
> nvmet_setup_dhgroup() leaves the DH transform and group ID
> initialized when private-key generation, public-key allocation,
> or public-key generation fails.
> 
> A subsequent invocation with the same DH group incorrectly
> returns success because the existing transform and group ID
> are treated as proof of successful initialization.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvmet: clean up DH group state on initialization failure
      commit: 920cd269c9228c5f51a8bbd65575010890797afa
--
Keith Busch <kbusch@kernel.org>


