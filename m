Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F3606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 07:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZyWzYrHu;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UtJ0FR8P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5PgdFhNbn9b0o9svD2HeoyeXJznjk9CJVbL0rae6iFk=; b=ZyWzYrHuoOyaAc
	/lMCF8oo/8YhZo0O3fspMRVUQC12OsYGpJBHFN1w18whTiSw77DKDlclzE1Qa1cmT7PxhfqSKmrpA
	S6wy1QIaz8TO/+CSI6/mkAkCE3O5pFYuXTknZpuyzjr8qI7BiG9hDiBZ4o0iJHKottJ3HxKjR1yNP
	5ygaY2dxlUDj1zwkZiWM/WPfJVTRPydPLl5LhRAE5i3jfu1TRXDib7EAMqiUCbwxxU3p60Vcz34o/
	Qa/HOD9vdnbshMAkSZX7t8b48V1ci5ereHanCcIFJ8HEWadFj3m5onisa9zrpAyPdgxIgNp9U6zXn
	8cY0IkugmLJKnviof+wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTwBW-0000000B2Ia-3GGD;
	Thu, 19 Nov 2026 07:03:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTwBU-0000000B2IE-187o
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 07:03:53 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uVjV3436385;
	Thu, 19 Nov 2026 07:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5PgdFh
	Nbn9b0o9svD2HeoyeXJznjk9CJVbL0rae6iFk=; b=UtJ0FR8PReu9tlcHwMcqBj
	JSVD+dAb97liNthmTwmkCYLBPzG15JcNBYtPQORbdq0SD0VNncbDPoy01SFXxR4d
	EuEmPN71aiQv2Ko+cFihAveZYtR+SD/weCmsQg4+9kOOi5LA8gup+4zRFqdXfx1L
	5jsgn0WMOmjI/CjvdQvEWAfrv7FmKfB2pM1693JaBYbyXw9TgMFm7bwnuwBCFIVV
	ycV/BWbvHFw+GIviQyqbu/1ZZHoaqOXehvWivF1MmuS1iEDdJvW/RcdMCYGTofKu
	VbLlcYsP8NHHgEvD5WTgnnCGITyXyxJo1NeLSvocEvVc/07CBvqiTMeZWJNcMpqQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t769b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 07:03:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4o3xD3959866;
	Thu, 19 Nov 2026 07:03:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3ht4u0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 07:03:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ73Wjo32310006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 07:03:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9989D5805F;
	Thu, 19 Nov 2026 07:03:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A96A75805C;
	Thu, 19 Nov 2026 07:03:29 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 07:03:29 +0000 (GMT)
Message-ID: <6956e2fc-2548-48c4-b7ec-4dc3b58f243f@linux.ibm.com>
Date: Thu, 19 Nov 2026 12:33:28 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] nvmet: add context annotation for nvmet_ns::bdev
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-2-nilay@linux.ibm.com>
 <829201ae-e646-44ee-afc5-39f63117bfe6@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <829201ae-e646-44ee-afc5-39f63117bfe6@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afe9f47 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=0QZfkQ5KzHyPhc5h-g0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: d1usx6Rz8Qc1ra1EBZ-_KD6vuIx20Fph
X-Proofpoint-GUID: -kQMPf1mAxsxqDlnPfqF71lnL5-gh63T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNyBTYWx0ZWRfX4COHEmFSBk5Q
 t82XZBDto80B34oysmWNXzhr41NljyvGoo8ykcS7UJVubmzxeGRCMHpAbGwLVlpdUlRjibnNT7E
 9MN9ityuE4SuwI6DkOE4jYsA6V0t+Tp6h06ybD6OQxMY/GXU87/+MyzfNDoBSY9nhQ5880gzLy9
 VGpUK4P265o16GkVZTnNcL5f52I10hcsUoEQtetxlWDmArVjvZcFKA8xzMtCn8ABZlSyfl1ZKQe
 MfZ/y5hJrGwc2gmQgrwSN/316XvHEwbz8dc9M8maXHVZrh56XnR57LySSjLL7gIb4iKlr322mFw
 VVjWZ0AB3MtZCPKDpLGwmxRxk5R8juheLdXmebkohKa/x4aXvG2k5bV/cW9h7eY8mQGNznXwqB0
 28+nkjH7GKcTR7Qr/uk1ZJeoA0ylhPJfcpWqjZ7AnJ/K6zgyeWAB1IAvTjjkvd88fDFgkr/hvS2
 y0xwt+F471bPZ9yNRaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNyBTYWx0ZWRfX1UcnwKaWdNp1
 M3nPOd0o3GiV9XCg6qtcCp6MSEk0dj9arMkK6JwXWrTLV/n9/cmbr6s+Z1K8i8E+ccOu6cX6I+I
 d3HC4G3VYq62Rta4JiiPXmU5QZc3ZJI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_230352_316707_0ADA846F 
X-CRM114-Status: GOOD (  16.38  )
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

On 11/19/26 5:55 AM, Bart Van Assche wrote:
> On 11/17/26 11:34 PM, Nilay Shroff wrote:
>> +/*
>> + * The accessors generated by this macro are annotated with __context_unsafe()
>> + * because they are intended for use in I/O hotpaths and request-processing
>> + * paths where a namespace reference is held. These paths access namespace
>> + * fields that are guaranteed not to change while the reference is held and the
>> + * I/O or request processing is in progress.
>> + */
>> +#define NVMET_NS_ACCESSOR(_type, _name)                        \
>> +static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)            \
>> +    __context_unsafe(/* access _name after getting ns reference */)        \
>> +{                                        \
>> +    return ns->_name;                            \
>> +}
> 
> Lock context analysis enables thread-safety checking at compile time.
> The accessors defined by NVMET_NS_ACCESSOR() disable compile time
> thread-safety checks. So these accessors defeat the purpose of this
> patch series, isn't it?
> 
By design, the NVMe target I/O hotpaths access namespace parameters without holding
subsys->lock. Instead, they acquire a namespace reference before accessing these
parameters.

The namespace reference provides the required synchronization guarantee: namespace
parameters cannot be modified while outstanding namespace references exist. When a
namespace is disabled, the target first prevents new references from being acquired
and then waits for all outstanding references to drain before allowing namespace
parameters to be modified. This allows I/O hotpaths to safely access namespace
parameters without acquiring subsys->lock, avoiding the overhead of taking a mutex
in the I/O and request-processing paths.

On the other hand, control paths that access or modify namespace parameters must continue
to hold subsys->lock. The problem is that Clang's context annotations can express
lock-based access requirements, but cannot currently express the above reference-
counting-based synchronization guarantee. That's why I introduced the NVMET_NS_ACCESSOR()
macro. The accessors generated by this macro are marked with __context_unsafe() to
explicitly opt out of context checking for these particular accesses. They are intended
to be used only in I/O hotpaths and request-processing paths where a namespace reference
has already been acquired.

This does not eliminate context checking for namespace parameter accesses in general.
Control-path accesses are still subject to the __guarded_by(&subsys->lock) annotations
and must satisfy the corresponding locking requirements.

Thanks,
--Nilay


