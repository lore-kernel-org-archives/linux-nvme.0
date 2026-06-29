Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CE3C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 06:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fX6ABhDQXdHF33llVyVwLKlqOFgL14l6CVWMx+m9NZM=; b=ljB/9nd9McImXrBJRNC8uMVqie
	YPCfqBoEV2FSLtBKGnAB92Nwu+EztsrQ/1DO2vNTIFMZv5S07Zv/NPAt0cCjxfz1Lco1t446vIwO+
	wNujkljQMBAvwXVjxHPC0/LzLnIWcf5q6m/ivAUTrowkTUgiFyE3JTVzAc5LgAriPBQN+ooo3DNrJ
	F5nbbZfAz4FJMtel8XLYLPqTYQ231dAwzACsFC5SwAUb7bZSSMVi+gkmj3Ki/fGs9XrcXN3SAWKG4
	Iup/LC5/9BzP9RRVFEsqJmrbK7GWkTPH9I7qdhBU8AloVXmcOsEl728MOMxgDFp7u4YB1rEX9VI0y
	g3xzsudg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we56W-0000000Djk0-2KtH;
	Mon, 29 Jun 2026 06:04:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we56T-0000000Djjd-2Kuk
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 06:04:22 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T3IILw2098811;
	Mon, 29 Jun 2026 06:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fX6ABh
	DQXdHF33llVyVwLKlqOFgL14l6CVWMx+m9NZM=; b=VwgAnPZrF8hAFJnMZYBhNL
	NUluLR8IfaQoCDNlhb0aaLFxUUSVIGF1dw9V2o9Iw27yALo0NvDo/i6gWwEnE67A
	1N39v45AuQ7nBF15GuFIvcazaHGhBn6nybWoWxjBOpEQ/7mGBLBel7/F9fa361f3
	DfY6JolwExq7WfOgJJ/bwCr7YWxYWWrQNXXjlDfC6z/SQ0s9oKDdV9A6s+PzLmlW
	U8PfmBjOCkYPN+bwtoTRXFcNtoTbjmhyqMA5oQwLhAVjfJn5lqqDQAoxWcOigfd/
	qfjcg8E7xRpIQec7NxdJ06vRKjgP/Q/VfhdCIVfz2TL5sQVWRfrRIAApXKnssw6w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pdqrrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:04:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65T5nhha023345;
	Mon, 29 Jun 2026 06:04:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g3w4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 06:04:08 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65T647bc49676744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 06:04:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C1B058059;
	Mon, 29 Jun 2026 06:04:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DBE658063;
	Mon, 29 Jun 2026 06:04:03 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 06:04:03 +0000 (GMT)
Message-ID: <86244af7-268b-45f3-a8a1-e94ae1923ca9@linux.ibm.com>
Date: Mon, 29 Jun 2026 11:34:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for
 nvme_ns_head::current_path
To: Marco Elver <elver@google.com>, paulmck@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de>
 <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
 <CANpmjNPPF3TYx6qPzLO-DbQE6qvL_g6r3jYnGCk3aqeiQnnL5g@mail.gmail.com>
 <41a4cb5a-077c-499f-b060-2a4263303350@paulmck-laptop>
 <CANpmjNPAYsiQ=eiZ=0g579j1uO+-23ZXAhRA7M3uM-B8NdHg1g@mail.gmail.com>
 <62bbec8e-6eb5-4024-acba-6be1e7f33080@paulmck-laptop>
 <CANpmjNOJ6HnkjsGR-7pn=3uy1nOOgFGC-FXVd4idbF-KrHqaNg@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANpmjNOJ6HnkjsGR-7pn=3uy1nOOgFGC-FXVd4idbF-KrHqaNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 22JtMsD6j39KfnoqKoP6cHzufmuOWnqr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfX7bgb91GGQryo
 EIJrQCTVmt3/Yy3gqa17TSempWCJGH2yu0AfwV0CVvqd+xCm4ACNRYeP2ipDvqi5bAxJ3fMaEpE
 wlC1OoTmWg+roeazO0HOnfEKcvZNma0=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a420ad9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=6P4JVspCszbSNExKLKAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NyBTYWx0ZWRfX+UxsxIBKSQI7
 hu8gz82J+Wr4Jp2lMkdzovE6OTJo4xqgGNqCe9K1F/2qz2JNnUmMbQnBWnrmQC+c1RfaH4UBR70
 5b7fB+szcOKdLZVE6Y/dZWRp5G2Oo9Uo1dGU+CDX9miRNcIKX0jlAARpNNt67KVJaUZpNpfE7RP
 Ei/xnbXMnj/t5uDgrk1htLFC+ydTRJ2JHGS2rnifH5I3o4NdbgiaIVrLwOS31KMZE9n2cJ9HPiu
 +lLSU4KaTd+dJqpKHwim9Z6sMzGC30q6A4d6XbuknzO2piQpmywJTgmxS/DgYZP/j6NbsGaA2Kd
 PkOJIylry0X12h1ZJ7tcR6rqN2S4A5A+4FknwSFCcRWK1u2Yl5srOXAvwAoYEkFWv/Zwb4ORFLe
 zE8YCqPSrKoroaj+pWoHHxWInIC7dKOWA3P8HfGv1TSvIFhHzzZSmDOMEw4dyvttUyY9sVkKPW/
 BDru047r3CXoC2F9fIg==
X-Proofpoint-ORIG-GUID: tTsSgPbcE_ubEQbp56dd6syL7Grf86nk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260628_230421_635771_1648E519 
X-CRM114-Status: GOOD (  26.57  )
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

