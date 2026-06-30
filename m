Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3436AC43638
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0He9jXo245dNWMz6yHF6NDYJ1OV667Z+05olDQMvfiU=; b=RAw164UtvLv138XfTm8ltTxGGC
	VsWbcHaGJgEG/zo0MOVklIT9UcOmB7DEC0piFPo2v0b1wxHyI0hNSh4XZaWSV2nIgDrG3c/TDObw8
	9wG8xBlh5IGeaU1Q5uvT2RTWv0uU+Z8fhNvwoaogXNjCNXM+T/5YouzAugjnuwmqKWVkbeuKqaMTn
	+z84DdtmCRnOakWOSVSSeFsGRFYC794TXO+7CMYUNJjraGnywIVyTJf05kZbvTKGIeHpoWbpQlFxE
	iZ/pbyS/IqJb2bqqBYpzYzlC0ovqxRt2ooP3hgvXKp5SNgu49o2qANOtVGZelsAgNiD8WAJ42oOcB
	KE927Uow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weUkz-0000000GQZz-3wvl;
	Tue, 30 Jun 2026 09:27:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weUkJ-0000000GPxi-41N2
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 09:27:13 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U5mDp91191291;
	Tue, 30 Jun 2026 09:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0He9jX
	o245dNWMz6yHF6NDYJ1OV667Z+05olDQMvfiU=; b=pKyLH7V71VfLXFsKIEcfdo
	tYEK+VMeFePMXoz50//7Ch/wP3kZngx7cjlkA80rLMFqp6Msgc1TWigAv7IKunG/
	iVuF5AkwXla0l/caJV0y/z26147bZ8d6CMpPvY/VurZR9JqU+VUoh1IcmMtVohId
	ENNBd6BFWDiNE2qPzi8vmhE7eNE7TaOSCGv7tGI9WnJFqATh4n/P0HYHAmRXwFMS
	7k9ulC4vu2kHOAYcD3mdlke52CLjo4u/osub9vRl7PkW7ve/gV8fptnyv2ZxXozH
	SLYGiiSWaFOrQ9VvuetR36qur8va6mkCx2Tm67p7BRM6zUF3KBpGiMtaKPyctxAw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdwwqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:26:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U9Jfga020651;
	Tue, 30 Jun 2026 09:26:53 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhy96gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:26:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65U9QqbA23528174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 09:26:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3380358059;
	Tue, 30 Jun 2026 09:26:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B2CB58055;
	Tue, 30 Jun 2026 09:26:48 +0000 (GMT)
Received: from [9.43.78.19] (unknown [9.43.78.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 09:26:48 +0000 (GMT)
Message-ID: <5eb42ac4-9fda-48ec-ad65-c895c81d7608@linux.ibm.com>
Date: Tue, 30 Jun 2026 14:56:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 12/17] nvme: add Clang context annotations for
 nvme_queue::cq_poll_lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-13-nilay@linux.ibm.com>
 <20260626064816.GB11106@lst.de>
 <b9961ab6-897d-4a93-8e43-8b23eb439fc5@linux.ibm.com>
 <20260629125010.GB23695@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260629125010.GB23695@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: fm5u0NofYOShul3LRmZQEcesKNARFDKr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfXyGe28f2/9ilJ
 LIodJoKlV8qg5Byqqz9lJ4qyF72rcKgbyEPAZtLYJBRvrhDS7saIjQAgJ9HqkXC9lVn9nRsl2pa
 o3R1dI+TAkbZPu31Ne2rG2wk1LS604Q=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a438bde cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=vQ5SruvOIXU6FFzfEoIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4MyBTYWx0ZWRfXyTKKuNoo7KYp
 GH5yXzKaNJJo4TN0k0O3ilDxSAxYT6thDlnm2xIZatjPmJQ940u4C4lydM7EL9c0yoA1GGltnOX
 Xh33QPLqSnpswnYFHHaJ4Jndr6eXdht+DojfgFGp4dVLGBbI8Wj+CGdDpWQVoF6wKbU5+YQ1BjX
 KKnSyiyj2/kBRH4/M0aZEcjAJeMSEVGlsuufsY8GmApl3JlXrLBrwAHkFHyN8hLs/VvUdDvz9By
 UpYx9JSheKYDY+i8qfC/gi9gv7cS8RzMa3HCiAmP5IJyEsES+ASYRoTnL9imIssC+vM1RwQVnFs
 4fKBD+NV1aHJcQMLNJm5p54ozLwS0y1FEtgm9SYhprPo/WYAG3U1uwMZ1bE8da9w5B3HlG2Bm/A
 kLlwIuIjCuwYzVoGT2grxgYOVmHKDKbfaCHkQURFkC47j5mBlZyTSu0SpwoWiAPxsyUgWA5AqcS
 Dnfu9b2aR1UhSPUbzlA==
X-Proofpoint-ORIG-GUID: mHPfdRadV5XpHZ0h9MdrYu_gSQHAakeY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_022712_035005_49ACC52F 
X-CRM114-Status: GOOD (  19.16  )
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

On 6/29/26 6:20 PM, Christoph Hellwig wrote:
> On Fri, Jun 26, 2026 at 08:52:36PM +0530, Nilay Shroff wrote:
>>
>> That's because nvme_poll() and nvme_irq() both reuse nvme_poll_cq() to
>> process completions, but they rely on different synchronization mechanisms.
> 
> Well, we could split the function easily, but it still uses the same
> data structure and thus annotations.
> 
I see your point. The annotations describe only the polling synchronization model,
while the same state is also accessed under interrupt serialization for IRQ queues.
Since __guarded_by() cannot express alternative synchronization mechanisms today,
the annotations end up requiring __context_unsafe() for the IRQ path.

It sounds like your preference would be to leave these fields unannotated rather
than partially annotate one synchronization model. Is that the direction you'd
recommend until the annotation infrastructure can express multiple valid
synchronization schemes?


Marco,
I know it's not currently supported, but are there any plan to extend the current
capability model to support multiple valid synchronization mechanisms for a single
object? For example, allowing a guarded field to be protected by either a lock or
another abstract capability (such as interrupt serialization), instead of requiring
a single __guarded_by() relationship." For instance,

__guarded_by_any(&cq_poll_lock, IRQ_CONTEXT)

Then irq handler would be annotated with __capability(irq_serialization).

So now the compiler would know if the code executes in the interrupt/irq context
then access to the guarded variable doesn't require any lock otherwise it needs
->cq_poll_lock when accessed. I don't know how easy it'd be to add such support
but it may be explored.

Thanks,
--Nilay

