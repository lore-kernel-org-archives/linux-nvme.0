Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A4C606A335
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yLDtA0dL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FzlUUiOscv6KxNaGuf7J3CipKqeeZk/pbDOTrBNrc0o=; b=yLDtA0dLaFt9dU
	wPFZX4NanigqyjFq0hXx4aa2U68Sb68MyTtM3mjMRM49Z4oaPIEGsuyiYOwlVyqqH5GUY+4bG10ci
	P7UmNgQ4D9trtdy8zpzPjK1jTecbEsAyoB/Oj4m3U72oY2EZuMJ/x0PExcY83TUEnuGTb0S/epK+x
	C+5Io7y77fTWlNYItZ0A7uIiY4TUmtUJ0/8BPcg+pGjEaj4OvDzKiUOpgFbDIrZjjBjMUAk2ZTSix
	uSviFr16VHajMWEXW/CJVBUH5OkvoewDCWnPnswrnPm3gS7ek6jN84Dby2cL/swOUIJQeC5ec89Gh
	p7EfxdPgfu3FdCy7S4GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUhv-0000000G9Af-0V6T;
	Fri, 20 Nov 2026 19:55:39 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUhB-0000000G8p3-0r7F
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:55 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AKGrvou3858792
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:52 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4j2t4j1fn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:52 -0800 (PST)
Received: from twshared76683.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:41 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id E89CB2F4934D1;
	Fri, 20 Nov 2026 11:54:23 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Martin George <martinus.gpy@gmail.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <hare@kernel.org>
In-Reply-To: <20261118100347.14832-1-marting@netapp.com>
References: <20261118100347.14832-1-marting@netapp.com>
Subject: Re: [PATCH] nvme-sysfs: serialize DH-HMAC-CHAP secret updates
Message-ID: <179520446394.200156.7191790505765820965.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:23 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX1pYmDLZNYQyG
 GuGzOQwXR9tSgyN2tYCdjDxrrtBlpPv14syTqRgTi7xxnNnd2CIFoXK9Hh7Dzf7uiNU+2GRk0Ye
 pGEdl1VvAvbgCN8PIG6/xsNLR1HvB2HD6/6z9sxjnN9frdXfOlpU5y5shVM+vrr+sU8Y6WwWTfY
 6lZaHnBEspy7jq11Xhd/Te7MpXBodg6nXgoVoUHSJaUFuR1v8Iv3O52Cf8DY73t/kGGT7pex5qC
 NAAh0lzT4nZM4B5WY0rfzgJZfFf2R5DAPu8jzwFZsStBP3eeGWewsgtn1TT+kwEz5q+W+/d/buJ
 xLoBQKv6o2nS6yJwf/y6OJM4fB1AR4+e3n6uxrjhG866ro1FT03COxypURJBvHBPay+3BabBqQW
 vARH22UeKm0PWGE7raezBEnRy/PbeS7vFNEKtceMrNjUe36YPpnPIhaE6RA4W26TvkOUQGNzYwO
 SnMFjtjOqM+0Hh9Y6fg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX9+c3jfeJW5vH
 qm6eP41Gayp1w6e6U9XIrbrnSizN8kSxbVvL7xq062fPJa0JlEaCpzKoy7RheG6lTqKQ86sFZLB
 mIALtzGDul5PN+BWvXYp2cAaryPXVnY=
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6b00a58c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22
 a=VwQbUJbxAAAA:8 a=L4yHT0_AkXBbB-Kb-W8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: u8aRBpdZahJm3xJhWTGysxV3Qf2rSZCN
X-Proofpoint-GUID: u8aRBpdZahJm3xJhWTGysxV3Qf2rSZCN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115454_633538_CB642547 
X-CRM114-Status: UNSURE (   7.97  )
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

On Wed, 18 Nov 2026 15:33:47 +0530, Martin George wrote:
> dhchap_secret_store() and dhchap_ctrl_secret_store() free/replace the
> stored secret and swap ctrl->host_key / ctrl->ctrl_key, but hold
> dhchap_auth_mutex only around the key assignment; the free/replace and
> the show handlers run unlocked. Concurrent writes to the same attribute
> can thus double-free the secret or the old key, and a concurrent show()
> can read the secret as it is freed (use-after-free).
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme-sysfs: serialize DH-HMAC-CHAP secret updates
      commit: bdd56686afbc4e84eebff90ae7be7c1c62e21c49
--
Keith Busch <kbusch@kernel.org>