On 6/29/26 11:30 AM, Marco Elver wrote:
> On Sun, 28 Jun 2026 at 18:07, Paul E. McKenney <paulmck@kernel.org> wrote:
>>
>> On Sun, Jun 28, 2026 at 08:00:00AM +0200, Marco Elver wrote:
>>> On Sat, 27 Jun 2026 at 19:14, Paul E. McKenney <paulmck@kernel.org> wrote:
>>>>
>>>> On Sat, Jun 27, 2026 at 05:38:44PM +0200, Marco Elver wrote:
>>>>> On Fri, 26 Jun 2026 at 20:36, Paul E. McKenney <paulmck@kernel.org> wrote:
>>>>>> On Fri, Jun 26, 2026 at 08:40:50AM +0200, Christoph Hellwig wrote:
>>>>>>> On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
>>>>>>>> +++ b/drivers/nvme/host/multipath.c
>>>>>>>> @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
>>>>>>>>      bool changed = false;
>>>>>>>>      int node;
>>>>>>>>
>>>>>>>> +   /*
>>>>>>>> +    * This helper is used by namespace failover/teardown and I/O policy
>>>>>>>> +    * update paths. We only compare the head->current_path[] pointer value
>>>>>>>> +    * and do not dereference the referenced namespace, so suppress the
>>>>>>>> +    * context analysis warning for this lockless inspection of the
>>>>>>>> +    * __rcu_guarded pointer.
>>>>>>>> +    */
>>>>>>>>      for_each_node(node) {
>>>>>>>> -           if (ns == rcu_access_pointer(head->current_path[node])) {
>>>>>>>> +           if (context_unsafe(ns ==
>>>>>>>> +                           rcu_access_pointer(head->current_path[node]))) {
>>>>>>>
>>>>>>> I think we need a helper for this, as for a simple pointer value
>>>>>>> comparison without a dereference we don't really need either
>>>>>>> rcu_access_pointer nor locking.
>>>>>>>
>>>>>>> Maybe somthing like a
>>>>>>>
>>>>>>>        rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
>>>>>>>
>>>>>>> ?
>>>>>>
>>>>>> We could provide something like this:
>>>>>>
>>>>>> #define rcu_compare_pointer(rcu_pointer, nonrcu_pointer) \
>>>>>>          context_unsafe(rcu_access_pointer(rcu_pointer) == (nonrcu_pointer))
>>>>>>
>>>>>> Or maybe rcu_pointer_equals()?
>>>>>>
>>>>>> Marco, thoughts?
>>>>>
>>>>> I see 2 options:
>>>>>
>>>>> 1. rcu_compare_pointer / rcu_pointer_equals as proposed. It's more
>>>>> explicit but does add some friction during Context Analysis
>>>>> enablement. But this only makes sense if there are cases where
>>>>> rcu_access_pointer() should be used under the RCU reader lock, which
>>>>> led me to the next suggestion...
>>>>>
>>>>> 2. Redefine rcu_access_pointer() to just not require the RCU read-side
>>>>> lock to be held as:
>>>>>
>>>>>> #define rcu_access_pointer(p) context_unsafe(__rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu))
>>>>>
>>>>> [ Or alternatively wrap __rcu_access_pointer() in context_unsafe()
>>>>>    (similar to rcu_assign_pointer and friends). ]
>>>>>
>>>>> I think rcu_access_pointer() is in the same category as the other RCU
>>>>> pointer helpers, although currently only the pointer update helpers
>>>>> imply context_unsafe(); I think it might have been an oversight
>>>>> initially, and we should change rcu_access_pointer() to match. There
>>>>> should be no reason why an rcu_access_pointer() should be protected by
>>>>> the RCU read-side critical section, since it's not meant for
>>>>> dereferencing the pointer (that'd be a bug; its documentation also
>>>>> says "Return the value of the specified RCU-protected pointer, but
>>>>> omit the lockdep checks for being in an RCU read-side critical section
>>>>> [...]").
>>>>>
>>>>> If you agree there should be no cases where an rcu_access_pointer()
>>>>> should be guarded by an RCU read-side critical section, then I think
>>>>> this is the simplest and correct design, and avoids expanding the RCU
>>>>> API.
>>>>
>>>> I don't know of any uses of rcu_access_pointer() within an RCU read-side
>>>> critical section, but code in a function that might be called both within
>>>> and outside of a critical section might well use rcu_access_pointer().
>>>> In other words, it should be OK to use rcu_access_pointer() within an
>>>> RCU read-side critical section as well as outside of one.
>>>
>>> Thanks, yes, that's what I wanted to confirm; i.e. it's ok to use
>>> rcu_access_pointer() within and outside an RCU read-side critical
>>> section.
>>>
>>> In which case, my proposal (2) to make rcu_access_pointer() not warn
>>> on accessing __rcu_guarded pointers outside an RCU read-side critical
>>> section should be the simpler and more generic change (vs. adding a
>>> new rcu_pointer_equals() helper).
>>
>> As shown below?
>>
>> My guess is that this change makes it unnecessary to have a separate
>> RCU-protected-pointer comparison macro, but please let me know if I am
>> missing something.
> 
> Looks good to me. Yes, this makes a new comparison macro unnecessary.
> 
> Nilay, does this work and simplify the patch for you?

Yeah, this work for me. In fact, I have already tested this patch from
Paul and sent my Tested-by tag[1]. You may have missed it.

[1] https://lore.kernel.org/all/2a3c6a56-a9a6-461e-80ca-c0f2b4203bff@linux.ibm.com/

Thanks,
--Nilay

