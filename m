Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947D606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 09:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=g3N/nDro;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zq9G9+UG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1DKCTjP7BR+DFu8PVux5oix3/4/uV4ok7TA+K67TgHo=; b=g3N/nDrojRu91V
	Q9YW5IJ0u/zXqPZIvqHm5dHxXWcD/mKntOhHQZVqFqc4147TekMblOb7nUhKmQZtVt5FJPDJqIsUR
	CaeJ+krwOH1JXRhzwrtlVJJ59K5EdslvtcBwkcVVYXkmkrUHwJT3SU545OzhXDIKWxU5RVOjQ+FiF
	e7wUMhzAcldqLdwK9R8J0xueVzKKijcbkrd1m8GTPImNalLv66amrwREgiFJUbuW936rjg05dGoOM
	BYO5rJ8jR7z8QtD8c0TSGlAu16Ys9wbW7BVz+w9+8g2M8/CPragTQfokXwH1sWFiNQvV+IkRcf3fN
	ETN6VMRZwngu3wzl+juw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyA9-0000000BMFT-1ezk;
	Thu, 19 Nov 2026 09:10:37 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTyA7-0000000BMEu-1zJj
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 09:10:36 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uUvx1805513;
	Thu, 19 Nov 2026 09:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1DKCTj
	P7BR+DFu8PVux5oix3/4/uV4ok7TA+K67TgHo=; b=Zq9G9+UG9E2ukuizpBqnz/
	Bb1P4+7JvTsmVtKsUbt+HBtalucp0nuFms1ji95t6d2u9bs9VOIh79BcKD2MppLt
	NYUp9RmUwFf6Y1hJnRgBasB9zppPzqTpBOIRZquMsR8JXWHLcKhqenJMs64DEdg3
	FcfJIkQ0lTH2JXrnboQV5GV5g3SkBFN3tbaf+u+bx2pKUuPFNUTS+EbkG+yImBlS
	g3C0TRid3z86GI1biXd5znMlAQfBe4gXFU0Yknbvg7qSgyvBRiymEEhkyUE/Mnra
	XDqXAvc5upmg20Unq7AKuF+a3LUAZF0N5p+PMiNscgkWbHJWnQGHU4DXrPWL6q0w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rqujs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:10:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ756Oh2161156;
	Thu, 19 Nov 2026 09:10:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9x8mhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 09:10:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ9AG4Y41419348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 09:10:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E2B658056;
	Thu, 19 Nov 2026 09:10:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40FE458060;
	Thu, 19 Nov 2026 09:10:13 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Nov 2026 09:10:12 +0000 (GMT)
Message-ID: <8b46ce36-3add-4b2f-8a2f-455f6c70ec30@linux.ibm.com>
Date: Thu, 19 Nov 2026 14:40:11 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/22] nvmet: fix nvmet_ns::bdev access using
 nvmet_subsys::lock
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-3-nilay@linux.ibm.com>
 <da37a4fa-656f-440a-9ca7-50266619813e@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <da37a4fa-656f-440a-9ca7-50266619813e@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: dUy0T5tkxV2BVs9J031X8DsvLDDp38b2
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afebcfa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=WkRjoUyRONK5PHhhxewA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzNSBTYWx0ZWRfX4nc20QygQf72
 PrQySFgxilJyRKMdOVVOfkHDbett/cxxzY1EkGndm4xXDKdAgSrQqmg6ORDrcwqaqB1PtJzZUia
 BFxGCetXxJtV6mX64mF6goTTTeLEMZY=
X-Proofpoint-ORIG-GUID: WYFGNdmZG-PJMNYsSEHXTvs2OyPNvq-b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzNSBTYWx0ZWRfX0XnY0lbHLTq2
 vgNp/X4n296mR12r5GMmucu9jiqRcxld/mPY1sIn/4CvyfrEN5SiMk8WvmJA+7EYbDDJFsikbRh
 rjmspGkuIyRR+ZVl+F1oVNLZOjME/Cq2RyS+wp6YgIWe+zQXVWw0yW5D4XdObWVv0VlXz156BFf
 KaXOEHdIAl3bHW9vBmmZiqDTPDRRqjfZPhA1IMdbUh3+IbdJfN1CPzaC9Sp7zlyDisMkPz+xqvu
 I1lGQFX1g/8ymbSN1yzoSOZznmy9jXDAPo/NwUkCk60glN8B2u20guTzN8E3el7+rt4pyBh4xiR
 fD+OEMYBu/7JUBVGga5DNtVSFLHhmayuovJf5AwE028qSi6799AD3FNu7ly4IbQ+ieyz2Zwu0QH
 /dMnR7vAHx6zhsQ5Js628AVTJ/dJVYjb7hsrFdYvg/X4NnZprz4p2a3EKye5DnQmWLLXc4+T2eN
 9hQUGz5QEZZ/Pa5Ra6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190035
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_011035_516138_6E452DDC 
X-CRM114-Status: GOOD (  14.71  )
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

On 11/19/26 5:38 AM, Bart Van Assche wrote:
> On 11/17/26 11:34 PM, Nilay Shroff wrote:
>> +        /*
>> +         * Both ctrl->subsys->lock and ns->subsys->lock refer to the
>> +         * same lock. However there's no way for us to annotate such
>> +         * locking semantics using clang context annotation. So
>> +         * explicitly assert the capability.
>> +         */
>> +        __assume_ctx_lock(&ns->subsys->lock);
> 
> __assume_ctx_lock() should be avoided whenever possible. Please either
> modify this function such that "subsys" is passed as an argument or use
> lockdep_assert_held().
> 

Yes, okay. I need to extract the namespace iteration into a helper function
and pass subsys as an argument. This will allow to annotate the helper with
  __must_hold(&subsys->lock) and then use lockdep_assert_held() to establish
the context for accessing namespace fields, avoiding the explicit use of
  __assume_ctx_lock().

Thanks,
--Nilay

