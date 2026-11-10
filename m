Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69142606A31C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 08:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zdWkBBuR;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kElyEk6R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UBndQeo4kexQ2982B78PRnLng5x8qBx2fWryIb6GF7Q=; b=zdWkBBuRp+98sW
	kkPHkfZocr6LzUVQWHxU1i10wO/jsEpHnGqO+AjcFlXCWV0Jz+Pj/4VsaaOAD3MLo4OccjFoT44Ui
	m1xLS8B16nGmCElBbpvBU4fONacWfM1Hmha9Agdvx+SonTgn5/zA3YWxvOEH1vY/u1lk9cyGBPTPM
	Vg3qrPXenULiqfl1mBw3NjLMZc0qbJrQ9EJrwKALQ1Q9tHPhTC3ZJyU0XgdUHnxNfQtI8LnzLBdru
	JMPwXSRMrkNykZQEGJ2xguCFLWG1p6cgYf7wGlNuE/kLyh+R6P87aWoxWaZn1e6q7hatrdhwqIrJC
	M2D2R0t27Aei4JRktwPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhZV-00000003Awn-0LjN;
	Tue, 10 Nov 2026 08:51:17 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhZS-00000003Avr-0oTo
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 08:51:15 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8ERuc602398;
	Tue, 10 Nov 2026 08:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UBndQe
	o4kexQ2982B78PRnLng5x8qBx2fWryIb6GF7Q=; b=kElyEk6RpTrsAX12tpHbmn
	S7TCsZJA3ihsZ2TfrmrxIahs1WjgsdK9iNw5XEpndtF5g7ml0y8FBSL7buJjQaUD
	BkAm2G483Wf6xqNSvqZCgdwQAYugGZRzdcgfmkzm7/XTv1w4Lbs26A+FlZNE0cGN
	sz68MDo/izXqOkge4Go/NEMIlf7ZjDMSXJxXDG+CnTiFtan4bIU+7Sr+22kykIE3
	heNELAGg+tiUhwTv8N3nSI7dCHdRPLKgSATNQhqMKTRFXgDjBX3/RHz1tPcgNppN
	PaupkUaWschEjmjCk1xZzoOOvA3FkzaesWFD4IvyaDOAMrAlrb7Sh0XoIeRQEFSw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg3kc0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 08:51:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA84u291498080;
	Tue, 10 Nov 2026 08:51:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvwytc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 08:51:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA8oF6L27722378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 08:50:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1820C58059;
	Tue, 10 Nov 2026 08:51:05 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1345558058;
	Tue, 10 Nov 2026 08:51:01 +0000 (GMT)
Received: from [9.61.143.141] (unknown [9.61.143.141])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 08:51:00 +0000 (GMT)
Message-ID: <89747f20-3b3f-4370-9717-fa3fce242628@linux.ibm.com>
Date: Tue, 10 Nov 2026 14:20:59 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/23] nvmet: add context annotation for nvmet_ns::nsid
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-31-nilay@linux.ibm.com>
 <a8268f53-bbe0-4648-93ca-fa71081137bc@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a8268f53-bbe0-4648-93ca-fa71081137bc@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af2dafa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=WoBpCtCYttECDN_zKDYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNCBTYWx0ZWRfX/6K4LLO2kDHi
 nD5hOSVGXtJZKuzFfhcUZ+DOU0b5+gZoXcxARntubZIu7g4IpqE+CzAULL31CKed2mXAxXPg94b
 y85UtpbmuWHmPIkQ/578z23aBcxpSQbUhCSaSLbexvHMMWzA5B1TwKHMYj6hTmgwvlD4fehP5Zc
 vAXVIGa92CX+EV82qIgK/YpElhckTJBLBfkdXmIVhtEVOIso3uoPfelGFinX9nT/lvQ4AfvRt7M
 LB/ajnO5Y5QF03k/K12QXDV+PSn2nBzDtqF0peklDriJe7ei7Zcmir8QWbM6/5/IKavPthYK7qu
 ba18tR+pD/N2h9IzNAbbv9CtKMFIMmxyq3KcIMFfvjDVC0Zxcd7D/zvUO4WRdhCYCyva4thFxai
 kApvfIW/eCO9d1CNXvW42b/KBvGeDvZcSIY1OtTY7DhJ4Hy5cjtixlKfEXvHpTfKNT/OMzW7MS/
 ICN7IrymBw3U5g6TSNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNCBTYWx0ZWRfX3BOI/dwSaIug
 4T7en+HDqxLKAcn4zAORV7ZmnpGzwLWFl6JI7sQA0jI5Xe17Vt8knLuusBNWqQoPalv6VpbyVkj
 WMWkkCa6mzGIwBLzTSf01ppcf9o8u0c=
X-Proofpoint-GUID: tGI70byy-BjbfCcgIec4sb7AsdeLjdSX
X-Proofpoint-ORIG-GUID: jb5u_OqF7kIQsKgqMjYrmgwIA6rciAsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_005114_352454_70CC04A2 
X-CRM114-Status: GOOD (  21.72  )
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 3:26 AM, Bart Van Assche wrote:
> On 11/8/26 7:28 PM, Nilay Shroff wrote:
>  > [ ... ]
> 
> 1. Bisectability:
>     This patch causes Clang analyzer errors in nvmet_format_ana_group(),
>     nvmet_execute_identify_endgrp_list(), and nvmet_execute_identify_nslist(),
>     which are only resolved in patch 07. Please reorder or squash patch 07.
> 
As mentioned in your next comment, I agree that the nsid annotation is unnecessary
and will drop patch 06/23. Since patch 07/23 only addresses access violations
introduced by annotation added in patch 06/23, I'll drop patch 07/23 as well.

That said, patch 07/23 also addresses a separate locking issue: we should hold
subsys->lock while iterating over subsys->namespaces. However, I'll address this
when annotating subsys->namespaces with __guarded_by(&subsys->lock) in a
subsequent series.

> 2. Design:
>     ns->nsid is set once during nvmet_ns_alloc() and is immutable throughout
>     the lifetime of the namespace. It is never modified under subsys->lock or
>     any other lock. Marking it __guarded_by(&subsys->lock) and creating
>     nvmet_ns_nsid() to bypass the annotation throughout the driver adds
>     unnecessary churn. Please drop the annotation on nsid.

Agreed. Although ns->nsid is initialized under subsys->lock in nvmet_ns_alloc(),
this happens before the namespace is enabled or published. Since ns->nsid is never
modified afterwards in any other code path throughout the namespace's lifetime,
annotating it with __guarded_by(&subsys->lock) is unnecessary. I'll drop this
annotation.

>  > @@ -746,6 +755,12 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
>  >
>  >      init_completion(&ns->disable_done);
>  >
>  > +    __assume_ctx_lock(&ns->subsys->lock);
>  >      ns->nsid = nsid;
>  >      ns->subsys = subsys;
> 
> Here and elsewhere, lockdep_assert_held() should be used instead of
> __assume_ctx_lock(). Additionally, the lock state should only be
> verified after the ns->subsys assignment.
Yes correct, but if we drop this patch then above change would not be needed.

Thanks,
--Nilay


