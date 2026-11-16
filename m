Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496E4606A331
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JR/7851L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HLzCj0RuJsDmSLXUShLgTXOXCsX+4EAi5ae/ZnypCZI=; b=JR/7851LwD7vMK
	gg79ZywhhK0lSno3Ruyb69S5AREx48loDOMfDoF0rS5n0EmRoY0jv/Grl+xTsUEXWLFmo9c1CVK7O
	/bpnvoY09CK8Wft5BE0/2cChJkppjVC9yYa4YaL0GW5B0wzJe3z5LiBHOu6H+r4cEMTUDBqu6pegB
	86MLnS6qqomNHuFSIwxCbK1POsgJUCpLU993XV7kvgLXMKxVF8CCb/sewbTFKZqpznjf6OYpxzIRZ
	S/B6IXy85JRllXiXEC+vVOyb3VDOojxDwNHr9qEd2YvRmiJYBx03GjE8EFtwbxVHFMuX2bUUNh+dc
	WTV9XYZhuLX+xBoBtPwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSySD-000000031AE-01k1;
	Mon, 16 Nov 2026 15:17:09 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSyS9-00000003191-1af0
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 15:17:07 +0000
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGBxG051957743
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 07:17:04 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hya5jp0bf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 07:17:04 -0800 (PST)
Received: from twshared26372.02.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 15:17:02 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 97C7D2F083074;
	Mon, 16 Nov 2026 07:16:49 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <hare@kernel.org>, <hare@suse.de>, <hch@lst.de>, <kch@nvidia.com>,
        <sagi@grimberg.me>, Sreeraj S Kurup <sreekuttan2156239@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
In-Reply-To: <20261110081559.2730-1-sreekuttan2156239@gmail.com>
References: <20261110081559.2730-1-sreekuttan2156239@gmail.com>
Subject: Re: [PATCH v2] nvmet: synchronize DH-CHAP secret removal
Message-ID: <179484220961.249619.12113326051904353767.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 07:16:49 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: kL0mUJIHPqXKk1R7m9ehzurMFr5mFgCT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfX6KGvkjS5cNZr
 3cGTEBkrlbkJvdmhiJsmT+1ojgcjC+fI+nTEYnHCb42lO/MXyeMfGrRG7PpLJCUHg+UyvrxmvAu
 ztG/TIlhSG3THYQbfF7e8IorjOLakQF+Lui7wZP5BJ2mVPLTuPd1qQefgenrKkDv3q7ATVM3xkH
 hlfvuoDHAma4u6eaa9LBP4ZFRK3So40E5Qv3sJowfxmxRVvA/eDmEAMxKm7mE8Uo/0qTLQ4rKml
 CcMHqScLBlFV9JD5WwVrIV8qwRcmyP9Z4rNQS0OBf9f/yRBBEGkrYZD+yPpnkmkVoUQLoLAPKEN
 0IwIKu5e0++wIO81MJXbBXR9SAaqPEUFaB6I/t3lkb6vULnJaD59V5/5z4C8cYuoizFAypXO4Nv
 W1yLrWPFvgNdM/o1G/1Nywg8WeZpE6EcTcD3Fr7dVxRkicVJu7TgYlqATff0q1U9/Li5U8cj9b2
 6SfFEoGT6sCS8WaUTKw==
X-Proofpoint-ORIG-GUID: kL0mUJIHPqXKk1R7m9ehzurMFr5mFgCT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2MCBTYWx0ZWRfX453cjQF5U/cx
 PThr5Sq2OvnKVk5NwTFgabsgleWKoBVA11rueHfsdrI981iTQPkmABBUzBb0fDzCbxBRT4BuznQ
 t1XrxaGvAIVIZkvPXEYuuBg180ehYEc=
X-Authority-Analysis: v=2.4 cv=R7aWitRX c=1 sm=1 tr=0 ts=6afb1e70 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22
 a=VwQbUJbxAAAA:8 a=ErKaWFu-b7fWwdv8pp0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_071706_845226_6449B491 
X-CRM114-Status: UNSURE (   7.83  )
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

On Tue, 10 Nov 2026 08:15:59 +0000, Sreeraj S Kurup wrote:
> The empty-secret path in nvmet_auth_set_key() modifies and frees
> host authentication secrets without holding nvmet_config_sem.
> 
> nvmet_setup_auth() accesses these fields under the read lock,
> allowing concurrent secret removal to cause a use-after-free.
> 
> Acquire nvmet_config_sem for writing while clearing the secrets
> to synchronize with authentication setup.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvmet: synchronize DH-CHAP secret removal
      commit: 706076f51eb78ebb4cc7fb06751bf09042fb515c
--
Keith Busch <kbusch@kernel.org>


