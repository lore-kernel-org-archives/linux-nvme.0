Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B95C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 09:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N7B8iMHwp+52WMqMhoCQxN1cm4v8o5HqUV4Qb5yxNcU=; b=1URpMlMUU19WE3lwpyZZVJslaV
	xpNqdBkDP3RAantupC/fWkYVOtaglRPU9t5PcuBuooqt9WuOlSrfyl9UqTzx0wmE5wa4lqSHue2oj
	MiO6GfedGJVUBhIVhnJfZxwtmUTut2hKAln1chkJCXe6aovaEhZ3Ohy1JbH+4k2H4VNuweDfJJnsx
	6ebi9+gPO52aWE2N4a2Br6YAkcpLZiFCECK+IX4xy4ycjuIJJODFF9qQH/IgQfPwVgjkgpuWCV0RR
	ZIM12G9CJz2JwqRulQaTVxwEPRNh3SKvVdNvYYFCo6QsLDa7/H/WVDGFbUTzb7O7BYesH+cTdM5hf
	Qng0zmpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVD9-0000000GYAa-2NFX;
	Tue, 30 Jun 2026 09:56:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVD6-0000000GY8f-3Tn0
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 09:56:58 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9n9oc1578226;
	Tue, 30 Jun 2026 09:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N7B8iM
	Hwp+52WMqMhoCQxN1cm4v8o5HqUV4Qb5yxNcU=; b=OQG10JOxQB4acz7kVuHVSq
	sE2NVlLRFsGkVdESu4y7s4tqa+433kIWABhH1N7rdvrCaBgL/TOBGsTpJIVM/8zd
	Cl7XYBV8cwe06x3sJoOFdcARPZypixTEomvr53rgK7glHlvpZ/7faYYsKmbBLbQr
	U4wOG4OGr9L5zu2m/nE1g/+XxroC2woqfCZ83BuHYmfc2pt3IYjZcxPWiWJ6Xk5t
	Q7XuRl1DOyG6uZ5UUehDQuAOjf9pWUHMbnp32yUQ0K9MjIDZtwDaOs0owyYZvE1c
	QjRFE1JjigU4UXuUN6kMKCUXx1EDemm5n++yP4dQ5EbXAfP9sjpPKrM/OQ8Lo3kA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rewpqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:56:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U9okBJ017927;
	Tue, 30 Jun 2026 09:56:46 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk1jaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:56:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65U9ukad19399360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 09:56:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 305FD5804B;
	Tue, 30 Jun 2026 09:56:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A59358055;
	Tue, 30 Jun 2026 09:56:42 +0000 (GMT)
