Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E5606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lIK6PSSZ;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ecLMmd9Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=GSYRZZkpTJPm/OWyb3hRBoE6D53eUGuSdvqYoEsvVL8=; b=lIK6PSSZ4mwMpp
	OGaqLbU0BOx5gdJXpOjcmiXgdx/bwq/Yc3cEua+Kyk49URCqXKVPKby4iLl1CME3ovAIc7zMY0qQ4
	jFCtkZ22vFkOQz+Q66S4OAJgG57lpYLrp7WHUbze6VC+UFb20mKoj8uUTYwSBTprpj2vOX9Figplf
	7FStGRZ4bXzgpOhc3CugOqp0zp9fQnC40HYa7oh7TNi9E2CHbGbs8qtapkrNnAb2ERWRAiF1vqaXi
	HctsKtXw6dEv3qeDZ1atOdevM/rhz/vtDrwHJx415ucjFeCwccO5pRc/IgbD6XB10Bs/WNSgBgCLJ
	zIFy1HZZrOic4Uf7c0+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU30e-0000000CCuI-2pkb;
	Thu, 19 Nov 2026 14:21:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU30c-0000000CCtc-1rH4
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 14:21:07 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBu7184105232;
	Thu, 19 Nov 2026 14:20:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GSYRZZ
	kpTJPm/OWyb3hRBoE6D53eUGuSdvqYoEsvVL8=; b=ecLMmd9ZqV547WGyCcoU9h
	zsCryNgkSJ7qOOK9ztb+63uwJcm+BIXZRKYKM4acAhQi2AYWZzx/NHV2P9Ve/fMk
	UtPavtuwncCLMvB5093HFiMKvlPuL4NZM3bHGxoiS73IPc6iymvuDs/lW3DoYS02
	r2mtaP8he8yhs50ofoi8/tABvbIFevUqBjrU1EoMvTBoK1XyJcgefx6Ia76tm/0e
	PTNEC/1mLo2ss1khVWzlzzhNx3qo6kdTZ8hmKPgoGSe33xqa+48CuD286xImAnu3
	+I9Ik4RXsje4tInAHETsAm9xISPjA9kPpo451VRf9lQsnfWByVEudeC9ynvqj7mA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vseem-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 14:20:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJBo55H520426;
	Thu, 19 Nov 2026 14:20:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3hv72q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 14:20:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJEKs8717892092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 14:20:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AE455805A;
	Thu, 19 Nov 2026 14:20:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEFEE5803F;
	Thu, 19 Nov 2026 14:20:51 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 14:20:51 +0000 (GMT)
Message-ID: <6790a3d2-52a8-4baa-95aa-a04073d25e4a@linux.ibm.com>
Date: Thu, 19 Nov 2026 19:50:50 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] nvmet: add context annotation for nvmet_ns::bdev
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-2-nilay@linux.ibm.com>
 <23016086-7d09-4a42-94d4-3270caee36e8@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <23016086-7d09-4a42-94d4-3270caee36e8@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: o20nNqIGE0_XUNLUcnk0KMQxlxHIoe8s
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6aff05c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-owyJEA_ml2O4WxMYSgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: cLxS2xhmSGTLfPqcttchpVha5kdVayve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA1NSBTYWx0ZWRfX1fTRxCg6YHt1
 /17bUsZ+5gY6JFsbWgNbfFAoiSw4k2ERebqsbZa/cZ73xXlHw9iZl8ZquufP8/7Jo6cBeP4tUEv
 //wYPHXxF9ielI74c58vP9bQIpvrWjBxjU/puZzOdlWNhQEnqlyIZRDZ78qOaqwNv+X6ENecw/M
 nKZF3ZMBQLRCZvh3qbJeHjOx8BWJtJ/mffIee3RxhsXyCinIe4HYOntPMGml7FF7tczfNRLz6VV
 N/h+UdAdcypK6oSti0DdZbBeHgqeHL8WNbUz9x7eQVsE5Z1Zoijb54E+XqGM7doEjVJzUeURMna
 +Qyx3mKa8A1QcZC1RThjrzor9pQXhAXCafOmejB1OsbJNk8TBB0JAYFmd++3WMK3SH68U0xaZkA
 Uf7cWSf5yHJU0G+/oYCeZ+JdesVvkcSTR23gu904ObdC4eHBE627aNbIY/8vHdwVdauGfTH0qV+
 nVGwb/wg8dLTM6pzKEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA1NSBTYWx0ZWRfX7ksCTTfG6ngF
 Mqj0kNiIWivqhW274+3TJ6ViaRrtY3egobd833odXpOTQPMoNcIqe+zYp0FjL/osl7ewMkVVIH4
 iCXHA+QnbF4y9GayjoCc346ZEeGn64k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_062106_609145_F0962073 
