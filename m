Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E99C606A331
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gIH02bJr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7UXGBzR+5rEYyQlPP5+mMP0S0QqtG1TcgnC8R1Thm6I=; b=gIH02bJrkvAo+4
	4BoRwNXtVz6u6UdW42SkzOW0Xk4EP+r/a+O2lUxCqpLPuOBkyGySHuLs0oEMFsyHP3R5+WNYyBRcx
	YeXZuW67F8EcbQMY0VyiSvdgv0ZsfPRoPGE8u+wFPW89Cm0NMG/cNJMMRWGRDBQK7IDmfamUPkjph
	YJrU2xCgcgN01HoZNm0KT9ibtm3fX6iOLPTpgv8cdm+rzb8VqPqPmyMZZaElrWue1w5bun0+cKRcx
	JJT93X68iIkSFPplsUtDBEDIG0aJnCPe6/TOkdV/iPDI6zx7H1901peNudCOdna2HcNWSzD/Mmew7
	Uh27wMq6yZg7fXYPPx7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPr-00000003BEQ-0ZLF;
	Mon, 16 Nov 2026 16:18:47 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzPo-00000003BCx-0RM3
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:18:45 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIguh2345161
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:43 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hxp8hjfdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:18:42 -0800 (PST)
Received: from twshared26372.02.snb2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:18:41 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id AB9172F08A7BB;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Martin George <martinus.gpy@gmail.com>
CC: <hch@lst.de>, <sagi@grimberg.me>, <hare@kernel.org>
In-Reply-To: <20261116100244.7824-1-marting@netapp.com>
References: <20261116100244.7824-1-marting@netapp.com>
Subject: Re: [PATCH 0/2] nvme: use kfree_sensitive() for DH-HMAC-CHAP
 secrets
Message-ID: <179484590970.648177.14486358557240564408.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 08:18:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: hSLH84sf-RuNIgmUj8UpRaIUJEGlJ2Bu
X-Proofpoint-GUID: hSLH84sf-RuNIgmUj8UpRaIUJEGlJ2Bu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX2FLdVpHdx9a2
 08XRX4OolbuAkgGj9vAo7STrENtA+fZVSsWRUrmun1KVQBlNOTKSZgR1vydfrynHV7dquGL6dV9
 TUqmaSOty79QGcCDHNpOdLMeFmW9j88xeB2sW6F5UNHOm7yd0yaCU85q5WJhOzOEUJx0P9DNSFh
 ImBUsVbPeLzrCrfoEIJ9DJl5eYbCJ00hWpPsJMxnLqyAP8J8RGby/pgofzJm66LMmsiaT8XEsMS
 HRqbn6tOfYIOiurwozuV9flYa4JtvPKBPg3b7Zww8rwh3i78zB4ihB1WOt93R6bSHvez0kpTKMn
 vYroB6PCaqG8alL2Cuck7oiorZOU8H9ZEMCBVL1kPrfq5r6wpwFY5lwV19m7SHPpUWg8Mbcz0SU
 THlDUaE+P+ws9nWMFCoPkQ+chVE2KoXTqoGrkDGHl0B8LyOcyOPpGNuyQA/ByEyjKhXBVUzTL1m
 DhbW5lIIHBvCcziuQnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfXzsJp53pH1qGz
 3IAnUqtB1wsnoasSldk+x2qXu/zykS7337Ps9cmfGgVQQB6mriEsZg3Ja58Saa9GYVaFioWi9+W
 t7veA+Av+WN7HiWUTxaTqtgp8ldm40M=
X-Authority-Analysis: v=2.4 cv=J+4/fwnS c=1 sm=1 tr=0 ts=6afb2ce2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=xtH7KyWI9dI7BmFOsl-x:22
 a=VwQbUJbxAAAA:8 a=6A6OBvg0bk2zjrTHOSAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_081844_265194_67F3DF2C 
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

On Mon, 16 Nov 2026 15:32:42 +0530, Martin George wrote:
> The host side stores the raw DH-HMAC-CHAP secret ("DHHC-1:...") but frees
> it with plain kfree() in a few places, leaving the secret in freed slab
> until the memory is reused. Switch those kfrees to kfree_sensitive() so
> the contents are wiped on free.
> 
> This is a hardening-only series; it fixes no functional bug and changes
> no behaviour.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/2] nvme-sysfs: use kfree_sensitive() for DH-HMAC-CHAP secrets
      commit: 7fce38923253c27650835c91201b222214aeb149
[2/2] nvme-fabrics: use kfree_sensitive() for the old DH-HMAC-CHAP secret
      commit: 68099cf27253a8c89d703a282d3d811446d9453b
--
Keith Busch <kbusch@kernel.org>


