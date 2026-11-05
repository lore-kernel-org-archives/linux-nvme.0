Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A17606D803
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=p01N1Rx4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UZ8DsvYdOYu4YnthJODg6wuyHI70zGW4VvxoRcZW9ng=; b=p01N1Rx42X3jwE
	gkZoAcJAlJQl3LhYyXJZZpPkuvpt87DVdd1EIIbjHX3gog95kmK777gjLi43f2ZyGKEIOExKOmCRz
	mw1Vrs/FcNzWoeYHPUiuB5JPiFUa0+pdlk8N94YAmUVvp7QIrTn8UpArTTq7E6J7nRrbzL2Iql54I
	P+BjJ5YqfupBCDUhOTcWO9/15whivz62GALKQBCxS4WlsWz9O/z5HZmbKjXZVEwqzcV0AejnNQk9G
	pgalc3GNk4Y6gUO6tAK1Ui1Q85ffA/OsBv5hu2tzkgjZ2ks5lABhguPYI79m3whGWy+vgLCMG1YHn
	S5pZJdI92O12+4gyAn2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOz89-00000009NFN-1v7C;
	Thu, 05 Nov 2026 15:11:57 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOz84-00000009NEj-0BTV
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 15:11:53 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5ETCTs4156153
	for <linux-nvme@lists.infradead.org>; Thu, 5 Nov 2026 07:11:50 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hrbck69d7-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Nov 2026 07:11:50 -0800 (PST)
Received: from twshared91271.16.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 15:11:46 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 92C122E7EC6F2;
	Thu,  5 Nov 2026 07:11:31 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>
In-Reply-To: <20261104211446891tN1QRJiKV3CLPQqfb7gJu@zte.com.cn>
References: <20261104211446891tN1QRJiKV3CLPQqfb7gJu@zte.com.cn>
Subject: Re: [PATCH] nvmet: drop the redundant auth check in
 nvmet_parse_io_cmd()
Message-ID: <179389149159.2132554.6031206055539117690.b4-ty@kernel.org>
Date: Thu, 5 Nov 2026 07:11:31 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX0wK44w2+wQVW
 G+Y9r3E6B/eMi0Wi6Xy+Mo118pquIFwfXoXQowtwv9TPsoIm963D3uBmVDGBT3Pmz0I1Cb8sneZ
 85H6Vzqwjbp1IaGyiGqjOTyloYHB1gQ728hJ5I4oH9gihJMvQDNYxz123orQoR57mkxeXknbrlD
 R1kYLBuT1p2Ex8I4ljoV3F7O2PMKN38Hhj8kzUWOZpy5Sfby26rRoHLXyXb2me/bsAL3taY1EL+
 4LVIkZ7DHrJSvO8CSYGG7Vgn2if9ucBwW8a9QTLRbqlUspOONz7dSFMIujrxoJdj32sCmlmRwjV
 f8vJDizGBHkx7xEh+WdL1hAhEW2AIGHr52LuudY5E/aHUJh/RlIG8ec4TI1q95r1BWp9GkX/cWm
 poskqq1OOL0LWUAtx2JxHNYW1ouNWEYsluNte5/ydjkCSdZnn2NZca2XANFQt/aPBousCknqkCg
 vkOfcKcoCDi2PRHYGEg==
X-Proofpoint-ORIG-GUID: tAIIQtQwSf3IKvGZGJs9HbB1sCf48Tck
X-Authority-Analysis: v=2.4 cv=bp/Zl0ai c=1 sm=1 tr=0 ts=6aec9cb6 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=cjythY3byQ-Lh-OW6DMA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: tAIIQtQwSf3IKvGZGJs9HbB1sCf48Tck
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MCBTYWx0ZWRfX4G255nE+7xYt
 nLh0PCxaUdDg67uZ0+TgUtoW+rHTDMW7rREOmwc1qxW2Eyw8y1YcUM7twOI6vQF4Odor9+kz8jg
 5PCenmPeA8gr0fJ0n5XInfjqbVM+PeQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_071152_087938_271006BA 
X-CRM114-Status: UNSURE (   7.72  )
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


On Wed, 04 Nov 2026 21:14:46 +0800, shao.mingyin@zte.com.cn wrote:
> nvmet_parse_io_cmd() calls nvmet_check_auth_status() and then
> nvmet_check_ctrl_status(), which performs the same check again.  The
> first call cannot fail either: this path only handles commands from I/O
> queues, and nvmet_check_auth_status() returns true unconditionally for
> qid > 0.  Drop the duplicate.
> 
> No functional change.
> 
> [...]

Applied, thanks!

[1/1] nvmet: drop the redundant auth check in nvmet_parse_io_cmd()
      commit: f96d1722e5861375c47c315117d900ef103ab331

Best regards,
-- 
Keith Busch <kbusch@kernel.org>


