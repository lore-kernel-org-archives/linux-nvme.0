Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663B0FD8FF5
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 18:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXdh84RdPOoqDY3OSLaaWn1ZE39dlO9RMcXJyhvXBWI=; b=FoEJgKvuBkNNiCmYfxvzgekI1r
	wkb/EMgn+Z1GXrMEtNUEU33SrhhKcVpss5oENXwR3wXNBj3GMs4FHcKOaCKYiQpIGiDLXXcaYRCIz
	4PtL3+MG9bz0DQMoMwD7sgEIeMf9FletrtTyTNeYTMrSbJKurr3TbLp+hVnJKK2Js7QJ7EL/3Axkw
	ndGra3ksNPspMGB1Ya5sNbEeMMT6IFaWOxT06LT5MoHujmsZ1OTYt4NW/hbLMWEiylh0ioh7QUiZ9
	nw0HurvF04kuty9X7OrOJMxL7x2fFiglEGqhDUAaZIGaw5D3phHbOik0XvWabSuWcaYV7gecjHqZQ
	tK7lgeLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvg9Z-00000006y9q-1A6y;
	Thu, 26 Feb 2026 18:32:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvg9W-00000006y9L-363K
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 18:31:59 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QEZ2sA2870425;
	Thu, 26 Feb 2026 18:31:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xXdh84
	RdPOoqDY3OSLaaWn1ZE39dlO9RMcXJyhvXBWI=; b=kBJtdlEWipLZIld/CrWt3S
	m39HOPvlifIpuIUsrUoJLHMzEslXG/ww81LwhwVj/lKm55je9eGcic8vioCXtPRm
	pTqVGWm6jvozUQ+OQZJ95Yv6rbualHXSXZItLLcWgjbEENLIE+lkgl2ym44nk9WL
	Ri5nkpD92Wb7UCnBsVTFGZvTWNjn5U21tTFkjdudQJE1m5mC9vP9sulRwgpRstBD
	XSp0LJMnGOgwxgXvujgaSwzD6x7yx1lF1B6KaeeHNRBQS1PJMXSnT7CNV+l9roYr
	9Xzk1xEYUGfSoUAnMLF54PA4xD3Iw/QT+f3fR/QXu1Mw84IwZ48SUqDM7a/nS5DQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4bs7dwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 18:31:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61QGUxnH027776;
	Thu, 26 Feb 2026 18:31:54 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfsr253sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 18:31:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61QIVs7914877192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 18:31:54 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10B2058043;
	Thu, 26 Feb 2026 18:31:54 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5900F58053;
	Thu, 26 Feb 2026 18:31:51 +0000 (GMT)
Received: from [9.43.72.132] (unknown [9.43.72.132])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 18:31:50 +0000 (GMT)
Message-ID: <e79a3ed5-e2ae-49f3-919c-735a2ff33358@linux.ibm.com>
Date: Fri, 27 Feb 2026 00:01:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: fix unmatched id's under delayed path deletion
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
References: <20260225202109.447144-1-kbusch@meta.com>
 <20260225202109.447144-2-kbusch@meta.com> <20260226153740.GB31615@lst.de>
 <aaB6BJV3FvAVBuPq@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aaB6BJV3FvAVBuPq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oMl11jq-w5eWsI1SsmiUA7hs8DwgzAM7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE2NSBTYWx0ZWRfXx1baa/hJqOMr
 M4SjAnNVBX9HrqDs83F+BWQ1FwrCvxYOPR6LVdml9JdlIiHo+ac6Rw/PJNzlQxFZuJBGF+odCo/
 tCM2XuGCzPuSmzcIV6jiicjun7R+99xNEY1u7joFichZmIZEXTjj1vWpMDPoyQxVNRGSQc1YkyI
 t+pmZeji3BOeDPiGDepSNCMH89dxeVLMRqTOSbQna1HeynrGbkox/Z67ayv9/pslgJJKbkZQvIS
 F7YDpSxW2aOALL5fkpPR1Y9xGlTm+ufjrCMWdNq2aygx1bfQvMGUXPWkSbiZ3etnFhUSHzNUGxj
 2Z3y+HerFh9lFqvRz70ujoC0/NAf0d43s1sfYcuLOJDEMFe7RB4L+RZ/199eA2scH7pnOMxRj24
 Te1c7BzX+ierFjqWG2XhGeeEQ4+fgUornA4kzQq12a2d1kB9zZYI8av6O26eQZTRWcDfLsBYYTA
 ewMArtR2mCw0gEiiVkA==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=69a0919b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=ZS2Dj84VEUT51mOs_a4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: oMl11jq-w5eWsI1SsmiUA7hs8DwgzAM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_103158_893496_32967E95 
X-CRM114-Status: GOOD (  19.76  )
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



On 2/26/26 10:21 PM, Keith Busch wrote:
> On Thu, Feb 26, 2026 at 04:37:40PM +0100, Christoph Hellwig wrote:
>> I find the retry logic a bit odd and different from other places
>> do in similar areas.  What I'd expected is either a "nr_retries" or
>> "did_retry" variable initialized to 0/false, then checked here to
>> be not set (plus the IS_ENABLED() for multipath) and incremented/set
>> below.
>>
>> But independent of that, the actual logic looks fine.
> 
> I was able to test this, and it does work when we're specifically
> blocking on the delayed removal. But there's a different race this
> doesn't handle: controller A's scan_work may depend on controller B's
> scan_work to finish first to remove a final reference on the deleted
> namespace when A is trying to add a newly created namespace that
> recycled the NSID.
> 
> This is looking pretty tricky to resolve. The best solution I'm coming
> up with so far is to have the scan_work synthesize a
> NVME_AER_NOTICE_NS_CHANGED event for every controller in the subsystem,
> then re-kick their scan work if the scan_work removed anything.

So does your disk when reuse NSID, changes ns ids such as NGUID/UUID/EUI64?

Thanks,
--Nilay

