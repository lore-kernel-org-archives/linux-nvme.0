Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60062C98332
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Sep 2026 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AEgB3UlOC/tslfPgqENzGfwe9QqlYXjoCo35jVy2sgI=; b=oPpSiOqfRHy9gO0Bm4DF8DQn12
	5zGn3OFvCP2bSdUfysxrcQtlbGEBFow79L1Slm2Ovt/UsMfSOgvTw6R2/dtxm4nTKydK6TRFrl/Vn
	wZUdpA/QNzsoGbh7qLbpLx6aOCR5ehy5tDrWuDddGTIiZ1ZdMMHUSFpD8l+zCNXBPuSxDVXQXEbc9
	Cq8zdT2SxY6ibQpSQFaoz4SIaIxVqV62PmZJPNxlVsX+sCXTFiA5+8T+2fplgqxXcgzTy+oCczTTX
	EcfvfX2b4MeriDYuInXxJICLA2LlsYeXuoWvwzcvNOyVRzS/iYQVYbr4lurNJiSpBMRqJmDfGeZtM
	fugPiNaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAQ3X-0000000FHOR-3IxB;
	Sat, 26 Sep 2026 10:54:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAQ3U-0000000FHO4-3aFS
	for linux-nvme@lists.infradead.org;
	Sat, 26 Sep 2026 10:54:58 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q6ZhjE2030873;
	Sat, 26 Sep 2026 10:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AEgB3U
	lOC/tslfPgqENzGfwe9QqlYXjoCo35jVy2sgI=; b=VdwMCHkiAUjbN/mYPUH/fb
	Vt105qv5LeZkNQ5Z7HAwMtz47Edwxyjhdh6Geqrgt1F0DgnOJqcI8oZNUxVrzBqb
	dnYu3J+fBecRRKH/r8URB5TRQ4TAs0PHh51RGABNAb+cCuPtObiyojivbEpHTxox
	UTke5yclE558maofxPHFY1NuTOx4Ob9U4a2zlBHWLCwEY7w/OZIiGQ/SIfhwO7HY
	Yrr5m4gk6dckzD2tSu0u2n+ntBZ1dtDs2yGnuXPfBdQvnKDeCXtAxn5JAO7pN7mh
	u0tDDNa+irJ/svatnnrY9B7WJ3zmC75jUH5DEX9xwDZb0zFqX71RXjx3RdZM6z2A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fds92q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 10:54:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68QAltpe4062481;
	Sat, 26 Sep 2026 10:54:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ej8s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 10:54:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68QAslxF8847886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 10:54:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C2B858072;
	Sat, 26 Sep 2026 10:54:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9C245806D;
	Sat, 26 Sep 2026 10:54:40 +0000 (GMT)
Received: from [9.61.92.150] (unknown [9.61.92.150])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 26 Sep 2026 10:54:40 +0000 (GMT)
Message-ID: <4159f3a5-4cd8-4518-85aa-c82b68ed359c@linux.ibm.com>
Date: Sat, 26 Sep 2026 16:24:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, Jens Axboe <axboe@kernel.dk>,
        john.g.garry@oracle.com, wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com> <20260902133104.GA20945@lst.de>
 <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com>
 <20260902141347.GA24385@lst.de>
 <61165430-a724-40d3-a00d-2cbe1ea656b0@linux.ibm.com>
 <57629796-d346-4cc4-8c9c-b153a60e1709@linux.ibm.com>
 <fe4e7f28-14ec-4b8f-81f8-d230569cbdad@linux.ibm.com>
 <20260925073835.GA5608@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260925073835.GA5608@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6ab7a479 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=4mc-twsBqLh3BKEv8vwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA0MiBTYWx0ZWRfXy6iNT+CcBXVO
 au51AaW+0fZ+C3Ej08SvcvOGY+ybtqixBhSEhGSwcCjlaUxmBBxlrwbHpGf8VurWIUc48fm9I/k
 80+YFFaHb1vz4nDGoYvNoTdMW8ps5MM=
X-Proofpoint-ORIG-GUID: 3qIbV91ccFDOCKnZJTlscyXwTieVauRU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA0MiBTYWx0ZWRfX+AbMADomrKSh
 WbwIFM9TQliKV/ODBL8uzdZZ2xwL1rT2leeRq/ojiRLMRyKwf+fxL6t8Lj1OMHgZ/2/hv9unNWv
 roM2cjdLZZB+qn0xhs1GXyJfaY69x0+EU1N1+Jmvt7Xs7ySngyrpAsq996xSs3xFgnPYiBQkL5i
 Q2V4Er63qCkjAVh6/Iye6NSq2tlCsNEOTrtqrzn6r1yj8cZl0Z4g4HhSvU+QM7csVRuwSMr3/Rh
 my0b/AKoUs3uRnRZOs7jlCtzbBD+n/Z0dQapXLLTqR/NgLlSlZn/GhQFw56N/w2ZEdBWSKRwpwn
 M2ZpeIgXW2FIT9vVsVzYT7FawteslqgG/NUsjZKG+cAsJw6s9nGsopyO9leBvtxncVx1DS2cQJg
 BOv09PPjY1drfcQP2UsZix1RdZEm8gajHvyWY38vDuJHgFGKGay8PnJ+mHQBe9cIPyga+Bcor+t
 a//u0gFqSVNVYdKc2gA==
X-Proofpoint-GUID: 3qIbV91ccFDOCKnZJTlscyXwTieVauRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609260042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_035457_025814_0C78F212 
X-CRM114-Status: GOOD (  20.58  )
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

On 9/25/26 1:08 PM, Christoph Hellwig wrote:
> On Tue, Sep 22, 2026 at 09:03:38PM +0530, Nilay Shroff wrote:
>> Hi Christoph, Keith
>>
>> A gent ping on this one...
>> Do you have any further comment/feedback on this one?
> 
> I still don't think this is a good idea.  Removing the transport is
> valid, and allows to create a valid condition (multipath gendisk without
> paths).

Yes, I agree that a zero-path multipath gendisk is a valid state, and
I think the proposed change does not alter that semantics. With the proposed
change, we only take a reference on the underlying transport module while
the multipath head has active openers. Once the last opener/user goes away, the
transport module reference is dropped, so the transport can still be unloaded
when there are no users of the multipath gendisk. Does that address your
concern, or do you think we should also allow unloading the underlying
transport module while the multipath gendisk has active openers?

The case I'm trying to protect is specifically when the multipath head
is backing the root filesystem. If the intention is that the transport
should be unloadable even with active openers on the multipath gendisk,
perhaps we could make transport module pinning an opt-in nvme-core policy,
enabled through a module parameter (e.g. nvme_core.pin_transport), and
take the transport module reference only when that parameter is enabled.
The parameter would be disabled by default, so this would preserve the
valid zero-path/open-head case and would not generally pin transport
modules merely because the multipath head has active openers.

Any thoughts/suggestions?

Thanks,
--Nilay

