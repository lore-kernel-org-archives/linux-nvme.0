Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190DB606A32A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=j6/V0FUv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nvFyqL3Y0/F0u1N6y6kg8ykuU4M2/XUEp7+RfXlmBzs=; b=j6/V0FUv5hvhYi
	t5yC4SLQtj1rksS4q+5fV/xp73XCvSMVYxwBhEF9TonusNB/p/syakbNr7wjZBFkS2z6PNdlVIXfM
	Tci/TRsIiu824ijXT1yJV8+1SgHKjw/pjSMLH2j2hS9p4SnaSWenyddegQBpNo4Mepjo2oqL/IsyP
	JSwIseITiwSvQhvj2e9Ofp5QUMYmvuzILUzemjQGpVBhSb3rhAzDqbXA098ZKO7g7vUkG02jfMhUV
	LhDtPhgjcYqvrxhDQkABHBjEI3wHfkv3vXexgiEbA4CPlyYjUBzgqYblFRGyQf5/zLTU+GlrC4a/t
	azOj5NgMGaTALnwJ2yoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzSc-00000003Bt2-1Ofc;
	Mon, 16 Nov 2026 16:21:38 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSzSa-00000003Bsi-1E3m
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 16:21:37 +0000
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIfAw2660633
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:21:35 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hya99p6gj-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2026 08:21:35 -0800 (PST)
Received: from twshared77744.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:21:21 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id A7B112F08A7BA;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
Subject: Re: [PATCH v2 0/6] nvme: fix transport request and queue error
 handling
Message-ID: <179484590968.648177.5424785032446332753.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 08:18:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX8+56aazsappe
 KspTx/lf3KgnwPcddSi6Jsa1LctEAiCnUzr/PkvIIeFMW8Nz/5klpOZrgSyV78GScJZNoVbyhaT
 CoNG3aWZvjga3VH6j0JEsUL5pHom1IA=
X-Proofpoint-ORIG-GUID: v6pccT8okmNTiihgdhQW4MA7c5jZ4wyv
X-Authority-Analysis: v=2.4 cv=ZuN4uN7G c=1 sm=1 tr=0 ts=6afb2d8f cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=0v5wFFy9qJCc6wKa7McA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: v6pccT8okmNTiihgdhQW4MA7c5jZ4wyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX+R8ednACaThM
 38fzmdfgJ4lfdZBuPltYHv70MnoVrlF/lxA7rFCjD04GJ7bSYi69eU+DMmt3+0mGi7D/q3QpzUf
 5B9lQUeFLLcgqs+UpfsozSIrFNSDL1+pMHrRYNFO0PhsIeBzdqxdj94LA5EcdGesjT0qYMSjXjf
 tgnVlp/ELs3ngc4/y6C8RRIygX6HOnNqRd5WlsJsLldUCe3ELNTk6gLZCqU0eyBHVAZGBPFKrPi
 CVB7XJiURnPOS7kgmeQeJD33mBtMPkQ5aaec++T2B5EU2Yv3u0/Xyp3d+A50sYy09I4JzYVpZ1e
 J9jHnI0QE0ZLNCegr9lQu5ktSbZLggZWwhrlf09OfzhfAfu5s2n68H0bAqJz93qbzGM2/686fDB
 178KA5bnkBjTlIEl49NQ++TQ5SWfvNjl58KsVUag0fMSRRW7DWLDWs/31YGj7kiKkNwutQmJz6u
 aUeVriVbVF9qf1j5+aA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_082136_891394_6B2670DF 
X-CRM114-Status: UNSURE (   9.08  )
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

On Sat, 14 Nov 2026 02:02:45 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> The six patches fix independent error paths in the NVMe transports.
> 
> Patch 1 releases the target request in nvme-loop when SG setup fails.
> nvmet_req_init() has already taken the queue, namespace and reservation
> references, and blk-mq retries the same request, so each failure leaked a
> set of references.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/6] nvme-loop: release the target request when SG setup fails
      commit: f2937481c28033e10e8a29b8742a767e73c696df
[2/6] nvmet-tcp: only wait for in-capsule data for inline SGLs
      commit: 9dac3b1aa2a99e126a5504b7f5bc781c8b2771e0
[3/6] nvme-tcp: require the R2T offset to match the data sent
      commit: 347d50d92e25d4b9c50c5f5c1d8b727b9c88d12c
[4/6] nvmet-fcloop: free the LS request when delivery fails
      commit: 8c1f99419b6cc51892e259497c8e10a5d079621a
[5/6] nvmet-fc: reject duplicate queue IDs on Create Connection
      commit: 153eac284ebf68be74993643e9b2fe2f9b2b1d88
[6/6] nvmet: roll back queue bindings on connection failure
      commit: 3f82752e089283eb8204b9d2ebd8246077031173
--
Keith Busch <kbusch@kernel.org>


