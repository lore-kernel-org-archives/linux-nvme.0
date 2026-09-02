Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A84BC624D0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 04:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sLY6q+TPIJg/NWeZ12QMP+NrY9M0JxuIc/0tzu9PAA4=; b=jF23nj/UC0dpgVgpEFoJ6YvK1J
	UTNWd7xFNZnaoE7rsW6GpSG+d0WLHxpAcYu0veUPOe7uOmaZtw/jahVMvrV/JHokfv6gAsy6iFziO
	kOepwJNAEkwd41yMWAshaWBnmN8i5wZb3VLvyeHH1IpFwh1ACYycZbwJ6nhM7ajpTNOlCgS7AjJO5
	i+zVnZRMAAQJvkOuuntO20pq/CYl4Hy3fHlRWYQ+4mJesnPnzO7hCcbTBiGhWtzQUEkZBjSsxbE1m
	8acJNApXBZHWpsz4wzYnyd1kbgeCfassFyNxlabmpiNnjgllhgW0/8k3HV9y9Ah+L9chYM7PZs0JP
	WFSnu+UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1d1H-0000000Dmte-20rV;
	Wed, 02 Sep 2026 04:56:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1d14-0000000Dmrs-0Epo
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 04:56:17 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KWQRF354682;
	Wed, 2 Sep 2026 04:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sLY6q+
	TPIJg/NWeZ12QMP+NrY9M0JxuIc/0tzu9PAA4=; b=UXKrKLytc6+C4G3Nr7mCqq
	bp2ZRK1odwJWZLLk8sqzEGViXGyK46W8+INrHja+BAf+RdTFMWyGrtA21+aroLPF
	rYlusB0bGg/fgnb7CHBVi4JtUPDY14421+SC5XyjIcp8x0KJj7wlcsCZE7q0pAbf
	5g64ErDBybJw0CavMeoX9khH/30S7hWaaw0UYvrRDgZAQMQ6bqcOt8NEic3krkVa
	RU7H02BJGJeRiQzkucC4d1HTfyzZabYxFHK3bvYdLRWTkQCAIvek4GaudBX3Ri6v
	RXydfQohFtN9N8jQBvdvm2L0IADfEgDiaxzFv/wasKLGaYX1dYm1DeFi7dtSqO3A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rca4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 04:55:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6824feht005789;
	Wed, 2 Sep 2026 04:55:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark7sbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 04:55:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6824trDn52101470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 04:55:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 098995805D;
	Wed,  2 Sep 2026 04:55:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EDAC58057;
	Wed,  2 Sep 2026 04:55:50 +0000 (GMT)
Received: from [9.61.83.86] (unknown [9.61.83.86])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 04:55:49 +0000 (GMT)
Message-ID: <94c6ccbb-0b76-43e1-b3a2-ef2fcb485ca5@linux.ibm.com>
Date: Wed, 2 Sep 2026 10:25:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
        john.g.garry@oracle.com, wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com> <apb_3yu6G0dx_rWe@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <apb_3yu6G0dx_rWe@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a97ac5b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGKkRDS4hbavg4qZ3psA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOCBTYWx0ZWRfX2aBXm3dgyRxy
 bssQaRUzXwPwQUP6h/ALqH5MRWs7mQe9YGvORbc66ii6SxULb41rfEPIrr1hp9d1B9bOy1D9DwC
 Rj6LuRdfuGGKl/r53aKfUMzgLXmmPSJzn7ACpYMYfU6KJzZt2RZys4b62DnDqKf98qiKc/ibC9L
 gQdde9eWxpJMx3r2fhTUlOPifB90lU6StGowR8flkSRk3wVeLxjvusuPwhyDZljktSqafuPFbBg
 5IMXS764J8jAG6RJZ/6iUNUDjypzgViHUk9VqhpvOfSG2GT5we4bRbfxFQvTiO9d1E+QLDBZ92v
 t1kKfCNusnXviKBsgz1dz1ZFOoAxG1U4BIXu60dTfKAsvaAF64lokCTaGUw81Tx+N8FOjETvKIS
 yIp+Tt2SHNxwFhS5EJTSZrOYv0supdsXNW7kWvoC5BoaaRbM2GDqMh5rSKCrKCnJwl98vN9NEUN
 Kcp6LJvBvJH5ySR02OA==
X-Proofpoint-GUID: mJ5H6RYYSoP6u5PXemNkKI_3GDCXG5I1
X-Proofpoint-ORIG-GUID: mJ5H6RYYSoP6u5PXemNkKI_3GDCXG5I1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOCBTYWx0ZWRfX13X0HJqNWRXk
 wg5YLMZFENIVR+eAWf7fjOcFnaNIhfjp8H7KnnNRSMmnWUnVH8q7J+AJHcgkwW/2lCCFsiezjVd
 7NRXWmPAR6H5hWCpw4TMxvROhkzIFP8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_215607_624310_9A4C9E39 
X-CRM114-Status: GOOD (  18.64  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/1/26 10:09 PM, Keith Busch wrote:
> On Mon, Aug 31, 2026 at 08:49:54PM +0530, Nilay Shroff wrote:
>> +static inline int nvme_module_get(struct nvme_ns *ns, unsigned int count)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		if (!try_module_get(ns->ctrl->ops->module))
>> +			goto out_unwind;
>> +	}
>> +
>> +	return 0;
>> +out_unwind:
>> +	while (i--)
>> +		module_put(ns->ctrl->ops->module);
>> +	return -ENXIO;
>> +}
>> +
>> +static inline void nvme_module_put(struct nvme_ns *ns, unsigned int count)
>> +{
>> +	while (count--)
>> +		module_put(ns->ctrl->ops->module);
>> +}
> 
> Thanks, looks correct to me.
> 
> I don't like the looping though. This could be done in a single
> atomic_sub instead of multiple atomic_dec calls if the module api
> provided something to get/put many references.

Yeah I though of the same however unfortunately module APIs don't
provide something using which we could atomically get/put more than
one references.

Thanks,
--Nilay

