Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB54606A6EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GFjsTRYp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/47zC8E8/yYHCOoWpvctxUJ9P5s+zzSW7Ej6lIyA364=; b=GFjsTRYpi1oTjZ
	4qX7pcQvxQW9hO5yHI4WnfM9fz4C68ZbMW0wAAqDKKZXE74FsAP58tPnHTneE87cOCx92aJN3cfgq
	BggMhrHTMOY92kagL3HIDGK6B/wbY4V6DnrUNuLKAXdRhdkYvhyrrvP03u0iUAgo+dS+/Czm0/WVr
	y7g47Fqqr+7EXQzOH/EEM5e0ovSs7Hc50sObkeKKQk6W8HmszzuTfbe8w1rjVcaO9vqg7jBv9qk5/
	geq6M1i39FWpq09aDyw3D0jS/oNTKm/ushVsipYL+xNwSkAd9N0Q7mkwfmg6xGdN2f4YAIaurw75t
	laOQ1o3RQSMb0TfoN/Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUhl-0000000G93F-3PwH;
	Fri, 20 Nov 2026 19:55:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh7-0000000G8nd-2UAA
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:53 +0000
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHAda82337671
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:49 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tcjsamx-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:49 -0800 (PST)
Received: from twshared24494.03.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:40 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 05B2F2F4934D4;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Martin George <martinus.gpy@gmail.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <loberman@redhat.com>
In-Reply-To: <20261113165002.12536-1-marting@netapp.com>
References: <20261113165002.12536-1-marting@netapp.com>
Subject: Re: [PATCH v2 0/3] nvme-fabrics: bound reconnect_delay, kato and
 fast_io_fail_tmo
Message-ID: <179520446402.200156.17336384388664996367.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: 1V50bYgzbFzfuF8d9bhBz6QdZwPaqp_p
X-Proofpoint-ORIG-GUID: 1V50bYgzbFzfuF8d9bhBz6QdZwPaqp_p
X-Authority-Analysis: v=2.4 cv=JYcpPkKV c=1 sm=1 tr=0 ts=6b00a589 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=VwQbUJbxAAAA:8 a=oi3Sl-Ziz4yuWQDtFf0A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX8V33m3UE8b3b
 bOa0jscyE8nxh1XRyDgFj1CeZXY+u124Gy+7VhvUh2l+1HxSl0QugaBPHgubF83//F/T1bFirUK
 dJ6MSHG9BWQxk0Cyjs+0umnxIogrJ20NBHiVDwuRD4z4YjlU1yxd9wwLj4s7YoiPtalkiOI2fBH
 Wh1OjpWxQqr/xKAGErrZDrJz9QATUoNM1lQpVcgfohGDwgLgGOu9fCmHqvS7ffMAh6gdtW4bt6G
 TtdjD6jgKmyahhHAbrM3wEIxjNFGAdlEzPxNfRDox7mXeigiNrNwh/BbaZjPJOF4ZwcvOsZQ3+1
 YbItC0xdHNw2pfm0jyhe4Y8+YTVKMXhU0RVIdtfmdhe2B1Mv2ENz+6JhWBiabB2dnzi9nYvGJju
 O+HgNNBHwYCU1bNp/xjbZmsJeKRfCwQam6B47wTCKYfboOIG0Jf85Q2+BziQtA8fqIao5W0+Uvh
 whcCrhdx3g7ULl0gZ8A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX/V0RVeMJL/Zp
 LJlMue9zEGvpf4y5l4/WF2bSfczQ50IjhCTzvRtfEtBvWN9L8aBiDMjRAU7APU6Bn/o2rDdQjcF
 OhlYhU0Ypartu6VENfbf0Q/+iPFk2rQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115452_195407_417049AE 
X-CRM114-Status: UNSURE (   8.87  )
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

On Fri, 13 Nov 2026 22:19:59 +0530, Martin George wrote:
> reconnect_delay, keep_alive_tmo (kato) and fast_io_fail_tmo are accepted
> in seconds but later multiplied by HZ (and, for kato, by 1000) in 32-bit
> arithmetic, so large values overflow and yield bogus timers. Bound all
> three at parse/store time so the conversions can't wrap.
> 
> The target already does this for kato via NVMET_MAX_KATO, and the host
> recently fixed the same class for admin_timeout/io_timeout (4a5aeebf1a00)
> and partly for reconnect_delay (f92fe8dea19c).
> 
> [...]

Thanks, applied to nvme-7.4.

[1/3] nvme-fabrics: bound reconnect_delay to avoid overflow
      commit: af904d3b2c6d8581b03716f35a814e3899bc1ec9
[2/3] nvme-fabrics: bound keep_alive_tmo to avoid overflow
      commit: 95312acf502748e63623069380c39fe5f055d245
[3/3] nvme-fabrics: bound fast_io_fail_tmo to avoid overflow
      commit: ed666c3cbdce1c72521db41270694ff1e1b8631d
--
Keith Busch <kbusch@kernel.org>


