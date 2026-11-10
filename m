Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B789606A326
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vGTbO7ui;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o0iQOHf9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oGTRBIwBTCS0F1nX8cEfzPofeO/4GAwflNUq9/3wXBA=; b=vGTbO7uiek6Ojd
	tLgoDwqVEmqiiDrVmC7f/iQGykC89uEIKo8MSPtkILj5V0tWamhMPa6MICErff6ZRNz3psn5pJ9lN
	paY5pL+I0KpAApmcVN6Ekpud/TAaEGg9E9rM7Dwg3ZKKUrAS+kKcEYe61jmKHgj+3XQzH3AL7XKQt
	+HX31VsmzT56eqj9LY39yERkol3t+b6xPxhhdC/VLDUzv04Fmp8ItBl/mqRbCXmWje0OIOCkPWeD8
	KADCSwO/pR2iXjqDQqOVAtWGmAw2wl2WXzT77s35tDDSi8zCBDGMnCWLVSFsrgWVomr3r/gauJhsA
	SmPvEkcTRwAUarjAJZbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQffY-00000002iE0-0vFr;
	Tue, 10 Nov 2026 06:49:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQffV-00000002iDW-3gct
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 06:49:22 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA51lZt1631975;
	Tue, 10 Nov 2026 06:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oGTRBI
	wBTCS0F1nX8cEfzPofeO/4GAwflNUq9/3wXBA=; b=o0iQOHf9msHZNxGsBX3Zmt
	gVX0OnmIVi+GvnpRJKbBksHAJFVgwOG9UyoL3k8VurYGsrSbPWab9QWVcrNzKdVC
	CfvBaKp1I2Os3vZEm3baqqxAmRU8vnBEIKH8Eyyhu9ueJuvKWJL3M22JD+VaMlnS
	dNtkiYZijilpwYvhwzOstmAUAenInVGfwKt4F0vL4+cacFvirEvip0m2wktP9lPl
	0M8ANKgIdTIhAE2SOXm64YpH2cDzS5yP0I2y7FA+E40VUddJBNi/6HNpQp5R5Sz5
	Ru4hA0rabyUc0jgmBzAJz2IPAB5GVnWzowckAqvVJqK+cWEjOXh5cgxYUO7g3KJw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug63k9d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 06:49:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4K2oE1216464;
	Tue, 10 Nov 2026 06:49:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq5pec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 06:49:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA6mGW119530338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 06:48:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00F7958058;
	Tue, 10 Nov 2026 06:49:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7095658057;
	Tue, 10 Nov 2026 06:49:03 +0000 (GMT)
Received: from [9.61.143.141] (unknown [9.61.143.141])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 06:49:03 +0000 (GMT)
Message-ID: <a25dad48-82c4-445b-875d-b1c20c31e346@linux.ibm.com>
Date: Tue, 10 Nov 2026 12:19:02 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] nvmet: fix nvmet_ns::bdev access using
 nvmet_subsys::lock
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-27-nilay@linux.ibm.com>
 <50a22851-ce22-4c31-afdd-9fcd49854dbb@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <50a22851-ce22-4c31-afdd-9fcd49854dbb@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: orGbijZyG9EC9X0iao5oihUzM44uvisu
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af2be64 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7z6e83x4PxQBmx97XDoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JiyV-Utembkm49znWekGrHMWzlubYMh5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyNiBTYWx0ZWRfX0IFX2Nj71FuD
 FtKDsBsCYvoWG+XksHxXO2J5QG7fgHfhVbxI7KJL/SFBmLkkYbkCyun1FUx8sfGjE5/Adxk0aHC
 QPIwDbgGyUCmTfm1C5YCa7DmrsHbPI8CkZDScGw0NPiwKr0h/TGxRgj949gcICp5/CpdoVDSIZC
 qPii19Eom79y136zuYpXVFuAG2aIgUn9beCagEuowM7r+mEtbHS+V1fElxNqp/ncaywgaL7pw+D
 vmC8nQer0+/AAK9y1dA8S5ebIl1JptsyLXcfRnua1q3rznaztiiSj+RcPTarvMGj1JOUk8Ofmds
 hBcV9SAO2xbDhrkKw+QpW+RvyUAbX3kr8j5QNqZ+qyAXXJDB28pUxOBIJd5lld0cHa6LR5iK9DM
 86Tith3VGZXQzLc4kE2gIeKeL0zb/zXqcoA1yXj1Dzwvqp0BcHaJpcRf6vcTv09MUyKwepSZM/X
 rGzT2wEQ+mMWZeegElg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyNiBTYWx0ZWRfX0Jh4wPyE8/pp
 OuxTykQvbIQ4XJDDwgVPhcqj9dU79pXbkDso/Pm+9/vedQttyQM686iGjD+VVP1lBkVCuXHVQTi
 39YMNqYVafeLsB+HLNGprnwLdcUHo68=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_224921_918745_08436D5B 
X-CRM114-Status: GOOD (  12.88  )
X-Spam-Score: -2.6 (--)
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 3:17 AM, Bart Van Assche wrote:
> On 11/8/26 7:28 PM, Nilay Shroff wrote:
>> +        __assume_ctx_lock(&ns->subsys->lock);
> 
> Please pass "subsys" as an additional argument to nvmet_get_smart_log_all() instead of using __assume_ctx_lock().
> As I stated in my previous mail, it appears that the context analyzer recognizes
subsys->lock as a near match, but cannot establish that it is the same mutex as
ns->subsys->lock. That's why passing subsys alone doesn't resolve the warning,
and I used __assume_ctx_lock() to explicitly establish the capability expected
by the field annotation.

If there's another way to express this lock equivalence to the analyzer, I'm happy
to try it.

Thanks,
--Nilay

