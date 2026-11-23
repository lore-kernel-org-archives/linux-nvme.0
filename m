Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CFC606A334
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=vxEw03Gv;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mmEDF1op
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=H4v0EqxjNdlrRoxou2odVUpiWupmpL57Nn6UDzPQ3vk=; b=vxEw03GvSy5jA3
	3jJWmg/pv0I5F5uOGCBEOuqOVt37VjSjVHN9QyNEhQ/pQWHL6NX6LdPUth+S2IE+byHskihQ6FsGM
	IzvcGa0POgoD1XDsvCK5qtwVQ0YX3Qob7gr9F+fdmS9mR0ibTvA9Wn3kzqbE2OsFWgUk89fB/3K8/
	emb4ghTq9Lb0TtzAc4DBDOknqZ4yhs6XLKG/C55E2zefNwmZA7keidF7scr5VRbFlxOY5jnr0NNF3
	kvU591FaQu1I3/h9qH/M6/mDwwvwpAKjYSP77mDU8qJPkuZyImwpL34dJh0VNR0RcSQSxf1YwQ+dG
	hysEyTMw0nU83x4QcSNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPqb-00000002cLE-1T31;
	Mon, 23 Nov 2026 08:56:25 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVPpy-00000002cFV-0Kph
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 08:55:47 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54rhW1364742;
	Mon, 23 Nov 2026 08:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H4v0Eq
	xjNdlrRoxou2odVUpiWupmpL57Nn6UDzPQ3vk=; b=mmEDF1opB0N0wCYd9ghaaJ
	L9HOZkezinxFvb/v1CiJDwZOccMYUUsg5/HWanSgmSRZrp3EWGGCG6hLePuzaZpR
	sUA9V5d9juI/DImIsURQTLWP3fwzvSB/B6fh65r/4c4Ln8JnVjnUNP16hU71eKXO
	EHPbLDLnTMDmfVQryC10cq1TAZPWvbGitiHf7gO6KYjPZYqQPnuhhpmi4fn09PRk
	Xt9G3bUbTwx6u7lCRMB37Dfs5EAnGsP3zpz6D9C98Sf9NUtt8HDCY5SMjequNafD
	9hLToqSJ9AUDVa/+83sG7bUxMPBCCN7TEVk4+fmK24BIkpX5p+A+FbQbbV25lO/w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p49vrt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:55:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54Qat2817308;
	Mon, 23 Nov 2026 08:55:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjx1da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:55:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN8tLic33686034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 08:55:21 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D3FE5804E;
	Mon, 23 Nov 2026 08:55:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B70C58054;
	Mon, 23 Nov 2026 08:55:18 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 08:55:18 +0000 (GMT)
Message-ID: <acebc852-60f7-4479-b53d-139015d3f722@linux.ibm.com>
Date: Mon, 23 Nov 2026 14:25:16 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] nvmet: add context annotation for nvmet_ns::bdev
From: Nilay Shroff <nilay@linux.ibm.com>
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-2-nilay@linux.ibm.com>
 <23016086-7d09-4a42-94d4-3270caee36e8@acm.org>
 <5c756c41-9db2-4c30-90f9-1e170621d552@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5c756c41-9db2-4c30-90f9-1e170621d552@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXyw++YlqJkIHK
 EZ4vpdGF1OhaQbJ9nKDUeQOKntKqqRki8UP5oS0FC/heH/DgtHDniFmLeMzCQBuTPwwk7Dp0jry
 dLVDsXHKL/9OUu2eGfQO9S0EIlwK8Hk=
X-Proofpoint-GUID: 7bmHnq4TpY4WF8WmWS5vRdUxf_Lf4dRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfX7iUK3bpF76us
 /oBVVBHN6154PSBQkEyrLHYrW7ryJqQLfye27na2zDmYvoBWaZYm8h+MJryHJjfzjbiMOic17So
 PYp6ZQNUBZzNF+hx0IGgEUHB1iBRaPZ1gwVlTmsB7uASsgvVP4j6nR+M5ONvPmg+gu66siuCEsH
 2aeEchv1MiLdFFXMvB6LTraF3WxGzXLp73yOzjElm7PFIOldBQq/wupUmgi8jZ6P8RRusx7LFEU
 YoIZUyn3+DkWTYFiRAJKenmKiYYuQYDhZ+6GZ6ykpVvblsn1yukdmViIS00/CmOprPvLW61BRk9
 uegc+ljdr4vT2aivmUQ0wbtgE4WRGgH3faI2qSvZaW+S4WJDGA7tfg+X504AXhUnjlVRhjifnDB
 wCnHXrDJUTteqE+k111azGrHJlynWav0Rmfvm2Adphl4lTzVULjrbRHDq7iyuWSWMFg0hqMQ4Lt
 3s/ZJ8nZ0moQeDQ4BDA==
X-Proofpoint-ORIG-GUID: lrKddfzLGehaz55IXGonWIsBd4i_HnEw
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b03ff7a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=W7p65nDiWBuJEn2px7QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_005546_469549_B3015B54 
X-CRM114-Status: GOOD (  30.34  )
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

