Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CEA606A6DB
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=S3G7nFvY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jf0k2jZ5GT4jqtEGuqrJuKzcyXCpPc0FQ7ztUI+mW1o=; b=S3G7nFvYc8rR/3
	vmFG3872Jpjlb+jRJkHme9jJwEO2w/Gw52Avlforc9etPMPDi+vysJHh5WHLV4gRI9zTAcFxnOKaO
	G59q0lpxAid5pCCtdquaW9U+QRJ2dg2xXED/CN/6oxLrysjVSWUeNKrfq4MgaEBUrm42upQNpGc/C
	yp6WEPuzeMFPhTFlk+W4ou/forVlrRCr4gDlKnGBB1XjQ+SplE4x+0nJL2NX3MuOa0OsPbwb2DkdQ
	1zoQgTV4PXMid7scANBfFegOuFDRanFDrWaJ5+2KCWPje/oM9vyaTHDi0/jQZNnLItmfgpnd0vPVE
	SW41Ka+ZISZ8ir/6/+uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUho-0000000G969-3Ca8;
	Fri, 20 Nov 2026 19:55:32 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh9-0000000G8nh-230z
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:53 +0000
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHISXW1244279
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:50 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tg8194d-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:50 -0800 (PST)
Received: from twshared98463.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:40 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id B6B8F2F4934E3;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
References: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
Subject: Re: [PATCH] nvmet: fix the CSTS state iteration in debugfs
Message-ID: <179520446474.200156.8716970202832870904.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX4GuwC9P0YjQO
 EwF5LVZ0OhSb8obhHjsFXqeIo+molQowwCkWU+7OMKmSKOQ/b97RfHHNqKvccqeKW88Z3AI3Jkx
 I3j7TdW3r2UIuTuBAYiKewKmlnq05UQ=
X-Proofpoint-GUID: vSsO-OgpBzx2IWfGW3pvPzXYgVgNva1U
X-Proofpoint-ORIG-GUID: vSsO-OgpBzx2IWfGW3pvPzXYgVgNva1U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfXzJN3E1yqn4Wb
 IcnGoHhUi91AagqF29XdG23HE76dVing9a+iMHuLkedhBSTX6XInNlf68sOPVr/tzebgnvv9f2r
 OM042hS0h7FNPF6GUeySqvIqdUb+WSzDeONEjVcRUubIoOM9jcAxTOF2BEY4h35Dx2ccYr6c7Eq
 Y/Dhp1ca1r2Tbn0YMoGKw7SEIy8WZ2F+ctSsRcI1eEbqHph9R3ux0PXPHMH5eFGCidtEO3CWT5v
 f4+eXVSeGDh6hXx1piwftTk+IQB7WeL66E92JvSSOkjlChwjPpdhyfg9TE1Rc1HlwrG2MOCkJlK
 JHLzCPybpPpQCPKJSnzcReOVz1P+iKM1Ps2y4f3wzpu/yDA72ovgYwbv3aJ6N+RxnjAkDmlqyq2
 lXa4/EkUnB7wZAeRmMr5xEZlIsmEpfRMmIq+UT3z59YcMvIEHE8xagZjdpeHO3l956tuxanJa7C
 NBQ7D4IwadswV5T0QSg==
X-Authority-Analysis: v=2.4 cv=YewodARf c=1 sm=1 tr=0 ts=6b00a58a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=n7hJ2mYiLs74TmPVfwwA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115452_232164_E75BB1E6 
X-CRM114-Status: GOOD (  10.18  )
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

On Sun, 15 Nov 2026 01:28:06 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> nvmet_ctrl_state_show() uses the size of a sparse name array as a
> bit count.  Its last index is NVME_CSTS_PP (BIT(5)), so the loop has
> 33 iterations and evaluates BIT(32).  This exceeds the width of an
> unsigned long on 32-bit systems.  With GCC on x86 this can make a
> normal ready status print "ready|ready".
> 
> Iterate over the 32 bits of csts instead.  Check the name array bounds
> before indexing it and print unknown bits as unsigned values.  The
> out-of-bounds lookup requires a reserved status bit; the current target
> code does not set those bits.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvmet: fix the CSTS state iteration in debugfs
      commit: fedfd360c2f6e00d7c566ee5ed52e2ee46c99b8d
--
Keith Busch <kbusch@kernel.org>


