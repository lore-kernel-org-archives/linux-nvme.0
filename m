Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D5606A329
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=VEU0zIrR;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A/yNAbom
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=u0iVuP4IzyITbE7c8alQYiCPEmyDXIrEmyWTumAA+D8=; b=VEU0zIrRR3pcby
	aFBKzwKpvDh5ivNOqmarlJpPkVXqyOoHWk3FZdUwUOtITPM7bFVUOOpTlv9nSFHTPu1QmRwhPdLUA
	zetDVJnz7/fJuxg2JfDfXRjhg05UfCVKs4dNtJ+7Th5sDld9viVo4Y7brRQms0S2om5NGi7sAidsO
	f/+hzL7ayx8RWT9sEKAUtjVIEpyNwU8LmMMPc/XD9Q2mSWl4xPPocdXZAt4aSkAWhL3EJVTzK7sGP
	Uv3LitB3BNx8v9gx4DuGrqm03eJQEeJMSSyNoMQMTDZ3tu16O3gHvfVLgIaBxryKmWWl0SONV4d91
	/Jus1PyKmTlxH07GWwcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJoM-0000000CP4f-1XXr;
	Fri, 06 Nov 2026 13:16:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJoK-0000000CP4B-28Hd
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:16:53 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AitlI2370671;
	Fri, 6 Nov 2026 13:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u0iVuP
	4IzyITbE7c8alQYiCPEmyDXIrEmyWTumAA+D8=; b=A/yNAbomXPtQlMpCpxvJsd
	ZW/eruy/4e1jXTgp0iaiiFjddfw/YG3KKLm7qS6Y7Jmvxs5T8VELUyMww6uGaRYV
	KYwqpd3uRqHRz43XOiAkWFhWz9+o4UkkEwM7+becvs9CdPxl+SkISdqIJALlBbtD
	SxPozogtb4pEwPrK6pigBQmzd/YMBHpkL3EpXMrjdlKn9Hv61d266iYFGd17ALhu
	XJDIaXpGkL4wvr7JooE8hBM73uVa77abKw5zl9mpW1pPDavdfZsyWqD4K0dA4Fpq
	xfMbtEylOHvJt7/kyvo3qStzrAuu9UJy/s850VEI7BgP8B7ry7vKddw8pKCh9YrA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rccbgr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:16:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYwj42071091;
	Fri, 6 Nov 2026 13:16:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h12vxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:16:45 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DGjqC12845758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:16:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7D5258059;
	Fri,  6 Nov 2026 13:16:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AFDD58058;
	Fri,  6 Nov 2026 13:16:39 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:16:38 +0000 (GMT)
Message-ID: <40fa9638-60a2-454c-86bd-e31615b9a404@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:46:37 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] nvme-auth: remove dead entry field in
 nvme_dhchap_queue_context
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-4-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-4-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: oaNboEmn4VR7PNjIIASdSWqzSq_Fmqzq
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aedd33e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=r763B9aCUq5-LjGBhlwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LzOQ0x-x8td75ZoKONtyIyIkRQULYpkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX7Jw8MjpL6zbL
 +kFzXMXVuVF/+B8vztTDO3lvlE00fKwtIz9rVfXXbGVNH3SzL4egaYxiIAo/l2xOUjAAaPOJetG
 7C6y56A5xtRsJA/T87jaiRBfdbDy1cPIPFV1QNQidmuukblRZHSs9uFQ4QwQzmwdGSoxbtr4Gk6
 ugCMAbRjg55oL+yzH44aDg6qiv1usEGzvBpoz49uTORcmMv+mWottyg6GBYcdGMGvOdB7mzlHBx
 9WtiVXCbrT5DMpmYH4sFzNcuMGTCfTic542tRWCB2YdBke+2Pp3tU/NXJRU68013+L88TvyKnzU
 FUckoVUppFs2YqW4KONuay7ziXPy2r+IFfdP3g/t7l5JYnOs6/q4NcI/7Q9UiTbzDKGovw1Pm01
 RhdecI+xdy+18I+z5jbs4T1VYqZWU3SfzYXRj7n2Jw2NhAKVO7jB/xxr6FL5n5CqBcQ4N/tw5OB
 GyK1XYtw17eK3NejpIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfXzIEqvEg3MIyF
 1lbbdJhkELFBH/n5B0nsISS50HpFiLoSJ7bko034+nrQBwpOgYP3zdkZOKJuGZDueOKFUQWY8rR
 RdrfN8P9In3GugSQbfhPZQcRJTEag4U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_051652_575019_FA5B5F5C 
X-CRM114-Status: GOOD (  10.86  )
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

On 11/6/26 7:57 AM, Guixin Liu wrote:
> The entry list_head of struct nvme_dhchap_queue_context has never been
> used since it was introduced in commit f50fff73d620c ("nvme: implement
> In-Band authentication"). Drop it.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


