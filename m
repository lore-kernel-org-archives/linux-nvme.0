Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2C2CD8C9D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2026 04:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u02/qk3zDG71zo1fmIc2aoaAFTxsD0hrykMchg4v6bE=; b=b7xiAmDF84iSokroJtrrT32cwL
	9b6V6hdIiKTWgM4Xmi3VoWVHz/yz71NWcmavmXAVuHwNEoDzp6kC08QFbbMNaU8jVt8nqMHW8b5pp
	JvTBWhQfxWI6u48o4lWnW5Is9CjxpLDjPk2qtOe2+QKXg6bpmIUwstCjXNrEdSEBQW8juTxDeBuau
	PLGbwmRjklPKbTSZQ6jqG/3n4d6j4H0I8292Xgvcu0JnPGhcBur/Rg5aroOju6SGX8q8/AZPV7TPk
	f7ZOUIspAS+AdnE5Y2aKuHMdfC7/BzxjLXbtaGeVFC71LbIt2xzCzWfRcJW4VGi1NCvFEb7CV7GfJ
	ycCEcKjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXXPA-00000008h9l-1eJN;
	Thu, 11 Jun 2026 04:52:36 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXXP7-00000008h8x-3EoH
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jun 2026 04:52:35 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu3J5722148;
	Thu, 11 Jun 2026 04:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u02/qk
	3zDG71zo1fmIc2aoaAFTxsD0hrykMchg4v6bE=; b=QfBYON1XqutubrsUr+mh4g
	rj9TM2aY9Tym8kEk1SV/0Nhtk1KcJAvC1MSCPIZ3uxReAeuxxNewHhrhwKgobl0U
	UnjCDyw/o3ndiVjneBYdI+h13bK1myqnWVOe/NYkZp1BROUrHCut4PuAVkagy5bp
	a/n19tawrsGGKEaJM5I2UuyOirK0uhEVVQlQl+eNCW5JrpYKhhvZ+nVoSPALk83o
	xr4kh6a40FLnsdctnvXH8QI5FDaoQdGjGW2d8HwQRh3LVtxnbz52/SKKTXR+vvW2
	7e9mShcRXekySS9z3GucXvlRIvtxO8P8EVNCd84XIhsjFSe8aRrJoQBCydZlwZ5A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8d9g08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:52:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65B4naNV008901;
	Thu, 11 Jun 2026 04:52:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09hnwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:52:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65B4qIvG29164280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 04:52:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DB4058055;
	Thu, 11 Jun 2026 04:52:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC635805F;
	Thu, 11 Jun 2026 04:52:15 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 04:52:14 +0000 (GMT)
Message-ID: <f7fca454-5291-40b7-9542-6d79988baf5c@linux.ibm.com>
Date: Thu, 11 Jun 2026 10:22:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] nvme: add Clang context annotations for
 nvme_queue::sq_lock
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-12-nilay@linux.ibm.com>
 <78da28e4-97c1-405e-8edc-707e62577b51@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <78da28e4-97c1-405e-8edc-707e62577b51@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX0HmWEUD1AU7h
 piWmyIh+ZLcVnSXerLWBhA/4YR9CDFRKiUI2PYgDDFUlcslXRuTDHL7kSSReeGvCTRJWR2T45AH
 O4hA19Wqua8PELomJBod3DaVp6amspQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA0MiBTYWx0ZWRfX/x9w9YGSkGUj
 CvOMN3nTVZhky1LH5ZuPOBtzsM6Q7MaYw+gYXkExm1rU+Vp/CT3E1cr9lm0KHJDLxE9EyhKe8j+
 eINGeoHE7JoTx1KrBbZIgE8H1uLqa3RjE7ev6s5ZMdKDfRf84rxvGzkMlJ9QrIZrkkkoiPCuOQK
 sK9blgdUF9iFP/qI0FKCM+YzQGr342wUAzurBTzCbGw1os7uZBYTF9XuQ3PbPAqODHjDkdrLeF+
 hBE40c2DHqiVyCRVC2wm+MEcWTVKAT29LJEm8+YYWcbXModk488PhYzsbwIqCuFGSh0TRkYAO0w
 o+aREKqlO950k48ixuhW9uWWRo2PoBXo2kHA25E+ydzQhe8nrh/vWgb3sSqXAvdVv4/RlWRw4cz
 vohngfjCviazZ+p/N4yj1rZ3w8p14V9PwM49HpMqWGl2v3FNmK176aUSokDTW/kZOACVqG1J1Q2
 FCBOniF/DM0Q9LNr42g==
X-Proofpoint-ORIG-GUID: JYvJWZBjvYrtFJ8yB1pqPlKHT_AvdeG5
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2a3f04 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=ZcehwgQdTXXDgkSVmzoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: PHqfTWhzsSURYsVbf9S4tt4vvw6bzyDt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_215233_823885_507F0B40 
X-CRM114-Status: GOOD (  14.29  )
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

On 6/10/26 10:03 PM, Bart Van Assche wrote:
> On 6/10/26 7:27 AM, Nilay Shroff wrote:
>>   static void nvme_free_queue(struct nvme_queue *nvmeq)
>> +    __context_unsafe(/* frees queue which is no longer in use */)
>>   {
>>       dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
>>                   (void *)nvmeq->cqes, nvmeq->cq_dma_addr);
>> @@ -2176,6 +2182,7 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
>>   }
>>   static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
>> +    __context_unsafe(/* safe to init queue without any protection */)
>>   {
>>       struct nvme_dev *dev = nvmeq->dev;
> 
> __context_unsafe() is a big hammer that disables context analysis
> for the entire function body. Has it been considered to use
> guard(..._init)(...) instead?
> 
Yeah, I considered using guard(..._init), but it is a bit tricky in
this case. The lock (nvmeq->sq_lock) that protects nvmeq->sq_tail and
nvmeq->last_sq_tail is initialized in nvme_alloc_queue(), while those
fields are initialized later in nvme_init_queue(). Because the lock
initialization and the protected-field initialization happen in different
functions, I don't see a straightforward way to use guard() here to
create the synthetic acquire/release pattern around the accesses that
Clang complains about.

That said, I agree that __context_unsafe() is a fairly big hammer since
it disables context analysis for the entire function body. One alternative
would be to wrap the individual field initializations with context_unsafe(),
but that would require annotating several initialization/freeing operations
throughout these functions, which would add a fair amount of noise and make
the code less readable. Given that these functions operate on objects that
are still being initialized (or are already being torn down), using
__context_unsafe() seemed like the cleaner tradeoff.

Thanks,
--Nilay