X-CRM114-Status: GOOD (  20.87  )
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

On 11/19/26 5:36 AM, Bart Van Assche wrote:
> On 11/17/26 11:34 PM, Nilay Shroff wrote:
>> Some accesses to nvmet_ns::bdev in the I/O hotpath do not require
>> holding nvmet_subsys::lock, as the namespace reference guarantees that
>> the namespace remains valid and the field is not modified while I/O is
>> in flight. However, the clang context analyzer cannot express this
>> access pattern directly. So introduce nvmet_ns_bdev() as an inline
>> helper annotated with __context_unsafe() to allow these accesses
>> without requiring the subsystem lock. Convert the relevant accesses in
>> the I/O hotpath and other request-processing paths to use this helper.
> 
> This is not what __context_unsafe() is intended for. Has it been
> considered to introduce a token context lock and to annotate the
> functions called with either the namespace reference held or with the
> nvmet_subsys::lock held?
> 
I haven't considered using a token context lock so far, but token context
lock looks interesting and plausible. I'll explore this approach further.
At a high level, I think we would need something along these lines:

/* Declare the context lock */
token_context_lock(nvmet_ns_ref);

/* Annotate fields with this lock */
struct nvmet_ns {
         ...
         struct block_device *bdev
                 __guarded_by(&subsys->lock, nvmet_ns_ref);
         ...
};

The namespace lookup and release functions could then be annotated as follows:

u16 nvmet_req_find_ns(struct nvmet_req *req)
         __cond_acquires_shared(0, nvmet_ns_ref);

void nvmet_ns_put(struct nvmet_ns *ns)
         __releases_shared(nvmet_ns_ref);

These annotations would allow the I/O hotpath to access namespace fields while
holding a namespace reference, without requiring nvmet_subsys::lock.

For the control path, which updates namespace fields while holding
nvmet_subsys::lock, we could introduce wrappers along these lines:


static inline void nvmet_subsys_lock(struct nvmet_subsys *subsys)
         __acquires(nvmet_ns_ref)
{
         mutex_lock(&subsys->lock);
         __acquire(nvmet_ns_ref);
}

static inline void nvmet_subsys_unlock(struct nvmet_subsys *subsys)
         __releases(nvmet_ns_ref)
{
         __release(nvmet_ns_ref);
         mutex_unlock(&subsys->lock);
}

If we can successfully model the namespace reference-counting semantics using token
context locks, that would be a nice improvement. It would also allow us to get rid
of the NVMET_NS_ACCESSOR() macro, which currently expands into helpers marked with
__context_unsafe().

I'll first experiment with modeling the namespace reference-counting logic using
token context locks. If that works out, I'll respin the series accordingly.

>> Also pass subsys as an explicit argument to nvmet_p2pmem_ns_add_p2p()
>> and nvmet_setup_p2p_ns_map(). This allows their __must_hold()
>> annotations and lockdep assertions to reference subsys->lock directly,
>> rather than accessing the same lock through ctrl->subsys->lock.
> 
> How many changes does this patch include? Should this patch perhaps be
> split?
> Yes in the next revision, I'll split the changes.

Thanks,
--Nilay


