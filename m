Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143A606A327
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 09:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BvdL2ZV+;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=g3C2Eba0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MVcA4chgMMDEmnNMU77vj8Lf679fDrGI3TrVone8Utc=; b=BvdL2ZV+K/TNVW
	Z+sJDHW2tciBTVd0+B/cjhXYbwH/p0ypjtrZcuWVzFjiakiwLtXffEaKAl8BWnKhFWTMdj9aeCnzB
	zG4tsIyGTJx25TYdAVIneFlw18ExABxV3jH9vuRIFa0sKnUgcFFevRDbG7k+/ljUUqmJCbIapjx79
	yVPSnb+FzlCcvfL1xz3F1RXHPK/yfmqlmkIcPHxvDs4rbZO15olIjMW2oP2worDwJ7Vymh7M72D4v
	WZ+DmuoHlZo/hNkaDeKGnryq8Kr+LMzUW64tYrItstjPdhBMeu+OO2f/u6FCNOtAQI9H5SDEyMn7h
	kPFJuRfOQr7vkGIdM5+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQjp-00000009HgH-0xiP;
	Thu, 12 Nov 2026 09:04:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQjc-00000009Hcn-11WS
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 09:04:52 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ija52858255;
	Thu, 12 Nov 2026 09:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MVcA4c
	hgMMDEmnNMU77vj8Lf679fDrGI3TrVone8Utc=; b=g3C2Eba0eefCaQTN6gskNF
	ll44ndtCtc29WrZ6R6Mm5JAwmRXsz0ZK0smJ2Pon5PZdtfDDpzi4Ihzqk5B+PPFC
	LknFAVlHw2fVRvxC8ziQh05RGchbvqfv7uZKLDBicVat/Vj6JxHW9VFGUVn2eiwG
	PLeCdN7njIMTUsGWgYNI+IjjvpdN88sE8GCebKR17gQIfzikyfiJcJ1DqDs5LUD+
	ryl3e3+KvbT/UxFtWvhUOvrNxTRRgkZJZ0mdp2QnLajlzNoxoHKPkDZMtOkcNYFN
	GFvKeXnL+wqKz+PUqZQlDbjMaZ+fUf+Vc227f4pT5JxcJoe5wmqkeZxwzJ9qevjg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv5ey4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 09:04:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8FsWP053986;
	Thu, 12 Nov 2026 09:04:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309r46d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 09:04:24 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC94NYR32178814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 09:04:23 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9F3958057;
	Thu, 12 Nov 2026 09:04:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B631D58061;
	Thu, 12 Nov 2026 09:04:20 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 09:04:20 +0000 (GMT)
Message-ID: <13905077-d09f-424e-b04b-cb1a961323c0@linux.ibm.com>
Date: Thu, 12 Nov 2026 14:34:19 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-26-nilay@linux.ibm.com>
 <8beba915-07a5-4eae-b8a4-3ec7330c90f7@acm.org>
 <e9f42390-9115-40b2-b0a5-df17c53ce38b@linux.ibm.com>
 <6708de12-ed0d-4101-9328-d08864e677a5@acm.org>
 <e31029f5-c022-4fc9-be94-d1faadfb327e@linux.ibm.com>
 <849733b4-9790-49fd-9585-25b137eeebf4@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <849733b4-9790-49fd-9585-25b137eeebf4@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNCBTYWx0ZWRfXzdb5ekjlHtA+
 T/SX6VS5tcFVEJcVCQN4QSYVpHfYYYxF4yIV5pwM4zCTT4IhgxTHJkk7vA+WyrFqJW8i2mSmiQN
 TI5BvT0fQFOCNhBCKdmkd5LBk8HTmAs=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af58119 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=5fGVUrPxiRUIrxGn3CQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: z9hv5HpD-UFL7syJAkkOXYNnfRXZk8ME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNCBTYWx0ZWRfX9mfuB6/S/6/u
 eeaJLukg0OGywnGGbot3UpzSsqEdz+pvKhUUF6d3TMkQgNMrImZUpNqPlUWGUnC6oLOT7FUYDhR
 REuSF4QJmOWlbH4xsdizo+KfiLqV+OCSnUvWTmU4dA0khUDqOyp8sVQGxcn7oWxFFKf6qQwDcBL
 hOd66m+u030Z0TNc35ELG+YrY6+3eneXQkSwcMz8yPf8Z5pMLI+Utj5JOebedvs3+8/ipfmRems
 IwIk48DLCVKT9+CRLhdcNlgW+qUs3pDVfwX+KT+jwXI3HsjsAy/LHHBZ1kzFHwev0nqFElKWaOE
 7lwjj5LDtYAc4P9lSToPEmctm6hc1+wet0PkWHpnytnPIOXnzNCbEBvhhOYJlZEKXM5uO0PHaOy
 kcAiAzuMAcHo6VZVRTgXJCFCh2pqLrX5FkwhvsgM3VE7pwir07Cze6Hs18DiTTqRxG84fgmoWZk
 kC59JHhRYjlewyjII3g==
X-Proofpoint-ORIG-GUID: Ickgr0zufNmHOt9gnv7CTtdSRmfwBLB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_010447_106877_F0D66B5F 
X-CRM114-Status: GOOD (  12.66  )
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

On 11/11/26 11:30 PM, Bart Van Assche wrote:
> On 11/10/26 11:25 PM, Nilay Shroff wrote:
>> Attached the complete patch for your reference. Even after making
>> this change, clang still complains about locking violation:
>>
>> drivers/nvme/target/nvmet.h:255:13: error: reading variable 'bdev' requires holding mutex 'ns->subsys->lock' [-Werror,-Wthread-safety-precise]
>>    255 |         return ns->bdev ? disk_to_dev(ns->bdev->bd_disk) : NULL;
>>        |                    ^
>> drivers/nvme/target/nvmet.h:255:13: note: found near match 'subsys->lock'
> 
> This can be solved by adding a lockdep_assert_held(&ms->bdev->bd_disk)
> statement, isn't it?
> I think there's a typo above. I assume you're suggesting adding
lockdep_assert_held(&ns->subsys->lock) here.

And yes, adding the lockdep assertion resolves the compilation error.
As I see now (frankly I was not aware about this earlier), lockdep
internally assumes the required capability, which allows Clang's context
analyzer to satisfy the corresponding lock annotation.

So as you suggested, for complex call paths involving multiple locks,
where the same lock may be accessed through different expressions, I'll
use the appropriate lockdep_assert_held() assertions instead of explicitly
adding __assume_ctx_lock() annotations as far as possible.

Thanks,
--Nilay

