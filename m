Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DD7C43211
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7z1jJPHNW8xbBOvUMfR0PS2C6t6H6tXTE75ez/mYGl4=; b=G3ZuadmDgobCeUV2ivCfc6Tpns
	6aGutSyhOvC6sUu7GkWZEF9uTgoHjmq+OWfKA7AA3M9rZGg+VqlrKzhcvDlakclvMBE/1vPGaJLZa
	6Hevas2VexBVUe9TJh89+jdrahHfZ3v5rc7Mlw3rBSvphamOSMKDqwEVR+TTqmtY1HFRL0akR2OaJ
	i0aUoI+ab353dar2S+q8I17m8jVT37hp9hsD6FjEa7SODRYRY81CTWxJLlzuT3s6KAMbg7GVrHjKd
	JYfOVxDCF9k6ZVF2h9qbvYacijlScaUzXNytEw8IALFw7Elzeqk5DHWcsVJoesO5vJRMoWPOvOIeS
	4i9mRCBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8EH-0000000BX4S-1EJS;
	Fri, 26 Jun 2026 15:12:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd8EE-0000000BX3C-468V
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 15:12:28 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIRvs2660004;
	Fri, 26 Jun 2026 15:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7z1jJP
	HNW8xbBOvUMfR0PS2C6t6H6tXTE75ez/mYGl4=; b=RIsIbAjGMUDXJ+bIgO+gmb
	mSWzan2sar5nYOXUZdtzEOhXimGCZyOq+vayYWktTmatZ9mQ7BmDSBPsxKygrivb
	2qJcV3WOiEn8dm6PJB5Zhxn2KqadkdJwSjSeWAG5WuNZfPB+5big/VAWEAReYhq5
	oOuR3iNpTQHaxiL7y3UG65fqdDDH5ReN4bP1/HuMBTwI+6okol4MWeIuqAbGvtZz
	p3yeA1+75bQAAxzgY0wSxmNurqCQSCEESY8ROgxZ/uZRdM7+U9jt/Ws/udRo3Zwe
	icRnI6aBH8nNcCh/18LWZCFb2GeeCj0c6BLlXCQpZ7QRGCOk9RrvCAJHED6PiL8g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gy8k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:12:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QF6xuF000895;
	Fri, 26 Jun 2026 15:12:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgkdt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 15:12:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QFC9KE31982208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 15:12:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D6895805D;
	Fri, 26 Jun 2026 15:12:09 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0597A58057;
	Fri, 26 Jun 2026 15:12:06 +0000 (GMT)
Received: from [9.43.54.234] (unknown [9.43.54.234])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 15:12:05 +0000 (GMT)
Message-ID: <09fb5b3d-e5d0-4c7b-a333-9ca51286929b@linux.ibm.com>
Date: Fri, 26 Jun 2026 20:42:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 11/17] nvme: add Clang context annotations for
 nvme_queue::sq_lock
To: Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-12-nilay@linux.ibm.com>
 <20260626064721.GA11106@lst.de>
 <CANpmjNNc0YaFWv9yW_AT3fPX1cOY7k5no2kKqvSTijnp_GV=Gw@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANpmjNNc0YaFWv9yW_AT3fPX1cOY7k5no2kKqvSTijnp_GV=Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 3me4vj911bivnZ9aF2C7RX9TCvqu0mLc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyMiBTYWx0ZWRfX2KhmghEdOHWW
 EwiYjEih4M8ysjhLHmAxxuMkK3aI2KB1XYictkyTQGaSXuiBwD9XESFxrL3DBmRYmLrshxunX4e
 tZKYiZYVplqGOSSk073qVX+Irv/N7Z8=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3e96cb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=LADbP_c0cKmsurRaz28A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyMiBTYWx0ZWRfXwprDvjCleuhv
 6mDhRAdFF6carK7aN0YgpQtFdxthfiRHflEU74R/YZpAPSoP7A3KYsQnRTWvdHSSTu1CjK2/TiX
 fdE0v3H3qw/B6W6BGxQ4ipoEsGt8VvDAyPQnuG4yvlzdoBw32Hxh/0wyoQESXUm6yh1puL7QNds
 mc8JjNdoKD0c5zKFVxpAXFNFpjYsO51E4MVbdx6E7abu3S0OiXw08KtuDghY0PNHaojXRJ3ubMG
 c4///FvvbZLmsl/evZTlmGuk2dKpGoWevW65l2a92BN7e3UQBjGbXfP1XngY9B+fn6xPwndOid4
 NI9EAqS2DfFfnCVITV2g2qWa7lAJ4EvGsqvQigP4S2vI1lOYC9QDZ59mmlsIzurqpWOIE/O2B8l
 L9SPjxQhDpJDR+JcC6QgTDgiWWphwjvyAL/JwKwPWH4UEpTwJ454ii4vrO/eZ9z3wYR3Vu/OcFK
 b0KdENyIm+zdgsK2zIw==
X-Proofpoint-ORIG-GUID: q90oZa9-FzUP2HjD5i-ZPAWfYdAj7OJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_081227_140735_7AC7BA14 
X-CRM114-Status: GOOD (  20.23  )
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

On 6/26/26 3:20 PM, Marco Elver wrote:
> On Fri, 26 Jun 2026 at 08:47, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Sun, Jun 14, 2026 at 06:45:26PM +0530, Nilay Shroff wrote:
>>> Accesses to sq_tail used solely for tracing are annotated with
>>> context_unsafe(), as they only require a lockless snapshot of the
> 
> This sounds like an intentional "benign" data race...
> 
Yes, agreed. For the tracing case this is an intentional data race,
so it can simply be written as:

trace_nvme_sq(req, cqe->sq_head, data_race(nvmeq->sq_tail));

>>> value. Likewise, nvme_init_queue() and nvme_free_queue() operate on
>>> queues that have not yet been published or are no longer reachable,
>>> and therefore do not require sq_lock protection. Similarly,
>>> nvme_alloc_sq_cmds() allocates memory for nvme_queue::sq_cmds for
>>> the queue which is not yet published or in use and hence it's safe
>>> to annotate all these helpers using context_unsafe.
>>
>> Accessing scalar fields without lock is pretty common.  Don't we
>> have an annotation that only requires the guarding lock for
>> writes?
> 
> If the writes can happen concurrently with readers these are data
> races. I'd probably annotate the particular reads with data_race(...):
> this will both tell Context Analysis this is ok without a lock, and
> also if KCSAN is enabled, not to report these data races when actually
> observed at runtime
> (https://docs.kernel.org/dev-tools/lkmm/docs/access-marking.html).

I don't think data_race() is appropriate for the initialization paths.
There we're only initializing scalar fields before the object is published,
so there is no concurrent reader or writer and hence no actual data race.

The remaining issue is simply convincing the context analyzer that these
accesses are safe. As far as I can tell, the only way to suppress those
warnings today is to use context_unsafe(), either around the helper itself
or around the individual scalar field accesses.

Thanks,
--Nilay




