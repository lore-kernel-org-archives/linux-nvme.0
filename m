Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE89AC624D6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hVl0eez+7rGwrMJ/yB2fB5hDd+8YYsGugLvclub5l6A=; b=TLRUDTxtFhkh0vcl7xZWzsmlnT
	V8aT/XqmeL60ubOw9TVpZ3rYyYgStgk5rw56ceV1neE0NnrffqWsI4BTlwtbjDt0XysyW9snhfdOW
	xizTaTq1b2tb06/VMYqw4xfiQeJ2gEVM6B2U+evVyj5vj0le7iBA74HW4mA8NBVMpxVeHT1s7nnnX
	bQ6pFVisSYs0nGbWkhwQvqT8rRJKVxxe4ty4371fmWBwcJsNeRJxQjUQFRR3nQ5UauhIzY0LZWcKg
	g99n5sbBKXlMbcMh+veEiNmzW9poDfd51798rFVXNCNsNJRYzJXdewDPp6OJ0jyUGZKi6cANh89Jy
	ZVPgJCcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lwb-0000000EwgV-1n6N;
	Wed, 02 Sep 2026 14:28:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lwZ-0000000Ewfi-16zy
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 14:28:04 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CVqRR4189531;
	Wed, 2 Sep 2026 14:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hVl0ee
	z+7rGwrMJ/yB2fB5hDd+8YYsGugLvclub5l6A=; b=XQPie5X3kqJEIKr9EbRfYN
	8/zopN1AuOVGDkJecLWwfrfYcB1xwGXRnlDg9qpRhr6FIR732LbtUhmeXANAXrxb
	xMGbrLPEahCZB/NEMAG65HDvRsZkyEgThce5r5COtyYBiA1kpeSlpPZSaJHecnWU
	MrekdxhzkmPpALCI+7grU6B+BsFpYYBokxUpHreHKeCzDajzQG+rjHnajp9vK1qG
	G8tCUmx4T0gEzsFu8M3mtVPtkgjtfnSC0vAGqrZLmgkKxQAa0Qmr4kHFVywsQ5NS
	6bS+pAUQFqp5z5Lsc08yOVX/wlSqEfDKMcRzGYlYqY3RGSd3NFjyyQuYwB5K1OpA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5q5w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:27:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682EQGLR010056;
	Wed, 2 Sep 2026 14:27:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceya37b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 14:27:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682ERoXR15532736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 14:27:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C525805D;
	Wed,  2 Sep 2026 14:27:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E76158062;
	Wed,  2 Sep 2026 14:27:48 +0000 (GMT)
Received: from [9.61.83.86] (unknown [9.61.83.86])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 14:27:48 +0000 (GMT)
Message-ID: <61165430-a724-40d3-a00d-2cbe1ea656b0@linux.ibm.com>
Date: Wed, 2 Sep 2026 19:57:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, john.g.garry@oracle.com, wenxiong@linux.ibm.com,
        gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com> <20260902133104.GA20945@lst.de>
 <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com>
 <20260902141347.GA24385@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260902141347.GA24385@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a983269 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=38FUgixByHOs7A2MsVUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zcAHXQHAracm4bHI1_30wT_g9vc85hk5
X-Proofpoint-ORIG-GUID: zcAHXQHAracm4bHI1_30wT_g9vc85hk5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX+4pG6WE9wTAp
 qoz8WO4eSM2lSCnUqLsJJVgqFds90gkvBoZuFB6uwGX0ZygGXHjjAuyHvkJQF1U1vp186WDY7np
 zW8jYjqkz/S56maENH7pwEgp5AUPr6o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyNCBTYWx0ZWRfX77T1YwOsHzT/
 iNjCR0IhJ+JMwYj8whxF/elF6Oa3r53EqKaFNMB21TP77CIxTB0p8mBw3IDr6TagDjoekf3VKgj
 JRBdxC9f9hZzU2ZJERZd99jisoWag0S0dYQQhNTwv8VWyqVjTU757rYKafn1YInQUh23B3NtD2J
 lLUEqaTgBNBkdAl3jj1jGjAYa1XiyI9gRWUo1ssqXDSCZMYxv5KelWZf5bEGW8rZXLTmoFlA52b
 srWrLd5QlFM2DjkM1iBMTLFeBcQVoftCyIibljdmxZ1DAXPVapnMySyp2Fxlvjg9t+Aui9fzV+q
 KRqqBL/BZHTKYR/gFvIOgHanG24cO7yYBIS+xhFV8zYQJ1Ge6+A0EydAIxLfI6SJn/02qVlrZFZ
 NHRwUhoiWZ5sr61Hohm4KhGnRUm7bpC2OXB0K3eAutSj1d/qUUm7mK2xjUHiVbxH3FyAQr70iIF
 guq4wtjQW/mQyIYrYSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_072803_314902_8F21B13C 
X-CRM114-Status: GOOD (  18.76  )
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

On 9/2/26 7:43 PM, Christoph Hellwig wrote:
> On Wed, Sep 02, 2026 at 07:39:32PM +0530, Nilay Shroff wrote:
>> So the practical problem is that an open multipath head can continue to
>> be used after its underlying transport module has been unloaded. The
>> proposed change keeps the transport module referenced while the head
>> node is open, preventing the module from being unloaded in this
>> scenario.
> 
> But why do you unload it in the first place?
> 
Well, in my view, unloading a module while it is not in use should be a legitimate operation.

In the example shown earlier, the NVMe transport module is still being
used by the open multipath head. Shouldn't we explicitly reflect that by
incrementing its module refcount? We don't explicitly unload the module
as part of normal NVMe operation, but in theory I think the transport module
should remain referenced for as long as it is being used. That would also
prohibit user from unloading module by mistake.

Thanks,
--Nilay