Received: from [9.43.78.19] (unknown [9.43.78.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 09:56:41 +0000 (GMT)
Message-ID: <fa1eb6cd-39e5-4e98-aff0-83733abb5cb4@linux.ibm.com>
Date: Tue, 30 Jun 2026 15:26:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for
 nvme_ns_head::current_path
To: paulmck@kernel.org, Marco Elver <elver@google.com>
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
 <2a3c6a56-a9a6-461e-80ca-c0f2b4203bff@linux.ibm.com>
 <CANpmjNNVw9rR5J-Bd3FL9Cxss3b+mN-XCGsg1c9HrTa70S0HEQ@mail.gmail.com>
 <38955e20-0bf3-4c8c-bfc6-352ca1a4d83c@paulmck-laptop>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <38955e20-0bf3-4c8c-bfc6-352ca1a4d83c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4392df cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=_KUfwnEbNJUcxR04-s8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CrLzQEVJAKY6O0jr21ObQ-sqt6ysVhDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4OCBTYWx0ZWRfX7KGclBDnsFrd
 q7numwUCkIsY0xeb3N4DfaBjuTe9dmhADAtBgVoVJumrdlK4BqAKNuq2Mm2ZxVfeGAQWUsvZV9D
 E1pp3cZ+CmVieQswfK1lTNPdkvZyq4L/Q+AUGplEfCi2I9vaMdteDnjCw+UjBnNTHf3yBqF7LbI
 Jqo4m7nGFazryPDaEaBenEy1kKneRzL2V/pACcZ1MO06Slpk3euthCnvuMeu++4rzzaAMJcrKQA
 HHeGDKMmwKAcmwyiRLbVca8ruPflSboSgGmf67ciuKrnGXtOer4IlKWlMyUG0cBKJ6UemXCVjOL
 DTyL3YMnxCUEVBfAZyuEOthvQfUbRNirBL//lKaKhGiGcnfYXcLYEV4Rn9h7G8RuRtT5Im1MSGd
 5xLZshRqnmS12cdCgGa6lces3rohJkdWMD24WjU+OVRb1+0xHPuUtEwZCYyUBbjiilJXYq9ux5X
 B80tyCCMSX0qaS0vwlQ==
X-Proofpoint-GUID: HjjHCIYjLhfy3TpIEjthObjKxAIIYaZe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4OCBTYWx0ZWRfX+BCt77bolPqh
 ImYZnmjWKYboOZmBLErILrmaEmgx0W0ZYvNSduY0PSkvttFEvLMiXBl3so2hsd/+1czNg2Jb4WL
 s6u988qDtL1cHXnV4pDiVHs5kVr6beM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_025656_990424_593AE16B 
X-CRM114-Status: GOOD (  18.92  )
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

>>>>
>>>> commit 32c1e63fee171f7ed8cc986ec64f576ee80bccab
>>>> Author: Paul E. McKenney <paulmck@kernel.org>
>>>> Date:   Sun Jun 28 09:00:01 2026 -0700
>>>>
>>>>       rcu: Mark __rcu_access_pointer() as context_unsafe()
>>>>
>>>>       A simple comparison of a pointer returned by rcu_access_pointer() results
>>>>       in a context-analysis warning for lockless inspection of the RCU-protected
>>>>       (also known as __rcu-protected) pointer.  This can be suppressed by
>>>>       placing context_unsafe() calls around calls rcu_access_pointer(),
>>>>       but this is messy and distracting.  This commit therefore wraps the
>>>>       underlying __rcu_access_pointer() macro with a call to context_unsafe(),
>>>>       thereby informing the context-analysis code that rcu_access_pointer()
>>>>       may safely be invoked outside of an RCU read-side critical section.
>>>>
>>>>       Reported-by: Christoph Hellwig <hch@lst.de>
>>>>       Suggested-by: Marco Elver <elver@google.com>
>>>>       Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>>>
>>>> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
>>>> index 5e95acc33989b6..e40dc2e20c5b1f 100644
>>>> --- a/include/linux/rcupdate.h
>>>> +++ b/include/linux/rcupdate.h
>>>> @@ -490,12 +490,12 @@ context_unsafe(                                                         \
>>>>     */
>>>>    #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
>>>>
>>>> -#define __rcu_access_pointer(p, local, space) \
>>>> +#define __rcu_access_pointer(p, local, space) context_unsafe( \
>>>>    ({ \
>>>>        typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>>        rcu_check_sparse(p, space); \
>>>>        ((typeof(*p) __force __kernel *)(local)); \
>>>> -})
>>>> +}) )
>>>>    #define __rcu_dereference_check(p, local, c, space) \
>>>>    ({ \
>>>>        /* Dependency order vs. p above. */ \
>>>
>>> I have tested the above patch with an __rcu_guarded pointer accessed
>>> outside an RCU read-side critical section while Clang context analysis
>>> is enabled. I can confirm that this change suppresses the context
>>> analysis warning when the pointer is accessed via rcu_access_pointer().
>>>
>>> With that, if you send out this change, please add:
>>>
>>> Tested-by: Nilay Shroff <nilay@linux.ibm.com>
>>
>> Thanks for double-checking.
>>
>> Reviewed-by: Marco Elver <elver@google.com>
> 
> Thank you all!
> 
> By default, I will push this into the upcoming v7.3 merge window.  If you
> need it earlier, we would have to make a case for this being a regression.
> Which I could probably do, but first, is v7.3 too late for you?
> 
> 							Thanx, Paul

I think anyways the current series would not land in the upcoming
kernel v7.2. So if you could push this during v7.3 merge window then
that should be good for us.

Thanks,
--Nilay




