Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DB606A33F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4BVzioiV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QShwFXVc4TIj1Q9ZwvuBQ2UDDsgucmj4kvIqTU75w6g=; b=4BVzioiV6I/Wni
	LOnUGTsCveBYQJreCSYVX/Y/rjwYTx9orkWMLTlTCiTsk6AK/2+rlCbCQyKLILst6VcRFhTjHG3W1
	6mOngiKCBi9pKVAg/doWGyj4FAwvJ1FGeF+q1Slc+uU0aXOnI+EsorQAH2MKHHairYU8UjpszTjsl
	6H2BhTOYWIxJ77xwewTfCbT3kKqbItIATSXy/b8t9Sd3QnqfH2cEkVSRqlPX7s+gNc0vq5Kw7SENs
	X49v5rGNZaQ6TSYRKCKxuITJthOXJB29skSsIehttdEhzju4gTbbLqUqyb68ARIXxsioMet8kjMRh
	kr9EC+VAZWIjEAeSlgDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh3-0000000G8lM-3L9w;
	Fri, 20 Nov 2026 19:54:45 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh1-0000000G8jb-0JAZ
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:44 +0000
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHAegH2935013
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:40 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tcjha7x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:40 -0800 (PST)
Received: from twshared36151.31.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:39 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 4A76C2F4934DD;
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
In-Reply-To: <20261116081211.1757155-1-kanie@linux.alibaba.com>
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
Subject: Re: (subset) [PATCH v3 0/2] nvme: fabrics and target fixes
Message-ID: <179520446430.200156.4397281152675386883.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfXwXZcS5wDRBlQ
 LdmaWVpG53FSsbBiPEsB8kEcVwoG0bBtJ1J0ky4gZ7ODRxPYrSLanzAfeiIONXBPBUiXY38G+WT
 Wlx/gXzh1EpbqdPlwmxHIfwvLA7m8Cs=
X-Authority-Analysis: v=2.4 cv=bMWDs/+Z c=1 sm=1 tr=0 ts=6b00a580 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=hVyGQdznKZfJv2TqwZAA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfXyqOyPrLQO9AJ
 BbIBergDB+FlieFE/g5hWAJBTZoTcILrjM2CRyJetW6NMmmazqh7Y2wsjjhtlyLZNDe+xcMs5it
 ogiBZRCGmljjo5dnhq3BG1rbnEsUL+9rYOKH4awwQo7t8VStsxfIZGnINbro7Ld8/wIECJI8vQa
 dhpFn0XmHihrjyzws0FI/StN19v0rfoLsFG24F/u+JysxazfIVqbvbR3bn6WX+7DFMMxhPLKb6V
 T9lW5uIKSqdlAldfvyCoeEtmkYlHa7Jq9EVsW71w2XFpibgwRqpWYZzTyV5GuyXDwm1zqb3GUEG
 Y43BLJ48+wpp6HiB+3A/bp7jG9pfCo1VyMqQ2dysMeTGVM5sv8FmCMNvbSldshOPGL+Bt66S9Sq
 tt412pJ8Ry6RAPnpv3qfevKcmlogz9R1SHuaujxsNSRTKnkNDSmyMo/zarp6OekjW4Gyqhm1dsC
 bxpi5UciU6XdyMOD/6A==
X-Proofpoint-ORIG-GUID: HnL_4RV-BPeXHGbR-QiB3KYrbunMTU13
X-Proofpoint-GUID: HnL_4RV-BPeXHGbR-QiB3KYrbunMTU13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115443_125077_5C4DE1A9 
X-CRM114-Status: GOOD (  11.71  )
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

On Mon, 16 Nov 2026 16:12:09 +0800, Guixin Liu wrote:
> Two remaining fixes from the previous rounds of this series:
> 
>  - a use-after-free in nvme_fc_match_disconn_ls(): no iterator is
>    sound across the rport lock drop inside the loop, so the loop is
>    reworked to run entirely under the rport lock and to take a
>    reference only for the match; reproduced under KASAN through fcloop
>  - a data race on the shared authentication transaction counter,
>    reworked per review to a per-queue counter, dropping the shared
>    ctrl->transaction field entirely
> 
> [...]

Thanks, applied to nvme-7.4.

[1/2] nvme-fc: fix use-after-free in nvme_fc_match_disconn_ls()
      commit: 505384850afd4c85f6d58cb3eb078a71f83d849d
--
Keith Busch <kbusch@kernel.org>


