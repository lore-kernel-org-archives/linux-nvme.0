Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851DA606B2C7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P65oyLyp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yEwlMD+apRiDovdAi+eN7RFCWjcZq9vW3pEB9WA7jKw=; b=P65oyLyp6TFH2s
	mIrJRJPwjBzR3FASjqRj1u87RsPe8nO32asqpnHA527R1IHEIDX0YLm4ULx596+9ykhXGDJkFUeZZ
	iKlKuMKsYP0tlmyBaenWbq7R68bL4nbbsnaz4TtvENUwqlPiNxnzowG29oOVrRn83MBuaVPVCWKyp
	FE/9FY7HV9v9xc6RowWjjH/YnPcu5jTtLQFdxNiLqB9j6ZsSWz0p4e4L10FVcXuV/8ptCPjRNpi8a
	tVMX31o/OwMmyF/q2e2eGmGoALZmbGdD5j/p0DistZGCxvcUBygw1E0KeJeLv7F2Li19aKTRTvHpd
	gVECAyRI0RfLAB9BOJjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhje-00000006uaK-0MZT;
	Wed, 04 Nov 2026 20:37:30 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOhjb-00000006uZL-3J4Q
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 20:37:28 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4KMJFE2591694
	for <linux-nvme@lists.infradead.org>; Wed, 4 Nov 2026 12:37:27 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hqp80s8da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 12:37:27 -0800 (PST)
Received: from twshared15540.01.snb2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 4 Nov 2026 20:37:26 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id B2CAB2E753570;
	Wed,  4 Nov 2026 12:37:15 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, "Ewan D. Milne" <emilne@redhat.com>
CC: <kch@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>
In-Reply-To: <20261104172833.161567-1-emilne@redhat.com>
References: <20261104172833.161567-1-emilne@redhat.com>
Subject: Re: [PATCH] nvmet: don't return memory contents beyond valid data
 when reading ANA log page
Message-ID: <179382463572.3441171.1653694484050535990.b4-ty@kernel.org>
Date: Wed, 4 Nov 2026 12:37:15 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=YPkKWhGx c=1 sm=1 tr=0 ts=6aeb9787 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=zYqOzibKicJnM6tJ3O8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: B--rtp8u0JU3Qau7qGAD_EjIFAcd5TkR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA4MiBTYWx0ZWRfX7wiU/6mXHzDc
 m1Q6E3T2NTg31TDRD2Vx62c5b7NcXUTgLXZVcWSoHsVkV4k6t00DWX0mIwEjXU7bO84nokgK9ZG
 jL+Q4xb3CTCA9ZQjq3xsbKzAdyt7t+g=
X-Proofpoint-GUID: B--rtp8u0JU3Qau7qGAD_EjIFAcd5TkR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA4MiBTYWx0ZWRfX8KtVu0+poVJ1
 9Y7xGyNIezfpU+XFrjUtMrOPyTo/ERN0qcTye+XIQ2yKZydmSiyRl1uOy5Suaa1ScigtW/gsX6i
 PoUFrktg6d8+fiYuYc82WVcMdtQapC/xwbIUWucBc+1fE2jTb6I/m2uVmqHqd1jTmFMirWqNRBr
 DO246vwmnXQL9/DII7X/U/NzvB94tGXA3z6JFTz8MYToyof74OnHvshyipFSMquxsMEnGSOBo9s
 7DG+LR4OKrSrgoxB25m3Jw7czlToYb0v3G2/uFIERlhBXQwQQlEB4Y1QtOWjgdcDuYMrH3cNmAZ
 cv0TWS/aX/7TXPxwACcC8KTPKilV2B7/qStAJLHvCLQNUy/6QEaezCGa5dLEQx79Podghc5ORzQ
 9noxbE6n7vIwDddQROGosScYZOwS58+ehi5EKLHpriKSE5wClbCTWwNx33ctjeqVgbjMT8nBdGz
 7jXBBuyEQ0vvyC99p8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_123727_837228_7ADAE069 
X-CRM114-Status: UNSURE (   9.86  )
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


On Wed, 4 Nov 2026 12:28:33 -0500, Ewan D. Milne wrote:
> The host side does not know how much valid data will be returned by the target
> so it will typically provide a buffer larger than the amount of valid data in
> the ANA log page.  The memory allocation used by the target does not guarantee
> that prior kernel memory contents will not be returned past the end of the valid
> page data.  Fix this to ensure that the SGL is zeroed before copying the data.
> 
> 
> [...]

Applied, thanks!

[1/1] nvmet: don't return memory contents beyond valid data when reading ANA log page
      commit: 29b8758b4700357909f06705a0c48c7a60c556d5

Best regards,
-- 
Keith Busch <kbusch@kernel.org>


