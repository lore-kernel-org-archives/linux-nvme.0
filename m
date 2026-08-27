Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D51DC61DC6
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DWpPd40fgTQnygQ4jQFKBmnT1n2A/aO+zUtfPoK7iAE=; b=nbNb0DROy2NJnbzrKc1Zy4XA0L
	XHuXLFdLq/2d4MV7iZzSJFdeQjU+YpvBrXonP/54huorIXq+k8XQKYdSoZWfCq0+07pWr8k6Xdpg6
	LN34L4kLFIwxCx8HkpGsUUuHwuHucJUto48cvYkeeKyJ3dChX6k5HDlkEav3SxYyR6ap1YefkJ28D
	DHB16E2yarQ0lgFx0HNgjyWxxBKNJKnDGXjMStYhjw5sw/BQFxFT10Jz5S3jWqRvcJgeZe+oi3p0L
	TXCZCXyVTe+drh+miQHemnB1DO7w6IjxHTGDEKaMhYcWcNI7E1WWZ6ZPQohXkwV/cMLCYr/dCA2Fg
	z+MHs8Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wza2s-000000042hO-2V5Y;
	Thu, 27 Aug 2026 13:21:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wza2r-000000042gP-02xK
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 13:21:30 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RCVhKO2891965;
	Thu, 27 Aug 2026 13:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DWpPd4
	0fgTQnygQ4jQFKBmnT1n2A/aO+zUtfPoK7iAE=; b=LD22CU+gbSgWaPNIZ9S4WJ
	XKaY8SgoeljDG0uhUjb7a8qOjNViJgUV29wzPUvDCt3S5bv6o7Vatl5eY3gYEMFZ
	Ulv9RnNIGpjRQmKN1V257qrUfnFct2zb1el17HFm9VuQzOb81UDO8sd/+n61HK5N
	n83ean9uWZeFRoO80f05WYUH1iqQHJ/EaeP+ZtbVa1j6pPENP+JnAYv7+tAi+jut
	YDGWhcvN+nEHeLfWH0/PWGSZtRsIH/VYtoNnL9FVpWaRYpRnH3q066FXUaAh7n/T
	8kzui2rPka982TGdUSTxdNY+OjcKNaT9OW9M6oV1N9cK1t04Akc9bIpsioThfC6w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j5mec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:21:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RDBHuj007484;
	Thu, 27 Aug 2026 13:21:25 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyfysw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 13:21:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RDLLOp26804746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 13:21:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BA4F58043;
	Thu, 27 Aug 2026 13:21:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A8005805F;
	Thu, 27 Aug 2026 13:21:19 +0000 (GMT)
Received: from [9.61.79.117] (unknown [9.61.79.117])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 13:21:19 +0000 (GMT)
Message-ID: <e09f539f-a6f8-40ec-aac6-0722289e5591@linux.ibm.com>
Date: Thu, 27 Aug 2026 18:51:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
To: Keith Busch <kbusch@kernel.org>, Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, gjoyce@linux.ibm.com, wenxiong@us.ibm.com
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
 <d3cb6438-f1b6-4b46-9f96-56819052bc02@linux.ibm.com>
 <dc9af96205cfff939f96d7465a50eef1@linux.ibm.com>
 <ao8WB4Ywz_akBEdR@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ao8WB4Ywz_akBEdR@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfXxGTADwzUW/BE
 zQLF1ixEtgwmECDomPnO4yZpE3QwjMIp0zKq8FNHk73s15QQ06VdR9srHafzyE2lRAems+gWMA+
 kIav78DVSNVI/yN/YdQzZZon9KK35Ug=
