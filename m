Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D739E606A329
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wAWI68gf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nXdmDwfGGuNm/Mgws4iP6TcoVVHB/JpAmkzSWW/BBKc=; b=wAWI68gfsB2L98
	pILQPQ1M/gUfP3UDKppRlDYBeJVgf5RPgQqmGHrl2qCn0ok9K4R6quYqVs1dSGiiiosKd1G6FVWVt
	MswG7bhArVSfSeHPiDy7ntk1AMTIsY2fZhd6tC0KzJSPE3/ub5O97fQSiyysV0DfdFyeuCQvkabOH
	9yxTTsL1sLP58gl3BVDlxQU4V/mwmPpEFwu5gQaiIE6QR07MUCo7YZEFe029ypOtMEM/2NEHyDdpx
	fZ12rOpA/XaakVJYg0iZbTQ5in7OA32L0ZFjlFsUeT8T4Nrc8YCiiw4JPSYMewynOSVTXUosdN03Z
	qVsgEjM5ikn5trg3J3Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOU1-0000000DMsS-2BhZ;
	Fri, 06 Nov 2026 18:16:13 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPOTy-0000000DMqn-1cvJ
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 18:16:11 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Hsftb3123277
	for <linux-nvme@lists.infradead.org>; Fri, 6 Nov 2026 10:16:09 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3r15sg6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 10:16:09 -0800 (PST)
Received: from twshared31846.02.snb1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 18:16:06 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 844A92E8E27D0;
	Fri,  6 Nov 2026 10:15:49 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Avi Weiss <thnkslprpt@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261022071934.3818224-1-thnkslprpt@gmail.com>
References: <20261022071934.3818224-1-thnkslprpt@gmail.com>
Subject: Re: [PATCH] nvme-tcp: wait for in-flight TLS handshake callback
Message-ID: <179398894953.310047.10583693700779992471.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 10:15:49 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=UdrE26SN c=1 sm=1 tr=0 ts=6aee1969 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=Rq7DPwlVEgKamONATukA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfXxIEPTCYC+r0j
 2d6cBWoadUDuYUqK0HvpAWmAgcovhWNgWHefXbFS/5a8WHf8jjDqo+vMkknPfG7VyoqWxrDrd2z
 HTRgsC7Wn2pETJlUFMBsFoC0Fd640vz7P3QZJlzafs+OnYs9/JVf22qWfrCGOWmwdhGMjJQ8g+3
 Lx6UjOOnSLrU6LOFIKvSksPUUoubd4rG0WrqjadoXZpnb4zfyWM81gtJ7VsMBSo/PmsnJEnE7J2
 bEt9fh26wJjrOBY0cxVdxcs6rIu6TD3ZCVbMQdqRUXUe2lZ3vf6vAfi+Wc3EsnpMvlcTLFXrjsR
 FHpOLs7xfJim1bEFOsZqvkW40gBwswsf8N+9mj5TQ/x28H70GOcyWz+9O1RmXMHpdtxShwEGRHY
 mPHu0VVKrXa4rJZuNAaMeZQBzfq1HOCjx3rviQReTQfdP0cosFQhWFHzbzF2y0WZRhaW7lyshvm
 sSwLj7pUSb+OJVL7J0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MiBTYWx0ZWRfX3bJwv7zitCNm
 BOS9QaKyXmdRiffk5mF5MoE+0X6u0o1bB+PyTIfAmmjRN7eR6j3oFKogbRawg87dIg8DlKsb3eJ
 fZniQ0CZ9s8kgqITpTpQBj94EQHjVNA=
X-Proofpoint-ORIG-GUID: 5AoFnycFvdxhSj6SGeFdMdfarHvGyxeE
X-Proofpoint-GUID: 5AoFnycFvdxhSj6SGeFdMdfarHvGyxeE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_101610_556366_28AD6552 
X-CRM114-Status: GOOD (  10.58  )
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

On Thu, 22 Oct 2026 10:19:34 +0300, Avi Weiss wrote:
> When nvme_tcp_start_tls() times out or is interrupted,
> tls_handshake_cancel() can return false after handshake_complete()
> marks the request completed, but before nvme_tcp_tls_done()
> finishes. Error cleanup can then release the queue while the
> callback still accesses it.
> 
> Wait for queue->tls_complete when cancellation loses, before
> continuing cleanup. Preserve the original timeout or signal error.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme-tcp: wait for in-flight TLS handshake callback
      commit: 284894b212b5895047c4159525467510d707de5a
--
Keith Busch <kbusch@kernel.org>


