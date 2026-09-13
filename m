Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BD9C88E66
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Sep 2026 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WkgtGNLVj5lEWP3U7RT04RqO7sIFfDRKjhKOIiBSzdw=; b=X2kFjrQ7Ze2G8EvYmBRdBTj9hm
	8j+P1ja4JxhIlZAEnluQq6sndrMibfbDwmuUn0prDsoYLmzWD1jnct44/SYdNGNarVkuYEeRuMrbg
	qG3ve4fdcrSrKAoZxThQEiyRjmL0vg8c7dMghqN/YHblRqNbhy7HdCPf0UnhGsuQa0WmOLX4Wysmc
	Y5lxbwk6Lo7ge2B72LruV48HAFt5RQwnKJrO/82nnFbaiA+nbEQuoOtPHyqs+jpZn7KOCwqOYhecV
	IuU6WDgXk58ci7KKLoFSGxB2dbAVaGUsywEvNBuToBNqKvNwI6iAahoBjwjNA03+PBL4IRYFIyErB
	dfreFBuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5koX-00000001hea-0eyz;
	Sun, 13 Sep 2026 14:04:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5koU-00000001heE-2QGn
	for linux-nvme@lists.infradead.org;
	Sun, 13 Sep 2026 14:04:11 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68DE1SGx1656118;
	Sun, 13 Sep 2026 14:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WkgtGN
	LVj5lEWP3U7RT04RqO7sIFfDRKjhKOIiBSzdw=; b=bl2aY2/4jUe0esdIcM12t3
	//bJjS4BzZn8H/fq/qDApfdZLpJPve2XAuMawK8vagZ+sIOItfKMR7X+Z0NrGeyH
	uFBKnDEUvVLic1LCA/2480/wFLytF29IQAWE1jiTPlUmEB2kW9z4zA3AnT4SkMzn
	c7siBPKkrz8UvgSnFfnZ5EKiyFt+aQ29p9kvyLiaaD6zpb3stWn1gYGq/jaDIiOw
	WaTP0IFQvBh1ZSAa+wxZ+CXuwgmGsohFHa6ELqv6AnqtN3FuyFWRY7lpmOoUctfd
	qXEGqZz3grlp2DmHxeQHrHT3UzKHuG4xKzaFwLUhclAwp0acHNDfjkCQiCRatrdw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdpvrvb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2026 14:03:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68DAZ4SB541223;
	Sun, 13 Sep 2026 14:03:56 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnkry1d8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Sep 2026 14:03:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68DE3txW3146274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Sep 2026 14:03:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5921458055;
	Sun, 13 Sep 2026 14:03:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C41D5805D;
	Sun, 13 Sep 2026 14:03:52 +0000 (GMT)
Received: from [9.61.162.129] (unknown [9.61.162.129])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 13 Sep 2026 14:03:52 +0000 (GMT)
Message-ID: <57629796-d346-4cc4-8c9c-b153a60e1709@linux.ibm.com>
Date: Sun, 13 Sep 2026 19:33:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
From: Nilay Shroff <nilay@linux.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        Jens Axboe <axboe@kernel.dk>, john.g.garry@oracle.com,
        wenxiong@linux.ibm.com, gjoyce@linux.ibm.com
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com> <20260902133104.GA20945@lst.de>
 <c725f90c-b119-4669-afb7-6aeb6c4a308b@linux.ibm.com>
 <20260902141347.GA24385@lst.de>
 <61165430-a724-40d3-a00d-2cbe1ea656b0@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <61165430-a724-40d3-a00d-2cbe1ea656b0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDIwMSBTYWx0ZWRfX97x4eMQso7sG
 JJWfbIsqibxqQ41Z3V+7B1xxIPMZ84WcDV3o0uLy3lgTQBIl/a9zlWbqHJGkurID3RYHCO5BnTX
 q0PRalEI6vGi/BAEE+af+wRLmGHuYUAb111MD1Te9PS+jZYWQJ1iG1+J4R63FYiBoVWuU+H2Vp6
 kJkI8Itpg30WE4rYhdE98nJUsBSXuH8OyyEDKjyS6tV8LnTOg2Bkrq45BM1O0BFHr9GkfJY01qz
 DK/JV5ze0NdU0pYVZAmfwGFSUS1G57VvRlBmooN9CVLDNvJ6BrrkFqxiegw3wlFTJz/H/IrwJ05
 uF+MAIyKmOfZDOfozGSU+vUI62UDZ8fN/WH3bqD7VIVJ9yBTD7r5Jh2FI9v6mbH/6SVpuRnPRgr
 hrn3kgQYivwPd4J7prizamdLhSeiyHdtvoBiHHSl9gF+/mOJ1jU+W0jBzKB8q1LgG/7IFV1bWTA
 MdE2z6SFnRsZdKQQRkQ==
X-Proofpoint-GUID: pyUXw0zM3MGgjjjZvQGHQzfcZjlBxi31
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa6ad4d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=AXAQGVf3kW131NiH-mUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: pyUXw0zM3MGgjjjZvQGHQzfcZjlBxi31
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDIwMSBTYWx0ZWRfXyY3XBrqSEF5u
 KF1kNjhWI5EXjn/eyUfLDREJBoyLWXw85zPl9t91dNBjT1sIfHnJyFxAHBkLPQYE00nc53wsoKf
 3le5Y/mvrRMLNWMil6Zsl1m2XaWsanM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260913_070410_632784_D93CE483 
X-CRM114-Status: GOOD (  20.42  )
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

Hi Christoph,

A gentle ping on this one... Do you have any further comments on this?

Thanks,
--Nilay

On 9/2/26 7:57 PM, Nilay Shroff wrote:
> On 9/2/26 7:43 PM, Christoph Hellwig wrote:
>> On Wed, Sep 02, 2026 at 07:39:32PM +0530, Nilay Shroff wrote:
>>> So the practical problem is that an open multipath head can continue to
>>> be used after its underlying transport module has been unloaded. The
>>> proposed change keeps the transport module referenced while the head
>>> node is open, preventing the module from being unloaded in this
>>> scenario.
>>
>> But why do you unload it in the first place?
>>
> Well, in my view, unloading a module while it is not in use should be a legitimate operation.
> 
> In the example shown earlier, the NVMe transport module is still being
> used by the open multipath head. Shouldn't we explicitly reflect that by
> incrementing its module refcount? We don't explicitly unload the module
> as part of normal NVMe operation, but in theory I think the transport module
> should remain referenced for as long as it is being used. That would also
> prohibit user from unloading module by mistake.
> 
> Thanks,
> --Nilay