X-Proofpoint-GUID: bwyJ3C8L7PjVkmLaizkkfO2yLMyCyxGA
X-Proofpoint-ORIG-GUID: bwyJ3C8L7PjVkmLaizkkfO2yLMyCyxGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwOSBTYWx0ZWRfX6tFxS+vQcIkL
 XC3k1EgjoBP3ib8YhNsfGS0RXsrQo0zxfSOeur/d1bR/tl2lKWXE5kTK3qRWc0jlRQia9F0WZ3X
 A4vsdB/XiASEVHDkg/JSeJRS07o7hIhvqBh8VJAv7XJu4k8QfJyIIvChbdqmJFlu/pzSAOlrrmS
 vstbzg4CWCOy6UKdUpAEPwFe4/YEAEc2RlwOpHUshneV5ZXES6IQZVsfxxUIUf3Z3ugfdEUue6m
 Av2pil/I9rT4/ANYk9ydAVqX9umX/5YFYD/nByz+O9Agm2B+IvdF5dp0sXTUTYd0jI47nhH/ddV
 yDj886X5JRxJQLrqgWbTSwjArKd1yGFOqUXHy1YwsjmLq32YnfBFyaIwmeA23vQY0J8I7/xFojL
 ffiKf3nfexldkK6C/vSm+QWZZrH9MD0eI1Wi1GvEndbd0kgYVl+2Ai1Of4vBLQyqghH+yJM2uUd
 1HKx/8ZH3rpfeDurlCg==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a9039d5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=vjNg84M93zLaNEDguKAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_062129_196639_CC91A68A 
X-CRM114-Status: GOOD (  20.05  )
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

On 8/26/26 10:06 PM, Keith Busch wrote:
> On Wed, Aug 26, 2026 at 11:18:16AM -0500, Wen Xiong wrote:
>> On 2026-08-26 07:40, Nilay Shroff wrote:
>>
>>> Also, since a multipath head can have paths through different transports
>>> , we should not take a reference only to the transport of one
>>> namespace/path
>>> found through nvme_find_path(), as was done in v1. Instead, when opening
>>> the
>>> head, take a module reference iterating through each controller
>>> reachable
>>> from the corresponding NVMe subsystem. This ensures that every transport
>>> that can service I/O for the active multipath namespace remains loaded
>>> for
>>> the duration of its use.
>>>
>> I will look into iterating though each controller/each namespace from nvme
>> subsystem.
> 
> This is not viable. You can add and remove paths to a namespace at any
> time such that the transports counted on open are not the namespace's
> transports on close.

Yes correct, and I think we need some additional change in the code to
handle this gracefully. I though about it have some initial idea to
address this:

1. Add nr_openers to struct nvme_ns_head.

2. When the ns head is opened, iterate through each namespace associated
    with the head and increment the reference count of its underlying
    transport module. Then increment nr_openers.

3. If a new ns/path is added while the head is open, check nr_openers and,
    if it is non-zero, increment the reference count of the corresponding
    transport module nr_openers times.

4. If an existing ns/path is removed while the head is open, check nr_openers
    and decrement the reference count of the corresponding transport module
    nr_openers times.

5. When the ns head is closed, iterate through the namespaces associated
    with the head and decrement the reference count of each underlying
    transport module. Then decrement nr_openers.

The above operations are serialized by subsys->lock, so nr_openers serves
as the number of users that have actually opened the head node.

For example, suppose we have a shared namespace reachable through
TCP and RDMA paths:

1. User opens the head node:
    head->nr_openers = 1; tcp_module_ref_count = 1; rdma_module_ref_count = 1
2. The RDMA path is removed:
    head->nr_openers = 1; tcp_module_ref_count = 1; rdma_module_ref_count = 0
3. User closes the head node:
    head->nr_openers = 0; tcp_module_ref_count = 0; rdma_module_ref_count = 0

Another example with multiple openers:

1. User A opens the head node:
    head->nr_openers = 1; tcp_module_ref_count = 1; rdma_module_ref_count = 1
2. A new TCP path is added and linked to the head:
    head->nr_openers = 1; tcp_module_ref_count = 2; rdma_module_ref_count = 1
3. User B opens the head node:
    head->nr_openers = 2; tcp_module_ref_count = 4; rdma_module_ref_count = 2
4. User A closes the head node:
    head->nr_openers = 1; tcp_module_ref_count = 2; rdma_module_ref_count = 1
5. The RDMA path is removed:
    head->nr_openers = 1; tcp_module_ref_count = 2; rdma_module_ref_count = 0
6. User B closes the head node:
    head->nr_openers = 0; tcp_module_ref_count = 0; rdma_module_ref_count = 0

This way, the transport module references track the actual number of openers
and the set of paths associated with the head, even when paths are dynamically
added or removed while the head remains open.

Thanks,
--Nilay