On 11/20/26 10:56 PM, Nilay Shroff wrote:
> Hi Bart,
> 
> On 11/19/26 5:36 AM, Bart Van Assche wrote:
>> On 11/17/26 11:34 PM, Nilay Shroff wrote:
>>> Some accesses to nvmet_ns::bdev in the I/O hotpath do not require
>>> holding nvmet_subsys::lock, as the namespace reference guarantees that
>>> the namespace remains valid and the field is not modified while I/O is
>>> in flight. However, the clang context analyzer cannot express this
>>> access pattern directly. So introduce nvmet_ns_bdev() as an inline
>>> helper annotated with __context_unsafe() to allow these accesses
>>> without requiring the subsystem lock. Convert the relevant accesses in
>>> the I/O hotpath and other request-processing paths to use this helper.
>>
>> This is not what __context_unsafe() is intended for. Has it been
>> considered to introduce a token context lock and to annotate the
>> functions called with either the namespace reference held or with the
>> nvmet_subsys::lock held?
>>
> 
> I spent some time evaluating whether we could model namespace references
> using token context locks, but it looks like this approach does not fit
> the namespace-reference lifetime particularly well.
> 
> A namespace reference is optional. It is acquired after a successful namespace
> lookup and stored in req->ns. Later, nvmet_req_complete() drops the reference
> only if req->ns is non-NULL. Clang's conditional context annotations cannot
> express this ownership relationship directly. They can conditionally acquire
> or release a context based on a function's return value. Consequently, modeling
> this with token context locks would likely require splitting several existing
> completion and error paths into separate variants depending on whether the
> request holds a namespace reference.
> 
> Callback dispatch makes this even more complicated. req->execute is a common
> callback used by I/O commands, Fabrics commands, and admin commands. I/O
> handlers generally execute with a namespace reference held, whereas Fabrics
> and many admin handlers do not require one. Annotating the req->execute
> ccallback type as requiring the namespace-reference token would therefore
> incorrectly impose that requirement on all command handlers. Leaving the
> callback type unannotated, on the other hand, means Clang cannot propagate
> the token requirement from the dispatcher to individual I/O handlers.
> 
> Splitting the callback mechanism solely to accommodate context annotations
> would add considerable complexity to the existing design.
> 
> Given these constraints, I think it would be more practical to retain the
> NVMET_NS_ACCESSOR() helpers marked with __context_unsafe() for accesses
> protected by a live namespace reference. We can keep these helpers narrowly
> scoped to the relevant namespace-field accesses and document the namespace-
> reference requirement explicitly.
> 
> For control paths, we can continue using lock-based context annotations,
> since nvmet_subsys::lock directly describes the synchronization protecting
> those fields.
> 
> This approach does not provide the same level of static checking for I/O-path
> accesses, but it avoids introducing substantial complexity into namespace-
> reference handling and request dispatch.
> 
After thinking about it for a while, I found a middle ground which shall
help getting rid of context_unsafe annotation around nvmet namespace
accessor macro while still using token context lock:

// Define token context lock modeling ns ref count
token_context_lock(nvmet_ns_ref);

Then, we guard ns field using both subsys->lock and nvmet_ns_ref.

struct nvmet_ns {
     ...
     struct block_device	*bdev
         __guarded_by(&subsys->lock, nvmet_ns_ref);
     ...
}

Then I'd define helpers which are just wrapper around subsys->lock.

static inline void nvmet_subsys_lock(struct nvmet_subsys *subsys)
	__acquires(&subsys->lock)
	__acquires(nvmet_ns_ref)
{
	mutex_lock(&subsys->lock);
	__acquire(nvmet_ns_ref);
}

static inline void nvmet_subsys_unlock(struct nvmet_subsys *subsys)
	__releases(nvmet_ns_ref)
	__releases(&subsys->lock)
{
	__release(nvmet_ns_ref);
	mutex_unlock(&subsys->lock);
}

These wrappers model holding subsys->lock as also holding the exclusive
nvmet_ns_ref context. This allows the control path to satisfy both
context requirements when updating ns->bdev.

For I/O-path accesses, I would retain the accessor macro, but instead of
__context_unsafe() assume an explicit shared-context assumption and also
add a lokcdep assertion for runtime validation:

#define NVMET_NS_ACCESSOR(_type, _name)					    \
static inline _type nvmet_ns_##_name(struct nvmet_req *req)		    \
{									    \
	lockdep_assert(req->ns != NULL);				    \
	__assume_shared_ctx_lock(nvmet_ns_ref);				    \
	return req->ns->_name;						    \
}

With this arrangement, Clang's context analyzer would enforce the following:

1. Reading ns->bdev requires holding at least one of subsys->lock or nvmet_ns_ref.
    I/O-path accesses would go through nvmet_ns_bdev(), which assumes the shared
    namespace-reference context.

2. Updating ns->bdev requires holding both subsys->lock and nvmet_ns_ref. The
    subsystem lock wrappers provide both capabilities to the control path.

3. Direct/plain accesses to ns->bdev outside the accessor would still be checked
    by Clang. An access without either capability would result in a compilation
    warning. This would alert the user about requirement of accessing ns->bdev
    only after acquiring subsys->lock or nvmet_ns_ref token context lock or access
    ns->bdev after acquiring namespace reference (if called from the I/O hotpath).

And at runtime (when lockdep is enabled), the accessor checks that req->ns is
non-NULL. This relies on the fact that req->ns is populated only after successfully
acquiring a namespace reference and remains valid until request completion.

The main advantage is that we retain static checking for direct accesses to ns->bdev,
while confining the context assumption to a small accessor used by the I/O path.

This also avoids having to propagate the namespace-reference token through the
common req->execute callback and deal with the different reference-ownership
requirements of I/O, Fabrics and admin commands.

I think this could provide a reasonable compromise between static checking and the
existing nvmet request-lifetime design. Any thoughts?

Thanks,
--Nilay


