Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD47C43602
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RvxggTR14kYI/LBXmxIZU4DT50I7BgpPfAWv9biA3TM=; b=aRWWNJMa6HXP3lSmpWF0TX/BnU
	HSo3T6GxV89KYVk+l2tBKDR3xeXkfsOL+y/+NWIVr9nnmUbYjryhlvopsLYid7MShNuSB7deST/X6
	eBqceSDN7MOAqE4h7GQ7HT4tjy45rLKlC9pmV0uf/9TTUV/WCpNOGWK6VcBwAtiwpeSWCh1qFuqQe
	5l6b7l/p41dkYjBbvmOVCG6L0EmhuCa17LmbV4ymsaB1YSFAxKk+5fn5ahGMDscuqYocZBo7Swrxx
	Mj36JEGVZKzo/xC8qo6AVxWJY21jWx7Tf6Tk0k07uRe0ZYpeUVnF076awXQcBpBlq7f/7M7Tx5YOy
	jPPk4mew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wepeQ-00000000wCw-02gK;
	Wed, 01 Jul 2026 07:46:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wepeH-00000000wBY-2dTD
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 07:46:22 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6613IHrY3867369;
	Wed, 1 Jul 2026 07:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RvxggT
	R14kYI/LBXmxIZU4DT50I7BgpPfAWv9biA3TM=; b=mqCaK6E1j4DJV1D4RdPvu7
	3NXe2gHenuh6zSdMaa5UNBR9E1I5uHAOUWO1ik15mccAc9Jd5T58n6q3Wic8719y
	MbiTkAzFHr9IYpawWP77udm+pWVcrqhGrPIJOdaB6smTZs9ESKWQ/HpYxH4N8eU9
	Vlrh3/8/BfKNjKtfdFskYgmQuCrhWI4Pzu/315BkAfp0BsaqON9TPGe5i/U+z77J
	x0icMNCY18wWGWdQ2XnpOvAE/+5np5lZIe4C/RzIiHdzMigRjGe/0k5stYkRLQCt
	y/UK7DAq5B6BzAxTt+Aktsj8shFxTFIizr3JhwrjZmitdBGjTwWjnk/rkx7hO3mg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5u7ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 07:46:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6617Ji8p006303;
	Wed, 1 Jul 2026 07:46:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk68jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 07:46:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6617k2lf25887292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 07:46:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8901B5804B;
	Wed,  1 Jul 2026 07:46:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 245DD58068;
	Wed,  1 Jul 2026 07:45:59 +0000 (GMT)
