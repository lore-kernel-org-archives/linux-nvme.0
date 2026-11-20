Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011E606A325
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aoIp/Yqx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:Subject:References:In-Reply-To:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hoxfplFe/TQYjJ5V/KtZzdefBVtuVMq1TspOz2xkKTo=; b=aoIp/YqxlwwsYC
	rTHUNwZBc7x2FS8GckoOkQSNy+MXh/ANQQRoPharKUOXtg15NaRgRLGGXBYiK2B5NFYmz2+hDvGG/
	Q5acXQuKTN5xFfjGUs5RTx/VGrLwHO0v5QoYyKRN5ga/xkzyN6c4hFxx3V8lEiNMrbvHKU2HmelMo
	rrZrawIIIe3heLYFe7hpyZyFHZQoLcGVm3BOY0qmFGIIs0NxQYpUWwhyYnDyzMqbN1K801QJ/+vEp
	bnSfsHUOUVMFp83OkuxZ9GtT2VMZUc9g+oPAJdvVJhl5FaD64U6U/hmxQpsaX/szOAg0qKTvvShkf
	k8aoW6APHERW9/2qnEXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh3-0000000G8l2-2epC;
	Fri, 20 Nov 2026 19:54:45 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUUh1-0000000G8jc-0Jn9
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 19:54:44 +0000
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHAdZt2337671
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:41 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tcjsamx-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:54:41 -0800 (PST)
Received: from twshared80817.17.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:38 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id B93A42F4934E4;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
Subject: Re: (subset) [PATCH 0/5] nvme: validate and decode controller
 supplied values
Message-ID: <179520446475.200156.12946198917113625003.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:24 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: EIDdPlf9nUn6gCuJnb9anoNZCm0WX5Cv
X-Proofpoint-ORIG-GUID: EIDdPlf9nUn6gCuJnb9anoNZCm0WX5Cv
X-Authority-Analysis: v=2.4 cv=JYcpPkKV c=1 sm=1 tr=0 ts=6b00a581 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=013bj7QzCcn9ZdgyvDYA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX8QaPv4ir/Ro+
 Y77CrPm2B7OQ8jkMFKtkR0LNWr8clUcDRG2VdfFg4vU2VI+wjU+SaSnCwgL/sMl7U3Cre+y3sII
 vcQiEbsbEBr+wGie4cXTCHRdQ4jHLLhXQteaQQyAI7swZ5KOpX35UmZdeT9ZwbtMJ9mqnB2LXmF
 meF01BaKsVtTHAy1NdDRDdcRYyY3r/zy1B+n9qh64RV7NxKil5t7lSkJAZlkZEwufzanSKwSguw
 nrBKqKOLstDocM4qBggCikCZNTj/rwDk6vg/u/5v6/lkc7wlwD54ADitbgGn7uKT+BXdUcbERKi
 5wKNCiBDgRdziYwXLsmrWLI4WWd33a5rTgj6/vbziqxDEYFkk3D+yAWPuUt0AYvd7vld/x9HSVb
 mFZ/fIv7rxfgpheJjoFz2sGN1Phf6jP78MMGaqx7G7nTEDs8iXZJ+iA/TRqKGFDvBcDDIJIXZf2
 oXVP5EV6fyWRJ8DLzlw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX1SV8wNMnnTYn
 n46G1LLOQbraFLhTI6qxqKXZncbxbZIpzaBD7uGccmVhBCXMfxGM0q9auyQU0T13yjjzXWfTjnu
 PjHzeyT4ODfaeBgwhIKbxAVDCiJO0jQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_115443_120692_83C3EF1E 
X-CRM114-Status: GOOD (  10.32  )
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

On Sun, 15 Nov 2026 01:27:51 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> This series adds missing validation and endian decoding for values that
> come from a controller, a backing controller or a user request.
> 
> Patch 1 rejects an invalid ZASL from the controller.  nvme_set_max_append()
> shifts 1 by zasl + 3; a value of 29 or more shifts a 32-bit value by 32 or
> more, and the old code also used a signed int for the shift.
> 
> [...]

Thanks, applied to nvme-7.4.

[3/5] nvmet: validate the LBA format count of a passthrough namespace
      commit: e52b8562e2adb7c3bc77f8899db03f763d9cf49d
[5/5] nvme: bound the reservation report retry loop
      commit: b80093c7d0aabb92343f6b333c8ee36e7870ca67
--
Keith Busch <kbusch@kernel.org>


