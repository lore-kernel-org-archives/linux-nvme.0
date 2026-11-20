Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A4606A32A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ljNGjBuN;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HU93IixX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lMdTdRqfvzib1zVo6+3pnL3GPVGap3xZRxtPf0KXKSM=; b=ljNGjBuN246FnI
	QbFN8E2MYEA/HClsTX4UgJ1KdJKWcbnJRpbLhAV005t297PDNZjjzVW/3N6z/UhtNHRo9A7aoXyER
	HV+/177/sNZbuPmH1KEXNKnVETSBWZv8Jt/joGYrxJX4VNkR+J81XrC2aAm0ST5D/tF+rOt6cvMzq
	rgkA4GI1a2ak/cvih7xMfL/h33a2MJn9ESyiwZIyqDCUgSbAf9/QW39xjor1Fixc1kprANpn1Nctn
	YI/BipkFH1nMNqDm8WHGCQKyR99RBeoJ1rO4m7OQwf5T5SskpTX0dGpzlUJ1dZB2kVMiFKUbUhUWV
	Mw6ZzZkepGD+x38X3srA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSNs-0000000FgoY-0Oiu;
	Fri, 20 Nov 2026 17:26:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSNi-0000000Fgmn-1jL0
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:26:39 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEuruH3424197;
	Fri, 20 Nov 2026 17:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lMdTdR
	qfvzib1zVo6+3pnL3GPVGap3xZRxtPf0KXKSM=; b=HU93IixX0i0Qy2koUd+OHa
	VzxosoKhfGNboZz2ZVuMivb0YbYxsq5OC0sfvKAzf93z3+zaNJzqLxLBHWWctIlX
	W6jr0LD64WTM/e5iagvIVK2CzdwNXyos1MmGtdcQhY4DocshUUe+N7gBEW6gMvxb
	wUQnbKVHUhX2/6mWwCJO6HMR5FykcFIFf56jDf0mZXAV2tdYVr7L2+TRPB+Ts3o5
	A+FQL7ykmTkcAr+d6/Jtj4N6CX5uMZrIBXT59jlU9z3UHPnDjcV7K01fygV1+Yk2
	YngRtJLyui+oSNxGVuKDKL4NLNt+Vd4HJdi4JnoTsOnKqed7UY1HrgGdd1VOXqfA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w1s6t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 17:26:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEo2sV218769;
	Fri, 20 Nov 2026 17:26:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xhc8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 17:26:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKHPM9I17039918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 17:25:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2DF58043;
	Fri, 20 Nov 2026 17:26:13 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1C9B58059;
	Fri, 20 Nov 2026 17:26:10 +0000 (GMT)
Received: from [9.61.150.232] (unknown [9.61.150.232])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 17:26:10 +0000 (GMT)
Message-ID: <5c756c41-9db2-4c30-90f9-1e170621d552@linux.ibm.com>
Date: Fri, 20 Nov 2026 22:56:08 +0530
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
X-Proofpoint-GUID: TtLv4ki3Ad3NIuoYvcACAu7NYN-USPNR
X-Authority-Analysis: v=2.4 cv=HL9WhYtv c=1 sm=1 tr=0 ts=6b0082b7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=-owyJEA_ml2O4WxMYSgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9VEhH8eQn4SD6m6G7P3M6GSmWS6Xvk-y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OSBTYWx0ZWRfX4m1saNTtSFAf
 1SfCYSIKmKcbrb9TAw02tNev2lZYP3BNYBO0o6qPOwhQtGrEPxbteXq41Zcy3f57ks5wBWYMgr1
 EsYlo7E5SBQQRJzaA8E0t3wH/c0PJcLY7/moLmafzBzom6J3z6mMMhfoGrt//A1N0k2EXXqIpmE
 cIjvzlTT+Yq136hn1TDH3DncYjxBlTcmrqpEaZHwB0CPUBRFqunppzrJSLIjl0smBPD/IMpA6R4
 Q6O3RDGy3h16z5hUD+Dr1IWYXjODmVMVIFU0hCYiqoflFXFX4WiLKfTJN3HZ4qVHD1TMEtf3wJ0
 bi3t0I5IbNjr81lC3QfEmDHeBk6ilTP3f2zFiqxufLzTUB72ZdHGyjUDxPZHCUVK6szwJaSZTn/
 B5bnIt60R++UxMHTOeTHdfXrxXDtNXgVsFqerCD9FHQvyWxIGfuusraOohnhkjgNH3ojMVDz9XD
 n7TfOQLBSDmmOSQI4rA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OSBTYWx0ZWRfX3RpJuI/Vw5uR
 AfI+UTRpddKEzqUVk68bJpPQX/k9D1sZtTY9aFnds6DW5PFkgF2pL+Q5FDhVP+QWd+nHVRM/Kbv
 ItfoajaG59oHfDRccDB9NKv1mv9RDOg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_092638_622953_BAD0ACA5 
X-CRM114-Status: GOOD (  20.25  )
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

Hi Bart,

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

I spent some time evaluating whether we could model namespace references
using token context locks, but it looks like this approach does not fit
the namespace-reference lifetime particularly well.

A namespace reference is optional. It is acquired after a successful namespace
lookup and stored in req->ns. Later, nvmet_req_complete() drops the reference
only if req->ns is non-NULL. Clang's conditional context annotations cannot
express this ownership relationship directly. They can conditionally acquire
or release a context based on a function's return value. Consequently, modeling
this with token context locks would likely require splitting several existing
completion and error paths into separate variants depending on whether the
request holds a namespace reference.

Callback dispatch makes this even more complicated. req->execute is a common
callback used by I/O commands, Fabrics commands, and admin commands. I/O
handlers generally execute with a namespace reference held, whereas Fabrics
and many admin handlers do not require one. Annotating the req->execute
ccallback type as requiring the namespace-reference token would therefore
incorrectly impose that requirement on all command handlers. Leaving the
callback type unannotated, on the other hand, means Clang cannot propagate
the token requirement from the dispatcher to individual I/O handlers.

Splitting the callback mechanism solely to accommodate context annotations
would add considerable complexity to the existing design.

Given these constraints, I think it would be more practical to retain the
NVMET_NS_ACCESSOR() helpers marked with __context_unsafe() for accesses
protected by a live namespace reference. We can keep these helpers narrowly
scoped to the relevant namespace-field accesses and document the namespace-
reference requirement explicitly.

For control paths, we can continue using lock-based context annotations,
since nvmet_subsys::lock directly describes the synchronization protecting
those fields.

This approach does not provide the same level of static checking for I/O-path
accesses, but it avoids introducing substantial complexity into namespace-
reference handling and request dispatch.

Thanks,
--Nilay