Received: from [9.43.78.19] (unknown [9.43.78.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 07:45:58 +0000 (GMT)
Message-ID: <e6cbe529-8529-4927-8e16-637fb8d9012d@linux.ibm.com>
Date: Wed, 1 Jul 2026 13:15:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 12/17] nvme: add Clang context annotations for
 nvme_queue::cq_poll_lock
To: Marco Elver <elver@google.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-13-nilay@linux.ibm.com>
 <20260626064816.GB11106@lst.de>
 <b9961ab6-897d-4a93-8e43-8b23eb439fc5@linux.ibm.com>
 <20260629125010.GB23695@lst.de>
 <5eb42ac4-9fda-48ec-ad65-c895c81d7608@linux.ibm.com>
 <CANpmjNMnaxfoT6C5rC_Q8NaEuVANN0-imbYKZ6LNA004_uuMxg@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANpmjNMnaxfoT6C5rC_Q8NaEuVANN0-imbYKZ6LNA004_uuMxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NCBTYWx0ZWRfX8RprF5Nb9W+G
 ILW9D9Fu/wLyLMaMS1cpPiM6rxc3h+4oEQb4ok86jE7VpYpWW74+cl46OXovGmaI2Tv++l+b/RC
 xlDvoKajzbntvY9RFIge+Fgo2sum/NdoBa1LEWZq0tyzNjlhDSynUF4A3Itaw6LhHjDrlO68W8E
 V9GIECZMb6cwlvcCXoUsAVazfyaTw4mGcknFce7DVo/HxZzpG26TINQFUYnFYI3IVvs1g+WoIdS
 NW6rtUkAkqbIi86/n+uJDSzGTgsy72LQhbJSl5cdMXr1bxTw2Rx0zwbd3nPXyEBqIZlI39XgnGr
 C3wrbFjqvX7ZzSK0MqQoGKUqGyoiXDcWqOcwZbi4i7Jm5l3p9XJ+FDoZ0lvFstJyP5eXoNjq3jc
 LKMGDkU+Bge0Xa+U8d+VQMO4a2dpRiPpgegPyWYr4YCxtNP9rltjUpDaGa3Gz3vzDvG727yhnyi
 ztTJAn+eka+5NUA7hPA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a44c5bc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=bC-a23v3AAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=f_3kpL7QzgRnMEoAwwoA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: qTvB5DvE2pQN13LtZJjKFMfTig4wKpci
X-Proofpoint-GUID: 9aDTWY44R1Fpjf4VBblCRvKqQdTNUo8a
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NCBTYWx0ZWRfXwPKgA4uChce+
 EtPFaDSx6M0jVMst+V0/ZvNWFkI/ELqS6HJwY/iWlRmQBytuCkLAP/rYLco3GJuVSYBZr+2cp0e
 dKoffbUB67l+FvP8B/gFz6S0a3Fu7vs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_004621_693671_7BC87DB4 
X-CRM114-Status: GOOD (  29.65  )
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

On 6/30/26 4:26 PM, Marco Elver wrote:
> On Tue, 30 Jun 2026 at 11:26, Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>> On 6/29/26 6:20 PM, Christoph Hellwig wrote:
>>> On Fri, Jun 26, 2026 at 08:52:36PM +0530, Nilay Shroff wrote:
>>>>
>>>> That's because nvme_poll() and nvme_irq() both reuse nvme_poll_cq() to
>>>> process completions, but they rely on different synchronization mechanisms.
>>>
>>> Well, we could split the function easily, but it still uses the same
>>> data structure and thus annotations.
>>>
>> I see your point. The annotations describe only the polling synchronization model,
>> while the same state is also accessed under interrupt serialization for IRQ queues.
>> Since __guarded_by() cannot express alternative synchronization mechanisms today,
>> the annotations end up requiring __context_unsafe() for the IRQ path.
>>
>> It sounds like your preference would be to leave these fields unannotated rather
>> than partially annotate one synchronization model. Is that the direction you'd
>> recommend until the annotation infrastructure can express multiple valid
>> synchronization schemes?
>>
>>
>> Marco,
>> I know it's not currently supported, but are there any plan to extend the current
>> capability model to support multiple valid synchronization mechanisms for a single
>> object? For example, allowing a guarded field to be protected by either a lock or
>> another abstract capability (such as interrupt serialization), instead of requiring
>> a single __guarded_by() relationship." For instance,
>>
>> __guarded_by_any(&cq_poll_lock, IRQ_CONTEXT)
>>
>> Then irq handler would be annotated with __capability(irq_serialization).
> 
> I had planned to support IRQ context locks, which would be abstract
> but not be backed by a real object (similar to how RCU is handled).
> Just haven't gotten around to it.
> 
>> So now the compiler would know if the code executes in the interrupt/irq context
>> then access to the guarded variable doesn't require any lock otherwise it needs
>> ->cq_poll_lock when accessed. I don't know how easy it'd be to add such support
>> but it may be explored.
> 
> Multi-arg __guarded_by() is supported by Clang, but perhaps not
> exactly the way you imagined above. This has a brief summary:
> https://patch.msgid.link/20260515124426.2227783-1-elver@google.com
> 
> In short, you can hold any lock to get reader access, and must hold
> all for writer access.

That's interesting, and I can see how that would be useful. However, I don't think
it quite addresses this particular use case.
Here we're not choosing between multiple locks protecting the same object. Instead,
the synchronization mechanism depends on the execution context: the polling path
protects the completion queue with ->cq_poll_lock, whereas the IRQ path relies on
interrupt serialization and deliberately does not acquire ->cq_poll_lock.

So the requirement is effectively "hold ->cq_poll_lock or execute in the IRQ
serialization context and thus avoid holding any lock". Unless I'm misunderstanding,
I don't think multi-argument __guarded_by() can express that today.

Thanks,
--Nilay


