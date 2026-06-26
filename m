Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DFFC43327
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SA0TImprX+59HKNwV9tPBfPSw40s9XpCg8thS6KvUn0=; b=u/BrxIufhSeF6cyrz9Xj5wmWIa
	iKHYyGxqSCf+KqV9G417zsm7nZxx8Qey97OdluPhBW5akYVOjn22MIE9FPcn+rMJPm2IVWEuPHneJ
	c4gpJwzJZm2C2ohU6PTC3dgBHQP6okzbB+w9o9+IjVsNnvfrdcSmC0M1+sjYnni8fctTOb04HpZQr
	SzKTZ1ZJXGYXyu9e3Zi89bSCmTpDFaXve8lYRQlj1R7bSWOPDvJqNex83rB9+i8Tljx3IBertnurL
	/0vy5OQ68oAg/97dtdUd1k8bIxCN16402WPdBc3e4fZ3yqKeDpJc+6AWJ2Lr9R5oWYcVHPp1nLEqz
	8APZNRrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8ON-0000000BXvG-31sY;
	Fri, 26 Jun 2026 15:22:55 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8OK-0000000BXup-3gqT
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 15:22:54 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QFISLl3296836;
	Fri, 26 Jun 2026 15:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SA0TIm
	prX+59HKNwV9tPBfPSw40s9XpCg8thS6KvUn0=; b=DdBkoC+UN+3LaqLZ89PPeX
	FNZKkMwKHmdOjw4DQX80NWYxAX/DU+jcOBv+Vb2+9TmeEHNnl8deh0HAmfwbXM9U
	dsQk3SpXGHBKMiz5pZ7yah0ILzVfD2UYqkHS4/VnjJHxjw1hXWtBRN+gmalkCKtC
	WnRuJcRSxE5afaRROcgZ67bfszSmXZofGgrJNfLxyKCcZA0+CkqTdagcIRRaJtmC
	nPt8SWGGc+LRTT6bLTF42/YcJo/Qy9eV1j9w5+En1a+UOJk6eaTgkVT3eK8+oMuN
	eMRGW0RVGjHHU44Kr9qP8cfswGF/BeVIe7uaV3jonZZ1hCrqsSgHb3lViDXcy+XA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gya7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:22:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QFJha9023964;
	Fri, 26 Jun 2026 15:22:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phum66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:22:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QFMfdD29622968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 15:22:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3148A58059;
	Fri, 26 Jun 2026 15:22:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCE2258057;
	Fri, 26 Jun 2026 15:22:37 +0000 (GMT)
Received: from [9.43.54.234] (unknown [9.43.54.234])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 15:22:37 +0000 (GMT)
Message-ID: <b9961ab6-897d-4a93-8e43-8b23eb439fc5@linux.ibm.com>
Date: Fri, 26 Jun 2026 20:52:36 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260626064816.GB11106@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _8hF37dVTEBZbYP8meX6vHzZhKKLcJSL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX0JMnuag6fNhZ
 KZTJjMDySTL8qBEzMD3q3YTZPMnaz8ZES7JmhB8etryvfKn5+2HV7TdeYnPWvwKq3rJ08pxYPKn
 hNuNEt7IayiS/NHUL1Ri1EWS8EuK5ew=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3e9943 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=a8lqAR5Pe7EFLvi9kZUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyNiBTYWx0ZWRfX27gDBJiQ7D6j
 oY7eD2yxTnfst/nq/S15Qu/B9vew12GYYQVzwXbF+bl5XC6jUXH7R/StU9nk4sbLAAF1gTRGSj7
 WjfaagRVJfvj5O6u5WXCyKztoyG9UqV4OgegRjnmbDAAxKCDt70yW0I1XHiJ3w+Ys/+/fnP7C9s
 fUkTnctwjObxKOooeP5J3NV+kN+H+pO5aq7PiTVNcwg2r4m77pRQ2Vy9kiB11eCzDEk6HLnjUfw
 GEoCDXcTFO8HMuPj1p19t6SSKCUuY4ne5beqwwd3o3f4jjxtljRnfzSkMfT/5rv6q6HtK17ympU
 hjr4deDPy0CH+a2FAbWe531CgQnirasnmL9IVMY6ASrC4FaiDPIH0l0WPLuCtW8ClBkOWLuG87t
 Vbh/A5U1mYUM0y0b7Mfstm7Yiwp5orygrGMxrfXdWCeAGUljJGYALC2bgpQGw7qrV7Zi1vHm/0m
 tpCSNsBsPRNRvT34HOQ==
X-Proofpoint-ORIG-GUID: KFf8_M2BftG09edOJQX4Lg1iLKmVbJ0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_082253_040720_182F9924 
X-CRM114-Status: GOOD (  17.97  )
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

On 6/26/26 12:18 PM, Christoph Hellwig wrote:
> On Sun, Jun 14, 2026 at 06:45:27PM +0530, Nilay Shroff wrote:
>> nvme_queue::cqes, nvme_queue::cq_head, and nvme_queue::cq_phase are
>> protected by nvme_queue::cq_poll_lock. Annotate these fields with
>> __guarded_by(&cq_poll_lock) and annotate helpers accessing them with
>> __must_hold(&cq_poll_lock) so that Clang's context analysis can
>> validate the locking requirements.
>>
>> IRQ-based queues do not use cq_poll_lock and instead rely on interrupt
>> serialization. Annotate nvme_irq() and nvme_irq_check() with
>> __context_unsafe() to suppress the corresponding context analysis
>> warnings.
>>
>> nvme_poll() invokes nvme_cqe_pending() as a lockless fast-path check
>> before acquiring cq_poll_lock. This check is intentionally kept outside
>> the lock because nvme_poll() may be called repeatedly in a tight polling
>> loop until completions are found. The result is only advisory, as the
>> completion queue is subsequently revalidated under cq_poll_lock by
>> nvme_poll_cq(). Suppress the corresponding context analysis warning by
>> annotating the lockless invocation of nvme_cqe_pending() with
>> context_unsafe().
> 
> I'm not sure the annotation really buys us anything in this form,
> as it makes bold claims about a guard and then ignores it for the
> most common case.
> 

That's because nvme_poll() and nvme_irq() both reuse nvme_poll_cq() to
process completions, but they rely on different synchronization mechanisms.

For the polling path, accesses to the completion queue are synchronized by
->cq_poll_lock, so it is still useful to annotate those accesses with
__must_hold(&cq_poll_lock) and let Clang verify that the polling path
acquires the lock correctly.

The IRQ path, on the other hand, relies on interrupt serialization rather
than ->cq_poll_lock, so those accesses are intentionally annotated with
context_unsafe() to suppress the corresponding warnings.

So, IMO, while the annotations don't apply to the IRQ path, they still provide
value by validating the locking requirements for the polling path, where
->cq_poll_lock is the intended synchronization primitive.

Thanks,
--Nilay


