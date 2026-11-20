Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4874606A6C8
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uRbME6jF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8ojWkYm9szuOwyIOc7YkfrD0Mz/9kEubgoE2sC2Awis=; b=uRbME6jFoGsnGs
	+xbEtA86C6G5w8ToYrGN88snoC4hAak7uGqHMJkBO225xDfV+YZqUYaSj0q6FCdR/R80j8RNRctzn
	TuDp8QYNJDxEMHR6kyLxhK52yxOq4/BILu6+fTFQkGOcKTsn3MQpPPVXmMa6E9b3GtPOPoURwy7S+
	PjYybO7PiTSDx8wS3pW5jCzrWI3FPolHG04pmbQBZ4PM6W+mGOl6+yjLhb5iIsut2Hoaayakk4Ec1
	2OttnJO0ffZH4aw48VWWithJb2DoO/RtrBiITSuUc/+Kbaz6vtUO6mt7irkRA4jMicE0zfPg0jjE5
	b/qkzCAQhWJcm/0V9XZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUhG-0000000G8s5-24j9;
	Fri, 20 Nov 2026 19:54:58 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh3-0000000G8l0-2Oho
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:46 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHAegT2935013
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:45 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tcjha7x-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:45 -0800 (PST)
Received: from twshared98463.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:40 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 2CF1E2F4934DC;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
        Daniel
 Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        Guixin Liu
	<kanie@linux.alibaba.com>
CC: <linux-nvme@lists.infradead.org>
In-Reply-To: <20261120080540.1177154-1-kanie@linux.alibaba.com>
References: <20261120080540.1177154-1-kanie@linux.alibaba.com>
Subject: Re: [PATCH] nvmet-fc: skip hostport handling when the LLDD
 provides no hosthandle
Message-ID: <179520446418.200156.8133257052053093364.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX/rOOC+sDN1gz
 AY2NrdWqM7X2hx7uRzDRhaiMtflue39lgC3dCwKeyH/3lTnZQ5XN9H5Y2yf3BwpkJEC3fEq7Krk
 +4E7bAuui9+6cOgjpKimTNsEbO9HNys=
X-Authority-Analysis: v=2.4 cv=bMWDs/+Z c=1 sm=1 tr=0 ts=6b00a585 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=Be5DNFHmItW57VKgbRoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX6qZPR+DhGKzm
 mWhtuPCml4xzi9LeXtrgJVnLksF/vDn71hn110z7VoXn1+cMWO3GHnjpHrg3ffA+cS4SOYAss43
 V582dV2wowjaL8CeiGBxWSlQsHGUgwiOa1Crb+cNTJYke08FatIh0c9dU1PUnxM2sCReeyVCyhL
 3CE51vdoglevik9MJ48P2SZ5VfAs1Mbo/Z3s2Qnu+Xev76JnG088fHjMdknhlEXKAPn0jjmcwWR
 4B588zuZiZGrCBRB844yGQOMlA3d78FTXQNUstn3ZPPr0uWB1Ctmy8Ino+E2oMdd9vswKiYG30L
 9rHDZ+yAsPl1fTXK+1UeRoUj9GfaqAzUhAVWhbunzZq9XJjEUpW5U0rm1MCoumBoQKU9Ttqaf+s
 l9JfpFIegqnExJIKwHWONNiO8r9YSuHCy/JXhYrNLydXHTvHjM9mQCaAE+eMKeJorPbdUvrR8iA
 hOb42f0prwWEmDvaC8w==
X-Proofpoint-ORIG-GUID: kzv0ZFQRsmdUNM6fIPxfW_5lXjtSwqcW
X-Proofpoint-GUID: kzv0ZFQRsmdUNM6fIPxfW_5lXjtSwqcW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115445_644246_5EC451BE 
X-CRM114-Status: UNSURE (   9.47  )
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

On Fri, 20 Nov 2026 16:05:40 +0800, Guixin Liu wrote:
> nvmet_fc_alloc_hostport() returns NULL when the LLDD does not implement
> the hosthandle abstraction, but the association lifetime code assumes
> an association always has a hostport:
> 
>   - nvmet_fc_xmt_disconnect_assoc() reads assoc->hostport->invalid
>   - nvmet_fc_target_assoc_free() drops the hostport reference
>     unconditionally
>   - nvmet_fc_invalidate_host() compares assoc->hostport->hosthandle
>     while scanning the association list
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvmet-fc: skip hostport handling when the LLDD provides no hosthandle
      commit: 65f2f49bd912d446f93f840303e90283142ed15b
--
Keith Busch <kbusch@kernel.org>


