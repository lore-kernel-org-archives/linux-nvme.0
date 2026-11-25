Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD859606A333
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SiSDVlXr;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BGzrVUYE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QUhu/mMsgG6wlJsRePbuNwIJkm7YBuN48lXA9GY6i6A=; b=SiSDVlXr65ropV
	nxObRUUITcS4nORO0MKEUWp9LCBJu+WuuZOLo0oA5HtSyYIAjFqJN5tXmuPfkbvulCZimoGAX9485
	kBXJMpByg52mWeYB3NrTKNfyYRZL4yxe2rC+n2xW5w8cf3qcrfn8yvyLZvWaSpJ289db7iHm0JlCW
	PvX/fwKQj1sTd2ThlebMC6w+O4rXF2eajbic/qQopW/usq9ZTLJ3GXgBY8mi4hMX2mWR8nMsRYw6K
	2YSenpjGJ7oLCO1xKrF3ROYwUqWVNYRGJP182FGLgpcb74e7Oz/hM9stisDdrRyRI4PIeqmsjquG3
	NFO9VAGIHQJduktHjeqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9b4-00000009MSI-2L6N;
	Wed, 25 Nov 2026 09:47:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xW9b0-00000009MRu-1kdh
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 09:47:25 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP6YdYE3109648;
	Wed, 25 Nov 2026 09:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QUhu/m
	MsgG6wlJsRePbuNwIJkm7YBuN48lXA9GY6i6A=; b=BGzrVUYExWlQ/65ZZvwCOZ
	4UU9GCVYyXXDUQGP2QfK7wQTRhJvshIVWZoocAfKApPwiBNKltAFJj7+6wB2D8Er
	C+nxOElmdH9T+fgV2RaKZch4JdZdfuGLQDWD2FBDSODbA8rvcM1SlY0tDkITSGX+
	nlZUVKqXZpUj6D+v11zU6nk/yJbBUT3sMZP8kK1/zEz8YCNrPvkDOQg1gkhe/u1c
	hzLHEWfJVG0VH2fQhfXNgE/jVsUrb246B7YtS21/SIShyEELSmVch9IdLl1fuGB7
	Yrr+TNALw5rr1+8GC+jQlXJ5vLVjK+w5yJu/keDdhxEzr0OnXAUCyaTwMhFnldUg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3bs5j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:47:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP6JLkV3429557;
	Wed, 25 Nov 2026 09:47:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa1n1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 09:47:06 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AP9l5P96488626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 09:47:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80F425805A;
	Wed, 25 Nov 2026 09:47:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E3405805E;
	Wed, 25 Nov 2026 09:47:03 +0000 (GMT)
Received: from [9.61.9.230] (unknown [9.61.9.230])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 09:47:03 +0000 (GMT)
Message-ID: <9c4eda4b-ea64-4aaa-a4c7-9673e0dbabd6@linux.ibm.com>
Date: Wed, 25 Nov 2026 15:17:02 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: delete the ANATT timer after draining
 ana_work
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261124121349.1861269-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261124121349.1861269-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b06ae9b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=pOLyZNzHtnR6B4T_pVsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX5KIn4WRusgTe
 XAs0pGnvto2WBQFp4CfAuLZ2xzj+hALWxlgtmB3t1BZMTuDpAIaGnhfySZrjezqILrpvHfXVlK+
 56Mdi41B22rmDVN6lA/Agdn4HU6XNdY=
X-Proofpoint-ORIG-GUID: XUY8X0HFPCxOCea913WGXSL5AwpmRVAe
X-Proofpoint-GUID: i9R4X1147_vy5HUyaSKiAKXmcJdN3kEl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzOCBTYWx0ZWRfX6i+1Q/UUcSr9
 IlNIcgF71D+PmO9ZBKVZgTdHtiVZxvQpTXfiZsFftf4MJj9agwKsHTHoTHLu+ltCcng1+87A6N+
 R0iWYR3Txo1MT6KLW6AypKSBmH8KMlkTIR+GrDoo36yJDC/s0e+FymxLVNycl08bynuj58SU/8w
 x8Q6D1GHMe6oly/8DgkciQk+zpSFy6DW4PMgx9fgP/84AZHZv42AeA0y9W5TUbaGOZdrySzcH5t
 HQ9wvSd2LCN0GzEn0mOG0ud8vrAev4ijl4PieIwfAZcTqacAy4WsjKpSa4IxLrpzd41wjLWaxrB
 vza0uN33Vp9l8qfGYwYekT/Tl89+NRb8jxJOmqHKCLJy3jZb/2MDAxTNaVL1Br683yTFqkOG4zy
 kSMWJvAfszW2mpvl/5gMlqQNnmq+PvxvARK82z7DSXJ7DWyuY1V79j/yz/uGxQxOBaFeJnL41Pt
 WQPWB4d8Zi78EOMlxBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_014722_617368_C5532E86 
X-CRM114-Status: GOOD (  15.27  )
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

On 11/24/26 5:43 PM, Guixin Liu wrote:
> nvme_mpath_stop() deletes the ANATT timer before cancelling ana_work.
> An ana_work that is already past its controller state check can still
> read the ANA log and arm the timer after the timer was deleted. The
> controller is then freed with the timer armed, and nvme_anatt_timeout()
> dereferences the freed controller when it fires.
> 
> Cancel ana_work before deleting the timer so it cannot be armed again.
> Also delete the timer in nvme_mpath_uninit() after draining ana_work:
> commit 9b657c565984 ("nvme: stop asynchronous event work before ANA
> teardown") added the work drain there because ana_work has multiple
> producers and nvme_mpath_stop() is skipped once ana_log_buf is NULL.
> The timer needs the same treatment before the ANA resources are freed.
> 
> Fixes: 0d0b660f214d ("nvme: add ANA support")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

