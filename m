Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D2606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k3w+zyQ6;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=td/HJjTP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3zJPB054CiLUL2Ns+dwFD2VtTzECPYeXsu1AF1dUZDk=; b=k3w+zyQ6mTWCC2
	565sIAYoQaYl1uwEj0sU+4dw0Kiwr+k25MgDxGk1GVTsCZSLccSAi2uF3VMNOevQZKrVq5CvlNbYu
	mJrPJyz4Z/9ejt9yNvlpnRE4FWtNoTu0dtoNF0oIL6C1L+JS5OnvbFEfm48mKUcwd5b6SycGbJ8/+
	o9+b5RVsOTcnmjp0uG4UaDjFCdBpbd25YGD3RYBXdBOjxdd+BVXJUd0anPssmFnQrmWcCyammB04w
	9Mffovyi/ppzVLJ7yfVj3cibR2ZoDbIzZaGow1vrfUiEWor70f5gG9EviBIZu9c1FZZImtHi42nTJ
	6lsbh4OkGQd4HwbakGfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPK6H-0000000CSHU-2gAL;
	Fri, 06 Nov 2026 13:35:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPK6E-0000000CSGu-472o
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:35:24 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AiFln2143227;
	Fri, 6 Nov 2026 13:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3zJPB0
	54CiLUL2Ns+dwFD2VtTzECPYeXsu1AF1dUZDk=; b=td/HJjTPVzYQnb+sQpC4AH
	EH+AHpzCXhaKadOZwELjFQLoxTtuZhFPQctgfrWdr4juHF6oJxeoTkUuo8CtyVHF
	8N+APQfGvmFZOTCAHUeXNucVDua6Qppqozu14zh+8XbFvdF2bAbi/xhm3t7n7rMy
	lkXTf8PJZmXn92ul6qvpmARFfM+EibRTTdtr3PMXG3OztYq283zG0rjh+Gqw0qhX
	rmJrbUP9OqkxSRDQF2hoZ0FpsqttbVyzZWL0+x4cIZeI+mAgdP+XmrMpOMNveXCw
	GaoJ75gMQDjfR6dN4cJYJ+pottCvMwdgeVgYDwx99Xu2pqXa11GhDou4GFCC19LA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r94e2x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:35:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYxfL3268955;
	Fri, 6 Nov 2026 13:35:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka716ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:35:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DZEjM14746320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:35:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A013758058;
	Fri,  6 Nov 2026 13:35:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BE965805D;
	Fri,  6 Nov 2026 13:35:11 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:35:11 +0000 (GMT)
Message-ID: <5fb62ca0-ab59-4d9f-bb4e-802ec1511c7e@linux.ibm.com>
Date: Fri, 6 Nov 2026 19:05:09 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] nvmet: use GFP_KERNEL for PR allocations
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-7-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106015842.3534898-7-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedd794 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=-4cg3vrcwXNZYRz7saYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: b0CRJJKBl5EsK_nm8yLXae5KqH3A7RfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX/FHVu3dZWUWh
 1AgB8JASeCiclpsu6rGQy5Oug2u1EN7rCQ12eppB9yeT+l/3Soio54XPn0dSa4xY6/ZIO94uSDx
 KjrX/elf3CqelRph6vAmb8bsUqNX+t1DLjDC8v/SLhaNkx04JmH1MQkEbsG4wkj7Y4dW2vUaCKu
 mCqwdzKC7PXhdJHmdp2a2IcBpFEjVBlZ3W/IJbR6irnF6SnK7zYVvzJrVMBoSW7c2q5i3ASgI+x
 DD04JOuknqyOt2B4DR0vrIaYj42dwu3htFDZzkWvTylkCS4SUp26Ar8wmlvpePgrBVsBZcD9Uo4
 Tj+M85BvJBI2MgzDJAnDGzwOS1dgAM9jgOAJa3ZqXSJim9ZzA5lzgzqJCZjpdzyMNWul/BpG3c0
 L4pus9XhDAyV8jcNBcHToPFsQcbrlDE3NRGqjC917CYPCCMD3Vgz9RPFMhuow4aUW8I5DSqMDsu
 d8TLsWnugTV//losBSQ==
X-Proofpoint-GUID: 5wRKnUyU3wWIWD0uvbeaeuUPd387-DKg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX2CvNLT6pM/Ju
 T97bp8aQgyzPzw5jpwadnSqjjmxV6C5Q2vrTa4sjshSDRkjSQFq78u5aGaIh1Oh59mwvKBJ9W0N
 gsxoSuOlRJ73HGqnXJ9bGKrsccLxCjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_053523_030749_B41401A1 
X-CRM114-Status: GOOD (  13.92  )
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 7:28 AM, Guixin Liu wrote:
> nvmet_pr_update_reg_attr() and nvmet_pr_alloc_and_insert_pc_ref()
> allocate with GFP_ATOMIC, but both run in sleepable context: the PR
> command handlers execute from the transport workqueues and take the
> pr_sem semaphore, and the pc_ref allocation is reached from the
> connect and configfs paths. The latter function even passes
> GFP_KERNEL to the percpu_ref_init() in the same scope, so the
> GFP_ATOMIC only raises the failure rate for no reason.
> 
> Switch both allocations to GFP_KERNEL.
> 
> Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


