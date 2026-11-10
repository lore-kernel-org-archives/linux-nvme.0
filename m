Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5650060A2624
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ebYkTcdY;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qob6JWa6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tgGd9Zvr6tXatp8la8d7DFm62wkOsR9dNnmcWRdrZ2g=; b=ebYkTcdY6p0yJQ
	H0UDqPXVwxq3xR1Vkgj9gL5o+89pMQwQZP36/+m3VG9ZPvzmvXkWjs7/RJV8co0EG1PbLbhxyUm7/
	rv15cpyUarcmjI+NkhDXFhCKr9Yb555AF8rMina0ssSd0YkIfTTQMzvOuRXD//5CW+PRCrKzjhuWb
	58X+B2vMfDDcqktMDPb8qAcEBvM5JhpwNb2qxweATeDfXVwWaNDppSQ0LtEZSGkqGqzW9x6Ic9IbA
	vnJBwnx7VaFX9NpHRG4w1BRZ5gy2/03UNW4Egsd63izX9vibz/uI281zm+NQW3qmLcBntg4JlmfeT
	B2fv5Jpsth6qVbfW2z9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhjp-00000003CDy-1MnU;
	Tue, 10 Nov 2026 09:01:57 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhjn-00000003CDF-16bP
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:01:56 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA8Ed3q602722;
	Tue, 10 Nov 2026 09:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tgGd9Z
	vr6tXatp8la8d7DFm62wkOsR9dNnmcWRdrZ2g=; b=Qob6JWa6S7NY+isjmt1DSG
	0oUEB/NUQaQ7uG7qvmEMR+YMfRo17eb3NO9ySwU/HVoYwGLBUnN23yXvxjcpttce
	EW2aXBT+7apcHUBZMsmB/rcot9rCQxbZh48l/ZgH4X4sUXekaAyuRfStEFsBDBXd
	W5fycbe4/p7SQaEdBuHmVU/RW5zcTQxSJ8XxlItSuI23nL3n7YmCOfbAGmZB3S6j
	0eTAVTLtzFiXDYRJ3AFcNVwugQTcdS1fcrRuvjOPwRxiyuEIO8dEZjL7OysEwXj8
	l/o+cGqcPR5bp7S3g8RfIy43KTBLASlU/SPJlLGeuSH4S7pnK0ym0O2JNsu/Jeaw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg3mfv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:01:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7nun71450616;
	Tue, 10 Nov 2026 09:01:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq63b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:01:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA91dDW66388324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 09:01:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67FBF58064;
	Tue, 10 Nov 2026 09:01:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A604358057;
	Tue, 10 Nov 2026 09:01:35 +0000 (GMT)
Received: from [9.61.143.141] (unknown [9.61.143.141])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 09:01:35 +0000 (GMT)
Message-ID: <f3ab5d9d-cdf9-4e9c-b0ad-167cc88fdfef@linux.ibm.com>
Date: Tue, 10 Nov 2026 14:31:34 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/23] nvmet: add context annotation for nvmet_ns::uuid
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-36-nilay@linux.ibm.com>
 <00124916-2b34-412b-afbb-04b91546478c@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <00124916-2b34-412b-afbb-04b91546478c@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af2dd75 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=zNAvlbQwGzlCaYCEwCAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNCBTYWx0ZWRfX3qIaIx5Z+7RA
 i7rsqWinK+nL39MmtrOlgjVJiy/V7gwoWZ07EaH7MNXphbgxLN90SY0j+iZp7HFWhmMlteYgVeQ
 MREz1MU1cvLbssXJkjzb/uA2GY8mkcXUEhuMtrI9ia2H23gsGr7QdqT2Ox9dhNVdWOQ9+ycJoXw
 yQG1Aru6GaBsqpvAfGM9lcXKDSTRwMAdvUbo0DEEM72bn/Cvp6NWABNALJ1eOIW+X3IYXXEkvji
 gHsbAG6mrO7SIi/IEC/CemFBQSeid5wFS6SrHbxHzWCHfDyyxkEMwTgRt0UyI6OYCdxlEM9wSd/
 R8Gj8ptGirXWYu65sHqxUoZikpXQFLf/+mEUEb0Wl44I3Kaj516WleizuwcJg5hawErKAuKnluh
 mDgnWzbEKtqX8o/zMTvinEUk9lJwmtuQK9kMgk9Iw9i/vPe5iPQhuyvNrRTqTq4kCIFIsi34mfj
 FvLBgqweReBJTuBBPrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNCBTYWx0ZWRfX/syP9WERS9pT
 PNC90cu4+A9GbJ10+aC4odjjZjFm43oqeBHSpKU95Jd8crxuoTkBrk57IohetR8X0f9I85qnK8K
 jEDjhUVq7NYJCQb3nhrn550CbVXM5Eg=
X-Proofpoint-GUID: bpmkRt_cKSrx8O5-zWYrIi1unAVuKoYC
X-Proofpoint-ORIG-GUID: cGcGXpfdy1DJ8Nfrt5yQ0ETnwIUdFg8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_010155_427656_38579654 
X-CRM114-Status: GOOD (  16.12  )
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

On 11/10/26 3:28 AM, Bart Van Assche wrote:
> On 11/8/26 7:28 PM, Nilay Shroff wrote:
>> [ ... ]
> 
> This patch breaks compilation in nvmet_ns_alloc() because uuid_gen(&ns->uuid)
> is called without holding subsys->lock. This is fixed only in patch 12.
> Please move patch 12 before patch 11 (or squash them).

The intention of this series is to first annotate a field in struct nvmet_ns
and then address any locking violations reported by the clang context analyzer
in a subsequent patch. I split the annotation and the corresponding locking
changes into separate patches to make the changes easier to review.

Also, since I haven't enabled CONTEXT_ANALYSIS:= y in the NVMe target Makefile yet,
enabling CONFIG_WARN_CONTEXT_ANALYSIS alone should not cause this compilation
failure.

> In nvmet_ns_device_uuid_show(), please use guard(mutex)(&ns->subsys->lock).
> Do you think using guard(...) is more appropriate then simple mutex_lock()
and mutex_unlock() APIs? I find using conventional mutex_lock()/mutex_unlcok()
APIs more readable and easy to reason about then using guard(...). That said,
if others as well prefer using guard() them I'm open to switch to it.

Thanks,
--Nilay

