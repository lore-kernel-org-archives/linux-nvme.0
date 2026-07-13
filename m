Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFB4C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 05:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TW8VNnhfPRV14pn1GehuTQWqIZX3zXVF1sDBC/XYgTE=; b=PopKtCTLW9LvZb3zpsdJ3OrFjd
	U7TW1ntXIec92yEPIqyT6JTinlfrkXtCsdfr45pvaoq5kCkbSEP4ZSNcn80ueFtOAxORFI8QEHumb
	ZdDr1Ui56U3qod7EVwef1SR+qfe3uxQSSLu52HXGvGHSqd5pbFpkS6G3L9/Hu7g4RZY03bifRIx23
	/f36PjIFAotpSrBNc0HtlEiEEysSw0xUsOxwksjRR1rXPrsw018G9bxGPCKp9YwDFQHkINfECuFJE
	rEjIyInRr7Ls85PU6cZfrIOx55i92v3RilGcBCYD0tY6M7VVOKm+E+LmLVFg2b3TZrZFAp52m5gbA
	sIaFmZGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj932-00000008909-2rJh;
	Mon, 13 Jul 2026 05:17:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj92z-000000088zg-49PV
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 05:17:43 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3Crsp1314437;
	Mon, 13 Jul 2026 05:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TW8VNn
	hfPRV14pn1GehuTQWqIZX3zXVF1sDBC/XYgTE=; b=OAJYpRpv0v/UN/xQ923j7r
	glY+7/pRkuto0vF4uS5A4987DvbV4aM2DqwEWysH/tXjD76jLCxLIdUhXF9FLmfn
	xXahxLgC/r1CNnVojWwj0wA93lPdUM9YxxP2O3GcIPozpw6Zov4uvRAWGZpXGHFF
	+driBIXs0n2TCmJ4EW+sAoNiUEKfkvSQTW3gANCSMItHWUbFIih3TACvDTnnnQmH
	8wHOvXarQKrM94Vd8kv7v7C4m9HnioHD8MO6bm4aNkpVUwYRwoY/OqVQh5eIQN7L
	HJBpYKJ+WbVhGVbYhc5Pysgmr6uuOVtHCxZM1D9pJemOudDV5VTBGRyXeNCAcxog
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegsxtpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 05:17:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D54bl3012286;
	Mon, 13 Jul 2026 05:17:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxuv52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 05:17:21 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D5HKUB54198566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 05:17:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40325805C;
	Mon, 13 Jul 2026 05:17:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9805F5805B;
	Mon, 13 Jul 2026 05:17:17 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 05:17:17 +0000 (GMT)
Message-ID: <78b030be-878f-4c71-8288-66fc19d71512@linux.ibm.com>
Date: Mon, 13 Jul 2026 10:47:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/18] list: Permit context-unguarded access with
 list_empty_careful()
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
 <20260706141452.3008233-15-nilay@linux.ibm.com>
 <20260709063020.GC18056@lst.de>
 <1e72d8d2-ecfb-42c8-9ba4-97cf70f8b70b@linux.ibm.com>
 <CANpmjNMckikjJUdTT=ugs4pHMTOOQ+9mvSWZG31BGU3EFvRU1g@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANpmjNMckikjJUdTT=ugs4pHMTOOQ+9mvSWZG31BGU3EFvRU1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: fWMQPe69dFKHGfyOii4sfC7g1HqrZs1X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA1MSBTYWx0ZWRfXwV14/oWAwNe0
 v4v7q1xUDC66vASLFfQPOK+XfvonsVUqtZB0t9ahu7P3EkiOkGkW+gSVVtvtHxh4mORqiozQ3Za
 +cB5rtY1QtQqPw/ILbIZRaoEaorEN+0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA1MSBTYWx0ZWRfXwYrD6PahvUO9
 5E/HaRPsJdZP441ebT0oJB4ur3XpSq4klR2g+WsI2BPqnwXnY8wy8MtwIamr/D97MDha232am2a
 sXbklUPObSfuFuyzK3MoNNAmERa9ZGiPpjfJa983xSuiNUyKlXI8DZk7k9J/VNAMqgw+dMLhzhO
 eiuAXuInqJKee4rSc+wwPlo7+De363KKpWVoLwiyBxGXALq6T+AUjHZdTpomjpxPQ89K/8qdOlM
 Ud8zD7thFGZAUfh0Ncob+BkdWLGZDgYA3PtTd19lOCVNoCL6QYM6x7tSjTqzXKIWE4iAgoQ2Ebw
 Fp28P8Fsna/+oE2REMCSJd9F48EkHJd7EsUuoaGkP1tbsmRModdxVC0fT+6B93BhqVltPw6GkGf
 4yLIrIfJ1wN/6Ut+KAMimScEaSPYBAlHHLIwAE1+D7wRC7vD7NLW21ES8XFVoFXfwQTzkVcQ0Wx
 CD+/lhabQp2ZYLQwCYA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a5474e2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=1XWaLZrsAAAA:8 a=MeiAZp4Fa1qTV6vacYcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pQV957vY4xfbnxmUQT-cULwKMEcVN361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_221742_042375_6EF7CBB0 
X-CRM114-Status: GOOD (  26.68  )
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

On 7/12/26 3:29 AM, Marco Elver wrote:
> On Fri, 10 Jul 2026 at 10:10, Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>> Hi Marco,
>>
>> On 7/9/26 12:00 PM, Christoph Hellwig wrote:
>>> On Mon, Jul 06, 2026 at 07:44:16PM +0530, Nilay Shroff wrote:
>>>> From: Marco Elver <elver@google.com>
>>>>
>>>> With Context Analysis (viz. Clang's Thread Safety Analysis), list_heads
>>>> that are __guarded_by(..) require holding the appropriate context lock
>>>> when accessing and manipulating them via the list API. Because Clang's
>>>> warning diagnostics do not perform inter-procedural analysis, this is
>>>> enforced by Clang with -Wthread-safety-pointer in the caller at the call
>>>> boundary; a warning is produced when passing a pointer to a guarded
>>>> variable without holding the appropriate context locks:
>>>
>>> Same thing here, maybe try to get this to Linus late in the current
>>> window as it's trivial and makes dependency management much easier.
> 
> It's not a bug fix, more of a feature, so I don't think this should be
> sent in a post-rc1 PR (and Linus would likely reject it).
> 
>>> If that doesn't work, move it to the front of the series.
>>>
>> Would it be possible for you to send a pull request for Linus directly, or
>> would it need to go through another maintainer?
> 
> Needs another maintainer.
> 
>> If you're able to send it directly, we also have patch 09/18 in this
>> series that should go to Linus. In that case, I'd suggest including both
>> patches in the same pull request.
> 
> list has no de-facto maintainer, so anyone could take it. My guess is
> it could go through tip/locking/core since it's related to Context
> Analysis...
> 
> ... alas, this is more complex than it needs to be, esp. given it's
> borderline to get this merged post-rc1.
> 
>> Otherwise, as Christoph suggested, I'll move these patches to the
>> beginning of the series in the next revision.
> 
> I'd just move it to the beginning on the respin, given what I said above.
> 
Okay so then I'd move it at the beginning while I spin next revision.

Thanks,
--Nilay

